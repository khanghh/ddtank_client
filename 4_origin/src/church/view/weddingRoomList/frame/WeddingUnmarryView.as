package church.view.weddingRoomList.frame
{
   import baglocked.BaglockedManager;
   import church.controller.ChurchRoomListController;
   import church.view.ChurchPresentFrame;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class WeddingUnmarryView extends BaseAlerFrame
   {
       
      
      private var _controller:ChurchRoomListController;
      
      private var _alertInfo:AlertInfo;
      
      private var _text1:FilterFrameText;
      
      private var _text2:FilterFrameText;
      
      private var _text3:FilterFrameText;
      
      private var _bg:Bitmap;
      
      private var _titleBg:Bitmap;
      
      private var _needMoney:int;
      
      private var _textBG:ScaleBitmapImage;
      
      private var _textI:FilterFrameText;
      
      private var _textII:FilterFrameText;
      
      private var _otherPayBtn:TextButton;
      
      private var _friendInfo:Object;
      
      private var giveFriendOpenFrame:ChurchPresentFrame;
      
      public function WeddingUnmarryView()
      {
         super();
         initialize();
      }
      
      public function set controller(value:ChurchRoomListController) : void
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
         _otherPayBtn = ComponentFactory.Instance.creatComponentByStylename("wedding.otherPay.btn");
         _otherPayBtn.text = LanguageMgr.GetTranslation("ddt.friendPay.txt");
         addToContent(_otherPayBtn);
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("ddt.unwedding.txt");
         _alertInfo.moveEnable = false;
         this.escEnable = true;
         info = _alertInfo;
         _bg = ComponentFactory.Instance.creatBitmap("asset.church.UnmarryAsset");
         addToContent(_bg);
         _textBG = ComponentFactory.Instance.creatComponentByStylename("church.main.WeddingUnmarryView.textBG");
         addToContent(_textBG);
         _textI = ComponentFactory.Instance.creatComponentByStylename("church.main.WeddingUnmarryView.text1");
         _textI.text = LanguageMgr.GetTranslation("church.main.WeddingUnmarryView.text1.text");
         addToContent(_textI);
         _textII = ComponentFactory.Instance.creatComponentByStylename("church.main.WeddingUnmarryView.text2");
         _textII.text = LanguageMgr.GetTranslation("church.main.WeddingUnmarryView.text2.text");
         addToContent(_textII);
         _text1 = ComponentFactory.Instance.creatComponentByStylename("church.view.weddingRoomList.WeddingUnmarryViewT1");
         addToContent(_text1);
         _text2 = ComponentFactory.Instance.creatComponentByStylename("church.view.weddingRoomList.WeddingUnmarryViewT2");
         addToContent(_text2);
         _text3 = ComponentFactory.Instance.creatComponentByStylename("church.view.weddingRoomList.WeddingUnmarryViewT3");
         _text3.text = LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.note");
         addToContent(_text3);
      }
      
      public function setText(str1:String = "", str2:String = "", haveDivorce:Boolean = false) : void
      {
         _text1.htmlText = str1;
         _text2.htmlText = str2;
      }
      
      private function removeView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         if(_textBG)
         {
            ObjectUtils.disposeObject(_textBG);
         }
         _textBG = null;
         if(_textI)
         {
            ObjectUtils.disposeObject(_textI);
         }
         _textI = null;
         if(_textII)
         {
            ObjectUtils.disposeObject(_textII);
         }
         _textII = null;
         if(_text1)
         {
            _text1.dispose();
         }
         _text1 = null;
         if(_text2)
         {
            _text2.dispose();
         }
         _text2 = null;
      }
      
      private function setEvent() : void
      {
         addEventListener("response",onFrameResponse);
         _otherPayBtn.addEventListener("click",mouseClickHander);
      }
      
      private function mouseClickHander(e:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         SoundManager.instance.playButtonSound();
         giveFriendOpenFrame = ComponentFactory.Instance.creatComponentByStylename("church.view.ChurchPresentFrame");
         giveFriendOpenFrame.titleTxt.visible = false;
         giveFriendOpenFrame.setType(1);
         giveFriendOpenFrame.show();
         giveFriendOpenFrame.presentBtn.addEventListener("click",presentBtnClick,false,0,true);
         giveFriendOpenFrame.addEventListener("response",responseHandler2,false,0,true);
      }
      
      private function responseHandler2(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1 || event.responseCode == 4)
         {
            StageReferance.stage.focus = this;
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",onFrameResponse);
         _otherPayBtn.removeEventListener("click",mouseClickHander);
      }
      
      private function presentBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var name:String = giveFriendOpenFrame.nameInput.text;
         if(name == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.askPay"));
            return;
         }
         if(FilterWordManager.IsNullorEmpty(name))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.askSpace"));
            return;
         }
         _friendInfo = {};
         _friendInfo["id"] = giveFriendOpenFrame.selectPlayerId;
         _friendInfo["name"] = name;
         if(giveFriendOpenFrame.textArea)
         {
            _friendInfo["msg"] = FilterWordManager.filterWrod(giveFriendOpenFrame.textArea.text);
         }
         var myName:String = PlayerManager.Instance.Self.NickName;
         if(giveFriendOpenFrame.selectPlayerId == -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.friendOffline"));
            return;
         }
         SocketManager.Instance.out.requestUnWeddingPay(giveFriendOpenFrame.selectPlayerId);
         giveFriendOpenFrame.dispose();
         giveFriendOpenFrame = null;
         dispose();
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
         if(PlayerManager.Instance.Self.Money < _needMoney)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _controller.unmarry();
         dispose();
      }
      
      private function _responseV(evt:FrameEvent) : void
      {
         var _quick:* = null;
         SoundManager.instance.play("008");
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_responseV);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            _quick = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            _quick.itemID = 11233;
            LayerManager.Instance.addToLayer(_quick,2,true,1);
         }
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      public function show(needMoney:int) : void
      {
         _needMoney = needMoney;
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         removeView();
      }
   }
}
