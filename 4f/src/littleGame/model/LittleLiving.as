package littleGame.model
{
   import ddt.ddt_internal;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import littleGame.actions.LittleAction;
   import littleGame.actions.LittleActionManager;
   import littleGame.actions.LittleLivingMoveAction;
   import littleGame.data.Node;
   import littleGame.events.LittleLivingEvent;
   import road7th.comm.PackageIn;
   
   use namespace ddt_internal;
   
   [Event(name="die",type="littleGame.events.LittleLivingEvent")]
   [Event(name="posChanged",type="littleGame.events.LittleLivingEvent")]
   [Event(name="directionChanged",type="littleGame.events.LittleLivingEvent")]
   [Event(name="doAction",type="littleGame.events.LittleLivingEvent")]
   public class LittleLiving extends EventDispatcher
   {
      
      public static var count:int = 0;
       
      
      public var bornLife:int;
      
      public var dieLife:int;
      
      public var dieing:Boolean = false;
      
      public var borning:Boolean = false;
      
      public var speed:int = 10;
      
      public var collideable:Boolean = false;
      
      public var name:String;
      
      public var size:int;
      
      public var MotionState:int = 2;
      
      public var inGame:Boolean = false;
      
      public var dx:int;
      
      public var dy:int;
      
      public var lock:Boolean;
      
      private var _id:int;
      
      ddt_internal var _modelID:String;
      
      ddt_internal var gridIdx:int;
      
      private var _pos:Point;
      
      private var _path:Array;
      
      private var _type:int;
      
      private var _inhaled:Boolean = false;
      
      private var _onProcess:Boolean = false;
      
      private var _idx:int = 0;
      
      private var _direction:String = "leftDown";
      
      protected var _actionMgr:LittleActionManager;
      
      protected var _currentAction;
      
      public var servPath:Array;
      
      public function LittleLiving(param1:int, param2:int, param3:int, param4:int, param5:String = null){super();}
      
      public function get id() : int{return 0;}
      
      public function get type() : int{return 0;}
      
      public function dispose() : void{}
      
      public final function update() : void{}
      
      public function act(param1:LittleAction) : void{}
      
      public function get currentAction() : *{return null;}
      
      public function doAction(param1:*) : void{}
      
      public function stand() : void{}
      
      public function get pos() : Point{return null;}
      
      public function set pos(param1:Point) : void{}
      
      public function get isPlayer() : Boolean{return false;}
      
      public function get isSelf() : Boolean{return false;}
      
      public function set direction(param1:String) : void{}
      
      public function get direction() : String{return null;}
      
      public function get isBack() : Boolean{return false;}
      
      public function get isLeft() : Boolean{return false;}
      
      ddt_internal function setNextDirection(param1:Point) : void{}
      
      override public function toString() : String{return null;}
      
      public function readServPaht(param1:PackageIn) : void{}
   }
}
