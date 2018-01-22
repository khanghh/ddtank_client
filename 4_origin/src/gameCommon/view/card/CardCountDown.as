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
      
      public function tick(param1:uint, param2:Boolean = true) : void
      {
         _totalSeconds = param1;
         _isPlaySound = param2;
         _timer.repeatCount = _totalSeconds;
         __updateView();
         _timer.start();
      }
      
      private function init() : void
      {
         var _loc1_:int = 0;
         _digit = new Bitmap();
         _tenDigit = new Bitmap();
         _bitmapDatas = new Vector.<BitmapData>();
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__updateView);
         _timer.addEventListener("timerComplete",__onTimerComplete);
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _bitmapDatas.push(ComponentFactory.Instance.creatBitmapData("asset.takeoutCard.CountDownNum_" + String(_loc1_)));
            _loc1_++;
         }
      }
      
      private function __updateView(param1:TimerEvent = null) : void
      {
         var _loc2_:int = _timer.repeatCount - _timer.currentCount;
         if(_loc2_ <= 4)
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
         _tenDigit.bitmapData = _bitmapDatas[int(_loc2_ / 10)];
         _digit.bitmapData = _bitmapDatas[_loc2_ % 10];
         _digit.x = _tenDigit.width - 14;
         addChild(_digit);
         addChild(_tenDigit);
      }
      
      private function __onTimerComplete(param1:TimerEvent) : void
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
         for each(var _loc1_ in _bitmapDatas)
         {
            _loc1_.dispose();
            _loc1_ = null;
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
