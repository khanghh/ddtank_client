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
      
      private function __startFrame(e:Event) : void
      {
         _currentFrame = Number(_currentFrame) + 1;
         setMask(_currentFrame);
         var frameNum:int = 0;
         if(_taskFrames.hasOwnProperty(0))
         {
            frameNum = _taskFrames[0];
         }
         if(frameNum == 0 && _taskFrames.hasOwnProperty(1))
         {
            frameNum = _taskFrames[1];
         }
         if(_currentFrame >= frameNum)
         {
            if(frameNum >= _total)
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
               e.stopImmediatePropagation();
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
      
      private function setStarVisible(value:Boolean) : void
      {
         _star.visible = value;
      }
      
      public function getStarVisible() : Boolean
      {
         return _star.visible;
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
            if(tempWidth >= _graphics_thuck.width)
            {
               tempWidth = tempWidth % _graphics_thuck.width;
            }
            _progressBarMask.width = tempWidth;
         }
         _star.x = _progressBarMask.x + _progressBarMask.width;
      }
      
      public function initProgress(info:InventoryItemInfo) : void
      {
         var rate:Number = NaN;
         var tempFrame:int = 0;
         _currentFrame = 0;
         _strengthenExp = info.StrengthenExp;
         _strengthenLevel = info.StrengthenLevel;
         _max = StoreEquipExperience.expericence[_strengthenLevel + 1];
         if(_max > 0 && _strengthenExp < _max)
         {
            rate = _strengthenExp / _max;
            tempFrame = Math.floor(rate * _total);
            if(tempFrame < 1 && rate > 0)
            {
               tempFrame = 1;
            }
            _currentFrame = tempFrame;
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
      
      public function setProgress(info:InventoryItemInfo) : void
      {
         if(_strengthenLevel != info.StrengthenLevel)
         {
            _taskFrames[0] = _total;
            _strengthenLevel = info.StrengthenLevel;
         }
         _strengthenExp = info.StrengthenExp;
         _max = StoreEquipExperience.expericence[_strengthenLevel + 1];
         var rate:Number = _strengthenExp / _max;
         var tempFrame:int = Math.floor(rate * _total);
         if(tempFrame < 1 && rate > 0)
         {
            tempFrame = 1;
         }
         if(_currentFrame == tempFrame)
         {
            if(_taskFrames[0] && int(_taskFrames[0]) != 0)
            {
               setStarVisible(true);
               _taskFrames[1] = tempFrame;
               startProgress();
            }
         }
         else
         {
            setStarVisible(true);
            _taskFrames[1] = tempFrame;
            startProgress();
         }
         setExpPercent();
      }
      
      public function setExpPercent() : void
      {
         var expPercent:* = NaN;
         if(_strengthenExp == 0 || _strengthenLevel == 0)
         {
            _progressLabel.text = "0%";
         }
         else
         {
            expPercent = Number(StoreEquipExperience.getExpPercent(_strengthenLevel,_strengthenExp));
            if(isNaN(expPercent))
            {
               expPercent = 0;
            }
            _progressLabel.text = expPercent + "%";
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
