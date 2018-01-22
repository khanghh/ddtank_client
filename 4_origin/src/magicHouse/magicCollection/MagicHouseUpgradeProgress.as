package magicHouse.magicCollection
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import magicHouse.MagicHouseModel;
   
   public class MagicHouseUpgradeProgress extends Component
   {
      
      private static const MAXLEVEL:int = 5;
       
      
      private var _background:Bitmap;
      
      protected var _graphics_thuck:Bitmap;
      
      protected var _progressLabel:FilterFrameText;
      
      protected var _star:MovieClip;
      
      private var _progressBarMask:Sprite;
      
      private var _total:int = 50;
      
      private var _scaleValue:Number;
      
      protected var _max:Number = 0;
      
      private var _exp:int;
      
      protected var _currentFrame:int;
      
      private var _taskFrames:Dictionary;
      
      private var _level:int;
      
      public function MagicHouseUpgradeProgress()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _background = ComponentFactory.Instance.creatBitmap("magichouse.upgradeprogress.bg");
         addChild(_background);
         _graphics_thuck = ComponentFactory.Instance.creatBitmap("magichouse.upgradeprogress.progress");
         addChild(_graphics_thuck);
         initMask();
         _star = ClassUtils.CreatInstance("magichouse.upgradeprogress.light");
         _star.y = _progressBarMask.y + _progressBarMask.height / 2;
         addChild(_star);
         _progressLabel = ComponentFactory.Instance.creatComponentByStylename("magichouse.collectionItem.upgradeProgressText");
         addChild(_progressLabel);
         _scaleValue = _graphics_thuck.width / _total;
         resetProgress();
      }
      
      private function initMask() : void
      {
         _progressBarMask = new Sprite();
         _progressBarMask.graphics.beginFill(16777215,1);
         _progressBarMask.graphics.drawRect(7,5,_graphics_thuck.width,_graphics_thuck.height);
         _progressBarMask.graphics.endFill();
         _graphics_thuck.cacheAsBitmap = true;
         _graphics_thuck.mask = _progressBarMask;
         addChild(_progressBarMask);
      }
      
      private function startProgress() : void
      {
         this.addEventListener("enterFrame",__startFrame);
      }
      
      private function __startFrame(param1:Event) : void
      {
         _currentFrame = Number(_currentFrame) + 1;
         setMask(_currentFrame);
         var _loc2_:int = 0;
         if(_taskFrames.hasOwnProperty(0))
         {
            _loc2_ = _taskFrames[0];
         }
         if(_loc2_ == 0 && _taskFrames.hasOwnProperty(1))
         {
            _loc2_ = _taskFrames[1];
         }
         if(_currentFrame >= _loc2_)
         {
            if(_loc2_ >= _total)
            {
               _currentFrame = 0;
               _taskFrames[0] = 0;
            }
            else
            {
               _taskFrames[1] = 0;
               this.removeEventListener("enterFrame",__startFrame);
               setStarVisible(false);
               param1.stopImmediatePropagation();
            }
         }
      }
      
      public function resetProgress() : void
      {
         tipData = "0/0";
         _progressLabel.text = "0%";
         _exp = 0;
         _max = 0;
         _currentFrame = 0;
         _level = -1;
         setMask(0);
         setStarVisible(false);
         _taskFrames = new Dictionary();
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
            if(_loc2_ >= _graphics_thuck.width)
            {
               _loc2_ = _loc2_ % _graphics_thuck.width;
            }
            _progressBarMask.width = _loc2_;
         }
         _star.x = _progressBarMask.x + _progressBarMask.width;
      }
      
      private function setStarVisible(param1:Boolean) : void
      {
         _star.visible = param1;
      }
      
      public function getStarVisible() : Boolean
      {
         return _star.visible;
      }
      
      public function initProgress(param1:int, param2:int) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         _currentFrame = 0;
         _exp = param2;
         _level = param1;
         if(_level != 5)
         {
            _max = MagicHouseModel.instance.levelUpNumber[_level];
         }
         else
         {
            _max = 0;
         }
         if(_max > 0 && _exp < _max)
         {
            _loc3_ = _exp / _max;
            _loc4_ = Math.floor(_loc3_ * _total);
            if(_loc4_ < 1 && _loc3_ > 0)
            {
               _loc4_ = 1;
            }
            _currentFrame = _loc4_;
         }
         setMask(_currentFrame);
         setExpPercent();
         _taskFrames = new Dictionary();
         if(this.hasEventListener("enterFrame"))
         {
            this.removeEventListener("enterFrame",__startFrame);
         }
         setStarVisible(false);
      }
      
      public function setProgress(param1:int, param2:int) : void
      {
         if(_level != param1)
         {
            _taskFrames[0] = _total;
            _level = param1;
         }
         _exp = param2;
         if(_level != 5)
         {
            _max = MagicHouseModel.instance.levelUpNumber[_level];
         }
         else
         {
            _max = 0;
         }
         var _loc3_:Number = _exp / _max;
         var _loc4_:int = Math.floor(_loc3_ * _total);
         if(_loc4_ < 1 && _loc3_ > 0)
         {
            _loc4_ = 1;
         }
         if(_currentFrame == _loc4_)
         {
            if(_taskFrames[0] && int(_taskFrames[0]) != 0)
            {
               setStarVisible(true);
               _taskFrames[1] = _loc4_;
               startProgress();
            }
         }
         else
         {
            setStarVisible(true);
            _taskFrames[1] = _loc4_;
            startProgress();
         }
         setExpPercent();
      }
      
      public function setExpPercent() : void
      {
         _progressLabel.text = _exp + "/" + _max;
         if(_level >= 5)
         {
            tipData = "0/0";
         }
         else
         {
            if(isNaN(_exp))
            {
               _exp = 0;
            }
            if(isNaN(_max))
            {
               _max = 0;
            }
            tipData = _exp + "/" + _max;
         }
      }
      
      override public function dispose() : void
      {
         if(_background)
         {
            ObjectUtils.disposeObject(_background);
         }
         _background = null;
         if(_graphics_thuck)
         {
            ObjectUtils.disposeObject(_graphics_thuck);
         }
         _graphics_thuck = null;
         if(_progressLabel)
         {
            ObjectUtils.disposeObject(_progressLabel);
         }
         _progressLabel = null;
         if(_star)
         {
            ObjectUtils.disposeObject(_star);
         }
         _star = null;
         if(_progressBarMask)
         {
            ObjectUtils.disposeObject(_progressBarMask);
         }
         _progressBarMask = null;
         if(this.hasEventListener("enterFrame"))
         {
            this.removeEventListener("enterFrame",__startFrame);
         }
         super.dispose();
      }
   }
}
