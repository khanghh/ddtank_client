package sevenDouble.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class SevenDoubleCountDownView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _recordTxt:String;
      
      private var _timer:Timer;
      
      private var _endTime:Date;
      
      public function SevenDoubleCountDownView()
      {
         super();
         this.x = 291;
         initView();
         _timer = new Timer(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.sevenDouble.countDownBg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.countDownView.txt");
         _recordTxt = LanguageMgr.GetTranslation("sevenDouble.frame.countDownViewTxt");
         _txt.text = _recordTxt + "--:--";
         addChild(_bg);
         addChild(_txt);
      }
      
      public function setCountDown(endTime:Date) : void
      {
         _timer.start();
         _endTime = endTime;
         refreshView(_endTime);
      }
      
      private function refreshView(endTime:Date) : void
      {
         var endTimestamp:Number = endTime.getTime();
         var nowTimestamp:Number = TimeManager.Instance.Now().getTime();
         var differ:Number = endTimestamp - nowTimestamp;
         differ = differ < 0?0:Number(differ);
         var minute:int = differ / 60000;
         var second:int = differ % 60000 / 1000;
         var minStr:String = minute < 10?"0" + minute:minute.toString();
         var secStr:String = second < 10?"0" + second:second.toString();
         _txt.text = _recordTxt + minStr + ":" + secStr;
      }
      
      private function timerHandler(event:TimerEvent) : void
      {
         refreshView(_endTime);
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",timerHandler);
            _timer.stop();
         }
         _timer = null;
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _txt = null;
         _recordTxt = null;
         _endTime = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
