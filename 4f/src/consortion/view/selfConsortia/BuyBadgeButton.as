package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import road7th.utils.DateUtils;
   
   public class BuyBadgeButton extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _buyBadgeTxt:Bitmap;
      
      private var _badge:Badge;
      
      private var _badgeID:int;
      
      public function BuyBadgeButton(){super();}
      
      private function onClick(param1:MouseEvent) : void{}
      
      private function onMouseOver(param1:MouseEvent) : void{}
      
      private function onMouseOut(param1:MouseEvent) : void{}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function get badgeID() : int{return 0;}
      
      public function set badgeID(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
