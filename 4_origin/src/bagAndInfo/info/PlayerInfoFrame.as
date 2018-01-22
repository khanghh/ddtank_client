package bagAndInfo.info
{
   import beadSystem.beadSystemManager;
   import cardSystem.CardManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.utils.PositionUtils;
   import ddt.view.horse.HorseInfoView;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mark.MarkMgr;
   import petsBag.PetsBagManager;
   import petsBag.view.PetsBagOtherView;
   import room.RoomManager;
   import totem.TotemManager;
   
   public class PlayerInfoFrame extends Frame
   {
       
      
      private const PLAYER_VIEW:int = 0;
      
      private const PET_VIEW:int = 1;
      
      private const BEAD_VIEW:int = 2;
      
      private const CARD_VIEW:int = 3;
      
      private const HORSE_VIEW:int = 4;
      
      private const TOTEM_VIEW:int = 5;
      
      private const MARK_VIEW:int = 6;
      
      private var _info;
      
      private var _BG:ScaleBitmapImage;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _hBox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _infoBtn:SelectedButton;
      
      private var _horseBtn:SelectedButton;
      
      private var _cardBtn:SelectedButton;
      
      private var _petBtn:SelectedButton;
      
      private var _beadBtn:SelectedButton;
      
      private var _totemBtn:SelectedButton;
      
      private var _markBtn:SelectedButton;
      
      private var _view:PlayerInfoView;
      
      private var _petsView:PetsBagOtherView;
      
      private var _beadInfoView:Sprite;
      
      private var _horseView:HorseInfoView;
      
      private var _openTexp:Boolean;
      
      private var _openGift:Boolean;
      
      private var _openCard:Boolean;
      
      public function PlayerInfoFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         this.escEnable = true;
         this.enterEnable = true;
         _titleText = LanguageMgr.GetTranslation("game.PlayerThumbnailTipItemText_0");
         _BG = ComponentFactory.Instance.creatComponentByStylename("PlayerInfoFrame.bg");
         addToContent(_BG);
         _infoBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.playerInfoBtn");
         _cardBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.cardInfoBtn");
         _petBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.petInfoBtn");
         _beadBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.beadInfoBtn");
         _horseBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.horseInfoBtn");
         _totemBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.totemInfoBtn");
         _markBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.markInfoBtn");
         addToContent(_infoBtn);
         addToContent(_petBtn);
         addToContent(_horseBtn);
         addToContent(_cardBtn);
         addToContent(_beadBtn);
         addToContent(_totemBtn);
         addToContent(_markBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_infoBtn);
         _btnGroup.addSelectItem(_petBtn);
         _btnGroup.addSelectItem(_beadBtn);
         _btnGroup.addSelectItem(_cardBtn);
         _btnGroup.addSelectItem(_horseBtn);
         _btnGroup.addSelectItem(_totemBtn);
         _btnGroup.addSelectItem(_markBtn);
         _btnGroup.selectIndex = 0;
         if(RoomManager.Instance.current && PlayerInfoViewControl._isBattle)
         {
            _infoBtn.visible = false;
            _petBtn.visible = false;
            _horseBtn.visible = false;
            _cardBtn.visible = false;
            _beadBtn.visible = false;
            _totemBtn.visible = false;
            _markBtn.visible = false;
         }
         _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
         addChild(_attestBtn);
         _attestBtn.visible = false;
      }
      
      private function initEvent() : void
      {
         _btnGroup.addEventListener("change",__changeHandler);
         _infoBtn.addEventListener("click",__soundPlayer);
         _horseBtn.addEventListener("click",__soundPlayer);
         _cardBtn.addEventListener("click",__soundPlayer);
         _petBtn.addEventListener("click",__soundPlayer);
         _beadBtn.addEventListener("click",__soundPlayer);
         _totemBtn.addEventListener("click",__soundPlayer);
         _markBtn.addEventListener("click",__soundPlayer);
      }
      
      private function __soundPlayer(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __changeHandler(param1:Event) : void
      {
         _attestBtn.visible = false;
         MarkMgr.inst.removeMarkView();
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               showInfoFrame();
               break;
            case 1:
               PetsBagManager.instance().isSelf = false;
               loadPetData();
               break;
            case 2:
               showBeadInfoView();
               break;
            case 3:
               showCardEquip();
               break;
            case 4:
               loadHorseModule();
               break;
            case 5:
               showTotem();
               break;
            case 6:
               showMark();
         }
      }
      
      private function loadPetData() : void
      {
         var _loc1_:Array = [LoaderCreate.Instance.creatPetExpericenceAnalyzeLoader];
         new HelperDataModuleLoad().loadDataModule(_loc1_,loadPetModule);
      }
      
      private function loadPetModule() : void
      {
         new HelperUIModuleLoad().loadUIModule(["petsBag"],showPetsView);
      }
      
      private function loadHorseModule() : void
      {
         new HelperUIModuleLoad().loadUIModule(["horse"],showHorseView);
      }
      
      private function showInfoFrame() : void
      {
         if(_view == null)
         {
            _view = ComponentFactory.Instance.creatCustomObject("bag.PersonalInfoView");
            _view.showSelfOperation = false;
            addToContent(_view);
         }
         if(_info)
         {
            _view.info = _info;
         }
         setVisible(0);
         _attestBtn.visible = _info.isAttest;
      }
      
      private function showPetsView() : void
      {
         PlayerInfoViewControl.isOpenFromBag = false;
         if(_petsView == null)
         {
            _petsView = ComponentFactory.Instance.creatCustomObject("petsBagOtherPnl.other");
            addToContent(_petsView);
         }
         if(_info)
         {
            _petsView.infoPlayer = _info;
         }
         setVisible(1);
      }
      
      private function showBeadInfoView() : void
      {
         if(!_beadInfoView)
         {
            beadSystemManager.Instance.addEventListener("createComplete",__onCreateComplete);
            beadSystemManager.Instance.showFrame("infoview");
         }
         setVisible(2);
      }
      
      private function __onCreateComplete(param1:CEvent) : void
      {
         beadSystemManager.Instance.removeEventListener("createComplete",__onCreateComplete);
         if(param1.data.type == "infoview")
         {
            _beadInfoView = param1.data.spr;
            _beadInfoView["playerInfo"] = _info;
            addChild(_beadInfoView);
         }
      }
      
      private function showCardEquip() : void
      {
         if(!_openCard)
         {
            SocketManager.Instance.out.getPlayerCardInfo(_info.ID);
            _openCard = true;
         }
         if(_view == null)
         {
            _view = ComponentFactory.Instance.creatCustomObject("bag.PersonalInfoView");
            _view.showSelfOperation = false;
            addToContent(_view);
         }
         CardManager.Instance.isPlayerInfoFrameOpen = true;
         if(_info)
         {
            _view.info = _info;
         }
         setVisible(3);
      }
      
      private function showHorseView() : void
      {
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createHorseTemplateDataLoader(),LoaderCreate.Instance.createHorseSkillGetDataLoader()],createHorseView);
      }
      
      private function createHorseView() : void
      {
         if(!_horseView)
         {
            _horseView = new HorseInfoView();
            PositionUtils.setPos(_horseView,"PlayerInfoFrame.horseViewPos");
            addToContent(_horseView);
         }
         _horseView.info = _info;
         setVisible(4);
      }
      
      private function showTotem() : void
      {
         TotemManager.instance.showView("infoview",{
            "parent":_container,
            "info":_info
         });
         setVisible(5);
      }
      
      private function showMark() : void
      {
         MarkMgr.inst.showMarkView(_container,_info);
         setVisible(6);
      }
      
      private function setVisible(param1:int) : void
      {
         if(_view)
         {
            _view.visible = param1 == 0 || param1 == 3;
            if(_view.visible)
            {
               _view.switchShowII(param1 == 3);
            }
         }
         if(_petsView)
         {
            _petsView.visible = param1 == 1;
         }
         if(_beadInfoView)
         {
            _beadInfoView.visible = param1 == 2;
         }
         if(_horseView)
         {
            _horseView.visible = param1 == 4;
         }
         TotemManager.instance.setVisible("infoview",param1 == 5);
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__changeHandler);
         _infoBtn.removeEventListener("click",__soundPlayer);
         _horseBtn.removeEventListener("click",__soundPlayer);
         _cardBtn.removeEventListener("click",__soundPlayer);
         _petBtn.removeEventListener("click",__soundPlayer);
         _beadBtn.removeEventListener("click",__soundPlayer);
         _totemBtn.removeEventListener("click",__soundPlayer);
         _markBtn.removeEventListener("click",__soundPlayer);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         _btnGroup.selectIndex = 0;
         __changeHandler(null);
      }
      
      public function set info(param1:*) : void
      {
         _info = param1;
         if(_view)
         {
            _view.info = _info;
         }
         if(PlayerInfoViewControl._isBattle)
         {
            return;
         }
         if(_petsView)
         {
            _petsView.infoPlayer = _info;
         }
         if(_horseView)
         {
            _horseView.info = _info;
         }
         if(_info.Grade < 19 || StateManager.currentStateType == "fighting" && _info.ZoneID != 0 && _info.ZoneID != PlayerManager.Instance.Self.ZoneID)
         {
            _petBtn.enable = false;
         }
         else
         {
            _petBtn.enable = true;
         }
         if(_info.Grade < 12 || StateManager.currentStateType == "fighting" && _info.ZoneID != 0 && _info.ZoneID != PlayerManager.Instance.Self.ZoneID)
         {
            _horseBtn.enable = false;
         }
         else
         {
            _horseBtn.enable = true;
         }
         if(_info.Grade < 15 || StateManager.currentStateType == "fighting" && _info.ZoneID != 0 && _info.ZoneID != PlayerManager.Instance.Self.ZoneID)
         {
            _cardBtn.enable = false;
         }
         else
         {
            _cardBtn.enable = true;
         }
         if(_info.Grade < 16 || StateManager.currentStateType == "fighting" && _info.ZoneID != 0 && _info.ZoneID != PlayerManager.Instance.Self.ZoneID)
         {
            _beadBtn.enable = false;
         }
         else
         {
            _beadBtn.enable = true;
         }
         if(_info.Grade < 22 || StateManager.currentStateType == "fighting" && _info.ZoneID != 0 && _info.ZoneID != PlayerManager.Instance.Self.ZoneID)
         {
            _totemBtn.enable = false;
         }
         else
         {
            _totemBtn.enable = true;
         }
         _markBtn.enable = MarkMgr.inst.checkMarkOpen(_info);
      }
      
      public function setAchivEnable(param1:Boolean) : void
      {
         _view.setAchvEnable(param1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _info = null;
         PlayerInfoViewControl.currentPlayer = null;
         ObjectUtils.disposeObject(_BG);
         _BG = null;
         ObjectUtils.disposeObject(_infoBtn);
         _infoBtn = null;
         ObjectUtils.disposeObject(_horseBtn);
         _horseBtn = null;
         ObjectUtils.disposeObject(_cardBtn);
         _cardBtn = null;
         ObjectUtils.disposeObject(_petBtn);
         _petBtn = null;
         ObjectUtils.disposeObject(_totemBtn);
         _totemBtn = null;
         ObjectUtils.disposeObject(_markBtn);
         _markBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeObject(_horseView);
         _horseView = null;
         ObjectUtils.disposeObject(_petsView);
         _petsView = null;
         CardManager.Instance.isPlayerInfoFrameOpen = false;
         TotemManager.instance.closeView("infoview");
         PlayerInfoViewControl.clearView();
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
