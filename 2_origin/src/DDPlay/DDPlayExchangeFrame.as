package DDPlay
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class DDPlayExchangeFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _exchangeBtn:SimpleBitmapButton;
      
      private var _chooseNum:DDPlayExchangeNumberSekecter;
      
      private var _exchangeNum:Bitmap;
      
      private var _currentScore:FilterFrameText;
      
      private var _currentScoreBg:Bitmap;
      
      private var _currentScore2:FilterFrameText;
      
      private var _score:int;
      
      private var _fold:int;
      
      public function DDPlayExchangeFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         _fold = DDPlayManaer.Instance.exchangeFold;
         this.titleText = LanguageMgr.GetTranslation("tank.ddPlay.exchangeFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("DDPlay.exchange.frame.background");
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("DDPlay.exchange.frame.frameBtn");
         _chooseNum = ComponentFactory.Instance.creatComponentByStylename("DDPlay.exchange.frame.NumberSelecter");
         _exchangeNum = ComponentFactory.Instance.creatBitmap("DDPlay.exchange.exchangeNumber");
         _currentScoreBg = ComponentFactory.Instance.creatBitmap("DDPlay.exchange.currentScoreBg");
         _currentScore = ComponentFactory.Instance.creatComponentByStylename("DDPlay.exchange.frame.currentScoreTxt");
         _currentScore.text = LanguageMgr.GetTranslation("tank.ddPlay.exchangeFrame.currentScore");
         _currentScore2 = ComponentFactory.Instance.creatComponentByStylename("DDPlay.exchange.frame.currentScoreTxt2");
         _score = DDPlayManaer.Instance.DDPlayScore;
         _currentScore2.text = _score.toString();
         _chooseNum.valueLimit = "0," + Math.floor(_score / _fold);
         _chooseNum.currentValue = Math.floor(_score / _fold);
         addToContent(_bg);
         addToContent(_exchangeBtn);
         addToContent(_chooseNum);
         addToContent(_exchangeNum);
         addToContent(_currentScoreBg);
         addToContent(_currentScore);
         addToContent(_currentScore2);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _exchangeBtn.addEventListener("click",__exchange);
         DDPlayManaer.Instance.addEventListener("update_score",__updateScore);
         _chooseNum.addEventListener("change",__numberChange);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_exchangeBtn)
         {
            _exchangeBtn.removeEventListener("click",__exchange);
            _chooseNum.removeEventListener("change",__numberChange);
         }
         DDPlayManaer.Instance.removeEventListener("update_score",__updateScore);
      }
      
      private function __numberChange(param1:Event) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __updateScore(param1:Event) : void
      {
         _score = DDPlayManaer.Instance.DDPlayScore;
         _currentScore2.text = _score.toString();
         _chooseNum.valueLimit = "0," + Math.floor(_score / _fold);
         _chooseNum.currentValue = Math.floor(_score / _fold);
      }
      
      private function __exchange(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_chooseNum.currentValue * _fold > _score || _chooseNum.currentValue == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.ddPlay.exchangeFrame.scoreNotEnough"));
            return;
         }
         SocketManager.Instance.out.DDPlayExchange(_chooseNum.currentValue);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_exchangeBtn);
         _exchangeBtn = null;
         ObjectUtils.disposeObject(_chooseNum);
         _chooseNum = null;
         ObjectUtils.disposeObject(_exchangeNum);
         _exchangeNum = null;
         ObjectUtils.disposeObject(_currentScore);
         _currentScore = null;
         ObjectUtils.disposeObject(_currentScoreBg);
         _currentScoreBg = null;
         ObjectUtils.disposeObject(_currentScore2);
         _currentScore2 = null;
         super.dispose();
      }
   }
}
