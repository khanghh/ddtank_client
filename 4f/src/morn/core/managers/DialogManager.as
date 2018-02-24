package morn.core.managers
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import morn.core.components.Box;
   import morn.core.components.Dialog;
   import morn.core.utils.ObjectUtils;
   
   public class DialogManager extends Sprite
   {
       
      
      private var _box:Box;
      
      private var _mask:Box;
      
      private var _maskBg:Sprite;
      
      public function DialogManager(){super();}
      
      private function onAddedToStage(param1:Event) : void{}
      
      private function onResize(param1:Event) : void{}
      
      public function show(param1:Dialog, param2:Boolean = false) : void{}
      
      public function popup(param1:Dialog, param2:Boolean = false) : void{}
      
      public function close(param1:Dialog) : void{}
      
      public function closeAll() : void{}
   }
}
