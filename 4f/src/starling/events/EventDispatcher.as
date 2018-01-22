package starling.events
{
   import flash.utils.Dictionary;
   import starling.display.DisplayObject;
   
   public class EventDispatcher
   {
      
      private static var sBubbleChains:Array = [];
       
      
      private var mEventListeners:Dictionary;
      
      public function EventDispatcher(){super();}
      
      public function addEventListener(param1:String, param2:Function) : void{}
      
      public function removeEventListener(param1:String, param2:Function) : void{}
      
      public function removeEventListeners(param1:String = null) : void{}
      
      public function dispatchEvent(param1:Event) : void{}
      
      function invokeEvent(param1:Event) : Boolean{return false;}
      
      function bubbleEvent(param1:Event) : void{}
      
      public function dispatchEventWith(param1:String, param2:Boolean = false, param3:Object = null) : void{}
      
      public function hasEventListener(param1:String) : Boolean{return false;}
   }
}
