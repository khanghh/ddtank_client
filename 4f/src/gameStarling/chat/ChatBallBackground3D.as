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
      
      public function ChatBallBackground3D(param1:String){super();}
      
      private function initChatBall() : void{}
      
      public function set direction(param1:Point) : void{}
      
      public function fitSize(param1:Point) : void{}
      
      public function get direction() : Point{return null;}
      
      protected function set scale(param1:Number) : void{}
      
      protected function get scale() : Number{return 0;}
      
      public function get textArea() : Rectangle{return null;}
      
      public function drawTextArea() : void{}
      
      private function update() : void{}
      
      private function getChatBallArea() : Rectangle{return null;}
      
      public function get loadComplete() : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
