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
      
      public function RoomPlayerItem(param1:int)
      {
         _bordenArr = [0,0,0,0,0,0,12819,12820,12821,12822,12823,12582,12583,12584,12585,12586,12587,12588];
         super();
         _place = param1;
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _chatballview = new ChatBallPlayer();
         PositionUtils.setPos(_chatballview,"asset.ddtroom.playerItem.chatBallPos");
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.playerItemGBAsset");
         _bg.setFrame(1);
         addChild(_bg);
         _hitArea = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.playerItemClickArea");
         var _loc1_:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.PlayerItem.hitRect");
         _hitArea.graphics.beginFill(0,0);
         _hitArea.graphics.drawRect(_loc1_.x,_loc1_.y,_loc1_.width,_loc1_.height);
         _hitArea.graphics.endFill();
         _hitArea.buttonMode = true;
         addChild(_hitArea);
         _playerName = ComponentFactory.Instance.creatComponentByStylename("asset.ddroom.playerItem.NameTxt");
         _kickOutBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.playerItem.kickOutButton");
         _addFriendBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.playerItem.addFriendButton");
         _changeRoomHost = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.playerItem.changeRoomHostButton");
         _changeRoomHost.tipData = LanguageMgr.GetTranslation("ddt.room.playerItem.changeRoomHost");
         _roomBorden = ComponentFactory.Instance.creatComponentByStylename("ddt.room.playerItem.changeRoomBorden");
         addChild(_kickOutBtn);
         addChild(_addFriendBtn);
         addChild(_changeRoomHost);
         addChild(_roomBorden);
         _roomBorden.tipData = LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.changeBorden");
         _addFriendBtn.tipData = LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.addFriend");
         _kickOutBtn.tipData = LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.exitRoom");
         _iconContainer = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.PlayerItem.iconContainer");
         addChild(_iconContainer);
         _guild = ComponentFactory.Instance.creatBitmap("asset.ddtroom.playerItem.GuildTxtAsset");
         addChild(_guild);
         PositionUtils.setPos(_guild,"asset.ddtroom.playerItem.GuildTxtAssetPos");
         _guild.visible = false;
         _guildName = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.playerItem.GuildNamtTxt");
         addChild(_guildName);
         _face = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.playerItem.face");
         addChild(_face);
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.playerItem.facePos");
         if(RoomManager.Instance.current.type == 1)
         {
            if(_place % 2 == 1)
            {
               _face.scaleX = 1;
               _face.x = _loc2_.x;
            }
            else
            {
               _face.scaleX = -1;
               _face.x = _loc2_.y;
            }
         }
         else
         {
            _face.scaleX = -1;
            _face.x = _loc2_.y;
         }
      }
      
      private function creatAttestBtn() : void
      {
         if(_info && _info.playerInfo.isAttest)
         {
            if(_attestBtn == null)
            {
               _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
               addChild(_attestBtn);
            }
            _attestBtn.x = _addFriendBtn.x - _addFriendBtn.width - 4;
            _attestBtn.y = _addFriendBtn.y - 4;
            _attestBtn.visible = true;
         }
         else if(_attestBtn != null)
         {
            _attestBtn.visible = false;
         }
      }
      
      private function updatePet() : void
      {
         if(_info && _info.playerInfo && _info.playerInfo.currentPet && _info.playerInfo.currentPet.IsEquip)
         {
            if(!_roomPlayerItemPet)
            {
               _petHeadFrameBg = ComponentFactory.Instance.creatBitmap("asset.ddtroom.playerItem.petHeadFrame");
               PositionUtils.setPos(_petHeadFrameBg,"asset.ddtroom.playerItem.petHeadFramePos");
               addChild(_petHeadFrameBg);
               _roomPlayerItemPet = new RoomPlayerItemPet(_petHeadFrameBg.width,_petHeadFrameBg.height);
               PositionUtils.setPos(_roomPlayerItemPet,"assets.ddtroom.roomPlayerItemPetPos");
               _roomPlayerItemPet.mouseChildren = false;
               _roomPlayerItemPet.mouseEnabled = true;
               _roomPlayerItemPet.useHandCursor = true;
               _roomPlayerItemPet.buttonMode = true;
               addChild(_roomPlayerItemPet);
            }
            _roomPlayerItemPet.updateView(_info.playerInfo.currentPet);
         }
         else
         {
            removePet();
         }
      }
      
      private function removePet() : void
      {
         if(_petHeadFrameBg)
         {
            ObjectUtils.disposeObject(_petHeadFrameBg);
         }
         _petHeadFrameBg = null;
         if(_roomPlayerItemPet)
         {
            ObjectUtils.disposeObject(_roomPlayerItemPet);
         }
         _roomPlayerItemPet = null;
      }
      
      public function set switchInEnabled(param1:Boolean) : void
      {
         _switchInEnabled = param1;
         if(_switchInEnabled && _opened)
         {
            _hitArea.visible = _switchInEnabled;
         }
      }
      
      private function initEvents() : void
      {
         _addFriendBtn.addEventListener("click",__addFriendHandler);
         _roomBorden.addEventListener("click",__changeRoomBordenHandler);
         _changeRoomHost.addEventListener("click",__changeRoomHostHandler);
         _kickOutBtn.addEventListener("click",__kickOutHandler);
         _hitArea.addEventListener("click",__clickHandler);
         RoomManager.Instance.current.addEventListener("startedChanged",__startHandler);
         ChatManager.Instance.addEventListener("addFace",__getFace);
         ChatManager.Instance.model.addEventListener("addChat",__getChat);
         BagStore.instance.addEventListener(BagStore.OPEN_BAGSTORE,__openStoreHandler);
         BagStore.instance.addEventListener(BagStore.CLOSE_BAGSTORE,__closeStoreHandler);
         RoomManager.Instance.current.selfRoomPlayer.addEventListener("isHostChange",__updateButton);
         _chatballview.addEventListener("complete",onComplete);
      }
      
      private function __showExplain(param1:MouseEvent) : void
      {
         _signalExplain.visible = true;
         _signalExplain.setFrame(_signal.getFrame);
      }
      
      private function __hideExplain(param1:MouseEvent) : void
      {
         _signalExplain.visible = false;
      }
      
      private function __closeStoreHandler(param1:Event) : void
      {
         if(_chracter)
         {
            _chracter.playAnimation();
         }
      }
      
      private function __openStoreHandler(param1:Event) : void
      {
         if(_chracter)
         {
            _chracter.stopAnimation();
         }
      }
      
      private function __changeRoomHostHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         param1.stopImmediatePropagation();
         GameInSocketOut.sendChangeRoomHost(_info.playerInfo.ID);
      }
      
      private function removeEvents() : void
      {
         _addFriendBtn.removeEventListener("click",__addFriendHandler);
         _roomBorden.removeEventListener("click",__changeRoomBordenHandler);
         _changeRoomHost.removeEventListener("click",__changeRoomHostHandler);
         _kickOutBtn.removeEventListener("click",__kickOutHandler);
         _hitArea.removeEventListener("click",__clickHandler);
         RoomManager.Instance.current.removeEventListener("startedChanged",__startHandler);
         ChatManager.Instance.removeEventListener("addFace",__getFace);
         ChatManager.Instance.model.removeEventListener("addChat",__getChat);
         BagStore.instance.removeEventListener(BagStore.OPEN_BAGSTORE,__openStoreHandler);
         BagStore.instance.removeEventListener(BagStore.CLOSE_BAGSTORE,__closeStoreHandler);
         RoomManager.Instance.current.selfRoomPlayer.removeEventListener("isHostChange",__updateButton);
         if(_info)
         {
            _info.removeEventListener("readyChange",__infoStateChange);
            _info.removeEventListener("isHostChange",__infoStateChange);
            _info.playerInfo.removeEventListener("propertychange",__playerInfoChange);
            _info.webSpeedInfo.removeEventListener("stateChange",__updateWebSpeed);
         }
         _chatballview.removeEventListener("complete",onComplete);
      }
      
      private function __changeRoomBordenHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         param1.stopImmediatePropagation();
         AssetModuleLoader.addModelLoader("ddtbagandinfo",6);
         AssetModuleLoader.startLoader(showBordenFrame);
      }
      
      private function showBordenFrame() : void
      {
         var _loc2_:RoomBordenFrame = ComponentFactory.Instance.creatCustomObject("ddt.room.changeRoomBordenFrame");
         var _loc1_:Point = this.localToGlobal(new Point(_roomBorden.x,_roomBorden.y));
         PositionUtils.setPos(_loc2_,new Point(_loc1_.x + 48,_loc1_.y + 26));
         LayerManager.Instance.addToLayer(_loc2_,3,false,2);
      }
      
      private function __viewClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         PlayerTipManager.show(_info.playerInfo,localToGlobal(new Point(0,0)).y);
      }
      
      private function __addFriendHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         IMManager.Instance.addFriend(_info.playerInfo.NickName);
      }
      
      private function __kickOutHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         GameInSocketOut.sendGameRoomKick(_place);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:RoomInfo = RoomManager.Instance.current;
         if(_loc2_.mapId != 0 && _loc2_.mapId != 10000 && MapManager.Instance.singleDoubleIds.indexOf(_loc2_.mapId) != -1 && _info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.singleDungeonRoomMsg"));
            return;
         }
         if(_info)
         {
            PlayerInfoViewControl.view(_info.playerInfo);
         }
         else
         {
            if(_switchInEnabled && !_loc2_.selfRoomPlayer.isHost)
            {
               GameInSocketOut.sendGameRoomPlaceState(_loc2_.selfRoomPlayer.place,-1,true,_place);
               return;
            }
            if(_opened)
            {
               if(_loc2_.type == 1)
               {
                  !!RoomManager.Instance.canCloseItem(this)?GameInSocketOut.sendGameRoomPlaceState(_place,!!_opened?0:-1):MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.position"));
               }
               else
               {
                  GameInSocketOut.sendGameRoomPlaceState(_place,!!_opened?0:-1);
               }
            }
            else if(PlayerManager.Instance.Self.Grade >= 6)
            {
               GameInSocketOut.sendGameRoomPlaceState(_place,!!_opened?0:-1);
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.room.cantOpenMuti"));
            }
         }
      }
      
      private function __startHandler(param1:RoomEvent) : void
      {
         updateButtons();
      }
      
      private function __updateButton(param1:RoomPlayerEvent) : void
      {
         updateButtons();
      }
      
      private function onComplete(param1:Event) : void
      {
         if(_chatballview.parent)
         {
            _chatballview.parent.removeChild(_chatballview);
         }
      }
      
      private function __infoStateChange(param1:RoomPlayerEvent) : void
      {
         updatePlayerState();
         updateButtons();
      }
      
      private function __playerInfoChange(param1:PlayerPropertyEvent) : void
      {
         updateInfoView();
      }
      
      private function __getFace(param1:ChatEvent) : void
      {
         if(_info == null)
         {
            return;
         }
         var _loc2_:Object = param1.data;
         if(_loc2_["playerid"] == _info.playerInfo.ID)
         {
            _face.setFace(_loc2_["faceid"]);
         }
         addChild(_face);
      }
      
      private function __getChat(param1:ChatEvent) : void
      {
         if(_info == null)
         {
            return;
         }
         var _loc2_:ChatData = ChatData(param1.data).clone();
         if(_loc2_.senderID == _info.playerInfo.ID && (_loc2_.channel == 5 || _loc2_.channel == 4))
         {
            addChild(_chatballview);
            _loc2_.msg = Helpers.deCodeString(_loc2_.msg);
            _chatballview.setText(_loc2_.msg,_info.playerInfo.paopaoType);
         }
      }
      
      public function set info(param1:RoomPlayer) : void
      {
         var _loc2_:* = null;
         if(_info)
         {
            _info.removeEventListener("readyChange",__infoStateChange);
            _info.removeEventListener("isHostChange",__infoStateChange);
            _info.playerInfo.removeEventListener("propertychange",__playerInfoChange);
            _info.webSpeedInfo.removeEventListener("stateChange",__updateWebSpeed);
            _info = null;
            _face.clearFace();
         }
         _info = param1;
         if(_info == null)
         {
            if(RoomManager.Instance.current.selfRoomPlayer.isViewer)
            {
               switchInEnabled = true;
            }
         }
         if(_info)
         {
            _loc2_ = GameControl.Instance.Current;
            if(_loc2_ != null && _loc2_.hasNextMission && (RoomManager.Instance.current.type == 4 || RoomManager.Instance.current.type == 23 || RoomManager.Instance.current.type == 11 || RoomManager.Instance.current.type == 123))
            {
               _loc2_.viewerToLiving(_info.playerInfo.ID);
            }
            _info.addEventListener("readyChange",__infoStateChange);
            _info.addEventListener("isHostChange",__infoStateChange);
            _info.playerInfo.addEventListener("propertychange",__playerInfoChange);
            _info.webSpeedInfo.addEventListener("stateChange",__updateWebSpeed);
         }
         if(_info && _info.isSelf)
         {
            if(PlayerManager.Instance.Self.isUpGradeInGame && PlayerManager.Instance.Self.Grade > 15)
            {
               PlayerManager.Instance.Self.isUpGradeInGame = false;
            }
         }
         updateView();
      }
      
      public function get info() : RoomPlayer
      {
         return _info;
      }
      
      public function get place() : int
      {
         return _place;
      }
      
      private function __updateWebSpeed(param1:WebSpeedEvent) : void
      {
      }
      
      private function updateView() : void
      {
         updateBackground();
         updateInfoView();
         updateButtons();
         updatePlayerState();
         if(_info)
         {
            _hitArea.tipData = _info.playerInfo;
         }
         creatAttestBtn();
      }
      
      private function updateBackground() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         if(_info)
         {
            if(_info.isSelf && PlayerManager.Instance.curcentId != 0)
            {
               _loc2_ = PlayerManager.Instance.Self.getBag(43).items;
               var _loc6_:int = 0;
               var _loc5_:* = _loc2_;
               for each(var _loc3_ in _loc2_)
               {
                  if(_loc3_.ItemID == PlayerManager.Instance.curcentId)
                  {
                     if(_loc3_.getRemainDate() > 0)
                     {
                        _loc1_ = _loc3_.TemplateID;
                        _loc4_ = _bordenArr.indexOf(_loc1_);
                        _bg.setFrame(_loc4_);
                     }
                     else if(RoomManager.Instance.current.isYellowBg())
                     {
                        _bg.setFrame(5);
                     }
                     else
                     {
                        _bg.setFrame(_info.team + 2);
                     }
                  }
               }
            }
            else if(info.playerInfo.curcentRoomBordenTemplateId)
            {
               _loc1_ = info.playerInfo.curcentRoomBordenTemplateId;
               _loc4_ = _bordenArr.indexOf(_loc1_);
               _bg.setFrame(_loc4_);
            }
            else if(RoomManager.Instance.current.isYellowBg())
            {
               _bg.setFrame(5);
            }
            else
            {
               _bg.setFrame(_info.team + 2);
            }
         }
         else
         {
            _bg.setFrame(!!_opened?1:2);
            if(_chatballview.parent)
            {
               _chatballview.parent.removeChild(_chatballview);
            }
         }
      }
      
      private function updateInfoView() : void
      {
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_guardCoreIcon);
         _guardCoreIcon = null;
         ObjectUtils.disposeObject(_badge);
         _badge = null;
         if(_ready && _ready.visible)
         {
            _ready.visible = false;
         }
         if(_info)
         {
            if(_characterContainer == null)
            {
               if(_chracter == null)
               {
                  _chracter = _info.roomCharater;
               }
               _info.resetCharacter();
               _chracter.x = 20;
               _characterContainer = new Sprite();
               _characterContainer.addChild(_chracter);
               _characterContainer.x = 119;
               _characterContainer.y = 25;
               _chracter.show(false,_info.team == 2?1:-1);
               _chracter.setShowLight(true);
               _chracter.showGun = true;
               _chracter.playAnimation();
               if(_info.team == 2)
               {
                  _characterContainer.x = 11;
               }
               addChildAt(_characterContainer,1);
            }
            if(_levelIcon == null)
            {
               _levelIcon = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.playerItem.LevelIcon");
               addChild(_levelIcon);
            }
            _levelIcon.setInfo(_info.playerInfo.Grade,_info.playerInfo.ddtKingGrade,_info.playerInfo.Repute,_info.playerInfo.WinCount,_info.playerInfo.TotalCount,_info.playerInfo.FightPower,_info.playerInfo.Offer,true,false);
            if(_info.playerInfo.ID == PlayerManager.Instance.Self.ID || _info.playerInfo.IsVIP)
            {
               if(_vipIcon == null)
               {
                  _vipIcon = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.playerItem.VipIcon");
                  _vipIcon.setInfo(_info.playerInfo);
                  _iconContainer.addChild(_vipIcon);
                  if(!_info.playerInfo.IsVIP)
                  {
                     _vipIcon.filters = ComponentFactory.Instance.creatFilters("grayFilter");
                  }
                  else
                  {
                     _vipIcon.filters = null;
                  }
               }
            }
            else if(_vipIcon)
            {
               _vipIcon.dispose();
               _vipIcon = null;
            }
            if(_info.playerInfo.Grade >= GuardCoreManager.instance.guardCoreMinLevel)
            {
               ObjectUtils.disposeObject(_guardCoreIcon);
               _guardCoreIcon = ComponentFactory.Instance.creatComponentByStylename("core.guardCoreIcon");
               PositionUtils.setPos(_guardCoreIcon,"ddtcorei.roompGuardCoreIcon.pos");
               _guardCoreIcon.setup(_info.playerInfo);
               _iconContainer.addChild(_guardCoreIcon);
            }
            _playerName.text = _info.playerInfo.NickName;
            addChild(_playerName);
            if(_info.playerInfo.IsVIP)
            {
               ObjectUtils.disposeObject(_vipName);
               _vipName = VipController.instance.getVipNameTxt(106,_info.playerInfo.typeVIP);
               _vipName.x = _playerName.x;
               _vipName.y = _playerName.y;
               _vipName.text = _playerName.text;
               addChild(_vipName);
            }
            PositionUtils.adaptNameStyle(info.playerInfo,_playerName,_vipName);
            _guildName.text = !!_info.playerInfo.ConsortiaName?_info.playerInfo.ConsortiaName:"";
            if(_guildName.text.length > 0)
            {
               _guild.visible = true;
            }
            if(_info.isReady)
            {
               if(!_ready)
               {
                  _ready = ComponentFactory.Instance.creatBitmap("asset.ddtroom.playerItem.ReadyIconAsset");
               }
               addChild(_ready);
               _ready.visible = true;
            }
            else if(_ready && _ready.visible)
            {
               _ready.visible = false;
            }
            if(_info.playerInfo.ConsortiaID > 0 && _info.playerInfo.badgeID > 0)
            {
               if(_badge == null)
               {
                  _badge = new Badge();
                  _badge.buttonMode = true;
                  PositionUtils.setPos(_badge,"asset.ddtroom.playerItem.badgePos");
                  this.addChild(_badge);
                  PositionUtils.setPos(_guildName,"asset.ddtroom.playerItem.guildNamePos");
               }
               _badge.badgeID = _info.playerInfo.badgeID;
            }
            else
            {
               if(_badge)
               {
                  _badge.dispose();
               }
               _badge = null;
            }
            updatePet();
         }
         else
         {
            if(_characterContainer)
            {
               removeChild(_characterContainer);
            }
            if(_chracter != null && _characterContainer.contains(_chracter))
            {
               _characterContainer.removeChild(_chracter);
            }
            _characterContainer = null;
            _chracter = null;
            ObjectUtils.disposeObject(_levelIcon);
            _levelIcon = null;
            ObjectUtils.disposeObject(_vipIcon);
            _vipIcon = null;
            ObjectUtils.disposeObject(_guardCoreIcon);
            _guardCoreIcon = null;
            ObjectUtils.disposeObject(_badge);
            _badge = null;
            _guildName.text = "";
            _guild.visible = false;
            _playerName.text = "";
            removePet();
            if(_hitArea)
            {
               _hitArea.tipData = null;
            }
            DisplayUtils.removeDisplay(_vipName);
         }
      }
      
      public function updateButtons() : void
      {
         if(_info)
         {
            var _loc1_:* = true;
            _hitArea.visible = _loc1_;
            _loc1_ = _loc1_;
            _kickOutBtn.visible = _loc1_;
            _addFriendBtn.visible = _loc1_;
            _changeRoomHost.visible = true;
            _roomBorden.visible = true;
            if(_info.isSelf)
            {
               _kickOutBtn.enable = false;
               _changeRoomHost.enable = false;
               if(_info.playerInfo.Grade >= 25)
               {
                  _roomBorden.enable = true;
               }
               else
               {
                  _roomBorden.enable = false;
               }
            }
            else
            {
               _roomBorden.enable = false;
               if(RoomManager.Instance.current.selfRoomPlayer.isHost)
               {
                  if(RoomManager.Instance.current.started)
                  {
                     _kickOutBtn.enable = false;
                  }
                  else
                  {
                     _kickOutBtn.enable = true;
                  }
                  _changeRoomHost.enable = true;
               }
               else
               {
                  _kickOutBtn.enable = false;
                  _changeRoomHost.enable = false;
               }
            }
         }
         else
         {
            _roomBorden.visible = false;
            if(RoomManager.Instance.current.started)
            {
               _hitArea.visible = false;
            }
            else if(RoomManager.Instance.current.selfRoomPlayer.isViewer && _switchInEnabled && _opened)
            {
               _hitArea.visible = true;
            }
            else if(RoomManager.Instance.current.type == 12 || RoomManager.Instance.current.type == 13)
            {
               _hitArea.visible = false;
            }
            else
            {
               _hitArea.visible = RoomManager.Instance.current.selfRoomPlayer.isHost;
            }
            _loc1_ = false;
            _kickOutBtn.visible = _loc1_;
            _loc1_ = _loc1_;
            _addFriendBtn.visible = _loc1_;
            _changeRoomHost.visible = _loc1_;
         }
      }
      
      private function updatePlayerState() : void
      {
         if(_info)
         {
            if(_info.isReady)
            {
               if(!_ready)
               {
                  _ready = ComponentFactory.Instance.creatBitmap("asset.ddtroom.playerItem.ReadyIconAsset");
               }
               addChild(_ready);
               _ready.visible = true;
            }
            else if(_ready && _ready.visible)
            {
               _ready.visible = false;
            }
            if(_info.isHost)
            {
               if(!_hostPic)
               {
                  _hostPic = ComponentFactory.Instance.creatBitmap("asset.ddtroom.playerItem.host");
               }
               addChild(_hostPic);
               _hostPic.visible = true;
            }
            else if(_hostPic && _hostPic.visible)
            {
               _hostPic.visible = false;
            }
         }
         else
         {
            if(_hostPic && _hostPic.visible)
            {
               _hostPic.visible = false;
            }
            if(_ready && _ready.visible)
            {
               _ready.visible = false;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         _bg.dispose();
         _bg = null;
         if(_kickOutBtn)
         {
            ObjectUtils.disposeObject(_kickOutBtn);
            _kickOutBtn = null;
         }
         _addFriendBtn.dispose();
         _addFriendBtn = null;
         if(_hostPic)
         {
            if(_hostPic.parent)
            {
               _hostPic.parent.removeChild(_hostPic);
            }
            _hostPic.bitmapData.dispose();
         }
         if(_roomBorden)
         {
            ObjectUtils.disposeObject(_roomBorden);
            _roomBorden = null;
         }
         _hostPic = null;
         _guildName.dispose();
         _guildName = null;
         removeChild(_guild);
         _guild.bitmapData.dispose();
         _guild = null;
         _playerName.dispose();
         _playerName = null;
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
         }
         _vipName = null;
         if(_attestBtn)
         {
            ObjectUtils.disposeObject(_attestBtn);
         }
         _attestBtn = null;
         ObjectUtils.disposeObject(_changeRoomHost);
         _changeRoomHost = null;
         _signal = null;
         _signalExplain = null;
         if(_ready)
         {
            removeChild(_ready);
            _ready.bitmapData.dispose();
         }
         _ready = null;
         if(_characterContainer)
         {
            removeChild(_characterContainer);
         }
         if(_chracter != null && _characterContainer.contains(_chracter))
         {
            _characterContainer.removeChild(_chracter);
         }
         _characterContainer = null;
         _chracter = null;
         if(_levelIcon)
         {
            _levelIcon.dispose();
         }
         _levelIcon = null;
         if(_vipIcon)
         {
            _vipIcon.dispose();
         }
         _vipIcon = null;
         ObjectUtils.disposeObject(_guardCoreIcon);
         _guardCoreIcon = null;
         if(_face)
         {
            _face.dispose();
         }
         _face = null;
         ObjectUtils.disposeObject(_badge);
         _badge = null;
         ObjectUtils.disposeObject(_iconContainer);
         _iconContainer = null;
         if(_chatballview)
         {
            _chatballview.dispose();
         }
         _chatballview = null;
         _info = null;
         removePet();
         if(_hitArea)
         {
            ObjectUtils.disposeObject(_hitArea);
         }
         _hitArea = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get opened() : Boolean
      {
         return _opened;
      }
      
      public function set opened(param1:Boolean) : void
      {
         _opened = param1;
         updateView();
      }
   }
}
