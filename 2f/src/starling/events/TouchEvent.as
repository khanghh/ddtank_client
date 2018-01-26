package starling.events
{
   import starling.display.DisplayObject;
   
   public class TouchEvent extends Event
   {
      
      public static const TOUCH:String = "touch";
      
      private static var sTouches:Vector.<Touch> = new Vector.<Touch>(0);
       
      
      private var mShiftKey:Boolean;
      
      private var mCtrlKey:Boolean;
      
      private var mTimestamp:Number;
      
      private var mVisitedObjects:Vector.<EventDispatcher>;
      
      public function TouchEvent(param1:String, param2:Vector.<Touch>, param3:Boolean = false, param4:Boolean = false, param5:Boolean = true){super(null,null,null);}
      
      public function getTouches(param1:DisplayObject, param2:String = null, param3:Vector.<Touch> = null) : Vector.<Touch>{return null;}
      
      public function getTouch(param1:DisplayObject, param2:String = null, param3:int = -1) : Touch{return null;}
      
      public function interactsWith(param1:DisplayObject) : Boolean{return false;}
      
      function dispatch(param1:Vector.<EventDispatcher>) : void{}
      
      public function get timestamp() : Number{return 0;}
      
      public function get touches() : Vector.<Touch>{return null;}
      
      public function get shiftKey() : Boolean{return false;}
      
      public function get ctrlKey() : Boolean{return false;}
   }
}
