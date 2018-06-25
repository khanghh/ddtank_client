package enchant.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class EnchantExpBar extends Component
   {
       
      
      private var _progressBg:Bitmap;
      
      private var _progressColorBg:Bitmap;
      
      private var _progressBarMask:Sprite;
      
      private var _scaleValue:Number;
      
      private var _total:int = 50;
      
      private var _currentFrame:int;
      
      private var _destFrame:int;
      
      private var _isUpGrade:Boolean;
      
      private var _curExp:int;
      
      private var _sumExp:int;
      
      private var _starMc:MovieClip;
      
      private var _progressCompleteMc:MovieClip;
      
      private var _progressTxt:FilterFrameText;
      
      public var upGradeFunc:Function;
      
      public function EnchantExpBar()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         tipDirctions = "3,0";
         tipStyle = "ddt.view.tips.OneLineTip";
         _progressBg = ComponentFactory.Instance.creat("enchant.progress.bg");
         addChild(_progressBg);
         _progressColorBg = ComponentFactory.Instance.creat("enchant.progressColor.bg");
         addChild(_progressColorBg);
         _progressBarMask = new Sprite();
         _progressBarMask.graphics.beginFill(16777215,1);
         _progressBarMask.graphics.drawRect(_progressColorBg.x,_progressColorBg.y,_progressColorBg.width,_progressColorBg.height);
         _progressBarMask.graphics.endFill();
         _progressBarMask.width = 0;
         _progressColorBg.cacheAsBitmap = true;
         _progressColorBg.mask = _progressBarMask;
         addChild(_progressBarMask);
         _starMc = ComponentFactory.Instance.creat("enchant.starMc");
         addChild(_starMc);
         _starMc.visible = false;
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("ddt.store.view.exalt.StoreExaltProgressBar.percentage");
         addChild(_progressTxt);
         PositionUtils.setPos(_progressTxt,"enchant.percentTxtPos");
         _scaleValue = _progressColorBg.width / _total;
         width = _progressBg.width;
         height = _progressBg.height;
         initPercentAndTip();
      }
      
      public function initPercentAndTip() : void
      {
         setMask(0);
         _progressTxt.text = "0%";
         tipData = "0/0";
      }
      
      public function initProgress(curExp:Number, sumExp:Number) : void
      {
         var rate:Number = NaN;
         var tempFrame:int = 0;
         _currentFrame = 0;
         if(sumExp > 0 && curExp < sumExp)
         {
            rate = curExp / sumExp;
            tempFrame = Math.floor(rate * _total);
            if(tempFrame < 1 && rate > 0)
            {
               tempFrame = 1;
            }
            _currentFrame = tempFrame;
         }
         setMask(_currentFrame);
         setExpPercent(curExp,sumExp);
         _starMc.visible = false;
      }
      
      public function setExpPercent(curExp:Number, sumExp:Number) : void
      {
         tipData = curExp + "/" + sumExp;
         var percent:Number = sumExp == 0?100:Number((curExp / sumExp * 10000 / 100).toFixed(2));
         _progressTxt.text = percent + "%";
      }
      
      public function setMask(value:Number) : void
      {
         var tempWidth:Number = value * _scaleValue;
         if(isNaN(tempWidth) || tempWidth == 0)
         {
            _progressBarMask.width = 0;
         }
         else
         {
            if(tempWidth >= _progressColorBg.width)
            {
               tempWidth = tempWidth % _progressColorBg.width;
            }
            _progressBarMask.width = tempWidth;
         }
         _starMc.x = _progressBarMask.x + _progressBarMask.width;
      }
      
      public function updateProgress(curExp:int, sumExp:int, isUpGrade:Boolean = false) : void
      {
         _isUpGrade = isUpGrade;
         _curExp = curExp;
         _sumExp = sumExp;
         var rate:Number = curExp / sumExp;
         var tempFrame:int = !!_isUpGrade?_total:Math.floor(rate * _total);
         if(tempFrame < 1 && rate > 0)
         {
            tempFrame = 1;
         }
         if(_isUpGrade)
         {
            setExpPercent(sumExp,sumExp);
         }
         else
         {
            setExpPercent(curExp,sumExp);
         }
         if(_currentFrame != tempFrame)
         {
            _destFrame = tempFrame;
            _starMc.visible = true;
            addEventListener("enterFrame",__frameHandler);
         }
      }
      
      protected function __frameHandler(event:Event) : void
      {
         _currentFrame = Number(_currentFrame) + 1;
         setMask(_currentFrame);
         if(_currentFrame >= _destFrame)
         {
            removeEventListener("enterFrame",__frameHandler);
            _starMc.visible = false;
            if(_destFrame >= _total)
            {
               _currentFrame = 0;
               removeProgressCompleteMc();
               showProgressCompleteMc();
            }
         }
      }
      
      protected function __completeFrameHandler(event:Event) : void
      {
         if(_progressCompleteMc && _progressCompleteMc.currentFrame == _progressCompleteMc.totalFrames)
         {
            removeProgressCompleteMc();
            _progressTxt.text = "0%";
            setMask(0);
            if(upGradeFunc != null)
            {
               upGradeFunc();
            }
            updateProgress(_curExp,_sumExp);
         }
      }
      
      private function removeProgressCompleteMc() : void
      {
         if(_progressCompleteMc && _progressCompleteMc.parent)
         {
            _progressCompleteMc.removeEventListener("enterFrame",__completeFrameHandler);
            _progressCompleteMc.stop();
            _progressCompleteMc.parent.removeChild(_progressCompleteMc);
            _progressCompleteMc = null;
         }
      }
      
      private function showProgressCompleteMc() : void
      {
         _progressCompleteMc = ComponentFactory.Instance.creat("enchant.progressCompleteMc");
         addChildAt(_progressCompleteMc,3);
         _progressCompleteMc.addEventListener("enterFrame",__completeFrameHandler);
      }
      
      override public function dispose() : void
      {
         removeProgressCompleteMc();
         removeEventListener("enterFrame",__frameHandler);
         if(_starMc)
         {
            _starMc.stop();
            ObjectUtils.disposeObject(_starMc);
            _starMc = null;
         }
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_progressBg);
         _progressBg = null;
         ObjectUtils.disposeObject(_progressColorBg);
         _progressColorBg = null;
         _progressBarMask.graphics.clear();
         ObjectUtils.disposeObject(_progressBarMask);
         _progressBarMask = null;
         super.dispose();
      }
   }
}
