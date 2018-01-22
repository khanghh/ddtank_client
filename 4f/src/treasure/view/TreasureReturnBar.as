package treasure.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import treasure.events.TreasureEvents;
   
   public class TreasureReturnBar extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _stretchBtn:SelectedButton;
      
      private var _returnBtn:BaseButton;
      
      private var _pos:Point;
      
      public function TreasureReturnBar(){super();}
      
      private function initialize() : void{}
      
      private function addEvent() : void{}
      
      private function __onStretchBtnClick(param1:MouseEvent) : void{}
      
      private function __onReturnClick(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
