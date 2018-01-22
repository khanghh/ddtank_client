package starling.events
{
   import flash.utils.getQualifiedClassName;
   import starling.utils.formatString;
   
   public class Event
   {
      
      public static const ADDED:String = "added";
      
      public static const ADDED_TO_STAGE:String = "addedToStage";
      
      public static const ENTER_FRAME:String = "enterFrame";
      
      public static const REMOVED:String = "removed";
      
      public static const REMOVED_FROM_STAGE:String = "removedFromStage";
      
      public static const TRIGGERED:String = "triggered";
      
      public static const FLATTEN:String = "flatten";
      
      public static const RESIZE:String = "resize";
      
      public static const COMPLETE:String = "complete";
      
      public static const CONTEXT3D_CREATE:String = "context3DCreate";
      
      public static const RENDER:String = "render";
      
      public static const ROOT_CREATED:String = "rootCreated";
      
      public static const REMOVE_FROM_JUGGLER:String = "removeFromJuggler";
      
      public static const TEXTURES_RESTORED:String = "texturesRestored";
      
      public static const IO_ERROR:String = "ioError";
      
      public static const SECURITY_ERROR:String = "securityError";
      
      public static const PARSE_ERROR:String = "parseError";
      
      public static const FATAL_ERROR:String = "fatalError";
      
      public static const CHANGE:String = "change";
      
      public static const CANCEL:String = "cancel";
      
      public static const SCROLL:String = "scroll";
      
      public static const OPEN:String = "open";
      
      public static const CLOSE:String = "close";
      
      public static const SELECT:String = "select";
      
      public static const READY:String = "ready";
      
      private static var sEventPool:Vector.<Event> = new Vector.<Event>(0);
       
      
      private var mTarget:EventDispatcher;
      
      private var mCurrentTarget:EventDispatcher;
      
      private var mType:String;
      
      private var mBubbles:Boolean;
      
      private var mStopsPropagation:Boolean;
      
      private var mStopsImmediatePropagation:Boolean;
      
      private var mData:Object;
      
      public function Event(param1:String, param2:Boolean = false, param3:Object = null){super();}
      
      static function fromPool(param1:String, param2:Boolean = false, param3:Object = null) : Event{return null;}
      
      static function toPool(param1:Event) : void{}
      
      public function stopPropagation() : void{}
      
      public function stopImmediatePropagation() : void{}
      
      public function toString() : String{return null;}
      
      public function get bubbles() : Boolean{return false;}
      
      public function get target() : EventDispatcher{return null;}
      
      public function get currentTarget() : EventDispatcher{return null;}
      
      public function get type() : String{return null;}
      
      public function get data() : Object{return null;}
      
      function setTarget(param1:EventDispatcher) : void{}
      
      function setCurrentTarget(param1:EventDispatcher) : void{}
      
      function setData(param1:Object) : void{}
      
      function get stopsPropagation() : Boolean{return false;}
      
      function get stopsImmediatePropagation() : Boolean{return false;}
      
      function reset(param1:String, param2:Boolean = false, param3:Object = null) : Event{return null;}
   }
}
