package church.view.weddingRoom.frame
{
   import church.ChurchManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class WeddingRoomGiftFrameView extends BaseAlerFrame
   {
      
      private static const LEAST_GIFT_MONEY:int = 200;
       
      
      private var _bg:Bitmap;
      
      private var _alertInfo:AlertInfo;
      
      private var _txtMoney:FilterFrameText;
      
      private var _contentText:FilterFrameText;
      
      private var _noticeText:FilterFrameText;
      
      public function WeddingRoomGiftFrameView()
      {
         super();
         initialize();
      }
      
      protected function initialize() : void
      {
         setView();
         setEvent();
      }
      
      private function setView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("church.room.giftFrameBgAssetForGuest.titleText");
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _bg = ComponentFactory.Instance.creatBitmap("asset.church.room.giftFrameBgAssetForGuest");
         PositionUtils.setPos(_bg,"asset.church.room.giftFrameBgAsset.bg.pos");
         addToContent(_bg);
         _contentText = ComponentFactory.Instance.creat("church.room.frame.WeddingRoomGiftFrameView.contentText");
         _contentText.text = LanguageMgr.GetTranslation("church.room.frame.WeddingRoomGiftFrameView.contentText");
         addToContent(_contentText);
         _noticeText = ComponentFactory.Instance.creat("church.room.frame.WeddingRoomGiftFrameView.noticeText");
         _noticeText.text = LanguageMgr.GetTranslation("church.room.frame.WeddingRoomGiftFrameView.noticeText",200);
         addToContent(_noticeText);
         _txtMoney = ComponentFactory.Instance.creat("church.weddingRoom.frame.WeddingRoomGiftFrameMoneyTextAsset");
         _txtMoney.selectable = false;
         addToContent(_txtMoney);
      }
      
      public function set txtMoney(param1:String) : void
      {
         _txtMoney.text = param1;
      }
      
      private function setEvent() : void
      {
         addEventListener("response",onFrameResponse);
      }
      
      private function checkMoney() : void
      {
         var _loc1_:uint = Math.floor(PlayerManager.Instance.Self.Money / 200);
         var _loc2_:* = uint(Math.ceil(_txtMoney.text / 200) == 0?1:Number(Math.ceil(_txtMoney.text / 200)));
         if(_loc2_ >= _loc1_)
         {
            _loc2_ = _loc1_;
         }
         _txtMoney.text = String(_loc2_ * 200);
      }
      
      private function onFrameResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               dispose();
               ChurchManager.instance.dispatchEvent(new Event("submitRefund"));
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function removeView() : void
      {
         _alertInfo = null;
         if(_bg)
         {
            if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
            _bg.bitmapData.dispose();
            _bg.bitmapData = null;
         }
         _bg = null;
         if(_contentText)
         {
            if(_contentText.parent)
            {
               _contentText.parent.removeChild(_contentText);
            }
            _contentText.dispose();
         }
         _contentText = null;
         if(_noticeText)
         {
            if(_noticeText.parent)
            {
               _txtMoney.parent.removeChild(_noticeText);
            }
            _noticeText.dispose();
         }
         _noticeText = null;
         if(_txtMoney)
         {
            if(_txtMoney.parent)
            {
               _txtMoney.parent.removeChild(_txtMoney);
            }
            _txtMoney.dispose();
         }
         _txtMoney = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         dispatchEvent(new Event("close"));
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",onFrameResponse);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         removeView();
      }
   }
}
