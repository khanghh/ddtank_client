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
      
      public function ChatBallBackground3D(param1:String)
      {
         super();
         _scale = 1;
         paopaomc = BoneMovieFactory.instance.creatBoneMovie(param1);
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
      
      private function getChatBallArea() : Rectangle
      {
         var _loc1_:Rectangle = new Rectangle();
         _loc1_.x = int(paopaomc.getValueByAttribute("x"));
         _loc1_.y = int(paopaomc.getValueByAttribute("y"));
         _loc1_.width = int(paopaomc.getValueByAttribute("width"));
         _loc1_.height = int(paopaomc.getValueByAttribute("height"));
         return _loc1_;
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
