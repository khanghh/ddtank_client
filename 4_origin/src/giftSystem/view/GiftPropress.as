package giftSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.geom.Matrix;
   
   public class GiftPropress extends Component
   {
       
      
      private var _backgound:MovieImage;
      
      private var _thuck:Component;
      
      private var _graphics_thuck:BitmapData;
      
      private var _value:Number = 0;
      
      private var _max:Number = 100;
      
      private var _propgressLabel:FilterFrameText;
      
      public function GiftPropress()
      {
         super();
         _height = 10;
         _width = 10;
         initView();
         drawProgress();
      }
      
      private function initView() : void
      {
         _backgound = ComponentFactory.Instance.creatComponentByStylename("ddtGiftGoodItem.levelBG");
         addChild(_backgound);
         _thuck = ComponentFactory.Instance.creatComponentByStylename("gift.info.thunck");
         addChild(_thuck);
         _graphics_thuck = ComponentFactory.Instance.creatBitmapData("gift.info.Bitmap_thuck1");
         _propgressLabel = ComponentFactory.Instance.creatComponentByStylename("gift.info.LevelProgressText");
         addChild(_propgressLabel);
      }
      
      public function setProgress(value:Number, max:Number) : void
      {
         if(_value != value || _max != max)
         {
            _value = value;
            _max = max;
            drawProgress();
         }
      }
      
      private function drawProgress() : void
      {
         var rate:Number = _value / _max > 1?1:Number(_value / _max);
         var pen:Graphics = _thuck.graphics;
         pen.clear();
         if(rate >= 0)
         {
            _propgressLabel.text = Math.floor(rate * 10000) / 100 + "%";
            pen.beginBitmapFill(_graphics_thuck,new Matrix(1.04065040650407));
            pen.drawRect(0,0,(_width + 20) * rate,_height - 4);
            pen.endFill();
         }
      }
      
      public function set labelText(value:String) : void
      {
         _propgressLabel.text = value;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_graphics_thuck);
         _graphics_thuck = null;
         ObjectUtils.disposeObject(_thuck);
         _thuck = null;
         ObjectUtils.disposeObject(_propgressLabel);
         _propgressLabel = null;
         ObjectUtils.disposeObject(_backgound);
         _backgound = null;
         super.dispose();
      }
   }
}
