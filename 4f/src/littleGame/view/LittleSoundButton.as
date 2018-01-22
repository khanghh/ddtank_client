package littleGame.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class LittleSoundButton extends Sprite implements Disposeable
   {
       
      
      private var _back:DisplayObject;
      
      private var _state:int = -1;
      
      public function LittleSoundButton(){super();}
      
      private function addEvent() : void{}
      
      private function __mouseOut(param1:MouseEvent) : void{}
      
      private function __mouseOver(param1:MouseEvent) : void{}
      
      private function configUI() : void{}
      
      public function get state() : int{return 0;}
      
      public function set state(param1:int) : void{}
      
      public function dispose() : void{}
      
      private function removeEvent() : void{}
   }
}
