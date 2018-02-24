package morn.core.managers
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   import morn.core.events.UIEvent;
   
   public class RenderManager
   {
       
      
      private var _methods:Dictionary;
      
      public function RenderManager(){super();}
      
      private function invalidate() : void{}
      
      private function onValidate(param1:Event) : void{}
      
      public function renderAll() : void{}
      
      public function callLater(param1:Function, param2:Array = null) : void{}
      
      public function exeCallLater(param1:Function) : void{}
      
      public function removeCallLaterByObj(param1:Object) : void{}
      
      public function removeCallLater(param1:Function) : void{}
   }
}
