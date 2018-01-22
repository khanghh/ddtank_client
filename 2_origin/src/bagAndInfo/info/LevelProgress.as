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
      
      public function setProgress(param1:Number, param2:Number) : void
      {
         if(_value != param1 || _max != param2)
         {
            _value = param1;
            _max = param2;
            drawProgress();
         }
      }
      
      protected function drawProgress() : void
      {
         var _loc2_:Number = _value / _max > 1?1:Number(_value / _max);
         var _loc1_:Graphics = _thuck.graphics;
         _loc1_.clear();
         if(_loc2_ >= 0)
         {
            _progressLabel.text = Math.floor(_loc2_ * 10000) / 100 + "%";
            _loc1_.beginBitmapFill(_graphics_thuck,new Matrix(1.05263157894737));
            _loc1_.drawRect(0,0,(_width - 10) * _loc2_,_height - 8);
            _loc1_.endFill();
         }
      }
      
      public function set labelText(param1:String) : void
      {
         _progressLabel.text = param1;
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
