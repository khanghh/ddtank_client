package gameCommon.view.propContainer
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PropShortCutView extends Sprite
   {
       
      
      private var _btn0:SimpleBitmapButton;
      
      private var _btn1:SimpleBitmapButton;
      
      private var _btn2:SimpleBitmapButton;
      
      private var _index:int;
      
      public function PropShortCutView(){super();}
      
      public function setPropCloseVisible(param1:uint, param2:Boolean) : void{}
      
      public function setPropCloseEnabled(param1:uint, param2:Boolean) : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __throw(param1:MouseEvent) : void{}
      
      private function deleteProp() : void{}
      
      private function __over(param1:MouseEvent) : void{}
      
      private function __out(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
