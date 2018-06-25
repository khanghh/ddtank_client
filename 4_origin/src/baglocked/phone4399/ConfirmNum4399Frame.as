package baglocked.phone4399
{
   import baglocked.BagLockedController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ConfirmNum4399Frame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _description:FilterFrameText;
      
      private var _numInput:TextInput;
      
      private var _countDownTxt:FilterFrameText;
      
      private var _remainTxt:FilterFrameText;
      
      private var _confirmBtn:TextButton;
      
      private var remain:int;
      
      private var _timer:TimerJuggler;
      
      public function ConfirmNum4399Frame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.resetQuestion");
         _description = ComponentFactory.Instance.creatComponentByStylename("baglocked.whiteTxt");
         _description.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.inputIn60s");
         PositionUtils.setPos(_description,"bagLocked.inputIn60sPos");
         addToContent(_description);
         _numInput = ComponentFactory.Instance.creatComponentByStylename("baglocked.phoneTextInput");
         _numInput.textField.restrict = "0-9";
         _numInput.maxChars = 4;
         addToContent(_numInput);
         _countDownTxt = ComponentFactory.Instance.creatComponentByStylename("baglocked.whiteTxt");
         _countDownTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.countDown");
         PositionUtils.setPos(_countDownTxt,"bagLocked.countDownPos");
         addToContent(_countDownTxt);
         _remainTxt = ComponentFactory.Instance.creatComponentByStylename("baglocked.deepRedTxt");
         PositionUtils.setPos(_remainTxt,"bagLocked.remainTxtPos");
         addToContent(_remainTxt);
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         _confirmBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.confirm");
         PositionUtils.setPos(_confirmBtn,"bagLocked.nextBtnPos2");
         addToContent(_confirmBtn);
         remain = 60;
         _remainTxt.text = remain + " " + LanguageMgr.GetTranslation("tank.timebox.second");
         _timer = TimerManager.getInstance().addTimerJuggler(1000,60);
         _timer.addEventListener("timer",onTimer);
         _timer.addEventListener("timerComplete",onTimerComplete);
         _timer.start();
         addEvent();
      }
      
      private function onTimer(event:TimerEvent) : void
      {
         remain = Number(remain) - 1;
         _remainTxt.text = remain + " " + LanguageMgr.GetTranslation("tank.timebox.second");
      }
      
      protected function onTimerComplete(event:TimerEvent) : void
      {
         _timer.removeEventListener("timer",onTimer);
         _timer.removeEventListener("timerComplete",onTimerComplete);
         TimerManager.getInstance().removeTimerJuggler(_timer.id);
         _timer = null;
         _confirmBtn.enable = false;
      }
      
      protected function __confirmBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_numInput.text.length != 4)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.msnLengthWrong"));
            return;
         }
         BagLockedController.Instance.requestConfirm(2,_numInput.text);
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               _bagLockedController.close();
         }
      }
      
      public function set bagLockedController(value:BagLockedController) : void
      {
         _bagLockedController = value;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _confirmBtn.addEventListener("click",__confirmBtnClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _confirmBtn.removeEventListener("click",__confirmBtnClick);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_timer)
         {
            _timer.removeEventListener("timer",onTimer);
            _timer.removeEventListener("timerComplete",onTimerComplete);
            TimerManager.getInstance().removeTimerJuggler(_timer.id);
            _timer = null;
         }
         ObjectUtils.disposeObject(_description);
         _description = null;
         ObjectUtils.disposeObject(_numInput);
         _numInput = null;
         ObjectUtils.disposeObject(_countDownTxt);
         _countDownTxt = null;
         ObjectUtils.disposeObject(_remainTxt);
         _remainTxt = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         super.dispose();
      }
   }
}
