package sevenday.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.geom.Matrix;
   
   public class SevendayTaskProgress extends Component
   {
      
      public static const Progress:String = "progress";
       
      
      protected var _background:Bitmap;
      
      protected var _thuck:Component;
      
      protected var _graphics_thuck:BitmapData;
      
      protected var _value:Number = 0;
      
      protected var _max:Number = 100;
      
      protected var _progressLabel:FilterFrameText;
      
      public function SevendayTaskProgress()
      {
         super();
         _width = 10;
         _height = 18;
         initView();
         drawProgress();
      }
      
      protected function initView() : void
      {
         _background = ComponentFactory.Instance.creatBitmap("asset.sevenday.progressframe");
         addChild(_background);
         _thuck = ComponentFactory.Instance.creatComponentByStylename("sevenday.thunck");
         addChild(_thuck);
         _graphics_thuck = ComponentFactory.Instance.creatBitmapData("asset.sevenday.progress");
         _progressLabel = ComponentFactory.Instance.creatComponentByStylename("sevenday.LevelProgressText");
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
         var rate:Number = _value / _max >= 1?1:Number(_value / _max);
         var pen:Graphics = _thuck.graphics;
         pen.clear();
         if(rate >= 0)
         {
            if(_value / 10 == 0)
            {
               _progressLabel.text = " " + _value + "/" + _max;
            }
            else if(_value / 10 < 10 && _value / 10 > 0)
            {
               _progressLabel.text = _value + "/" + _max;
               PositionUtils.setPos(_progressLabel,"ddt.sevenday.progressTextPos");
            }
            else if(_value / 10 >= 10)
            {
               _progressLabel.text = _value + "/" + _max;
            }
            pen.beginBitmapFill(_graphics_thuck,new Matrix(1.04065040650407));
            pen.drawRect(0,0,(_width + 413) * rate,_height);
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
