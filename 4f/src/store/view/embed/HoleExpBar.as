package store.view.embed
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.TransformableComponent;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.geom.Matrix;
   
   public class HoleExpBar extends TransformableComponent
   {
      
      private static const P_Rate:String = "p_rate";
       
      
      private var thickness:int = 3;
      
      private var _rate:Number = 0;
      
      private var _back:BitmapData;
      
      private var _thumb:BitmapData;
      
      private var _rateField:FilterFrameText;
      
      public function HoleExpBar(){super();}
      
      private function configUI() : void{}
      
      override public function set visible(param1:Boolean) : void{}
      
      override public function draw() : void{}
      
      public function setProgress(param1:int, param2:int = 100) : void{}
      
      override public function dispose() : void{}
   }
}
