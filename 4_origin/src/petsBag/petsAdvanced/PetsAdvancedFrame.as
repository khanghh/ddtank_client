package petsBag.petsAdvanced
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpBtnEnable;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import petsBag.PetsBagManager;
   
   public class PetsAdvancedFrame extends Frame
   {
       
      
      private var _hBox:HBox;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _breakHelpBtn:SimpleBitmapButton;
      
      private var _ringStarBtn:SelectedButton;
      
      private var _evolutionBtn:SelectedButton;
      
      private var _formBtn:SelectedButton;
      
      private var _eatPetsBtn:SelectedButton;
      
      private var _breakBtn:SelectedButton;
      
      private var _awakenBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _currentIndex:int;
      
      private var _view;
      
      public function PetsAdvancedFrame()
      {
         super();
         initView();
         addEvent();
         checkOpenType();
      }
      
      private function initView() : void
      {
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"petsBag.button.helpBtn",null,LanguageMgr.GetTranslation("ddt.petsBag.formTitleTxt"),"asset.petsForm.helpText",404,484) as SimpleBitmapButton;
         PositionUtils.setPos(_helpBtn,"petsBag.form.helpBtnPos");
         _helpBtn.visible = true;
         var breakHelpContent:Sprite = ComponentFactory.Instance.creat("petsBag.helpFrame.petBreak");
         PositionUtils.setPos(breakHelpContent,"petsBag.advaced.petBreakHelpContentPos");
         _breakHelpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"petsBag.button.helpBtn",null,LanguageMgr.GetTranslation("ddt.petsBag.breakHelpTitle"),breakHelpContent,404,484) as SimpleBitmapButton;
         PositionUtils.setPos(_breakHelpBtn,"petsBag.form.helpBtnPos");
         _breakHelpBtn.visible = false;
         _hBox = ComponentFactory.Instance.creatComponentByStylename("petsBag.evolution.hBox");
         addToContent(_hBox);
         _ringStarBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.risingStarBtn");
         HelpBtnEnable.getInstance().addMouseOverTips(_ringStarBtn,30,"ddt.petsBag.isOpen");
         _hBox.addChild(_ringStarBtn);
         _evolutionBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.evolutionBtn");
         HelpBtnEnable.getInstance().addMouseOverTips(_evolutionBtn,35,"ddt.petsBag.isOpen");
         _hBox.addChild(_evolutionBtn);
         _formBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.formBtn");
         HelpBtnEnable.getInstance().addMouseOverTips(_formBtn,40,"ddt.petsBag.isOpen");
         _hBox.addChild(_formBtn);
         _eatPetsBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.eatPetsBtn");
         HelpBtnEnable.getInstance().addMouseOverTips(_eatPetsBtn,30,"ddt.petsBag.isOpen");
         if(PathManager.eatPetsEnable)
         {
            _hBox.addChild(_eatPetsBtn);
         }
         _breakBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.breakBtn");
         HelpBtnEnable.getInstance().addMouseOverTips(_breakBtn,60,"ddt.petsBag.isOpen");
         _hBox.addChild(_breakBtn);
         _awakenBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.awakenBtn");
         HelpBtnEnable.getInstance().addMouseOverTips(_awakenBtn,60,"ddt.petsBag.isOpen");
         _hBox.addChild(_awakenBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_ringStarBtn);
         _btnGroup.addSelectItem(_evolutionBtn);
         _btnGroup.addSelectItem(_formBtn);
         _btnGroup.addSelectItem(_eatPetsBtn);
         _btnGroup.addSelectItem(_breakBtn);
         _btnGroup.addSelectItem(_awakenBtn);
         var _loc2_:int = 0;
         _btnGroup.selectIndex = _loc2_;
         _currentIndex = _loc2_;
         PetsAdvancedControl.Instance.currentViewType = 1;
         PetsAdvancedManager.Instance.isPetsAdvancedViewShow = true;
         _view = new PetsRisingStarView();
         addToContent(_view);
      }
      
      private function checkOpenType() : void
      {
         if(PetsAdvancedManager.Instance.isLock)
         {
            enableBtn = false;
            var _loc1_:* = PetsAdvancedManager.Instance.openType;
            _btnGroup.selectIndex = _loc1_;
            _currentIndex = _loc1_;
         }
         else
         {
            _loc1_ = PetsAdvancedManager.Instance.openType;
            _btnGroup.selectIndex = _loc1_;
            _currentIndex = _loc1_;
         }
      }
      
      public function setBtnEnableFalse() : void
      {
         _ringStarBtn.enable = false;
         _evolutionBtn.enable = false;
         _formBtn.enable = false;
      }
      
      public function set enableBtn(value:Boolean) : void
      {
         var _loc2_:* = value;
         _awakenBtn.mouseEnabled = _loc2_;
         _loc2_ = _loc2_;
         _breakBtn.mouseEnabled = _loc2_;
         _loc2_ = _loc2_;
         _eatPetsBtn.mouseEnabled = _loc2_;
         _loc2_ = _loc2_;
         _formBtn.mouseEnabled = _loc2_;
         _loc2_ = _loc2_;
         _evolutionBtn.mouseEnabled = _loc2_;
         _ringStarBtn.mouseEnabled = _loc2_;
         _loc2_ = value;
         _awakenBtn.enable = _loc2_;
         _loc2_ = _loc2_;
         _eatPetsBtn.enable = _loc2_;
         _loc2_ = _loc2_;
         _breakBtn.enable = _loc2_;
         _loc2_ = _loc2_;
         _formBtn.enable = _loc2_;
         _loc2_ = _loc2_;
         _evolutionBtn.enable = _loc2_;
         _ringStarBtn.enable = _loc2_;
      }
      
      private function addEvent() : void
      {
         _btnGroup.addEventListener("change",__changeHandler);
         addEventListener("response",_response);
      }
      
      private function _response(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            if(PetsAdvancedControl.Instance.isAllMovieComplete)
            {
               SoundManager.instance.play("008");
               PetsAdvancedManager.Instance.dispatchEvent(new Event("petsAdvanceFrameClose"));
               dispose();
               SocketManager.Instance.out.sendClearStoreBag();
            }
         }
      }
      
      protected function __changeHandler(event:Event) : void
      {
         var visibleHelpBtn:Boolean = false;
         var helpTitle:* = null;
         var helpConten:* = null;
         SoundManager.instance.play("008");
         if(_btnGroup.selectIndex == _currentIndex)
         {
            return;
         }
         ObjectUtils.disposeObject(_view);
         _view = null;
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               visibleHelpBtn = false;
               _breakHelpBtn.visible = false;
               PetsAdvancedControl.Instance.currentViewType = 1;
               _view = new PetsRisingStarView();
               break;
            case 1:
               visibleHelpBtn = false;
               _breakHelpBtn.visible = false;
               PetsAdvancedControl.Instance.currentViewType = 2;
               _view = new PetsEvolutionView();
               break;
            case 2:
               visibleHelpBtn = true;
               _breakHelpBtn.visible = false;
               PetsAdvancedControl.Instance.currentViewType = 3;
               helpTitle = "ddt.petsBag.formTitleTxt";
               helpConten = "asset.petsForm.helpText";
               _view = new PetsFormView();
               break;
            case 3:
               visibleHelpBtn = false;
               _breakHelpBtn.visible = false;
               PetsAdvancedControl.Instance.currentViewType = 4;
               _view = new PetsEatView();
               break;
            case 4:
               visibleHelpBtn = false;
               _breakHelpBtn.visible = true;
               PetsAdvancedControl.Instance.currentViewType = 5;
               _view = new PetsMaxGradeBreakView();
               PetsBagManager.instance().petBreakInfoRequire();
               break;
            case 5:
               visibleHelpBtn = true;
               _breakHelpBtn.visible = false;
               helpTitle = "ddt.petsBag.petAwaken.formTitleTxt";
               helpConten = "asset.petsBag.petsAwaken.helpText";
               PetsAdvancedControl.Instance.currentViewType = 6;
               _view = new PetsAwakenView();
         }
         createHelpBtn(helpTitle,helpConten,visibleHelpBtn);
         _currentIndex = _btnGroup.selectIndex;
         if(_view)
         {
            addToContent(_view);
         }
      }
      
      private function createHelpBtn(title:String, centen:String, isVisible:Boolean) : void
      {
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
         }
         _helpBtn = null;
         if(isVisible)
         {
            _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"petsBag.button.helpBtn",null,LanguageMgr.GetTranslation(title),centen,404,484) as SimpleBitmapButton;
            PositionUtils.setPos(_helpBtn,"petsBag.form.helpBtnPos");
         }
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__changeHandler);
         removeEventListener("response",_response);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         PetsAdvancedManager.Instance.isPetsAdvancedViewShow = false;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         if(_ringStarBtn)
         {
            HelpBtnEnable.getInstance().removeMouseOverTips(_ringStarBtn);
            ObjectUtils.disposeObject(_ringStarBtn);
            _ringStarBtn = null;
         }
         if(_evolutionBtn)
         {
            HelpBtnEnable.getInstance().removeMouseOverTips(_evolutionBtn);
            ObjectUtils.disposeObject(_evolutionBtn);
            _evolutionBtn = null;
         }
         if(_formBtn)
         {
            HelpBtnEnable.getInstance().removeMouseOverTips(_formBtn);
            ObjectUtils.disposeObject(_formBtn);
            _formBtn = null;
         }
         if(_eatPetsBtn)
         {
            HelpBtnEnable.getInstance().removeMouseOverTips(_eatPetsBtn);
            ObjectUtils.disposeObject(_eatPetsBtn);
            _eatPetsBtn = null;
         }
         if(_breakBtn)
         {
            HelpBtnEnable.getInstance().removeMouseOverTips(_breakBtn);
            ObjectUtils.disposeObject(_breakBtn);
            _breakBtn = null;
         }
         if(_awakenBtn)
         {
            HelpBtnEnable.getInstance().removeMouseOverTips(_awakenBtn);
            ObjectUtils.disposeObject(_awakenBtn);
            _breakBtn = null;
         }
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_breakHelpBtn);
         _breakHelpBtn = null;
         super.dispose();
      }
   }
}
