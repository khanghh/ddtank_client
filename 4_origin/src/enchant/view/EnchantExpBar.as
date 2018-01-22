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
      
      public function initProgress(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         _currentFrame = 0;
         if(param2 > 0 && param1 < param2)
         {
            _loc3_ = param1 / param2;
            _loc4_ = Math.floor(_loc3_ * _total);
            if(_loc4_ < 1 && _loc3_ > 0)
            {
               _loc4_ = 1;
            }
            _currentFrame = _loc4_;
         }
         setMask(_currentFrame);
         setExpPercent(param1,param2);
         _starMc.visible = false;
      }
      
      public function setExpPercent(param1:Number, param2:Number) : void
      {
         tipData = param1 + "/" + param2;
         var _loc3_:Number = param2 == 0?100:Number((param1 / param2 * 10000 / 100).toFixed(2));
         _progressTxt.text = _loc3_ + "%";
      }
      
      public function setMask(param1:Number) : void
      {
         var _loc2_:Number = param1 * _scaleValue;
         if(isNaN(_loc2_) || _loc2_ == 0)
         {
            _progressBarMask.width = 0;
         }
         else
         {
            if(_loc2_ >= _progressColorBg.width)
            {
               _loc2_ = _loc2_ % _progressColorBg.width;
            }
            _progressBarMask.width = _loc2_;
         }
         _starMc.x = _progressBarMask.x + _progressBarMask.width;
      }
      
      public function updateProgress(param1:int, param2:int, param3:Boolean = false) : void
      {
         _isUpGrade = param3;
         _curExp = param1;
         _sumExp = param2;
         var _loc4_:Number = param1 / param2;
         var _loc5_:int = !!_isUpGrade?_total:Math.floor(_loc4_ * _total);
         if(_loc5_ < 1 && _loc4_ > 0)
         {
            _loc5_ = 1;
         }
         if(_isUpGrade)
         {
            setExpPercent(param2,param2);
         }
         else
         {
            setExpPercent(param1,param2);
         }
         if(_currentFrame != _loc5_)
         {
            _destFrame = _loc5_;
            _starMc.visible = true;
            addEventListener("enterFrame",__frameHandler);
         }
      }
      
      protected function __frameHandler(param1:Event) : void
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
      
      protected function __completeFrameHandler(param1:Event) : void
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
