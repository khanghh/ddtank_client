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
      
      override public function set visible(param1:Boolean) : void
      {
         .super.visible = param1;
      }
      
      override public function draw() : void
      {
         var _loc1_:int = 0;
         var _loc3_:* = null;
         super.draw();
         var _loc2_:Graphics = graphics;
         _loc2_.clear();
         _loc2_.beginBitmapFill(_back);
         _loc2_.drawRect(0,0,_width,_height);
         _loc2_.endFill();
         if(_width > thickness * 3 && _height > thickness * 3 && _rate > 0)
         {
            _loc1_ = _width - thickness * 2;
            _loc3_ = new Matrix();
            _loc3_.translate(thickness,thickness);
            _loc2_.beginBitmapFill(_thumb,_loc3_);
            _loc2_.drawRect(thickness,thickness,_loc1_ * _rate,_height - thickness * 2);
            _loc2_.endFill();
         }
         _rateField.text = int(_rate * 100) + "%";
      }
      
      public function setProgress(param1:int, param2:int = 100) : void
      {
         _rate = param1 / param2;
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
