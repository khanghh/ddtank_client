package beadSystem.controls
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class BeadFeedProgress extends Component
   {
       
      
      protected var _background:Bitmap;
      
      protected var _thuck:Component;
      
      protected var _graphics_thuck:Bitmap;
      
      protected var _progressLabel:FilterFrameText;
      
      protected var _star:MovieClip;
      
      private var _progressBarMask:Sprite;
      
      private var _scaleValue:Number;
      
      private var _total:int = 50;
      
      private var _taskFrames:Dictionary;
      
      private var _currentExp:int;
      
      private var _upLevelExp:int;
      
      private var _currentLevel:int;
      
      private var _currentFrame:int;
      
      public function BeadFeedProgress()
      {
         super();
         intView();
      }
      
      private function intView() : void
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
         _star.y = _progressBarMask.height / 2;
         addChild(_star);
         _progressLabel = ComponentFactory.Instance.creatComponentByStylename("ddtstore.info.StoreStrengthProgressText");
         addChild(_progressLabel);
         _scaleValue = _graphics_thuck.width / _total;
         resetProgress();
      }
      
      public function set currentExp(param1:int) : void
      {
         _currentExp = param1;
      }
      
      public function set upLevelExp(param1:int) : void
      {
         _upLevelExp = param1;
      }
      
      public function resetProgress() : void
      {
         tipData = "0/0";
         _progressLabel.text = "0%";
         _currentExp = 0;
         _upLevelExp = 0;
         _currentFrame = 0;
         _currentLevel = -1;
         setMask(0);
         setStarVisible(false);
         _taskFrames = new Dictionary();
      }
      
      public function intProgress(param1:InventoryItemInfo) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         _currentFrame = 0;
         _currentLevel = 5;
         if(_upLevelExp > 0 && _currentExp < _upLevelExp)
         {
            _loc2_ = _currentExp / _upLevelExp;
            _loc3_ = Math.floor(_loc2_ * _total);
            if(_loc3_ < 1 && _loc2_ > 0)
            {
               _loc3_ = 1;
            }
            _currentFrame = _loc3_;
         }
         setMask(_currentFrame);
         setExpPercent();
         setStarVisible(false);
         _taskFrames = new Dictionary();
      }
      
      public function setProgress(param1:InventoryItemInfo) : void
      {
         if(_currentLevel == 6)
         {
            _taskFrames[0] = _total;
            _currentLevel = 6;
         }
         var _loc2_:Number = _currentExp / _upLevelExp;
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
      
      private function setExpPercent() : void
      {
         var _loc1_:* = NaN;
         if(_currentExp == 0 || int(PlayerManager.Instance.Self.embedUpLevelCell.itemInfo.Hole1) == 21)
         {
            _progressLabel.text = "0%";
         }
         else
         {
            _loc1_ = Number(int(_currentExp / _upLevelExp * 100));
            if(isNaN(_loc1_))
            {
               _loc1_ = 0;
            }
            _progressLabel.text = _loc1_ + "%";
         }
         if(isNaN(_currentExp))
         {
            _currentExp = 0;
         }
         if(isNaN(_upLevelExp))
         {
            _upLevelExp = 0;
         }
         if(int(PlayerManager.Instance.Self.embedUpLevelCell.itemInfo.Hole1) == 21)
         {
            tipData = _currentExp + "/" + 0;
         }
         else
         {
            tipData = _currentExp + "/" + _upLevelExp;
         }
      }
      
      private function setStarVisible(param1:Boolean) : void
      {
         _star.visible = param1;
      }
      
      private function setMask(param1:Number) : void
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
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_thuck);
         _thuck = null;
         ObjectUtils.disposeObject(_background);
         _background = null;
         ObjectUtils.disposeObject(_graphics_thuck);
         _graphics_thuck = null;
         ObjectUtils.disposeObject(_progressLabel);
         _progressLabel = null;
         ObjectUtils.disposeObject(_progressBarMask);
         _progressBarMask = null;
         ObjectUtils.disposeObject(_star);
         _star = null;
         if(this.hasEventListener("enterFrame"))
         {
            this.removeEventListener("enterFrame",__startFrame);
         }
         super.dispose();
      }
   }
}
