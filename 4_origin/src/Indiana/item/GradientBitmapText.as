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
      
      public function set FilterTxtStyle(style:String) : void
      {
         if(style == "")
         {
            return;
         }
         if(_field)
         {
            removeChild(_field);
            ObjectUtils.disposeObject(_field);
            _field = null;
         }
         _field = ComponentFactory.Instance.creatComponentByStylename(style);
         _field.x = 0;
         _field.y = 0;
         addChild(_field);
      }
      
      public function set FontSize(size:int) : void
      {
         var fromat:* = null;
         if(_field)
         {
            fromat = _field.defaultTextFormat;
            fromat.size = size;
            _field.defaultTextFormat = fromat;
         }
      }
      
      public function set BitMapStyle(str:String) : void
      {
         if(str == "")
         {
            return;
         }
         if(_bmp)
         {
            _bmp.bitmapData.dispose();
            _bmp = null;
         }
         _bmp = ComponentFactory.Instance.creatBitmap(str);
      }
      
      public function setText(s:String) : void
      {
         _field.text = s;
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
