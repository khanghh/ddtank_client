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
      
      private function __clock(event:TimerEvent) : void
      {
      }
      
      ddt_internal function drawNum() : void
      {
         inhaleNeed = ClassUtils.CreatInstance("asset.littleGame.InhaleNeed");
         priceBack = ClassUtils.CreatInstance("asset.littleGame.price");
         priceNum = ClassUtils.CreatInstance("asset.littleGame.numprice");
         markBack = ClassUtils.CreatInstance("asset.littleGame.Mark");
         bigNum = ClassUtils.CreatInstance("asset.littleGame.num");
         var s:Number = 22 / bigNum.height;
         var mat:Matrix = new Matrix();
         mat.scale(s,s);
         normalNum = new BitmapData(bigNum.width * s,bigNum.height * s,true,0);
         normalNum.draw(bigNum,mat,null,null,null,true);
      }
      
      public function get stones() : Vector.<Rectangle>
      {
         return _stones;
      }
      
      public function addObject(object:ILittleObject) : ILittleObject
      {
         _objects[object.id] = object;
         return object;
      }
      
      public function removeObject(object:ILittleObject) : ILittleObject
      {
         if(object == null)
         {
            return null;
         }
         delete _objects[object.id];
         ObjectUtils.disposeObject(object);
         return object;
      }
      
      public function addLiving(living:LittleLiving) : LittleLiving
      {
         var node:* = null;
         if(_livings[living.id] == null)
         {
            _livings[living.id] = living;
            living.inGame = true;
            if(living.isSelf)
            {
               setSelfPlayer(living as LittleSelf);
            }
            living.speed = grid.cellSize;
            node = grid.getNode(living.pos.x,living.pos.y);
            _livingCount = Number(_livingCount) + 1;
            if(running)
            {
               dispatchEvent(new LittleGameEvent("addLiving",living));
            }
         }
         return living;
      }
      
      public function removeLiving(living:LittleLiving) : LittleLiving
      {
         var node:* = null;
         if(living && !living.dieing && _livings[living.id] != null)
         {
            delete _livings[living.id];
            living.inGame = false;
            node = grid.getNode(living.pos.x,living.pos.y);
            _livingCount = Number(_livingCount) - 1;
            dispatchEvent(new LittleGameEvent("removeLiving",living));
         }
         return living;
      }
      
      public function get livings() : Dictionary
      {
         return _livings;
      }
      
      public function findObject(id:int) : ILittleObject
      {
         return _objects[id] as ILittleObject;
      }
      
      public function get littleObjects() : Dictionary
      {
         return _objects;
      }
      
      public function findLiving(id:int) : LittleLiving
      {
         return _livings[id] as LittleLiving;
      }
      
      public function get running() : Boolean
      {
         return _onProcess;
      }
      
      private function creat() : void
      {
         _stones.push(new Rectangle(654,20,80,200));
      }
      
      public function setSelfPlayer(self:LittleSelf) : void
      {
         _selfPlayer = self;
      }
      
      private function __selfCollided(event:LittleLivingEvent) : void
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
      
      private function onTimer(event:TimerEvent) : void
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
         var living:* = null;
         var object:* = null;
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
         for(var key in _livings)
         {
            living = _livings[key];
            ObjectUtils.disposeObject(living);
            delete _livings[key];
         }
         var _loc8_:int = 0;
         var _loc7_:* = _objects;
         for(var key2 in _objects)
         {
            object = _objects[key2];
            ObjectUtils.disposeObject(object);
            delete _objects[key2];
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
      
      public function set onProcess(val:Boolean) : void
      {
         _onProcess = val;
      }
      
      public function process(rate:Number) : void
      {
         if(_pause)
         {
            return;
         }
         dispatchEvent(new LittleGameEvent("update"));
         var _loc4_:int = 0;
         var _loc3_:* = _livings;
         for each(var living in _livings)
         {
            living.update();
         }
      }
      
      public function get soundEnabled() : Boolean
      {
         return _soundEnabled;
      }
      
      public function set soundEnabled(value:Boolean) : void
      {
         if(_soundEnabled == value)
         {
            return;
         }
         _soundEnabled = value;
         dispatchEvent(new LittleGameEvent("soundEnabledChanged"));
      }
      
      public function get selfInhaled() : Boolean
      {
         return _selfInhaled;
      }
      
      public function set selfInhaled(value:Boolean) : void
      {
         if(_selfInhaled == value)
         {
            return;
         }
         _selfInhaled = value;
         dispatchEvent(new LittleGameEvent("selfInhaledChanged"));
      }
   }
}
