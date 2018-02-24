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
      
      public function LuckStarCoinsView(){super();}
      
      public function set count(param1:int) : void{}
      
      private function setupCount() : void{}
      
      private function updateCount() : void{}
      
      private function __onTimer(param1:TimerEvent) : void{}
      
      private function __onComplete(param1:TimerEvent) : void{}
      
      private function initCoinsStyle() : void{}
      
      private function updateCoinsView(param1:Array) : void{}
      
      private function play() : void{}
      
      private function createCoinsNum(param1:int = 0) : ScaleFrameImage{return null;}
      
      public function dispose() : void{}
   }
}
