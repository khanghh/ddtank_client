package catchInsect.view
{
   import catchInsect.CatchInsectControl;
   import catchInsect.CatchInsectManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class CatchInsectChooseFrame extends Frame
   {
       
      
      private var _roomBgImg:ScaleBitmapImage;
      
      private var _entranceImg:Bitmap;
      
      private var _activeTimeTxt:FilterFrameText;
      
      private var _chooseRoomText:FilterFrameText;
      
      private var _gotoForestBtn:BaseButton;
      
      private var _checkGeinBtn:BaseButton;
      
      private var _helpBtn:BaseButton;
      
      private var _bottomBg:ScaleBitmapImage;
      
      private var _clickDate:Number = 0;
      
      public function CatchInsectChooseFrame()
      {
         super();
         initView();
         initEvent();
         initText();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("catchInsect.chooseFrameTitle");
         _roomBgImg = ComponentFactory.Instance.creatComponentByStylename("catchInsect.chooseFrame.bg");
         _entranceImg = ComponentFactory.Instance.creatBitmap("catchInsect.entranceImg");
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("catchInsect.chooseFrame.bottomBg");
         _activeTimeTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.chooseFrame.timeTxt");
         _chooseRoomText = ComponentFactory.Instance.creatComponentByStylename("catchInsect.chooseFrame.descTxt");
         _gotoForestBtn = ComponentFactory.Instance.creat("catchInsect.chooseFrame.gotoForestBtn");
         _checkGeinBtn = ComponentFactory.Instance.creat("catchInsect.chooseFrame.checkGeinBtn");
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"catchInsect.chooseFrame.helpBtn",null,LanguageMgr.GetTranslation("ddt.ringstation.helpTitle"),"catchInsect.helpTxt",504,484);
         addToContent(_roomBgImg);
         addToContent(_entranceImg);
         addToContent(_bottomBg);
         addToContent(_activeTimeTxt);
         addToContent(_chooseRoomText);
         addToContent(_gotoForestBtn);
         addToContent(_checkGeinBtn);
         addToContent(_helpBtn);
      }
      
      private function initText() : void
      {
         _chooseRoomText.text = LanguageMgr.GetTranslation("catchInsect.chooseFrame.descTxt");
         _activeTimeTxt.text = LanguageMgr.GetTranslation("catchInsect.chooseFrame.timeTxt",CatchInsectManager.instance.model.activityTime);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _gotoForestBtn.addEventListener("click",__gotoForestBtnClick);
         _checkGeinBtn.addEventListener("click",__checkGeinBtnClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_gotoForestBtn)
         {
            _gotoForestBtn.removeEventListener("click",__gotoForestBtnClick);
         }
         if(_checkGeinBtn)
         {
            _checkGeinBtn.removeEventListener("click",__checkGeinBtnClick);
         }
      }
      
      private function __gotoForestBtnClick(e:MouseEvent) : void
      {
         if(new Date().time - _clickDate > 1000)
         {
            _clickDate = new Date().time;
            SoundManager.instance.play("008");
            SocketManager.Instance.out.enterOrLeaveInsectScene(0);
         }
      }
      
      private function __checkGeinBtnClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CatchInsectControl.instance.openCheckGeinFrame();
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         _roomBgImg = null;
         _entranceImg = null;
         _activeTimeTxt = null;
         _chooseRoomText = null;
         _gotoForestBtn = null;
         _checkGeinBtn = null;
         _helpBtn = null;
         _bottomBg = null;
      }
   }
}
