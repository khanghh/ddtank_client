package horse.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.view.tips.OneLineTip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import horse.amulet.HorseAmuletMainView;
   import horse.horsePicCherish.HorsePicCherishFrame;
   import trainer.view.NewHandContainer;
   
   public class HorseFrame extends Frame
   {
      
      private static const HorseLevel:int = 0;
      
      private static const HorseSkill:int = 1;
      
      private static const HorseImage:int = 2;
      
      private static const HorseFuwen:int = 3;
       
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _selectedBtnsHBox:Sprite;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _houseUpdateBtn:SelectedButton;
      
      private var _houseSkillBtn:SelectedButton;
      
      private var _houseImageBtn:SelectedButton;
      
      private var _houseRuneBtn:SelectedButton;
      
      private var _levelView:HouseLevelUpView;
      
      private var _imageView:HorsePicCherishFrame;
      
      private var _skillView:HorseSkillFrame;
      
      private var _horseAmuletMainView:HorseAmuletMainView;
      
      private var _fuwenSprite:Sprite;
      
      private var _runeTip:OneLineTip;
      
      private var _type:int = 0;
      
      private var helpArr:Array;
      
      public function HorseFrame()
      {
         helpArr = ["asset.horse.frame.helpPromptTxt"];
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("horse.frame.titleTxt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("horse.frame.helpBtn");
         addToContent(_helpBtn);
         _houseUpdateBtn = ComponentFactory.Instance.creatComponentByStylename("houseFrame.houseUpdateBtn");
         _houseSkillBtn = ComponentFactory.Instance.creatComponentByStylename("houseFrame.houseSkillBtn");
         _houseImageBtn = ComponentFactory.Instance.creatComponentByStylename("houseFrame.houseImageBtn");
         _houseRuneBtn = ComponentFactory.Instance.creatComponentByStylename("houseFrame.houseRuneBtn");
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_houseUpdateBtn);
         _btnGroup.addSelectItem(_houseSkillBtn);
         _btnGroup.addSelectItem(_houseImageBtn);
         _btnGroup.addSelectItem(_houseRuneBtn);
         _btnGroup.addEventListener("change",__changeTab);
         _btnGroup.selectIndex = _type;
         _selectedBtnsHBox = new Sprite();
         _selectedBtnsHBox.x = 14;
         _selectedBtnsHBox.y = -8;
         addToContent(_selectedBtnsHBox);
         _selectedBtnsHBox.addChild(_houseUpdateBtn);
         _selectedBtnsHBox.addChild(_houseSkillBtn);
         _selectedBtnsHBox.addChild(_houseImageBtn);
         _selectedBtnsHBox.addChild(_houseRuneBtn);
         if(PlayerManager.Instance.Self.Grade < 31)
         {
            _fuwenSprite = new Sprite();
            _fuwenSprite.addEventListener("rollOver",__avatarCollBtnOverHandler);
            _fuwenSprite.addEventListener("rollOut",__avatarCollBtnOutHandler);
            _fuwenSprite.graphics.beginFill(0,0);
            _fuwenSprite.graphics.drawRect(0,0,_houseRuneBtn.displayWidth - 12,_houseRuneBtn.displayHeight);
            _fuwenSprite.graphics.endFill();
            _fuwenSprite.x = _houseRuneBtn.x + 17;
            _fuwenSprite.y = _houseRuneBtn.y + 3;
            addToContent(_fuwenSprite);
            _runeTip = new OneLineTip();
            _runeTip.tipData = LanguageMgr.GetTranslation("tips.open",31);
            _runeTip.visible = false;
            _houseRuneBtn.enable = false;
         }
         _helpBtn.addEventListener("click",__helpClick);
      }
      
      private function __avatarCollBtnOverHandler(event:MouseEvent) : void
      {
         _runeTip.visible = true;
         LayerManager.Instance.addToLayer(_runeTip,2);
         var pos:Point = _houseRuneBtn.localToGlobal(new Point(0,0));
         _runeTip.x = pos.x - 12;
         _runeTip.y = pos.y + _houseRuneBtn.height;
      }
      
      private function __avatarCollBtnOutHandler(event:MouseEvent) : void
      {
         _runeTip.visible = false;
      }
      
      private function __helpClick(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.horse.frame.helpPromptTxt",404,484,true,true,null,2);
               break;
            case 1:
               HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.horse.skillFrame.helpPromptTxt",404,484,true,true,null,2);
               break;
            default:
               HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.horse.skillFrame.helpPromptTxt",404,484,true,true,null,2);
               break;
            case 3:
               HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.horseAmulet.help",430,520,true,true,null,2);
         }
      }
      
      private function __changeTab(e:Event) : void
      {
         SoundManager.instance.playButtonSound();
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               if(!_levelView)
               {
                  _levelView = new HouseLevelUpView();
                  _levelView.y = 37;
                  addToContent(_levelView);
               }
               _levelView.resetSecondPro();
               break;
            case 1:
               if(!_skillView)
               {
                  _skillView = new HorseSkillFrame();
                  _skillView.x = 2;
                  _skillView.y = 37;
                  addToContent(_skillView);
               }
               break;
            case 2:
               if(_imageView)
               {
                  ObjectUtils.disposeObject(_imageView);
                  _imageView = null;
               }
               if(!_imageView)
               {
                  _imageView = new HorsePicCherishFrame();
                  _imageView.x = 2;
                  _imageView.y = 41;
                  addToContent(_imageView);
               }
               _imageView.index = 1;
               break;
            case 3:
               if(_horseAmuletMainView)
               {
                  ObjectUtils.disposeObject(_horseAmuletMainView);
                  _horseAmuletMainView = null;
               }
               _horseAmuletMainView = new HorseAmuletMainView();
               _horseAmuletMainView.x = 0;
               _horseAmuletMainView.y = 37;
               addToContent(_horseAmuletMainView);
         }
         _helpBtn.visible = _btnGroup.selectIndex != 2;
         SetViewVisible();
      }
      
      public function setImagePage(index:int) : void
      {
         _btnGroup.selectIndex = 2;
         _imageView.index = index;
      }
      
      private function SetViewVisible() : void
      {
         if(_levelView)
         {
            _levelView.visible = _btnGroup.selectIndex == 0;
         }
         if(_imageView)
         {
            _imageView.visible = _btnGroup.selectIndex == 2;
         }
         if(_skillView)
         {
            _skillView.visible = _btnGroup.selectIndex == 1;
         }
         if(_horseAmuletMainView)
         {
            _horseAmuletMainView.visible = _btnGroup.selectIndex == 3;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
      }
      
      override public function dispose() : void
      {
         NewHandContainer.Instance.clearArrowByID(100000);
         removeEvent();
         ObjectUtils.disposeObject(_houseUpdateBtn);
         _selectedBtnsHBox = null;
         ObjectUtils.disposeObject(_houseSkillBtn);
         _selectedBtnsHBox = null;
         ObjectUtils.disposeObject(_houseImageBtn);
         _selectedBtnsHBox = null;
         ObjectUtils.disposeObject(_houseRuneBtn);
         _selectedBtnsHBox = null;
         ObjectUtils.disposeObject(_selectedBtnsHBox);
         _selectedBtnsHBox = null;
         ObjectUtils.disposeObject(_fuwenSprite);
         _fuwenSprite = null;
         ObjectUtils.disposeObject(_runeTip);
         _runeTip = null;
         super.dispose();
         _skillView = null;
         _levelView = null;
         _imageView = null;
         _horseAmuletMainView = null;
         _helpBtn.removeEventListener("click",__helpClick);
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
      }
   }
}
