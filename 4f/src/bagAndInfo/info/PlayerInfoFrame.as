package bagAndInfo.info{   import beadSystem.beadSystemManager;   import cardSystem.CardManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.utils.HelperDataModuleLoad;   import ddt.utils.HelperUIModuleLoad;   import ddt.utils.PositionUtils;   import ddt.view.horse.HorseInfoView;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import mark.MarkMgr;   import petsBag.PetsBagManager;   import petsBag.view.PetsBagOtherView;   import room.RoomManager;   import totem.TotemManager;      public class PlayerInfoFrame extends Frame   {                   private const PLAYER_VIEW:int = 0;            private const PET_VIEW:int = 1;            private const BEAD_VIEW:int = 2;            private const CARD_VIEW:int = 3;            private const HORSE_VIEW:int = 4;            private const TOTEM_VIEW:int = 5;            private const MARK_VIEW:int = 6;            private var _info;            private var _BG:ScaleBitmapImage;            private var _attestBtn:ScaleFrameImage;            private var _hBox:HBox;            private var _btnGroup:SelectedButtonGroup;            private var _infoBtn:SelectedButton;            private var _horseBtn:SelectedButton;            private var _cardBtn:SelectedButton;            private var _petBtn:SelectedButton;            private var _beadBtn:SelectedButton;            private var _totemBtn:SelectedButton;            private var _markBtn:SelectedButton;            private var _view:PlayerInfoView;            private var _petsView:PetsBagOtherView;            private var _beadInfoView:Sprite;            private var _horseView:HorseInfoView;            private var _openTexp:Boolean;            private var _openGift:Boolean;            private var _openCard:Boolean;            public function PlayerInfoFrame() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function __soundPlayer(event:MouseEvent) : void { }
            private function __changeHandler(event:Event) : void { }
            private function loadPetData() : void { }
            private function loadPetModule() : void { }
            private function loadHorseModule() : void { }
            private function showInfoFrame() : void { }
            private function showPetsView() : void { }
            private function showBeadInfoView() : void { }
            private function __onCreateComplete(e:CEvent) : void { }
            private function showCardEquip() : void { }
            private function showHorseView() : void { }
            private function createHorseView() : void { }
            private function showTotem() : void { }
            private function showMark() : void { }
            private function setVisible(type:int) : void { }
            private function removeEvent() : void { }
            public function show() : void { }
            public function set info($info:*) : void { }
            public function setAchivEnable(val:Boolean) : void { }
            override public function dispose() : void { }
   }}