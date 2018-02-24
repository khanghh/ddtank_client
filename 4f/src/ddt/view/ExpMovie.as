package ddt.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ExpMovie extends Sprite implements Disposeable
   {
       
      
      private var _expText:FilterFrameText;
      
      private var _expUpAsset:Bitmap;
      
      public function ExpMovie(){super();}
      
      private function initView() : void{}
      
      public function set exp(param1:int) : void{}
      
      public function play() : void{}
      
      private function onOut() : void{}
      
      private function onOut1() : void{}
      
      public function dispose() : void{}
   }
}
