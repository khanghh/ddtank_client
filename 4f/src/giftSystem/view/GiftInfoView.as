package giftSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.data.player.PlayerInfo;
   import flash.display.Sprite;
   import giftSystem.view.giftAndRecord.GiftAndRecord;
   
   public class GiftInfoView extends Sprite implements Disposeable
   {
       
      
      private var _banner:GiftBannerView;
      
      private var _giftAndRecord:GiftAndRecord;
      
      private var _info:PlayerInfo;
      
      public function GiftInfoView(){super();}
      
      private function initView() : void{}
      
      public function set info(param1:PlayerInfo) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
