package store.view.strength
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import store.data.StoreEquipExperience;
   
   public class StoreStrengthProgress extends Component
   {
       
      
      protected var _background:Bitmap;
      
      protected var _thuck:Component;
      
      protected var _graphics_thuck:Bitmap;
      
      protected var _progressLabel:FilterFrameText;
      
      protected var _star:MovieClip;
      
      protected var _max:Number = 0;
      
      protected var _currentFrame:int;
      
      private var _strengthenLevel:int;
      
      private var _strengthenExp:int;
      
      private var _progressBarMask:Sprite;
      
      private var _scaleValue:Number;
      
      private var _taskFrames:Dictionary;
      
      private var _total:int = 50;
      
      public function StoreStrengthProgress()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _background = ComponentFactory.Instance.creatBitmap("asset.ddtstore.StrengthenSpaceProgress");
         PositionUtils.setPos(_background,"asset.ddtstore.StrengthenSpaceProgressBgPos");
         addChild(_background);
         _thuck = ComponentFactory.Instance.creatComponentByStylename("ddtstore.info.thunck");
         addChild(_thuck);
         _graphics_thuck = ComponentFactory.Instance.creatBitmap("asset.ddtstore.StrengthenColorStrip");
         addChild(_graphics_thuck);
         initMask();
         _star = ClassUtils.CreatInstance("asset.strengthen.star");
         _star.y = _progressBarMask.y + _progressBarMask.height / 2;
         addChild(_star);
         _progressLabel = ComponentFactory.Instance.creatComponentByStylename("ddtstore.info.StoreStrengthProgressText");
         addChild(_progressLabel);
         _scaleValue = _graphics_thuck.width / _total;
         resetProgress();
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
               this.dispatchEvent(new Event("weaponUpgradesPlay"));
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
      
      private function initMask() : void
      {
         _progressBarMask = new Sprite();
         _progressBarMask.graphics.beginFill(16777215,1);
         _progressBarMask.graphics.drawRect(0,0,_graphics_thuck.width,_graphics_thuck.height);
         _progressBarMask.graphics.endFill();
         _graphics_thuck.cacheAsBitmap = true;
         _graphics_thuck.mask = _progressBarMask;
         addChild(_progressBarMask);
      }
      
      private function setStarVisible(param1:Boolean) : void
      {
         _star.visible = param1;
      }
      
      public function getStarVisible() : Boolean
      {
         return _star.visible;
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
      
      public function initProgress(param1:InventoryItemInfo) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         _currentFrame = 0;
         _strengthenExp = param1.StrengthenExp;
         _strengthenLevel = param1.StrengthenLevel;
         _max = StoreEquipExperience.expericence[_strengthenLevel + 1];
         if(_max > 0 && _strengthenExp < _max)
         {
            _loc2_ = _strengthenExp / _max;
            _loc3_ = Math.floor(_loc2_ * _total);
            if(_loc3_ < 1 && _loc2_ > 0)
            {
               _loc3_ = 1;
            }
            _currentFrame = _loc3_;
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
      
      public function setProgress(param1:InventoryItemInfo) : void
      {
         if(_strengthenLevel != param1.StrengthenLevel)
         {
            _taskFrames[0] = _total;
            _strengthenLevel = param1.StrengthenLevel;
         }
         _strengthenExp = param1.StrengthenExp;
         _max = StoreEquipExperience.expericence[_strengthenLevel + 1];
         var _loc2_:Number = _strengthenExp / _max;
         var _loc3_:int = Math.floor(_loc2_ * _total);
         if(_loc3_ < 1 && _loc2_ > 0)
         {
            _loc3_ = 1;
         }
         if(_currentFrame == _loc3_)
         {
            if(_taskFrames[0] && int(_taskFrames[0]) != 0)
            {
               setStarVisible(true);
               _taskFrames[1] = _loc3_;
               startProgress();
            }
         }
         else
         {
            setStarVisible(true);
            _taskFrames[1] = _loc3_;
            startProgress();
         }
         setExpPercent();
      }
      
      public function setExpPercent() : void
      {
         var _loc1_:* = NaN;
         if(_strengthenExp == 0 || _strengthenLevel == 0)
         {
            _progressLabel.text = "0%";
         }
         else
         {
            _loc1_ = Number(StoreEquipExperience.getExpPercent(_strengthenLevel,_strengthenExp));
            if(isNaN(_loc1_))
            {
               _loc1_ = 0;
            }
            _progressLabel.text = _loc1_ + "%";
         }
         if(_strengthenLevel >= 12)
         {
            tipData = "0/0";
         }
         else
         {
            if(isNaN(_strengthenExp))
            {
               _strengthenExp = 0;
            }
            if(isNaN(_max))
            {
               _max = 0;
            }
            tipData = _strengthenExp + "/" + _max;
         }
      }
      
      public function resetProgress() : void
      {
         tipData = "0/0";
         _progressLabel.text = "0%";
         _strengthenExp = 0;
         _max = 0;
         _currentFrame = 0;
         _strengthenLevel = -1;
         setMask(0);
         setStarVisible(false);
         _taskFrames = new Dictionary();
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
         if(_progressBarMask)
         {
            ObjectUtils.disposeObject(_progressBarMask);
         }
         if(this.hasEventListener("enterFrame"))
         {
            this.removeEventListener("enterFrame",__startFrame);
         }
         super.dispose();
      }
   }
}
