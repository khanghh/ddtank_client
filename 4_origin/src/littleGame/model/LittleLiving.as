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
      
      public function LittleLiving(id:int, x:int, y:int, type:int, modelID:String = null)
      {
         _pos = new Point(400,400);
         _id = id;
         _pos = new Point(x,y);
         _modelID = modelID;
         _type = type;
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
      
      public function act(action:LittleAction) : void
      {
         _actionMgr.act(action);
      }
      
      public function get currentAction() : *
      {
         return _currentAction;
      }
      
      public function doAction(action:*) : void
      {
         if(_currentAction != action)
         {
            _currentAction = action;
            dispatchEvent(new LittleLivingEvent("doAction",action));
         }
      }
      
      public function stand() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _actionMgr._queue;
         for each(var action in _actionMgr._queue)
         {
            if(action is LittleLivingMoveAction)
            {
               LittleLivingMoveAction(action).cancel();
            }
         }
      }
      
      public function get pos() : Point
      {
         return _pos;
      }
      
      public function set pos(val:Point) : void
      {
         var old:Point = _pos;
         _pos = val;
         dispatchEvent(new LittleLivingEvent("posChanged",old));
      }
      
      public function get isPlayer() : Boolean
      {
         return false;
      }
      
      public function get isSelf() : Boolean
      {
         return false;
      }
      
      public function set direction(val:String) : void
      {
         if(_direction != val)
         {
            _direction = val;
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
      
      ddt_internal function setNextDirection(next:Point) : void
      {
         if(next.x > pos.x && next.y >= pos.y)
         {
            direction = "rightDown";
            doAction("walk");
         }
         else if(next.x > pos.x && next.y < pos.y)
         {
            direction = "rightUp";
            doAction("backWalk");
         }
         else if(next.x < pos.x && next.y >= pos.y)
         {
            direction = "leftDown";
            doAction("walk");
         }
         else if(next.x < pos.x && next.y < pos.y)
         {
            direction = "leftUp";
            doAction("backWalk");
         }
         else if(next.y > pos.y)
         {
            doAction("walk");
         }
         else if(next.y < pos.y)
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
      
      public function readServPaht(pkg:PackageIn) : void
      {
         var i:int = 0;
         servPath = [];
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            servPath.push(new Node(pkg.readInt(),pkg.readInt()));
            i++;
         }
      }
   }
}
