package ddt.view.chat.chatBall
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.StyleSheet;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ChatBallTextAreaBoss extends ChatBallTextAreaNPC
   {
       
      
      private const TYPEDLENGTH:int = 1;
      
      private const TYPEINTERVAL:int = 80;
      
      private var _maskMC:Sprite;
      
      private var _bmdata:BitmapData;
      
      private var _bmp:Bitmap;
      
      private var _typeTimer:TimerJuggler;
      
      private var _count:int;
      
      public var animation:Boolean = true;
      
      public function ChatBallTextAreaBoss()
      {
         super();
         _typeTimer = TimerManager.getInstance().addTimerJuggler(80,0,false,"80ms");
         _typeTimer.addEventListener("timer",__onTypeTimerTick);
      }
      
      override protected function setFormat() : void
      {
         var _loc1_:StyleSheet = new StyleSheet();
         _loc1_.parseCSS("p{font-size:16px;text-align:left;font-weight:bold;leading:3px;}.red{color:#FF0000;}.blue{color:#0000FF;}.green{color:#00FF00;}");
         tf.styleSheet = _loc1_;
      }
      
      override public function set text(param1:String) : void
      {
         .super.text = param1;
         ObjectUtils.disposeObject(_maskMC);
         _maskMC = new Sprite();
         addChild(_maskMC);
         _maskMC.x = tf.x - 2;
         _maskMC.y = tf.y - 2;
         ObjectUtils.disposeObject(_bmp);
         _bmdata = new BitmapData(tf.width,tf.height + 4);
         _bmdata.draw(tf);
         _bmp = new Bitmap(_bmdata);
         _bmp.x = tf.x;
         _bmp.y = tf.y;
         addChild(_bmp);
         _bmp.mask = _maskMC;
         _count = 0;
         tf.visible = false;
         _typeTimer.start();
         if(!animation)
         {
            SoundManager.instance.play("008");
            drawFullMask();
         }
      }
      
      private function __onTypeTimerTick(param1:Event) : void
      {
         if(_count < 15)
         {
            SoundManager.instance.play("120");
         }
         while(!_text.charAt(_count))
         {
            _count = Number(_count) - 1;
            textDisplayCompleted();
         }
         redrawMask(_count);
         _count = _count + 1;
      }
      
      private function drawFullMask() : void
      {
         _bmp.mask = null;
         textDisplayCompleted();
      }
      
      private function redrawMask(param1:int) : void
      {
         if(!_text.charAt(_count))
         {
            return;
         }
         var _loc4_:Boolean = false;
         var _loc3_:String = _text.charAt(param1);
         var _loc2_:Rectangle = tf.getCharBoundaries(param1);
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc4_)
         {
            _bmp.mask = null;
            _maskMC.graphics.clear();
            _maskMC.graphics.beginFill(13421772);
            _maskMC.graphics.drawRect(_loc2_.x,_loc2_.y,_loc2_.width,_loc2_.height);
            _maskMC.graphics.endFill();
            addChild(_maskMC);
            return;
         }
         _maskMC.graphics.clear();
         _maskMC.graphics.lineStyle(0);
         _maskMC.graphics.beginFill(13421772);
         _maskMC.graphics.moveTo(0,-2);
         _maskMC.graphics.lineTo(0,_loc2_.y + _loc2_.height);
         _maskMC.graphics.lineTo(_loc2_.x + _loc2_.width,_loc2_.y + _loc2_.height);
         _maskMC.graphics.lineTo(_loc2_.x + _loc2_.width,_loc2_.y - 2);
         _maskMC.graphics.lineTo(tf.width,_loc2_.y - 2);
         _maskMC.graphics.lineTo(tf.width,-2);
         _maskMC.graphics.lineTo(0,-2);
         _maskMC.graphics.endFill();
         addChild(_maskMC);
      }
      
      override protected function clear() : void
      {
         super.clear();
         if(_bmp && _bmp.parent)
         {
            _bmp.parent.removeChild(_bmp);
         }
      }
      
      private function textDisplayCompleted() : void
      {
         _typeTimer.stop();
         dispatchEvent(new Event("complete"));
      }
      
      override public function dispose() : void
      {
         if(_typeTimer)
         {
            _typeTimer.removeEventListener("timer",__onTypeTimerTick);
            TimerManager.getInstance().removeJugglerByTimer(_typeTimer);
         }
         clear();
         ObjectUtils.disposeObject(_bmdata);
         _bmdata = null;
         _bmp = null;
         ObjectUtils.disposeObject(_maskMC);
         _maskMC = null;
         super.dispose();
      }
   }
}
