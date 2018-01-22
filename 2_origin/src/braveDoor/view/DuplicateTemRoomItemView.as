package braveDoor.view
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.RoomEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import room.RoomManager;
   import room.events.RoomPlayerEvent;
   import room.model.RoomPlayer;
   
   public class DuplicateTemRoomItemView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _levelIcon:LevelIcon;
      
      private var _addFriendBtn:SimpleBitmapButton;
      
      private var _kickOutBtn:SimpleBitmapButton;
      
      private var _playerInfoBtn:SimpleBitmapButton;
      
      private var _fightTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _readyIcon:Bitmap;
      
      private var _hostIcon:Bitmap;
      
      private var _info:RoomPlayer;
      
      private var _place:int;
      
      public function DuplicateTemRoomItemView(param1:int = 0)
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.braveDoor.room.playerListBg");
         addChild(_bg);
         _fightTxt = ComponentFactory.Instance.creatComponentByStylename("braveDoor.duplicateTeamRoom.fightText");
         addChild(_fightTxt);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("braveDoor.duplicateTeamRoom.nameText");
         addChild(_nameTxt);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("braveDoor.duplicateTemItem.playerItem.LevelIcon");
         addChild(_levelIcon);
         _addFriendBtn = ComponentFactory.Instance.creatComponentByStylename("braveDoor.duplicateTeamRoom.addFriendButton");
         _addFriendBtn.tipData = LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.addFriend");
         _kickOutBtn = ComponentFactory.Instance.creatComponentByStylename("braveDoor.duplicateTeamRoom.kickOutButton");
         _kickOutBtn.tipData = LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.exitRoom");
         _playerInfoBtn = ComponentFactory.Instance.creatComponentByStylename("braveDoor.duplicateTeamRoom.playerInfoButton");
         _playerInfoBtn.tipData = "Xem thông tin";
         addChild(_addFriendBtn);
         addChild(_kickOutBtn);
         addChild(_playerInfoBtn);
      }
      
      public function set info(param1:RoomPlayer) : void
      {
         if(_info)
         {
            _info.removeEventListener("readyChange",__infoStateChange);
            _info.removeEventListener("isHostChange",__infoStateChange);
            _info = null;
         }
         _info = param1;
         if(_info)
         {
            _info.addEventListener("readyChange",__infoStateChange);
            _info.addEventListener("isHostChange",__infoStateChange);
         }
         updateView();
      }
      
      public function get info() : RoomPlayer
      {
         return _info;
      }
      
      private function updateView() : void
      {
         var _loc1_:* = null;
         if(_info != null)
         {
            _loc1_ = _info.playerInfo;
            if(_levelIcon != null)
            {
               _levelIcon.setInfo(_loc1_.Grade,_loc1_.ddtKingGrade,_loc1_.Repute,_loc1_.WinCount,_loc1_.TotalCount,_loc1_.FightPower,_loc1_.Offer,true,false);
            }
            _fightTxt.text = _loc1_.FightPower.toString();
            _nameTxt.text = _loc1_.NickName;
         }
         updateButtons();
         updatePlayerState();
      }
      
      private function updateButtons() : void
      {
         if(_info)
         {
            var _loc1_:* = true;
            _playerInfoBtn.visible = _loc1_;
            _loc1_ = _loc1_;
            _kickOutBtn.visible = _loc1_;
            _addFriendBtn.visible = _loc1_;
            if(_info.isSelf)
            {
               _kickOutBtn.enable = false;
            }
            else if(RoomManager.Instance.current.selfRoomPlayer.isHost)
            {
               if(RoomManager.Instance.current.started)
               {
                  _kickOutBtn.enable = false;
               }
               else
               {
                  _kickOutBtn.enable = true;
               }
            }
            else
            {
               _kickOutBtn.enable = false;
            }
         }
      }
      
      private function updatePlayerState() : void
      {
         if(_info)
         {
            if(_info.isReady)
            {
               if(!_readyIcon)
               {
                  _readyIcon = ComponentFactory.Instance.creatBitmap("asset.braveDoor.hadReady");
               }
               addChild(_readyIcon);
               _readyIcon.visible = true;
            }
            else if(_readyIcon && _readyIcon.visible)
            {
               _readyIcon.visible = false;
            }
            if(_info.isHost)
            {
               if(!_hostIcon)
               {
                  _hostIcon = ComponentFactory.Instance.creatBitmap("asset.braveDoor.room.homeownersIcon");
               }
               addChild(_hostIcon);
               _hostIcon.visible = true;
            }
            else if(_hostIcon && _hostIcon.visible)
            {
               _hostIcon.visible = false;
            }
         }
         else
         {
            if(_hostIcon && _hostIcon.visible)
            {
               _hostIcon.visible = false;
            }
            if(_readyIcon && _readyIcon.visible)
            {
               _readyIcon.visible = false;
            }
         }
      }
      
      private function updateInfoView() : void
      {
         if(_levelIcon == null)
         {
            _levelIcon = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.playerItem.LevelIcon");
            addChild(_levelIcon);
         }
         _levelIcon.setInfo(_info.playerInfo.Grade,_info.playerInfo.ddtKingGrade,_info.playerInfo.Repute,_info.playerInfo.WinCount,_info.playerInfo.TotalCount,_info.playerInfo.FightPower,_info.playerInfo.Offer,true,false);
      }
      
      private function __infoStateChange(param1:RoomPlayerEvent) : void
      {
         updatePlayerState();
         updateButtons();
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
         GameInSocketOut.sendGameRoomKick(info.place);
      }
      
      private function __startHandler(param1:RoomEvent) : void
      {
         updateButtons();
      }
      
      private function __updateButton(param1:RoomPlayerEvent) : void
      {
         updateButtons();
      }
      
      private function initEvents() : void
      {
         _addFriendBtn.addEventListener("click",__addFriendHandler);
         _kickOutBtn.addEventListener("click",__kickOutHandler);
         _playerInfoBtn.addEventListener("click",__playerInfoClickHandler);
         RoomManager.Instance.current.addEventListener("startedChanged",__startHandler);
         RoomManager.Instance.current.selfRoomPlayer.addEventListener("isHostChange",__updateButton);
      }
      
      private function removeEvent() : void
      {
         if(_info)
         {
            _info.removeEventListener("readyChange",__infoStateChange);
            _info.removeEventListener("isHostChange",__infoStateChange);
            _playerInfoBtn.removeEventListener("click",__playerInfoClickHandler);
            _addFriendBtn.removeEventListener("click",__addFriendHandler);
            _kickOutBtn.removeEventListener("click",__kickOutHandler);
            RoomManager.Instance.current.removeEventListener("startedChanged",__startHandler);
            RoomManager.Instance.current.selfRoomPlayer.removeEventListener("isHostChange",__updateButton);
         }
      }
      
      private function __playerInfoClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         PlayerInfoViewControl.viewByID(_info.playerInfo.ID,-1,true,false);
         PlayerInfoViewControl.isOpenFromBag = false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_levelIcon)
         {
            ObjectUtils.disposeObject(_levelIcon);
         }
         if(_hostIcon)
         {
            ObjectUtils.disposeObject(_hostIcon);
         }
         if(_readyIcon)
         {
            ObjectUtils.disposeObject(_readyIcon);
         }
         if(_kickOutBtn)
         {
            ObjectUtils.disposeObject(_kickOutBtn);
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         if(_fightTxt)
         {
            ObjectUtils.disposeObject(_fightTxt);
         }
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         if(_addFriendBtn)
         {
            ObjectUtils.disposeObject(_addFriendBtn);
         }
         if(_playerInfoBtn)
         {
            ObjectUtils.disposeObject(_playerInfoBtn);
         }
         _levelIcon = null;
         _hostIcon = null;
         _readyIcon = null;
         _kickOutBtn = null;
         _bg = null;
         _fightTxt = null;
         _nameTxt = null;
         _addFriendBtn = null;
         _playerInfoBtn = null;
      }
   }
}
