package petsBag.petsAdvanced
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.utils.setTimeout;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   
   public class PetsBreakAnimationFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _barProgressBG:Bitmap;
      
      private var _progressBar:Bitmap;
      
      public var _btnBreak:SimpleBitmapButton;
      
      private var _petsBasicInfoView:PetsBasicInfoView;
      
      private var _maxProgressWidth:Number;
      
      private var _flag:int = 0;
      
      public function PetsBreakAnimationFrame()
      {
         super();
         escEnable = true;
         addEvent();
      }
      
      override protected function init() : void
      {
         super.init();
         titleText = "Pet Hiến Tế";
         _bg = ComponentFactory.Instance.creatBitmap("petsBag.break.breakBG");
         _bg.x = 5;
         _bg.y = 40;
         addToContent(_bg);
         _barProgressBG = ComponentFactory.Instance.creatBitmap("petsBag.break.BGProgress");
         _barProgressBG.x = 18;
         _barProgressBG.y = 295;
         addToContent(_barProgressBG);
         _progressBar = ComponentFactory.Instance.creatBitmap("petsBag.break.progressBar");
         _progressBar.x = 28;
         _progressBar.y = 295;
         addToContent(_progressBar);
         _maxProgressWidth = _progressBar.width;
         _btnBreak = ComponentFactory.Instance.creat("petsBag.break.SimpleBitmapBtn");
         addToContent(_btnBreak);
         _petsBasicInfoView = new PetsBasicInfoView();
         _petsBasicInfoView.x = -17;
         _petsBasicInfoView.y = -38;
         addToContent(_petsBasicInfoView);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_response);
      }
      
      private function _response(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            this.parent && this.parent.removeChild(this);
         }
         else
         {
            dispatchEvent(new Event("cancel"));
         }
      }
      
      public function show() : void
      {
         this.escEnable = true;
         this.closeButton.enable = true;
         this._btnBreak.enable = true;
         var petInfo:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         _petsBasicInfoView.setInfo(petInfo);
         this.addEventListener("enterFrame",onEF);
      }
      
      public function hide() : void
      {
         this.removeEventListener("enterFrame",onEF);
      }
      
      public function result(isSuccess:Boolean) : void
      {
         this.removeEventListener("enterFrame",onEF);
         this.escEnable = false;
         this.closeButton.enable = false;
         this._btnBreak.enable = false;
         if(isSuccess)
         {
            TweenMax.killTweensOf(_progressBar);
            TweenMax.to(_progressBar,1,{
               "width":_maxProgressWidth,
               "ease":Linear.easeNone,
               "onComplete":remove
            });
         }
         else
         {
            TweenMax.killTweensOf(_progressBar);
            TweenMax.to(_progressBar,1,{
               "width":0,
               "ease":Linear.easeNone,
               "onComplete":remove
            });
         }
      }
      
      private function remove() : void
      {
      }
      
      private function rmv() : void
      {
      }
      
      protected function onEF(e:Event) : void
      {
         var rnd:Number = NaN;
         _flag = Number(_flag) + 1;
         if(_flag > 15)
         {
            _flag = 0;
            rnd = Math.random() * _maxProgressWidth;
            _progressBar && TweenMax.killTweensOf(_progressBar);
            _progressBar && TweenMax.to(_progressBar,0.5,{
               "width":rnd,
               "ease":Linear.easeNone
            });
         }
      }
      
      override public function dispose() : void
      {
         _bg = null;
         _barProgressBG = null;
         _progressBar = null;
         if(_btnBreak != null)
         {
            ObjectUtils.disposeObject(_btnBreak);
            _btnBreak = null;
         }
         if(_petsBasicInfoView != null)
         {
            ObjectUtils.disposeObject(_petsBasicInfoView);
            _petsBasicInfoView = null;
         }
      }
   }
}
