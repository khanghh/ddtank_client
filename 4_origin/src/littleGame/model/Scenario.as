package littleGame.model
{
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.ddt_internal;
   import ddt.interfaces.IProcessObject;
   import ddt.manager.ProcessManager;
   import flash.display.BitmapData;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import littleGame.LittleGameLoader;
   import littleGame.LittleGameManager;
   import littleGame.clock.Clock;
   import littleGame.data.Grid;
   import littleGame.data.Node;
   import littleGame.events.LittleGameEvent;
   import littleGame.events.LittleLivingEvent;
   import littleGame.interfaces.ILittleObject;
   
   use namespace ddt_internal;
   
   [Event(name="selfInhaledChanged",type="littleGame.events.LittleGameEvent")]
   [Event(name="soundEnabledChanged",type="littleGame.events.LittleGameEvent")]
   [Event(name="addLiving",type="littleGame.events.LittleGameEvent")]
   [Event(name="removeLiving",type="littleGame.events.LittleGameEvent")]
   [Event(name="update",type="littleGame.events.LittleGameEvent")]
   public class Scenario extends EventDispatcher implements IProcessObject
   {
       
      
      public var localStartTime:int;
      
      public var startTimestamp:int;
      
      public var grid:Grid;
      
      public var id:int;
      
      public var worldID:int;
      
      public var monsters:String;
      
      public var objects:String = "object/other.swf";
      
      private var _objects:Dictionary;
      
      private var _livings:Dictionary;
      
      private var _livingCount:int = 0;
      
      private var _onProcess:Boolean;
      
      private var _pause:Boolean = false;
      
      private var _stones:Vector.<Rectangle>;
      
      private var _selfPlayer:LittleSelf;
      
      private var _numDic:Dictionary;
      
      public var clock:Clock;
      
      public var delay:int;
      
      ddt_internal var bigNum:BitmapData;
      
      ddt_internal var normalNum:BitmapData;
      
      ddt_internal var markBack:BitmapData;
      
      ddt_internal var priceBack:BitmapData;
      
      ddt_internal var priceNum:BitmapData;
      
      ddt_internal var inhaleNeed:BitmapData;
      
      public var serverClock:int;
      
      public var gameLoader:LittleGameLoader;
      
      public var music:String;
      
      private var _timer:Timer;
      
      public var virtualTime:int = 0;
      
      private var _last:int = 0;
      
      private var _soundEnabled:Boolean;
      
      private var _selfInhaled:Boolean;
      
      public function Scenario()
      {
         _objects = new Dictionary();
         _livings = new Dictionary();
         _stones = new Vector.<Rectangle>();
         _numDic = new Dictionary();
         clock = new Clock();
         _timer = new Timer(1000);
         _timer.addEventListener("timer",onTimer);
         super();
      }
      
      private function __clock(param1:TimerEvent) : void
      {
      }
      
      ddt_internal function drawNum() : void
      {
         inhaleNeed = ClassUtils.CreatInstance("asset.littleGame.InhaleNeed");
         priceBack = ClassUtils.CreatInstance("asset.littleGame.price");
         priceNum = ClassUtils.CreatInstance("asset.littleGame.numprice");
         markBack = ClassUtils.CreatInstance("asset.littleGame.Mark");
         bigNum = ClassUtils.CreatInstance("asset.littleGame.num");
         var _loc1_:Number = 22 / bigNum.height;
         var _loc2_:Matrix = new Matrix();
         _loc2_.scale(_loc1_,_loc1_);
         normalNum = new BitmapData(bigNum.width * _loc1_,bigNum.height * _loc1_,true,0);
         normalNum.draw(bigNum,_loc2_,null,null,null,true);
      }
      
      public function get stones() : Vector.<Rectangle>
      {
         return _stones;
      }
      
      public function addObject(param1:ILittleObject) : ILittleObject
      {
         _objects[param1.id] = param1;
         return param1;
      }
      
      public function removeObject(param1:ILittleObject) : ILittleObject
      {
         if(param1 == null)
         {
            return null;
         }
         delete _objects[param1.id];
         ObjectUtils.disposeObject(param1);
         return param1;
      }
      
      public function addLiving(param1:LittleLiving) : LittleLiving
      {
         var _loc2_:* = null;
         if(_livings[param1.id] == null)
         {
            _livings[param1.id] = param1;
            param1.inGame = true;
            if(param1.isSelf)
            {
               setSelfPlayer(param1 as LittleSelf);
            }
            param1.speed = grid.cellSize;
            _loc2_ = grid.getNode(param1.pos.x,param1.pos.y);
            _livingCount = Number(_livingCount) + 1;
            if(running)
            {
               dispatchEvent(new LittleGameEvent("addLiving",param1));
            }
         }
         return param1;
      }
      
      public function removeLiving(param1:LittleLiving) : LittleLiving
      {
         var _loc2_:* = null;
         if(param1 && !param1.dieing && _livings[param1.id] != null)
         {
            delete _livings[param1.id];
            param1.inGame = false;
            _loc2_ = grid.getNode(param1.pos.x,param1.pos.y);
            _livingCount = Number(_livingCount) - 1;
            dispatchEvent(new LittleGameEvent("removeLiving",param1));
         }
         return param1;
      }
      
      public function get livings() : Dictionary
      {
         return _livings;
      }
      
      public function findObject(param1:int) : ILittleObject
      {
         return _objects[param1] as ILittleObject;
      }
      
      public function get littleObjects() : Dictionary
      {
         return _objects;
      }
      
      public function findLiving(param1:int) : LittleLiving
      {
         return _livings[param1] as LittleLiving;
      }
      
      public function get running() : Boolean
      {
         return _onProcess;
      }
      
      private function creat() : void
      {
         _stones.push(new Rectangle(654,20,80,200));
      }
      
      public function setSelfPlayer(param1:LittleSelf) : void
      {
         _selfPlayer = param1;
      }
      
      private function __selfCollided(param1:LittleLivingEvent) : void
      {
      }
      
      public function get selfPlayer() : LittleSelf
      {
         return _selfPlayer;
      }
      
      public function startup() : void
      {
         ProcessManager.Instance.addObject(this);
      }
      
      public function shutdown() : void
      {
         ProcessManager.Instance.removeObject(this);
      }
      
      public function pause() : void
      {
         _pause = true;
      }
      
      public function resume() : void
      {
         _pause = false;
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         LittleGameManager.Instance.synchronousLivingPos(_selfPlayer.pos.x,_selfPlayer.pos.y);
      }
      
      public function startSysnPos() : void
      {
         trace("开始同步位置==========");
         _timer.start();
      }
      
      public function stopSysnPos() : void
      {
         trace("结束同步位置");
         _timer.stop();
      }
      
      public function dispose() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         ObjectUtils.disposeObject(inhaleNeed);
         inhaleNeed = null;
         ObjectUtils.disposeObject(priceNum);
         priceNum = null;
         ObjectUtils.disposeObject(priceBack);
         priceBack = null;
         ObjectUtils.disposeObject(markBack);
         markBack = null;
         ObjectUtils.disposeObject(bigNum);
         bigNum = null;
         ObjectUtils.disposeObject(normalNum);
         normalNum = null;
         ObjectUtils.disposeObject(grid);
         grid = null;
         ProcessManager.Instance.removeObject(this);
         _timer.stop();
         _timer.removeEventListener("timer",onTimer);
         _timer = null;
         gameLoader.unload();
         gameLoader.dispose();
         var _loc6_:int = 0;
         var _loc5_:* = _livings;
         for(var _loc4_ in _livings)
         {
            _loc3_ = _livings[_loc4_];
            ObjectUtils.disposeObject(_loc3_);
            delete _livings[_loc4_];
         }
         var _loc8_:int = 0;
         var _loc7_:* = _objects;
         for(var _loc1_ in _objects)
         {
            _loc2_ = _objects[_loc1_];
            ObjectUtils.disposeObject(_loc2_);
            delete _objects[_loc1_];
         }
         _livings = null;
         _objects = null;
         _selfPlayer = null;
         gameLoader = null;
      }
      
      public function get onProcess() : Boolean
      {
         return _onProcess;
      }
      
      public function set onProcess(param1:Boolean) : void
      {
         _onProcess = param1;
      }
      
      public function process(param1:Number) : void
      {
         if(_pause)
         {
            return;
         }
         dispatchEvent(new LittleGameEvent("update"));
         var _loc4_:int = 0;
         var _loc3_:* = _livings;
         for each(var _loc2_ in _livings)
         {
            _loc2_.update();
         }
      }
      
      public function get soundEnabled() : Boolean
      {
         return _soundEnabled;
      }
      
      public function set soundEnabled(param1:Boolean) : void
      {
         if(_soundEnabled == param1)
         {
            return;
         }
         _soundEnabled = param1;
         dispatchEvent(new LittleGameEvent("soundEnabledChanged"));
      }
      
      public function get selfInhaled() : Boolean
      {
         return _selfInhaled;
      }
      
      public function set selfInhaled(param1:Boolean) : void
      {
         if(_selfInhaled == param1)
         {
            return;
         }
         _selfInhaled = param1;
         dispatchEvent(new LittleGameEvent("selfInhaledChanged"));
      }
   }
}
