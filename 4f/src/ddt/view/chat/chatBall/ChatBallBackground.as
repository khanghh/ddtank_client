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
      
      public function ChatBallBackground(param1:MovieClip){super();}
      
      public function fitSize(param1:Point) : void{}
      
      public function set direction(param1:Point) : void{}
      
      public function get direction() : Point{return null;}
      
      protected function set scale(param1:Number) : void{}
      
      protected function get scale() : Number{return 0;}
      
      public function get textArea() : Rectangle{return null;}
      
      public function drawTextArea() : void{}
      
      private function update() : void{}
      
      public function dispose() : void{}
   }
}
