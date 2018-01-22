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
      
      public function CardCountDown(){super();}
      
      public function tick(param1:uint, param2:Boolean = true) : void{}
      
      private function init() : void{}
      
      private function __updateView(param1:TimerEvent = null) : void{}
      
      private function __onTimerComplete(param1:TimerEvent) : void{}
      
      public function dispose() : void{}
   }
}
