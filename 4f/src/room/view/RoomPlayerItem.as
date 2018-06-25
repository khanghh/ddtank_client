package room.view{   import bagAndInfo.info.PlayerInfoViewControl;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import consortion.view.selfConsortia.Badge;   import ddt.bagStore.BagStore;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.PlayerPropertyEvent;   import ddt.events.RoomEvent;   import ddt.events.WebSpeedEvent;   import ddt.manager.ChatManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MapManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.PlayerTipManager;   import ddt.manager.SoundManager;   import ddt.utils.AssetModuleLoader;   import ddt.utils.Helpers;   import ddt.utils.PositionUtils;   import ddt.view.FaceContainer;   import ddt.view.character.RoomCharacter;   import ddt.view.chat.ChatData;   import ddt.view.chat.ChatEvent;   import ddt.view.chat.chatBall.ChatBallPlayer;   import ddt.view.common.LevelIcon;   import ddt.view.common.VipLevelIcon;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.geom.Rectangle;   import gameCommon.GameControl;   import gameCommon.model.GameInfo;   import guardCore.GuardCoreIcon;   import guardCore.GuardCoreManager;   import road7th.data.DictionaryData;   import room.RoomManager;   import room.events.RoomPlayerEvent;   import room.model.RoomInfo;   import room.model.RoomPlayer;   import vip.VipController;      public class RoomPlayerItem extends Sprite implements Disposeable   {                   private var _bg:ScaleFrameImage;            private var _guild:Bitmap;            private var _hitArea:RoomPlayerArea;            private var _kickOutBtn:SimpleBitmapButton;            private var _addFriendBtn:SimpleBitmapButton;            private var _changeRoomHost:SimpleBitmapButton;            private var _roomBorden:SimpleBitmapButton;            private var _hostPic:Bitmap;            private var _guildName:FilterFrameText;            private var _playerName:FilterFrameText;            private var _vipName:GradientText;            private var _signal:ScaleFrameImage;            private var _signalExplain:ScaleFrameImage;            private var _ready:Bitmap;            private var _face:FaceContainer;            private var _chatballview:ChatBallPlayer;            private var _chracter:RoomCharacter;            private var _levelIcon:LevelIcon;            private var _vipIcon:VipLevelIcon;            private var _guardCoreIcon:GuardCoreIcon;            private var _badge:Badge;            private var _iconContainer:VBox;            private var _info:RoomPlayer;            private var _opened:Boolean;            private var _place:int;            private var _roomPlayerItemPet:RoomPlayerItemPet;            private var _petHeadFrameBg:Bitmap;            private var _attestBtn:ScaleFrameImage;            private var _bordenArr:Array;            private var _switchInEnabled:Boolean;            private var _characterContainer:Sprite;            public function RoomPlayerItem(place:int) { super(); }
            private function initView() : void { }
            private function creatAttestBtn() : void { }
            private function updatePet() : void { }
            private function removePet() : void { }
            public function set switchInEnabled(value:Boolean) : void { }
            private function initEvents() : void { }
            private function __showExplain(evt:MouseEvent) : void { }
            private function __hideExplain(evt:MouseEvent) : void { }
            private function __closeStoreHandler(event:Event) : void { }
            private function __openStoreHandler(event:Event) : void { }
            private function __changeRoomHostHandler(evt:MouseEvent) : void { }
            private function removeEvents() : void { }
            private function __changeRoomBordenHandler(e:MouseEvent) : void { }
            private function showBordenFrame() : void { }
            private function __viewClickHandler(evt:MouseEvent) : void { }
            private function __addFriendHandler(evt:MouseEvent) : void { }
            private function __kickOutHandler(evt:MouseEvent) : void { }
            private function __clickHandler(evt:MouseEvent) : void { }
            private function __startHandler(evt:RoomEvent) : void { }
            private function __updateButton(evt:RoomPlayerEvent) : void { }
            private function onComplete(evt:Event) : void { }
            private function __infoStateChange(evt:RoomPlayerEvent) : void { }
            private function __playerInfoChange(evt:PlayerPropertyEvent) : void { }
            private function __getFace(evt:ChatEvent) : void { }
            private function __getChat(evt:ChatEvent) : void { }
            public function set info($info:RoomPlayer) : void { }
            public function get info() : RoomPlayer { return null; }
            public function get place() : int { return 0; }
            private function __updateWebSpeed(evt:WebSpeedEvent) : void { }
            private function updateView() : void { }
            private function updateBackground() : void { }
            private function updateInfoView() : void { }
            public function updateButtons() : void { }
            private function updatePlayerState() : void { }
            public function dispose() : void { }
            public function get opened() : Boolean { return false; }
            public function set opened(value:Boolean) : void { }
   }}