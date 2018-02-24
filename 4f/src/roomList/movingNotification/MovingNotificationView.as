package roomList.movingNotification
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   
   public class MovingNotificationView extends Sprite
   {
       
      
      private var _list:Array;
      
      private var _mask:Shape;
      
      private var _currentIndex:uint;
      
      private var _currentMovingFFT:FilterFrameText;
      
      private var _textFields:Vector.<FilterFrameText>;
      
      private var _keyWordTF:TextFormat;
      
      private var _timer:Timer;
      
      public function MovingNotificationView(){super();}
      
      private function init() : void{}
      
      public function get list() : Array{return null;}
      
      public function set list(param1:Array) : void{}
      
      private function stopEnterFrame(param1:TimerEvent) : void{}
      
      private function clearTextFields() : void{}
      
      private function updateTextFields() : void{}
      
      private function updateCurrentTTF() : void{}
      
      private function moveFFT(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
