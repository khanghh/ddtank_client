package yzhkof
{
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class KeyMy
   {
      
      private static var listener_object:InteractiveObject;
      
      private static var btn_array:Object;
      
      private static var stage:Stage;
       
      
      public function KeyMy()
      {
         super();
         throw Error("This Class is Singleton Patton");
      }
      
      public static function startListener(param1:InteractiveObject) : void
      {
         listener_object = param1;
         btn_array = new Object();
         listener_object.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
         listener_object.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
      }
      
      public static function stopListener() : void
      {
         listener_object.removeEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
         listener_object.removeEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
         if(stage != null)
         {
            stage.removeEventListener(Event.MOUSE_LEAVE,mouseLeaveHandler);
         }
      }
      
      public static function isDown(param1:uint) : Boolean
      {
         return btn_array[param1];
      }
      
      public static function setStage(param1:Stage) : void
      {
         stage = param1;
         param1.addEventListener(Event.MOUSE_LEAVE,mouseLeaveHandler,false,0,true);
      }
      
      private static function mouseLeaveHandler(param1:Event) : void
      {
         btn_array = new Object();
      }
      
      private static function keyDownHandler(param1:KeyboardEvent) : void
      {
         btn_array[param1.keyCode] = true;
      }
      
      private static function keyUpHandler(param1:KeyboardEvent) : void
      {
         btn_array[param1.keyCode] = false;
      }
   }
}
