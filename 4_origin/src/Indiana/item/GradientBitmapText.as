package Indiana.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Matrix;
   import flash.text.TextFormat;
   
   public class GradientBitmapText extends Component
   {
       
      
      private var _field:FilterFrameText;
      
      private var _bmp:Bitmap;
      
      private var currentMatix:Matrix;
      
      private var _graidenBmp:ScaleBitmapImage;
      
      public function GradientBitmapText()
      {
         super();
         _graidenBmp = new ScaleBitmapImage();
         addChild(_graidenBmp);
      }
      
      public function set FilterTxtStyle(param1:String) : void
      {
         if(param1 == "")
         {
            return;
         }
         if(_field)
         {
            removeChild(_field);
            ObjectUtils.disposeObject(_field);
            _field = null;
         }
         _field = ComponentFactory.Instance.creatComponentByStylename(param1);
         _field.x = 0;
         _field.y = 0;
         addChild(_field);
      }
      
      public function set FontSize(param1:int) : void
      {
         var _loc2_:* = null;
         if(_field)
         {
            _loc2_ = _field.defaultTextFormat;
            _loc2_.size = param1;
            _field.defaultTextFormat = _loc2_;
         }
      }
      
      public function set BitMapStyle(param1:String) : void
      {
         if(param1 == "")
         {
            return;
         }
         if(_bmp)
         {
            _bmp.bitmapData.dispose();
            _bmp = null;
         }
         _bmp = ComponentFactory.Instance.creatBitmap(param1);
      }
      
      public function setText(param1:String) : void
      {
         _field.text = param1;
         render();
      }
      
      public function get textWidth() : Number
      {
         if(_field)
         {
            return _field.textWidth;
         }
         return 0;
      }
      
      private function render() : void
      {
         drawBox();
         _field.cacheAsBitmap = true;
         _graidenBmp.cacheAsBitmap = true;
         _graidenBmp.x = _field.x;
         _graidenBmp.y = _field.y;
         _graidenBmp.width = _field.textWidth + 5;
         _graidenBmp.height = _field.textHeight + 5;
         _graidenBmp.mask = _field;
      }
      
      private function drawBox() : void
      {
         if(_bmp)
         {
            if(_graidenBmp == null)
            {
               _graidenBmp = new ScaleBitmapImage();
            }
            _graidenBmp.resource = _bmp.bitmapData;
            _graidenBmp.scaleGridString = "6,6,55,44";
         }
      }
      
      override public function dispose() : void
      {
         if(_field)
         {
            ObjectUtils.disposeObject(_field);
         }
         _field = null;
         if(_bmp)
         {
            ObjectUtils.disposeObject(_bmp);
         }
         _bmp = null;
         if(_graidenBmp)
         {
            ObjectUtils.disposeObject(_graidenBmp);
         }
         _graidenBmp = null;
         super.dispose();
      }
   }
}
