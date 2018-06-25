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
      
      public static function startListener(input_object:InteractiveObject) : void
      {
         listener_object = input_object;
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
      
      public static function isDown(key:uint) : Boolean
      {
         return btn_array[key];
      }
      
      public static function setStage(stage_object:Stage) : void
      {
         stage = stage_object;
         stage_object.addEventListener(Event.MOUSE_LEAVE,mouseLeaveHandler,false,0,true);
      }
      
      private static function mouseLeaveHandler(e:Event) : void
      {
         btn_array = new Object();
      }
      
      private static function keyDownHandler(e:KeyboardEvent) : void
      {
         btn_array[e.keyCode] = true;
      }
      
      private static function keyUpHandler(e:KeyboardEvent) : void
      {
         btn_array[e.keyCode] = false;
      }
   }
}
