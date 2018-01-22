package drgnBoat.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import drgnBoat.DrgnBoatControl;
   import drgnBoat.DrgnBoatManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import invite.InviteManager;
   
   public class DrgnBoatMatchView extends Frame
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
      
      public function DrgnBoatMatchView()
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
         titleText = LanguageMgr.GetTranslation("drgnBoat.match.title");
         _bg = ComponentFactory.Instance.creatBitmap("drgnBoat.matchView.bg");
         _typeTextIcon = ComponentFactory.Instance.creatBitmap("drgnBoat.matchView.txtIcon");
         _tipTxtIcon = ComponentFactory.Instance.creatBitmap("drgnBoat.matchView.tipTxtIcon");
         _carImg = ComponentFactory.Instance.creatBitmap("drgnBoat.matchView.car" + DrgnBoatManager.instance.carStatus);
         _leftTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.race.matchViewTipTxt");
         _leftTxt.text = LanguageMgr.GetTranslation("escort.frame.matchViewTipTxt");
         _rightTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.race.matchView.rightTxt");
         _rightTxt.text = LanguageMgr.GetTranslation("drgnBoat.match.description");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.race.matchView.timeTxt");
         _timeTxt.text = "0" + _countDown;
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.matchView.cancelBtn");
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
         DrgnBoatControl.instance.addEventListener("drgnBoatCancelGame",cancelGameHandler);
      }
      
      private function cancelMatchHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 4 || param1.responseCode == 0)
         {
            SoundManager.instance.play("008");
            SocketManager.Instance.out.sendEscortCancelGame();
         }
      }
      
      private function cancelGameHandler(param1:Event) : void
      {
         dispose();
      }
      
      private function onCancel(param1:MouseEvent) : void
      {
         dispatchEvent(new FrameEvent(4));
      }
      
      private function timerHandler(param1:TimerEvent) : void
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
         DrgnBoatControl.instance.removeEventListener("drgnBoatCancelGame",cancelGameHandler);
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
