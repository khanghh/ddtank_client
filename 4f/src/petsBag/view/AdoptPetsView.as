package petsBag.view{   import baglocked.BaglockedManager;   import com.greensock.TweenMax;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.StripTip;   import ddt.data.analyze.PetconfigAnalyzer;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.PetInfoManager;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.PositionUtils;   import ddtBuried.BuriedManager;   import farm.control.FarmComposeHouseController;   import farm.viewx.newPet.NewPetViewFrame;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import kingBless.KingBlessManager;   import pet.data.PetInfo;   import pet.data.PetSkill;   import pet.data.PetTemplateInfo;   import petsBag.PetsBagManager;   import petsBag.data.AdoptItemInfo;   import petsBag.event.PetItemEvent;   import petsBag.view.item.AdoptItem;   import road7th.comm.PackageIn;      public class AdoptPetsView extends Frame   {                   private var _adoptBtn:SimpleBitmapButton;            private var _adoptItemBtn:SimpleBitmapButton;            private var _refreshBtn:TextButton;            private var _listView:SimpleTileList;            private var _petsImgVec:Vector.<AdoptItem>;            public var currentPet:AdoptItem;            private var _refreshTimerTxt:FilterFrameText;            private var _titleBg:DisplayObject;            private var _bg2:DisplayObject;            private var _refreshTimer:Timer;            private var _refreshVolumeImg:Bitmap;            private var _refreshVolumeTxt:FilterFrameText;            private var _refreshVolumeTxtBG:Scale9CornerImage;            private var _refreshVolumeTip:StripTip;            private var _newPetView:NewPetViewFrame;            private var _refreshPetPnl:RefreshPetAlertFrame;            private var _isband:Boolean;            public function AdoptPetsView() { super(); }
            public function show() : void { }
            private function initView() : void { }
            private function update(pets:Array, items:Array) : void { }
            private function updateRefreshVolume() : void { }
            public function updateTimer(timeStr:String) : void { }
            private function addItem() : void { }
            private function updateAdoptBtnStatus() : void { }
            private function removeItem() : void { }
            private function removeItemByPetInfo(petInfo:PetInfo) : void { }
            private function removeItemByPlace(place:int) : void { }
            private function __petItemClick(e:PetItemEvent) : void { }
            private function setSelectUnSelect(currentPetItem:AdoptItem, select:Boolean = false) : void { }
            private function initEvent() : void { }
            private function refreshPetBtn(event:Event) : void { }
            private function __bagUpdate(event:Event) : void { }
            private function __refreshUpdatePet(e:TimerEvent) : void { }
            private function __responseHandler(event:FrameEvent) : void { }
            private function __updateRefreshPet(e:PkgEvent) : void { }
            private function __onNewPetFrameClose(pEvent:Event) : void { }
            private function updateItems(items:Array) : void { }
            private function removeEvent() : void { }
            private function __adoptPet(e:MouseEvent) : void { }
            private function __refreshPet(e:MouseEvent) : void { }
            private function __poorManResponse(event:FrameEvent) : void { }
            private function refeshPet() : void { }
            private function refreshPetAlert() : void { }
            private function __RefreshResponseI(e:FrameEvent) : void { }
            private function __onAdoptResponse(e:FrameEvent) : void { }
            private function __onRefreshResponse(evt:FrameEvent) : void { }
            protected function onCheckComplete() : void { }
            override public function dispose() : void { }
   }}