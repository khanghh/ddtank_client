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
      
      public function HoleExpBar()
      {
         super();
         configUI();
      }
      
      private function configUI() : void
      {
         _back = ComponentFactory.Instance.creatBitmapData("asset.ddtstore.EmbedHoleExpBack");
         _thumb = ComponentFactory.Instance.creatBitmapData("asset.ddtstore.EmbedHoleExpThumb");
         _rateField = ComponentFactory.Instance.creatComponentByStylename("ddttore.StoreEmbedBG.ExpRateFieldText");
         addChild(_rateField);
         _width = _back.width;
         _height = _back.height;
         draw();
      }
      
      override public function set visible(value:Boolean) : void
      {
         .super.visible = value;
      }
      
      override public function draw() : void
      {
         var w:int = 0;
         var matrix:* = null;
         super.draw();
         var pen:Graphics = graphics;
         pen.clear();
         pen.beginBitmapFill(_back);
         pen.drawRect(0,0,_width,_height);
         pen.endFill();
         if(_width > thickness * 3 && _height > thickness * 3 && _rate > 0)
         {
            w = _width - thickness * 2;
            matrix = new Matrix();
            matrix.translate(thickness,thickness);
            pen.beginBitmapFill(_thumb,matrix);
            pen.drawRect(thickness,thickness,w * _rate,_height - thickness * 2);
            pen.endFill();
         }
         _rateField.text = int(_rate * 100) + "%";
      }
      
      public function setProgress(value:int, max:int = 100) : void
      {
         _rate = value / max;
         _rate = _rate > 1?1:Number(_rate);
         onPropertiesChanged("p_rate");
      }
      
      override public function dispose() : void
      {
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
            _back = null;
         }
         if(_thumb)
         {
            ObjectUtils.disposeObject(_thumb);
            _thumb = null;
         }
         if(_rateField)
         {
            ObjectUtils.disposeObject(_rateField);
         }
         _rateField = null;
         super.dispose();
      }
   }
}
