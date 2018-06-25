package bagAndInfo.info
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.geom.Matrix;
   
   public class LevelProgress extends Component
   {
      
      public static const Progress:String = "progress";
       
      
      protected var _background:Bitmap;
      
      protected var _thuck:Component;
      
      protected var _graphics_thuck:BitmapData;
      
      protected var _value:Number = 0;
      
      protected var _max:Number = 100;
      
      protected var _progressLabel:FilterFrameText;
      
      public function LevelProgress()
      {
         super();
         _height = 10;
         _width = 10;
         initView();
         drawProgress();
      }
      
      protected function initView() : void
      {
         _background = ComponentFactory.Instance.creatBitmap("bagAndInfo.info.Background_Progress1");
         addChild(_background);
         _thuck = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.info.thunck");
         addChild(_thuck);
         _graphics_thuck = ComponentFactory.Instance.creatBitmapData("bagAndInfo.info.Bitmap_thuck1");
         _progressLabel = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.info.LevelProgressText");
         addChild(_progressLabel);
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
      
      protected function drawProgress() : void
      {
         var rate:Number = _value / _max > 1?1:Number(_value / _max);
         var pen:Graphics = _thuck.graphics;
         pen.clear();
         if(rate >= 0)
         {
            _progressLabel.text = Math.floor(rate * 10000) / 100 + "%";
            pen.beginBitmapFill(_graphics_thuck,new Matrix(1.05263157894737));
            pen.drawRect(0,0,(_width - 10) * rate,_height - 8);
            pen.endFill();
         }
      }
      
      public function set labelText(value:String) : void
      {
         _progressLabel.text = value;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_graphics_thuck);
         _graphics_thuck = null;
         ObjectUtils.disposeObject(_background);
         _background = null;
         ObjectUtils.disposeObject(_thuck);
         _thuck = null;
         ObjectUtils.disposeObject(_progressLabel);
         _progressLabel = null;
         super.dispose();
      }
   }
}
