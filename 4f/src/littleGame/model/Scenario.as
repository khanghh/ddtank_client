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
      
      public function Scenario(){super();}
      
      private function __clock(param1:TimerEvent) : void{}
      
      ddt_internal function drawNum() : void{}
      
      public function get stones() : Vector.<Rectangle>{return null;}
      
      public function addObject(param1:ILittleObject) : ILittleObject{return null;}
      
      public function removeObject(param1:ILittleObject) : ILittleObject{return null;}
      
      public function addLiving(param1:LittleLiving) : LittleLiving{return null;}
      
      public function removeLiving(param1:LittleLiving) : LittleLiving{return null;}
      
      public function get livings() : Dictionary{return null;}
      
      public function findObject(param1:int) : ILittleObject{return null;}
      
      public function get littleObjects() : Dictionary{return null;}
      
      public function findLiving(param1:int) : LittleLiving{return null;}
      
      public function get running() : Boolean{return false;}
      
      private function creat() : void{}
      
      public function setSelfPlayer(param1:LittleSelf) : void{}
      
      private function __selfCollided(param1:LittleLivingEvent) : void{}
      
      public function get selfPlayer() : LittleSelf{return null;}
      
      public function startup() : void{}
      
      public function shutdown() : void{}
      
      public function pause() : void{}
      
      public function resume() : void{}
      
      private function onTimer(param1:TimerEvent) : void{}
      
      public function startSysnPos() : void{}
      
      public function stopSysnPos() : void{}
      
      public function dispose() : void{}
      
      public function get onProcess() : Boolean{return false;}
      
      public function set onProcess(param1:Boolean) : void{}
      
      public function process(param1:Number) : void{}
      
      public function get soundEnabled() : Boolean{return false;}
      
      public function set soundEnabled(param1:Boolean) : void{}
      
      public function get selfInhaled() : Boolean{return false;}
      
      public function set selfInhaled(param1:Boolean) : void{}
   }
}
