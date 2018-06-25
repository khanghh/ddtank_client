package oldplayergetticket
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import road7th.comm.PackageIn;
   
   public class GetTicketView extends Frame
   {
      
      private static var _getSuccess:Boolean = false;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _textBg:Bitmap;
      
      private var _bottomBtnBg:ScaleBitmapImage;
      
      private var _captionTxt1:FilterFrameText;
      
      private var _captionTxt2:FilterFrameText;
      
      private var _captionTxt3:FilterFrameText;
      
      private var _captionTxt4:FilterFrameText;
      
      private var _rechargeTicketNum:FilterFrameText;
      
      private var _tiepointNum:FilterFrameText;
      
      private var _recvBtn:BaseButton;
      
      public function GetTicketView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ddt.regress.getticketView.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("oldplayer.getTicketBg");
         addToContent(_bg);
         _textBg = ComponentFactory.Instance.creatBitmap("asset.getTicket.textBg");
         addToContent(_textBg);
         _bottomBtnBg = ComponentFactory.Instance.creatComponentByStylename("oldplayer.bottomBgImg");
         addToContent(_bottomBtnBg);
         _captionTxt1 = ComponentFactory.Instance.creatComponentByStylename("oldplayer.caption1");
         _captionTxt1.text = LanguageMgr.GetTranslation("ddt.regress.getticketView.caption1");
         addToContent(_captionTxt1);
         _captionTxt2 = ComponentFactory.Instance.creatComponentByStylename("oldplayer.caption2");
         addToContent(_captionTxt2);
         _captionTxt3 = ComponentFactory.Instance.creatComponentByStylename("oldplayer.caption3");
         addToContent(_captionTxt3);
         _captionTxt4 = ComponentFactory.Instance.creatComponentByStylename("oldplayer.caption4");
         _captionTxt4.text = LanguageMgr.GetTranslation("ddt.regress.getticketView.caption4");
         addToContent(_captionTxt4);
         _rechargeTicketNum = ComponentFactory.Instance.creatComponentByStylename("oldplayer.rechargeTicketNum");
         addToContent(_rechargeTicketNum);
         _tiepointNum = ComponentFactory.Instance.creatComponentByStylename("oldplayer.tiepointNum");
         addToContent(_tiepointNum);
         _recvBtn = ComponentFactory.Instance.creatComponentByStylename("oldplayer.recvBtn");
         addToContent(_recvBtn);
         _recvBtn.enable = !_getSuccess;
      }
      
      public function setViewData(info:Array) : void
      {
         _captionTxt2.text = LanguageMgr.GetTranslation("ddt.regress.getticketView.caption2",info[0],info[1]);
         _captionTxt3.text = LanguageMgr.GetTranslation("ddt.regress.getticketView.caption3",info[2]);
         _rechargeTicketNum.text = info[3].toString();
         _tiepointNum.text = info[4].toString();
         _recvBtn.enable = info[4] != 0;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _recvBtn.addEventListener("click",__onRecvBtnClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(149,7),__onGetTicket);
      }
      
      protected function __onRecvBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.sendRegressTicket();
      }
      
      protected function __onGetTicket(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var flag:int = pkg.readInt();
         if(flag == 0)
         {
            SocketManager.Instance.out.sendRegressTicketInfo();
            _recvBtn.enable = false;
            _getSuccess = true;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.regress.getticketView.getTicket"));
         }
         else if(flag != 1)
         {
            if(flag != 2)
            {
            }
         }
      }
      
      protected function __onAlertResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__onAlertResponse);
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
               SoundManager.instance.playButtonSound();
               alert.dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _recvBtn.removeEventListener("click",__onRecvBtnClick);
         SocketManager.Instance.removeEventListener(PkgEvent.format(149,7),__onGetTicket);
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               GetTicketManager.instance.hide();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_bg)
         {
            _bg.dispose();
            _bg = null;
         }
         if(_textBg)
         {
            _textBg.bitmapData.dispose();
            _textBg.bitmapData = null;
            _textBg = null;
         }
         if(_bottomBtnBg)
         {
            _bottomBtnBg.dispose();
            _bottomBtnBg = null;
         }
         if(_captionTxt1)
         {
            _captionTxt1.dispose();
            _captionTxt1 = null;
         }
         if(_captionTxt2)
         {
            _captionTxt2.dispose();
            _captionTxt2 = null;
         }
         if(_captionTxt3)
         {
            _captionTxt3.dispose();
            _captionTxt3 = null;
         }
         if(_rechargeTicketNum)
         {
            _rechargeTicketNum.dispose();
            _rechargeTicketNum = null;
         }
         if(_tiepointNum)
         {
            _tiepointNum.dispose();
            _tiepointNum = null;
         }
         if(_recvBtn)
         {
            _recvBtn.dispose();
            _recvBtn = null;
         }
      }
   }
}
