package luckStar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class LuckStarCoinsView extends Sprite implements Disposeable
   {
      
      private static const MAX_NUM_WIDTH:int = 8;
      
      private static const BUFFER_TIME:int = 50;
      
      private static const WIDTH:int = 25;
       
      
      private var _num:Vector.<ScaleFrameImage>;
      
      private var len:int = 4;
      
      private var coinsNum:int;
      
      private var notFirst:Boolean = false;
      
      private var time:Timer;
      
      private var oldCoins:int;
      
      public function LuckStarCoinsView()
      {
         super();
         _num = new Vector.<ScaleFrameImage>();
         time = new Timer(50);
         time.addEventListener("timerComplete",__onComplete);
         time.addEventListener("timer",__onTimer);
         time.stop();
         setupCount();
      }
      
      public function set count(param1:int) : void
      {
         if(coinsNum == param1)
         {
            return;
         }
         if(coinsNum != oldCoins && notFirst)
         {
            initCoinsStyle();
         }
         coinsNum = param1;
         updateCount();
      }
      
      private function setupCount() : void
      {
         var _loc3_:int = 0;
         while(len > _num.length)
         {
            _num.unshift(createCoinsNum(10));
         }
         while(len < _num.length)
         {
            ObjectUtils.disposeObject(_num.shift());
         }
         var _loc2_:int = 8 - len;
         var _loc1_:int = _loc2_ / 2 * 25;
         _loc3_ = 0;
         while(_loc3_ < len)
         {
            _num[_loc3_].x = _loc1_;
            _loc1_ = _loc1_ + 25;
            _loc3_++;
         }
      }
      
      private function updateCount() : void
      {
         var _loc1_:int = coinsNum.toString().length;
         if(_loc1_ != len)
         {
            len = _loc1_;
            setupCount();
         }
         if(coinsNum - oldCoins <= 0)
         {
            initCoinsStyle();
         }
         else if(!notFirst)
         {
            notFirst = true;
            initCoinsStyle();
         }
         else
         {
            play();
         }
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         oldCoins = Number(oldCoins) + 1;
         if(oldCoins > coinsNum)
         {
            oldCoins = coinsNum;
         }
         var _loc2_:Array = oldCoins.toString().split("");
         if(len > _loc2_.length)
         {
            _loc2_.unshift("0");
         }
         updateCoinsView(_loc2_);
      }
      
      private function __onComplete(param1:TimerEvent) : void
      {
         time.stop();
         oldCoins = coinsNum;
      }
      
      private function initCoinsStyle() : void
      {
         var _loc1_:Array = coinsNum.toString().split("");
         updateCoinsView(_loc1_);
         oldCoins = coinsNum;
      }
      
      private function updateCoinsView(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < len)
         {
            if(param1[_loc2_] == 0)
            {
               param1[_loc2_] = 10;
            }
            _num[_loc2_].setFrame(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      private function play() : void
      {
         time.stop();
         time.reset();
         time.repeatCount = coinsNum - oldCoins;
         time.start();
      }
      
      private function createCoinsNum(param1:int = 0) : ScaleFrameImage
      {
         var _loc2_:ScaleFrameImage = ComponentFactory.Instance.creatComponentByStylename("luckyStar.view.CoinsNum");
         _loc2_.setFrame(param1);
         addChild(_loc2_);
         return _loc2_;
      }
      
      public function dispose() : void
      {
         time.stop();
         time.removeEventListener("timerComplete",__onComplete);
         time.removeEventListener("timer",__onTimer);
         time = null;
         while(_num.length)
         {
            ObjectUtils.disposeObject(_num.shift());
         }
         _num = null;
      }
   }
}
