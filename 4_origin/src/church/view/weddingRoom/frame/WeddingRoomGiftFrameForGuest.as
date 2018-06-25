package church.view.weddingRoom.frame
{
   import church.controller.ChurchRoomController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   
   public class WeddingRoomGiftFrameForGuest extends BaseAlerFrame
   {
      
      public static const RESTRICT:String = "0-9";
      
      public static const DEFAULT:String = "100";
      
      private static const LEAST_MONEY:int = 100;
       
      
      private var _controller:ChurchRoomController;
      
      private var _bg:Bitmap;
      
      private var _alertInfo:AlertInfo;
      
      private var _txtMoney:FilterFrameText;
      
      private var _alertConfirm:BaseAlerFrame;
      
      private var _contentText:FilterFrameText;
      
      private var _money:FilterFrameText;
      
      private var _noticeText:FilterFrameText;
      
      private var _inputBG:Scale9CornerImage;
      
      public function WeddingRoomGiftFrameForGuest()
      {
         super();
         initialize();
      }
      
      public function get controller() : ChurchRoomController
      {
         return _controller;
      }
      
      public function set controller(value:ChurchRoomController) : void
      {
         _controller = value;
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
         _alertInfo.moveEnable = false;
         _alertInfo.title = LanguageMgr.GetTranslation("church.room.giftFrameBgAssetForGuest.titleText");
         info = _alertInfo;
         this.escEnable = true;
         _bg = ComponentFactory.Instance.creatBitmap("asset.church.room.giftFrameBgAssetForGuest");
         PositionUtils.setPos(_bg,"asset.church.room.giftFrameBgAssetForGuest.pos");
         addToContent(_bg);
         _contentText = ComponentFactory.Instance.creat("church.room.frame.WeddingRoomGiftFrameForGuest.contentText");
         _contentText.text = LanguageMgr.GetTranslation("church.room.frame.WeddingRoomGiftFrameForGuest.contentText");
         addToContent(_contentText);
         _inputBG = ComponentFactory.Instance.creatComponentByStylename("church.room.frame.WeddingRoomGiftFrameForGuest.moneyText.InputBG");
         addToContent(_inputBG);
         _money = ComponentFactory.Instance.creat("church.room.frame.WeddingRoomGiftFrameForGuest.moneyText");
         _money.text = LanguageMgr.GetTranslation("money");
         addToContent(_money);
         _noticeText = ComponentFactory.Instance.creat("church.room.frame.WeddingRoomGiftFrameForGuest.noticeText");
         _noticeText.text = LanguageMgr.GetTranslation("church.room.frame.WeddingRoomGiftFrameForGuest.noticeText",100);
         addToContent(_noticeText);
         _txtMoney = ComponentFactory.Instance.creat("church.weddingRoom.frame.WeddingRoomGiftFrameMoneyTextAssetForGuest");
         _txtMoney.maxChars = 8;
         _txtMoney.restrict = "0-9";
         _txtMoney.text = "100";
         addToContent(_txtMoney);
      }
      
      private function setEvent() : void
      {
         addEventListener("response",onFrameResponse);
         _txtMoney.addEventListener("mouseFocusChange",__focusOut);
         _txtMoney.addEventListener("keyDown",__keyDown);
      }
      
      private function __keyDown(event:KeyboardEvent) : void
      {
         if(event.keyCode == 13)
         {
            event.stopImmediatePropagation();
            SoundManager.instance.play("008");
            confirmSubmit();
         }
      }
      
      private function __focusOut(event:FocusEvent) : void
      {
         checkMoney();
      }
      
      private function checkMoney() : void
      {
         var total:uint = Math.floor(PlayerManager.Instance.Self.Money / 100);
         var current:* = uint(Math.ceil(_txtMoney.text / 100) == 0?1:Number(Math.ceil(_txtMoney.text / 100)));
         if(current >= total)
         {
            current = total;
         }
         _txtMoney.text = String(current * 100);
      }
      
      private function onFrameResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               confirmSubmit();
         }
      }
      
      private function confirmSubmit() : void
      {
         checkMoney();
         _alertConfirm = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaTax.info"),LanguageMgr.GetTranslation("church.churchScene.frame.PresentFrame.confirm") + _txtMoney.text + LanguageMgr.GetTranslation("tank.view.emailII.EmailIIDiamondView.money"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _alertConfirm.addEventListener("response",confirm);
      }
      
      private function confirm(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               ObjectUtils.disposeObject(evt.target);
               break;
            case 2:
            case 3:
            case 4:
               _controller.giftSubmit(uint(_txtMoney.text));
               dispose();
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
         if(_inputBG)
         {
            if(_inputBG.parent)
            {
               _inputBG.parent.removeChild(_inputBG);
            }
            _inputBG.dispose();
         }
         _inputBG = null;
         if(_money)
         {
            if(_money.parent)
            {
               _money.parent.removeChild(_money);
            }
            _money.dispose();
         }
         _money = null;
         if(_noticeText)
         {
            if(_noticeText.parent)
            {
               _noticeText.parent.removeChild(_noticeText);
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
         if(_alertConfirm)
         {
            if(_alertConfirm.parent)
            {
               _alertConfirm.parent.removeChild(_alertConfirm);
            }
            _alertConfirm.dispose();
         }
         _alertConfirm = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         dispatchEvent(new Event("close"));
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",onFrameResponse);
         if(_txtMoney)
         {
            _txtMoney.removeEventListener("mouseFocusChange",__focusOut);
         }
         if(_alertConfirm)
         {
            _alertConfirm.removeEventListener("response",confirm);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         removeView();
      }
   }
}
