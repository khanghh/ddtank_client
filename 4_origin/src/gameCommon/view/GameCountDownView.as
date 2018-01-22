package gameCommon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class GameCountDownView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _hundredsTxt:FilterFrameText;
      
      private var _tensTxt:FilterFrameText;
      
      private var _unitTxt:FilterFrameText;
      
      private var _total:int;
      
      private var _timer:Timer;
      
      public function GameCountDownView(param1:int)
      {
         super();
         _total = param1;
         _bg = ComponentFactory.Instance.creatBitmap("asset.game.gameCountDown.bg");
         _hundredsTxt = ComponentFactory.Instance.creatComponentByStylename("gameView.countDownView.txt");
         _tensTxt = ComponentFactory.Instance.creatComponentByStylename("gameView.countDownView.txt");
         PositionUtils.setPos(_tensTxt,"gameView.countDownView.tensTxtPos");
         _unitTxt = ComponentFactory.Instance.creatComponentByStylename("gameView.countDownView.txt");
         PositionUtils.setPos(_unitTxt,"gameView.countDownView.unitTxtPos");
         addChild(_bg);
         addChild(_hundredsTxt);
         addChild(_tensTxt);
         addChild(_unitTxt);
         refreshTxt();
         _timer = new Timer(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
         _timer.start();
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         _total = Number(_total) - 1;
         if(_total <= 0)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timerHandler);
         }
         refreshTxt();
      }
      
      private function refreshTxt() : void
      {
         _hundredsTxt.text = (int(_total / 100)).toString();
         _tensTxt.text = (int(_total % 100 / 10)).toString();
         _unitTxt.text = (int(_total % 10)).toString();
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timerHandler);
            _timer = null;
         }
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _hundredsTxt = null;
         _tensTxt = null;
         _unitTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
