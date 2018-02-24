package game.animations
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.TweenProxy;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.utils.BitmapUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   
   public class ScaleEffect extends Sprite implements Disposeable
   {
       
      
      private var src1:Bitmap;
      
      private var src2:Bitmap;
      
      private var mainTimeLine:TimelineMax;
      
      private var tp1:TweenProxy;
      
      private var tp2:TweenProxy;
      
      public function ScaleEffect(param1:int, param2:BitmapData, param3:int = 1){super();}
      
      private function runScale(param1:BitmapData) : void{}
      
      private function runUpToDown(param1:BitmapData) : void{}
      
      private function runRightToLeft(param1:BitmapData) : void{}
      
      private function changeRegist() : void{}
      
      private function runDownToUp(param1:BitmapData) : void{}
      
      private function runLeftToRight(param1:BitmapData) : void{}
      
      private function centerToScale(param1:BitmapData) : void{}
      
      public function dispose() : void{}
   }
}
