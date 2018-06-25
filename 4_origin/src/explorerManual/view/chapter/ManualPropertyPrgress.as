package explorerManual.view.chapter
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import explorerManual.data.ExplorerManualInfo;
   import flash.display.Bitmap;
   
   public class ManualPropertyPrgress extends Component
   {
       
      
      protected var _progressLabel:FilterFrameText;
      
      protected var _proBitmap:Bitmap;
      
      protected var _proBitMask:Bitmap;
      
      protected var _value:Number = 0;
      
      protected var _max:Number = 100;
      
      private var _oldValue:Number = 0;
      
      private var _isInit:Boolean = false;
      
      private var _model:ExplorerManualInfo;
      
      public function ManualPropertyPrgress(model:ExplorerManualInfo)
      {
         super();
         _model = model;
         _height = 10;
         _width = 10;
         initView();
      }
      
      private function initView() : void
      {
         _proBitMask = ComponentFactory.Instance.creat("asset.explorerManual.progressAsset");
         _proBitMask.width = 0;
         addChild(_proBitMask);
         _proBitmap = ComponentFactory.Instance.creat("asset.explorerManual.progressAsset");
         addChild(_proBitmap);
         _proBitmap.mask = _proBitMask;
         _progressLabel = ComponentFactory.Instance.creatComponentByStylename("explorerManual.chapterLeft.progressText");
         addChild(_progressLabel);
      }
      
      public function setProgress(curValue:Number, maxValue:Number) : void
      {
         _oldValue = _value;
         _value = curValue;
         _max = maxValue;
         drawProgress();
      }
      
      protected function drawProgress() : void
      {
         var vScale:int = 0;
         if(_value <= 0 && _isInit)
         {
            vScale = 225;
         }
         else
         {
            vScale = 225 * _value / _max;
         }
         var curV:Number = _progressLabel.text;
         var maxV:Number = _value == 0?_max:Number(_value);
         var offsetV:Number = (maxV - curV) / 25;
         TweenLite.to(_proBitMask,1,{
            "width":vScale,
            "onUpdate":updateLabel,
            "onUpdateParams":[offsetV],
            "onComplete":updateComplete
         });
      }
      
      private function updateLabel(pOffsetV:int) : void
      {
         if(_isInit)
         {
            _progressLabel.text = (int(_progressLabel.text) + pOffsetV).toString();
         }
      }
      
      private function updateComplete() : void
      {
         if(_value == 0)
         {
            _proBitMask.width = 0;
         }
         _progressLabel.text = _value.toString();
         _model.proLevMaxProgress = _model.maxProgress;
         _isInit = true;
      }
      
      override public function dispose() : void
      {
         if(_proBitMask)
         {
            TweenLite.killTweensOf(_proBitMask);
            ObjectUtils.disposeObject(_proBitMask);
            _proBitMask = null;
         }
         ObjectUtils.disposeObject(_proBitmap);
         _proBitmap = null;
         ObjectUtils.disposeObject(_progressLabel);
         _progressLabel = null;
         _model = null;
         super.dispose();
      }
   }
}
