package gameCommon.view.card
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CardCountDown extends Sprite implements Disposeable
   {
       
      
      private var _bitmapDatas:Vector.<BitmapData>;
      
      private var _timer:Timer;
      
      private var _totalSeconds:uint;
      
      private var _digit:Bitmap;
      
      private var _tenDigit:Bitmap;
      
      private var _isPlaySound:Boolean;
      
      public function CardCountDown()
      {
         super();
         init();
      }
      
      public function tick(seconds:uint, isPlaySound:Boolean = true) : void
      {
         _totalSeconds = seconds;
         _isPlaySound = isPlaySound;
         _timer.repeatCount = _totalSeconds;
         __updateView();
         _timer.start();
      }
      
      private function init() : void
      {
         var i:int = 0;
         _digit = new Bitmap();
         _tenDigit = new Bitmap();
         _bitmapDatas = new Vector.<BitmapData>();
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__updateView);
         _timer.addEventListener("timerComplete",__onTimerComplete);
         for(i = 0; i < 10; )
         {
            _bitmapDatas.push(ComponentFactory.Instance.creatBitmapData("asset.takeoutCard.CountDownNum_" + String(i)));
            i++;
         }
      }
      
      private function __updateView(event:TimerEvent = null) : void
      {
         var num:int = _timer.repeatCount - _timer.currentCount;
         if(num <= 4)
         {
            if(_isPlaySound)
            {
               SoundManager.instance.stop("067");
               SoundManager.instance.play("067");
            }
         }
         else if(_isPlaySound)
         {
            SoundManager.instance.play("014");
         }
         _tenDigit.bitmapData = _bitmapDatas[int(num / 10)];
         _digit.bitmapData = _bitmapDatas[num % 10];
         _digit.x = _tenDigit.width - 14;
         addChild(_digit);
         addChild(_tenDigit);
      }
      
      private function __onTimerComplete(event:TimerEvent) : void
      {
         dispatchEvent(new Event("complete"));
      }
      
      public function dispose() : void
      {
         _timer.removeEventListener("timer",__updateView);
         _timer.removeEventListener("timerComplete",__onTimerComplete);
         _timer.stop();
         _timer = null;
         var _loc3_:int = 0;
         var _loc2_:* = _bitmapDatas;
         for each(var bmd in _bitmapDatas)
         {
            bmd.dispose();
            bmd = null;
         }
         if(_digit && _digit.parent)
         {
            _digit.parent.removeChild(_digit);
         }
         if(_tenDigit && _tenDigit.parent)
         {
            _tenDigit.parent.removeChild(_tenDigit);
         }
         _digit = null;
         _tenDigit = null;
         if(this.parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
