package escort.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import escort.EscortControl;
   import escort.EscortManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import invite.InviteManager;
   
   public class EscortMatchView extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _carImg:Bitmap;
      
      private var _typeTextIcon:Bitmap;
      
      private var _tipTxtIcon:Bitmap;
      
      private var _leftTxt:FilterFrameText;
      
      private var _rightTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _cancelBtn:SimpleBitmapButton;
      
      private var _countDown:int = 9;
      
      private var _timer:Timer;
      
      private var _isDispose:Boolean = false;
      
      public function EscortMatchView()
      {
         super();
         initView();
         initEvent();
         _timer = new Timer(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
         _timer.start();
         InviteManager.Instance.enabled = false;
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("escort.frame.matchViewTitleTxt");
         _bg = ComponentFactory.Instance.creatBitmap("asset.escort.matchView.bg");
         _typeTextIcon = ComponentFactory.Instance.creatBitmap("asset.escort.matchViewtextIcon");
         _tipTxtIcon = ComponentFactory.Instance.creatBitmap("asset.escort.matchView.tipTxtIcon");
         _carImg = ComponentFactory.Instance.creatBitmap("asset.escort.matchView.car" + EscortControl.instance.carStatus);
         _leftTxt = ComponentFactory.Instance.creatComponentByStylename("escort.frame.matchViewTipTxt");
         _leftTxt.text = LanguageMgr.GetTranslation("escort.frame.matchViewTipTxt");
         _rightTxt = ComponentFactory.Instance.creatComponentByStylename("escort.matchView.rightTxt");
         _rightTxt.text = LanguageMgr.GetTranslation("escort.frame.matchViewRightTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("escort.matchView.timeTxt");
         _timeTxt.text = "0" + _countDown;
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("escort.matchViewCancelBtn");
         addToContent(_bg);
         addToContent(_typeTextIcon);
         addToContent(_tipTxtIcon);
         addToContent(_carImg);
         addToContent(_leftTxt);
         addToContent(_rightTxt);
         addToContent(_timeTxt);
         addToContent(_cancelBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",cancelMatchHandler);
         _cancelBtn.addEventListener("click",onCancel,false,0,true);
         EscortManager.instance.addEventListener("escortCancelGame",cancelGameHandler);
      }
      
      private function cancelMatchHandler(event:FrameEvent) : void
      {
         if(event.responseCode == 1 || event.responseCode == 4 || event.responseCode == 0)
         {
            SoundManager.instance.play("008");
            SocketManager.Instance.out.sendEscortCancelGame();
         }
      }
      
      private function cancelGameHandler(event:Event) : void
      {
         dispose();
      }
      
      private function onCancel(event:MouseEvent) : void
      {
         dispatchEvent(new FrameEvent(4));
      }
      
      private function timerHandler(event:TimerEvent) : void
      {
         _countDown = Number(_countDown) - 1;
         if(_countDown < 0)
         {
            _countDown = 9;
         }
         _timeTxt.text = "0" + _countDown;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",cancelMatchHandler);
         _cancelBtn.removeEventListener("click",onCancel);
         EscortManager.instance.removeEventListener("escortCancelGame",cancelGameHandler);
      }
      
      override public function dispose() : void
      {
         if(_isDispose)
         {
            return;
         }
         removeEvent();
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timerHandler);
         }
         _timer = null;
         super.dispose();
         _bg = null;
         _carImg = null;
         _typeTextIcon = null;
         _tipTxtIcon = null;
         _leftTxt = null;
         _rightTxt = null;
         _timeTxt = null;
         _cancelBtn = null;
         InviteManager.Instance.enabled = true;
         _isDispose = true;
      }
   }
}
