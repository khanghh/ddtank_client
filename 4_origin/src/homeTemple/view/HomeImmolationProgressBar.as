package homeTemple.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import homeTemple.HomeTempleController;
   import homeTemple.data.HomeTempleData;
   import homeTemple.event.HomeTempleEvent;
   
   public class HomeImmolationProgressBar extends Component
   {
       
      
      protected var _thuck:Bitmap;
      
      protected var _progressLabel:FilterFrameText;
      
      protected var _currentFrame:int;
      
      private var _strengthenLevel:int;
      
      private var _strengthenExp:int;
      
      private var _progressBarMask:Sprite;
      
      private var _scaleValue:Number;
      
      private var _taskFrames:Dictionary;
      
      private var _total:int = 50;
      
      private var _max:Number = 0;
      
      private var _upgradeMovie:MovieClip;
      
      public function HomeImmolationProgressBar()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _thuck = ComponentFactory.Instance.creatBitmap("asset.home.ColorStrip");
         addChild(_thuck);
         initMask();
         _progressLabel = ComponentFactory.Instance.creatComponentByStylename("home.temple.level.progressText");
         addChild(_progressLabel);
         _scaleValue = _thuck.width / _total;
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
            }
            else
            {
               _taskFrames[1] = 0;
               this.removeEventListener("enterFrame",__startFrame);
               param1.stopImmediatePropagation();
            }
         }
      }
      
      private function initMask() : void
      {
         _progressBarMask = new Sprite();
         _progressBarMask.graphics.beginFill(16777215,1);
         _progressBarMask.graphics.drawRect(0,0,_thuck.width,_thuck.height);
         _progressBarMask.graphics.endFill();
         _thuck.cacheAsBitmap = true;
         _thuck.mask = _progressBarMask;
         addChild(_progressBarMask);
      }
      
      public function initProgress() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:HomeTempleData = HomeTempleController.Instance.currentInfo;
         _currentFrame = 0;
         _strengthenExp = _loc3_.CurrentExp;
         _strengthenLevel = _loc3_.CurrentLevel;
         _max = HomeTempleController.Instance.getPracticeByLevel(_strengthenLevel + 1).Exp - HomeTempleController.Instance.getPracticeByLevel(_strengthenLevel).Exp;
         if(_max > 0 && _strengthenExp < _max)
         {
            _loc1_ = _strengthenExp / _max;
            _loc2_ = Math.floor(_loc1_ * _total);
            if(_loc2_ < 1 && _loc1_ > 0)
            {
               _loc2_ = 1;
            }
            _currentFrame = _loc2_;
         }
         setMask(_currentFrame);
         setExpPercent();
         _taskFrames = new Dictionary();
         if(this.hasEventListener("enterFrame"))
         {
            this.removeEventListener("enterFrame",__startFrame);
         }
      }
      
      public function setProgress() : void
      {
         var _loc3_:HomeTempleData = HomeTempleController.Instance.currentInfo;
         if(_strengthenLevel != _loc3_.CurrentLevel)
         {
            _taskFrames[0] = _total;
            _strengthenLevel = _loc3_.CurrentLevel;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("home.temple.upgradeText",HomeTempleController.Instance.getStarNum(),HomeTempleController.Instance.getStarLevelNum()));
            if(_strengthenLevel % 10 == 1)
            {
               HomeTempleController.Instance.dispatchEvent(new HomeTempleEvent("homeTempleUpdateBlessingState"));
            }
            playerUpgradeAnimation();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("home.temple.upgradeExpNumberText",_loc3_.CurrentExp - _strengthenExp),0,true);
         }
         _strengthenExp = _loc3_.CurrentExp;
         _max = HomeTempleController.Instance.getPracticeByLevel(_strengthenLevel + 1).Exp - HomeTempleController.Instance.getPracticeByLevel(_strengthenLevel).Exp;
         var _loc1_:Number = _strengthenExp / _max;
         var _loc2_:int = Math.floor(_loc1_ * _total);
         if(_loc2_ < 1 && _loc1_ > 0)
         {
            _loc2_ = 1;
         }
         if(_currentFrame == _loc2_)
         {
            if(_taskFrames[0] && int(_taskFrames[0]) != 0)
            {
               _taskFrames[1] = _loc2_;
               startProgress();
            }
         }
         else
         {
            _taskFrames[1] = _loc2_;
            startProgress();
         }
         setExpPercent();
      }
      
      private function playerUpgradeAnimation() : void
      {
         if(!_upgradeMovie)
         {
            _upgradeMovie = ComponentFactory.Instance.creat("home.temple.upgrade.animation");
            PositionUtils.setPos(_upgradeMovie,"home.temple.upgradeAnimationPos");
            addChild(_upgradeMovie);
         }
         _upgradeMovie.gotoAndPlay(1);
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
            if(_loc2_ >= _thuck.width)
            {
               _loc2_ = _loc2_ % _thuck.width;
            }
            _progressBarMask.width = _loc2_;
         }
      }
      
      private function setExpPercent() : void
      {
         var _loc1_:String = HomeTempleController.Instance.getExpPercent();
         if(_loc1_ == "")
         {
            _loc1_ = "0";
         }
         _progressLabel.text = _loc1_ + "%";
         if(_strengthenLevel >= HomeTempleController.MAXLEVEL)
         {
            _progressLabel.text = "0%";
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
         _currentFrame = 0;
         _strengthenLevel = -1;
         setMask(0);
         _taskFrames = new Dictionary();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_thuck);
         _thuck = null;
         ObjectUtils.disposeObject(_progressLabel);
         _progressLabel = null;
         ObjectUtils.disposeObject(_progressBarMask);
         _progressBarMask = null;
         if(this.hasEventListener("enterFrame"))
         {
            this.removeEventListener("enterFrame",__startFrame);
         }
         super.dispose();
      }
   }
}
