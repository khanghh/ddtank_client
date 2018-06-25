package gameStarling.chat
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import com.pickgliss.utils.StarlingObjectUtils;
   import dragonBones.Bone;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.Sprite;
   
   public class ChatBallBackground3D extends Sprite
   {
       
      
      private var paopaomc:BoneMovieStarling;
      
      private var _areaPos:Bone;
      
      private var _baseTextArea:Rectangle;
      
      private var _scale:Number;
      
      private var _direction:Point;
      
      public function ChatBallBackground3D(styleName:String)
      {
         super();
         _scale = 1;
         paopaomc = BoneMovieFactory.instance.creatBoneMovie(styleName);
         direction = new Point(-1,-1);
         initChatBall();
      }
      
      private function initChatBall() : void
      {
         addChild(paopaomc);
         paopaomc.stop();
         _baseTextArea = getChatBallArea();
         paopaomc.play();
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
      
      private function getChatBallArea() : Rectangle
      {
         var rect:Rectangle = new Rectangle();
         rect.x = int(paopaomc.getValueByAttribute("x"));
         rect.y = int(paopaomc.getValueByAttribute("y"));
         rect.width = int(paopaomc.getValueByAttribute("width"));
         rect.height = int(paopaomc.getValueByAttribute("height"));
         return rect;
      }
      
      public function get loadComplete() : Boolean
      {
         return paopaomc && paopaomc.loadComplete;
      }
      
      override public function dispose() : void
      {
         _areaPos = null;
         StarlingObjectUtils.disposeObject(paopaomc);
         paopaomc = null;
         _baseTextArea = null;
         super.dispose();
      }
   }
}
