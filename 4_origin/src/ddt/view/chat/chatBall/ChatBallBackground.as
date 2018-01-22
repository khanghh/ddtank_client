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
      
      public function ChatBallBackground(param1:MovieClip)
      {
         super();
         _scale = 1;
         paopaomc = param1;
         addChild(paopaomc);
         paopaomc.bg.rtTopPoint.parent.removeChild(paopaomc.bg.rtTopPoint);
         _baseTextArea = new Rectangle(paopaomc.bg.rtTopPoint.x,paopaomc.bg.rtTopPoint.y,paopaomc.bg.rtTopPoint.width,paopaomc.bg.rtTopPoint.height);
         direction = new Point(-1,-1);
      }
      
      public function fitSize(param1:Point) : void
      {
         var _loc2_:Number = param1.x / _baseTextArea.width;
         var _loc3_:Number = param1.y / _baseTextArea.height;
         if(_loc2_ > _loc3_)
         {
            scale = _loc2_;
         }
         else
         {
            scale = _loc3_;
         }
         update();
      }
      
      public function set direction(param1:Point) : void
      {
         if(x == 0)
         {
            x = -1;
         }
         if(y == 0)
         {
            y = -1;
         }
         if(_direction == param1)
         {
            return;
         }
         _direction = param1;
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
      
      protected function set scale(param1:Number) : void
      {
         if(_scale == param1)
         {
            return;
         }
         _scale = param1;
         if(paopaomc.scaleX > 0)
         {
            paopaomc.scaleX = param1;
         }
         else
         {
            paopaomc.scaleX = -param1;
         }
         if(paopaomc.scaleY > 0)
         {
            paopaomc.scaleY = param1;
         }
         else
         {
            paopaomc.scaleY = -param1;
         }
         update();
      }
      
      protected function get scale() : Number
      {
         return _scale;
      }
      
      public function get textArea() : Rectangle
      {
         var _loc1_:Rectangle = new Rectangle();
         if(paopaomc.scaleX > 0)
         {
            _loc1_.x = _baseTextArea.x * scale;
         }
         else
         {
            _loc1_.x = -_baseTextArea.right * scale;
         }
         if(paopaomc.scaleY > 0)
         {
            _loc1_.y = _baseTextArea.y * scale;
         }
         else
         {
            _loc1_.y = -_baseTextArea.bottom * scale;
         }
         _loc1_.width = _baseTextArea.width * Math.abs(scale);
         _loc1_.height = _baseTextArea.height * Math.abs(scale);
         return _loc1_;
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
