package petsBag.petsAdvanced
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import petsBag.petsAdvanced.event.PetsAdvancedEvent;
   
   public class PetsAdvancedProgressBar extends Sprite implements Disposeable
   {
       
      
      private var _progressBg:Bitmap;
      
      private var _progressBar:Bitmap;
      
      protected var _progressTxt:FilterFrameText;
      
      private var _progressBarMask:Sprite;
      
      protected var _progressMc:MovieClip;
      
      protected var _currentExp:int;
      
      protected var _max:int;
      
      protected var _sumWidth:Number;
      
      public function PetsAdvancedProgressBar()
      {
         super();
         initView();
      }
      
      private function addEvent() : void
      {
         addEventListener("enterFrame",__enterFrame);
      }
      
      protected function __enterFrame(param1:Event) : void
      {
         if(_progressMc.currentFrame >= 25)
         {
            _progressMc.stop();
            var _loc2_:Boolean = true;
            _progressBar.visible = _loc2_;
            _progressBg.visible = _loc2_;
            _progressMc.visible = false;
            removeEvent();
            dispatchEvent(new PetsAdvancedEvent("progress_movie_complete"));
         }
      }
      
      private function initView() : void
      {
         if(PetsAdvancedControl.Instance.currentViewType == 1)
         {
            _progressMc = ComponentFactory.Instance.creat("petsBag.risingStar.progressMc");
            _progressBg = ComponentFactory.Instance.creat("petsBag.risingStar.petsBag.progressBg");
            _progressBar = ComponentFactory.Instance.creat("petsBag.risingStar.petsBag.progressBar");
            _progressTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.advanced.progressTxt");
            PositionUtils.setPos(_progressTxt,"petsBag.risingStar.progressTxtPos");
         }
         else if(PetsAdvancedControl.Instance.currentViewType == 2)
         {
            _progressMc = ComponentFactory.Instance.creat("petsBag.evolution.progressMc");
            _progressBg = ComponentFactory.Instance.creat("petsBag.evolution.progressBg");
            _progressBar = ComponentFactory.Instance.creat("petsBag.evolution.progressBar");
            _progressTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.advanced.progressTxt");
            PositionUtils.setPos(_progressTxt,"petsBag.ecolution.progressTxtPos");
         }
         else
         {
            _progressMc = ComponentFactory.Instance.creat("petsBag.evolution.progressMc");
            _progressBg = ComponentFactory.Instance.creat("assets.PetsBag.eatPets.expBarBg");
            _progressBar = ComponentFactory.Instance.creat("assets.PetsBag.eatPets.expBar");
            _progressTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.advanced.progressTxt");
            PositionUtils.setPos(_progressTxt,"petsBag.eatPets.progressTxtPos");
         }
         addChild(_progressMc);
         _progressMc.stop();
         _progressMc.visible = false;
         addChild(_progressBg);
         addChild(_progressBar);
         addChild(_progressTxt);
         _sumWidth = _progressBar.width - 20;
         _progressBarMask = new Sprite();
         _progressBarMask.graphics.beginFill(16777215,1);
         _progressBarMask.graphics.drawRect(0,0,_sumWidth,_progressBar.height);
         _progressBarMask.graphics.endFill();
         _progressBarMask.x = _progressBar.x + 9;
         _progressBarMask.y = _progressBar.y;
         _progressBar.cacheAsBitmap = true;
         _progressBar.mask = _progressBarMask;
         addChild(_progressBarMask);
         setProgress(0);
      }
      
      public function setProgress(param1:Number, param2:Boolean = false) : void
      {
         _currentExp = param1;
         if(param2)
         {
            _progressBarMask.width = _sumWidth;
            _progressTxt.text = "100%";
            var _loc3_:Boolean = false;
            _progressBar.visible = _loc3_;
            _progressBg.visible = _loc3_;
            _progressMc.visible = true;
            _progressMc.play();
            PetsAdvancedControl.Instance.isAllMovieComplete = false;
            PetsAdvancedControl.Instance.frame.enableBtn = false;
            addEvent();
         }
         else
         {
            _progressBarMask.width = Math.floor(_currentExp / _max * _sumWidth * 100) / 100;
            _progressTxt.text = Math.floor(_currentExp / _max * 10000) / 100 + "%";
         }
      }
      
      public function maxAdvancedGrade() : void
      {
         max = 0;
         _progressBarMask.width = _sumWidth;
         _progressTxt.text = "100%";
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__enterFrame);
      }
      
      public function dispose() : void
      {
         removeEvent();
         while(this.numChildren)
         {
            ObjectUtils.disposeObject(this.getChildAt(0));
         }
         _progressMc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get max() : Number
      {
         return _max;
      }
      
      public function set max(param1:Number) : void
      {
         _max = param1;
      }
      
      public function get currentExp() : int
      {
         return _currentExp;
      }
      
      public function set currentExp(param1:int) : void
      {
         _currentExp = param1;
      }
   }
}
