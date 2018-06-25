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
      
      public function GiftInfoView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _banner = ComponentFactory.Instance.creatCustomObject("giftBannerView");
         _giftAndRecord = ComponentFactory.Instance.creatCustomObject("giftAndRecord");
         addChild(_banner);
         addChild(_giftAndRecord);
      }
      
      public function set info(value:PlayerInfo) : void
      {
         if(_info == value)
         {
            return;
         }
         _info = value;
         _banner.info = _info;
         _giftAndRecord.info = _info;
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_banner)
         {
            _banner.dispose();
         }
         _banner = null;
         if(_giftAndRecord)
         {
            _giftAndRecord.dispose();
         }
         _giftAndRecord = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
