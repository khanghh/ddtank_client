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
      
      public function LittleLiving(param1:int, param2:int, param3:int, param4:int, param5:String = null)
      {
         _pos = new Point(400,400);
         _id = param1;
         _pos = new Point(param2,param3);
         _modelID = param5;
         _type = param4;
         _actionMgr = new LittleActionManager();
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function dispose() : void
      {
         _actionMgr = null;
      }
      
      public final function update() : void
      {
         _actionMgr.execute();
      }
      
      public function act(param1:LittleAction) : void
      {
         _actionMgr.act(param1);
      }
      
      public function get currentAction() : *
      {
         return _currentAction;
      }
      
      public function doAction(param1:*) : void
      {
         if(_currentAction != param1)
         {
            _currentAction = param1;
            dispatchEvent(new LittleLivingEvent("doAction",param1));
         }
      }
      
      public function stand() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _actionMgr._queue;
         for each(var _loc1_ in _actionMgr._queue)
         {
            if(_loc1_ is LittleLivingMoveAction)
            {
               LittleLivingMoveAction(_loc1_).cancel();
            }
         }
      }
      
      public function get pos() : Point
      {
         return _pos;
      }
      
      public function set pos(param1:Point) : void
      {
         var _loc2_:Point = _pos;
         _pos = param1;
         dispatchEvent(new LittleLivingEvent("posChanged",_loc2_));
      }
      
      public function get isPlayer() : Boolean
      {
         return false;
      }
      
      public function get isSelf() : Boolean
      {
         return false;
      }
      
      public function set direction(param1:String) : void
      {
         if(_direction != param1)
         {
            _direction = param1;
            dispatchEvent(new LittleLivingEvent("directionChanged"));
         }
      }
      
      public function get direction() : String
      {
         return _direction;
      }
      
      public function get isBack() : Boolean
      {
         return _direction == "rightUp" || _direction == "leftUp";
      }
      
      public function get isLeft() : Boolean
      {
         return _direction == "leftDown" || _direction == "leftUp";
      }
      
      ddt_internal function setNextDirection(param1:Point) : void
      {
         if(param1.x > pos.x && param1.y >= pos.y)
         {
            direction = "rightDown";
            doAction("walk");
         }
         else if(param1.x > pos.x && param1.y < pos.y)
         {
            direction = "rightUp";
            doAction("backWalk");
         }
         else if(param1.x < pos.x && param1.y >= pos.y)
         {
            direction = "leftDown";
            doAction("walk");
         }
         else if(param1.x < pos.x && param1.y < pos.y)
         {
            direction = "leftUp";
            doAction("backWalk");
         }
         else if(param1.y > pos.y)
         {
            doAction("walk");
         }
         else if(param1.y < pos.y)
         {
            doAction("backWalk");
         }
         else if(isBack)
         {
            doAction("backWalk");
         }
         else
         {
            doAction("walk");
         }
      }
      
      override public function toString() : String
      {
         return "LittleLiving_" + _id;
      }
      
      public function readServPaht(param1:PackageIn) : void
      {
         var _loc3_:int = 0;
         servPath = [];
         var _loc2_:int = param1.readInt();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            servPath.push(new Node(param1.readInt(),param1.readInt()));
            _loc3_++;
         }
      }
   }
}
