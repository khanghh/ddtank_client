package room.view
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.selfConsortia.Badge;
   import ddt.bagStore.BagStore;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.events.RoomEvent;
   import ddt.events.WebSpeedEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.PlayerTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddt.view.FaceContainer;
   import ddt.view.character.RoomCharacter;
   import ddt.view.chat.ChatData;
   import ddt.view.chat.ChatEvent;
   import ddt.view.chat.chatBall.ChatBallPlayer;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.VipLevelIcon;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameCommon.GameControl;
   import gameCommon.model.GameInfo;
   import guardCore.GuardCoreIcon;
   import guardCore.GuardCoreManager;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   import room.events.RoomPlayerEvent;
   import room.model.RoomInfo;
   import room.model.RoomPlayer;
   import vip.VipController;
   
   public class RoomPlayerItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _guild:Bitmap;
      
      private var _hitArea:RoomPlayerArea;
      
      private var _kickOutBtn:SimpleBitmapButton;
      
      private var _addFriendBtn:SimpleBitmapButton;
      
      private var _changeRoomHost:SimpleBitmapButton;
      
      private var _roomBorden:SimpleBitmapButton;
      
      private var _hostPic:Bitmap;
      
      private var _guildName:FilterFrameText;
      
      private var _playerName:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _signal:ScaleFrameImage;
      
      private var _signalExplain:ScaleFrameImage;
      
      private var _ready:Bitmap;
      
      private var _face:FaceContainer;
      
      private var _chatballview:ChatBallPlayer;
      
      private var _chracter:RoomCharacter;
      
      private var _levelIcon:LevelIcon;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _guardCoreIcon:GuardCoreIcon;
      
      private var _badge:Badge;
      
      private var _iconContainer:VBox;
      
      private var _info:RoomPlayer;
      
      private var _opened:Boolean;
      
      private var _place:int;
      
      private var _roomPlayerItemPet:RoomPlayerItemPet;
      
      private var _petHeadFrameBg:Bitmap;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _bordenArr:Array;
      
      private var _switchInEnabled:Boolean;
      
      private var _characterContainer:Sprite;
      
      public function RoomPlayerItem(param1:int){super();}
      
      private function initView() : void{}
      
      private function creatAttestBtn() : void{}
      
      private function updatePet() : void{}
      
      private function removePet() : void{}
      
      public function set switchInEnabled(param1:Boolean) : void{}
      
      private function initEvents() : void{}
      
      private function __showExplain(param1:MouseEvent) : void{}
      
      private function __hideExplain(param1:MouseEvent) : void{}
      
      private function __closeStoreHandler(param1:Event) : void{}
      
      private function __openStoreHandler(param1:Event) : void{}
      
      private function __changeRoomHostHandler(param1:MouseEvent) : void{}
      
      private function removeEvents() : void{}
      
      private function __changeRoomBordenHandler(param1:MouseEvent) : void{}
      
      private function showBordenFrame() : void{}
      
      private function __viewClickHandler(param1:MouseEvent) : void{}
      
      private function __addFriendHandler(param1:MouseEvent) : void{}
      
      private function __kickOutHandler(param1:MouseEvent) : void{}
      
      private function __clickHandler(param1:MouseEvent) : void{}
      
      private function __startHandler(param1:RoomEvent) : void{}
      
      private function __updateButton(param1:RoomPlayerEvent) : void{}
      
      private function onComplete(param1:Event) : void{}
      
      private function __infoStateChange(param1:RoomPlayerEvent) : void{}
      
      private function __playerInfoChange(param1:PlayerPropertyEvent) : void{}
      
      private function __getFace(param1:ChatEvent) : void{}
      
      private function __getChat(param1:ChatEvent) : void{}
      
      public function set info(param1:RoomPlayer) : void{}
      
      public function get info() : RoomPlayer{return null;}
      
      public function get place() : int{return 0;}
      
      private function __updateWebSpeed(param1:WebSpeedEvent) : void{}
      
      private function updateView() : void{}
      
      private function updateBackground() : void{}
      
      private function updateInfoView() : void{}
      
      public function updateButtons() : void{}
      
      private function updatePlayerState() : void{}
      
      public function dispose() : void{}
      
      public function get opened() : Boolean{return false;}
      
      public function set opened(param1:Boolean) : void{}
   }
}
