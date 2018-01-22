package gameStarling.animations
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.TweenProxyStarling;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.utils.BitmapUtils;
   import flash.display.BitmapData;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   public class ScaleEffect3D extends Sprite
   {
       
      
      private var src1:Image;
      
      private var src2:Image;
      
      private var _texture:Texture;
      
      private var mainTimeLine:TimelineMax;
      
      private var tp1:TweenProxyStarling;
      
      private var tp2:TweenProxyStarling;
      
      public function ScaleEffect3D(param1:int, param2:BitmapData, param3:int = 1){super();}
      
      private function runScale() : void{}
      
      private function runUpToDown() : void{}
      
      private function runRightToLeft() : void{}
      
      private function changeRegist() : void{}
      
      private function runDownToUp() : void{}
      
      private function runLeftToRight(param1:BitmapData) : void{}
      
      private function centerToScale() : void{}
      
      override public function dispose() : void{}
   }
}
