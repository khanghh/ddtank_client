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
       
      
      public function KeyMy(){super();}
      
      public static function startListener(param1:InteractiveObject) : void{}
      
      public static function stopListener() : void{}
      
      public static function isDown(param1:uint) : Boolean{return false;}
      
      public static function setStage(param1:Stage) : void{}
      
      private static function mouseLeaveHandler(param1:Event) : void{}
      
      private static function keyDownHandler(param1:KeyboardEvent) : void{}
      
      private static function keyUpHandler(param1:KeyboardEvent) : void{}
   }
}
