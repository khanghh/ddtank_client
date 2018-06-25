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
      
      public function set count(value:int) : void
      {
         if(coinsNum == value)
         {
            return;
         }
         if(coinsNum != oldCoins && notFirst)
         {
            initCoinsStyle();
         }
         coinsNum = value;
         updateCount();
      }
      
      private function setupCount() : void
      {
         var i:int = 0;
         while(len > _num.length)
         {
            _num.unshift(createCoinsNum(10));
         }
         while(len < _num.length)
         {
            ObjectUtils.disposeObject(_num.shift());
         }
         var cha:int = 8 - len;
         var numX:int = cha / 2 * 25;
         for(i = 0; i < len; )
         {
            _num[i].x = numX;
            numX = numX + 25;
            i++;
         }
      }
      
      private function updateCount() : void
      {
         var length:int = coinsNum.toString().length;
         if(length != len)
         {
            len = length;
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
      
      private function __onTimer(e:TimerEvent) : void
      {
         oldCoins = Number(oldCoins) + 1;
         if(oldCoins > coinsNum)
         {
            oldCoins = coinsNum;
         }
         var arr:Array = oldCoins.toString().split("");
         if(len > arr.length)
         {
            arr.unshift("0");
         }
         updateCoinsView(arr);
      }
      
      private function __onComplete(e:TimerEvent) : void
      {
         time.stop();
         oldCoins = coinsNum;
      }
      
      private function initCoinsStyle() : void
      {
         var arr:Array = coinsNum.toString().split("");
         updateCoinsView(arr);
         oldCoins = coinsNum;
      }
      
      private function updateCoinsView(arr:Array) : void
      {
         var i:int = 0;
         for(i = 0; i < len; )
         {
            if(arr[i] == 0)
            {
               arr[i] = 10;
            }
            _num[i].setFrame(arr[i]);
            i++;
         }
      }
      
      private function play() : void
      {
         time.stop();
         time.reset();
         time.repeatCount = coinsNum - oldCoins;
         time.start();
      }
      
      private function createCoinsNum(frame:int = 0) : ScaleFrameImage
      {
         var num:ScaleFrameImage = ComponentFactory.Instance.creatComponentByStylename("luckyStar.view.CoinsNum");
         num.setFrame(frame);
         addChild(num);
         return num;
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
