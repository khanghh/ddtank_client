package ddt.view.chat.chatBall
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ChatBallBackground extends MovieClip
   {
       
      
      private var paopaomc:MovieClip;
      
      private var _baseTextArea:Rectangle;
      
      private var _scale:Number;
      
      private var _direction:Point;
      
      public function ChatBallBackground(paopaoMC:MovieClip)
      {
         super();
         _scale = 1;
         paopaomc = paopaoMC;
         addChild(paopaomc);
         paopaomc.bg.rtTopPoint.parent.removeChild(paopaomc.bg.rtTopPoint);
         _baseTextArea = new Rectangle(paopaomc.bg.rtTopPoint.x,paopaomc.bg.rtTopPoint.y,paopaomc.bg.rtTopPoint.width,paopaomc.bg.rtTopPoint.height);
         direction = new Point(-1,-1);
      }
      
      public function fitSize(size:Point) : void
      {
         var tempScaleWidth:Number = size.x / _baseTextArea.width;
         var tempScaleHeight:Number = size.y / _baseTextArea.height;
         if(tempScaleWidth > tempScaleHeight)
         {
            scale = tempScaleWidth;
         }
         else
         {
            scale = tempScaleHeight;
         }
         update();
      }
      
      public function set direction(value:Point) : void
      {
         if(x == 0)
         {
            x = -1;
         }
         if(y == 0)
         {
            y = -1;
         }
         if(_direction == value)
         {
            return;
         }
         _direction = value;
         if(_direction == null)
         {
            return;
         }
         if(_direction.x > 0)
         {
            paopaomc.scaleX = -_scale;
         }
         else
         {
            paopaomc.scaleX = _scale;
         }
         if(_direction.y > 0)
         {
            paopaomc.scaleY = -_scale;
         }
         else
         {
            paopaomc.scaleY = _scale;
         }
         update();
      }
      
      public function get direction() : Point
      {
         return _direction;
      }
      
      protected function set scale(value:Number) : void
      {
         if(_scale == value)
         {
            return;
         }
         _scale = value;
         if(paopaomc.scaleX > 0)
         {
            paopaomc.scaleX = value;
         }
         else
         {
            paopaomc.scaleX = -value;
         }
         if(paopaomc.scaleY > 0)
         {
            paopaomc.scaleY = value;
         }
         else
         {
            paopaomc.scaleY = -value;
         }
         update();
      }
      
      protected function get scale() : Number
      {
         return _scale;
      }
      
      public function get textArea() : Rectangle
      {
         var textArea:Rectangle = new Rectangle();
         if(paopaomc.scaleX > 0)
         {
            textArea.x = _baseTextArea.x * scale;
         }
         else
         {
            textArea.x = -_baseTextArea.right * scale;
         }
         if(paopaomc.scaleY > 0)
         {
            textArea.y = _baseTextArea.y * scale;
         }
         else
         {
            textArea.y = -_baseTextArea.bottom * scale;
         }
         textArea.width = _baseTextArea.width * Math.abs(scale);
         textArea.height = _baseTextArea.height * Math.abs(scale);
         return textArea;
      }
      
      public function drawTextArea() : void
      {
      }
      
      private function update() : void
      {
      }
      
      public function dispose() : void
      {
         _baseTextArea = null;
         paopaomc = null;
      }
   }
}
