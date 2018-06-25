package invite
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.player.BasePlayer;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.PlayerState;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.ChatEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import invite.data.InvitePlayerInfo;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   import team.TeamManager;
   
   public class InviteFrame extends Frame
   {
      
      public static const RECENT:int = 0;
      
      public static const Brotherhood:int = 1;
      
      public static const Friend:int = 2;
      
      public static const Hall:int = 3;
      
      public static const TEAM:int = 4;
       
      
      private var _visible:Boolean = true;
      
      private var _resState:String;
      
      private var _listBack:MutipleImage;
      
      private var _refreshButton:TextButton;
      
      private var _fastInviteBtn:TextButton;
      
      private var _hbox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _hallButton:SelectedTextButton;
      
      private var _frientButton:SelectedTextButton;
      
      private var _brotherhoodButton:SelectedTextButton;
      
      private var _recentContactBtn:SelectedTextButton;
      
      private var _teamButton:SelectedTextButton;
      
      private var _list:ListPanel;
      
      private var _changeComplete:Boolean = false;
      
      private var _refleshCount:int = 0;
      
      private var _invitePlayerInfos:Array;
      
      public var roomType:int;
      
      private var _titleSelectStatus:Object;
      
      private var _oldSelected:int;
      
      public function InviteFrame()
      {
         super();
         configUi();
         addEvent();
         if(RoomManager.Instance.current && RoomManager.Instance.current.type == 58)
         {
            refleshList(4);
         }
         else if(PlayerManager.Instance.Self.ConsortiaID != 0)
         {
            refleshList(1);
         }
         else
         {
            refleshList(2);
         }
      }
      
      private function configUi() : void
      {
         titleText = LanguageMgr.GetTranslation("tank.invite.InviteView.request");
         _listBack = ComponentFactory.Instance.creatComponentByStylename("asset.ddtInviteFrame.bg");
         addToContent(_listBack);
         _refreshButton = ComponentFactory.Instance.creatComponentByStylename("asset.ddtinvite.RefreshButton");
         _refreshButton.text = LanguageMgr.GetTranslation("tank.invite.InviteView.list");
         addToContent(_refreshButton);
         _fastInviteBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtinvite.FastInviteButton");
         _fastInviteBtn.text = LanguageMgr.GetTranslation("tank.invite.InviteView.fastInvite");
         addToContent(_fastInviteBtn);
         if(PlayerManager.Instance.Self.checkFreeInvite())
         {
            _fastInviteBtn.text = LanguageMgr.GetTranslation("tank.invite.InviteView.fastInvite1",PlayerManager.Instance.Self.freeInviteCnt);
            PositionUtils.setPos(_fastInviteBtn,"ddtinvite.inviteBtnPos");
         }
         _hbox = ComponentFactory.Instance.creatComponentByStylename("asset.ddtinvite.hbox");
         addToContent(_hbox);
         _btnGroup = new SelectedButtonGroup();
         _recentContactBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtinvite.recentButton");
         _recentContactBtn.text = LanguageMgr.GetTranslation("ddt.inviteFrame.recent");
         _btnGroup.addSelectItem(_recentContactBtn);
         _brotherhoodButton = ComponentFactory.Instance.creatComponentByStylename("asset.ddtinvite.consortiaButton");
         _brotherhoodButton.text = LanguageMgr.GetTranslation("ddt.inviteFrame.consortia");
         _btnGroup.addSelectItem(_brotherhoodButton);
         _frientButton = ComponentFactory.Instance.creatComponentByStylename("asset.ddtinvite.friendButton");
         _frientButton.text = LanguageMgr.GetTranslation("ddt.inviteFrame.friend");
         _btnGroup.addSelectItem(_frientButton);
         _hallButton = ComponentFactory.Instance.creatComponentByStylename("asset.ddtinvite.HallButton");
         _hallButton.text = LanguageMgr.GetTranslation("ddt.inviteFrame.hall");
         _btnGroup.addSelectItem(_hallButton);
         _teamButton = ComponentFactory.Instance.creatComponentByStylename("asset.ddtinvite.teamButton");
         _teamButton.text = LanguageMgr.GetTranslation("tofflist.teams");
         _btnGroup.addSelectItem(_teamButton);
         if(RoomManager.Instance.current && RoomManager.Instance.current.type == 58)
         {
            _hbox.addChild(_teamButton);
            _fastInviteBtn.enable = false;
         }
         else if(PlayerManager.Instance.Self.ConsortiaID == 0)
         {
            _hbox.addChild(_recentContactBtn);
            _hbox.addChild(_frientButton);
            _hbox.addChild(_hallButton);
            _hbox.addChild(_brotherhoodButton);
         }
         else
         {
            _hbox.addChild(_recentContactBtn);
            _hbox.addChild(_brotherhoodButton);
            _hbox.addChild(_frientButton);
            _hbox.addChild(_hallButton);
         }
         _list = ComponentFactory.Instance.creatComponentByStylename("asset.ddtinvite.List");
         addToContent(_list);
         IMManager.Instance.loadRecentContacts();
      }
      
      private function addEvent() : void
      {
         _btnGroup.addEventListener("change",__btnChangeHandler);
         _refreshButton.addEventListener("click",__onRefreshClick);
         _fastInviteBtn.addEventListener("click",__onFastInviteClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(69),__onGetList);
         addEventListener("response",__response);
         _list.list.addEventListener("listItemClick",__itemClick);
         ChatManager.Instance.addEventListener("freeInvited",__freeInvitedHandler);
      }
      
      private function __freeInvitedHandler(e:ChatEvent) : void
      {
         if(PlayerManager.Instance.Self.checkFreeInvite())
         {
            _fastInviteBtn.text = LanguageMgr.GetTranslation("tank.invite.InviteView.fastInvite1",PlayerManager.Instance.Self.freeInviteCnt);
            PositionUtils.setPos(_fastInviteBtn,"ddtinvite.inviteBtnPos");
         }
      }
      
      protected function __onFastInviteClick(event:MouseEvent) : void
      {
         var confirmFrame:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.checkFreeInvite())
         {
            SocketManager.Instance.out.sendFastInviteCall();
            dispatchEvent(new Event("complete"));
         }
         else
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.game.room.fastInvite.promptTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            confirmFrame.moveEnable = false;
            confirmFrame.addEventListener("response",__confirmFastInvite);
         }
      }
      
      private function __confirmFastInvite(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",__confirmFastInvite);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            ChatManager.Instance.sendBugle("",11101,true);
         }
      }
      
      private function __btnChangeHandler(event:Event) : void
      {
         SoundManager.instance.play("008");
         _hbox.arrange();
         if(_changeComplete)
         {
            _changeComplete = false;
            switch(int(_btnGroup.selectIndex))
            {
               case 0:
                  refleshList(0);
                  break;
               case 1:
                  if(PlayerManager.Instance.Self.ConsortiaID != 0)
                  {
                     refleshList(1);
                  }
                  else
                  {
                     _changeComplete = true;
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.store.consortiaRateI"));
                     _btnGroup.selectIndex = _oldSelected;
                  }
                  break;
               case 2:
                  clearList();
                  refleshList(2);
                  break;
               case 3:
                  refleshList(3);
            }
            _oldSelected = _btnGroup.selectIndex;
         }
      }
      
      private function __response(evt:FrameEvent) : void
      {
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               __onCloseClick(null);
               break;
            case 2:
            case 3:
            case 4:
               __onRefreshClick(null);
         }
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__btnChangeHandler);
         if(_refreshButton)
         {
            _refreshButton.removeEventListener("click",__onRefreshClick);
         }
         if(_fastInviteBtn)
         {
            _fastInviteBtn.removeEventListener("click",__onFastInviteClick);
         }
         SocketManager.Instance.removeEventListener(PkgEvent.format(69),__onGetList);
         ChatManager.Instance.removeEventListener("freeInvited",__freeInvitedHandler);
         removeEventListener("response",__response);
         if(_list && _list.list)
         {
            _list.list.removeEventListener("listItemClick",__itemClick);
         }
      }
      
      private function __onRefreshClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_changeComplete)
         {
            if(_btnGroup.selectIndex == 3)
            {
               _refleshCount = _refleshCount + 1;
               refleshList(3,_refleshCount + 1);
            }
            else
            {
               clearList();
               refleshList(_btnGroup.selectIndex);
            }
         }
      }
      
      private function __onGetList(evt:PkgEvent) : void
      {
         var i:* = 0;
         var info:* = null;
         var pkg:PackageIn = evt.pkg;
         var list:Array = [];
         var _length:int = pkg.readByte();
         for(i = uint(0); i < _length; )
         {
            info = new PlayerInfo();
            info.ID = pkg.readInt();
            info.NickName = pkg.readUTF();
            info.typeVIP = pkg.readByte();
            info.VIPLevel = pkg.readInt();
            info.Sex = pkg.readBoolean();
            info.Grade = pkg.readInt();
            info.ConsortiaID = pkg.readInt();
            info.ConsortiaName = pkg.readUTF();
            info.Offer = pkg.readInt();
            info.WinCount = pkg.readInt();
            info.TotalCount = pkg.readInt();
            info.EscapeCount = pkg.readInt();
            info.Repute = pkg.readInt();
            info.FightPower = pkg.readInt();
            info.isOld = pkg.readBoolean();
            info.isAttest = pkg.readBoolean();
            list.push(info);
            i++;
         }
         updateList(3,list);
      }
      
      override protected function __onCloseClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new Event("complete"));
      }
      
      private function __itemClick(event:ListItemEvent) : void
      {
         var _playerArray:* = null;
         var titleType:int = 0;
         var _titleList:* = null;
         var temp:* = 0;
         var n:int = 0;
         var tempArray:* = null;
         var tempArr:* = null;
         var tempArr1:* = null;
         var i:int = 0;
         var info:* = null;
         var j:int = 0;
         if((event.cellValue as InvitePlayerInfo).type == 0)
         {
            SoundManager.instance.play("008");
            _playerArray = [];
            titleType = (event.cellValue as InvitePlayerInfo).titleType;
            _titleList = PlayerManager.Instance.friendAndCustomTitle;
            if(_titleSelectStatus[titleType] == true)
            {
               _playerArray = _titleList;
            }
            else
            {
               temp = 0;
               for(n = 0; n < _titleList.length; )
               {
                  _playerArray.push(_titleList[n]);
                  if(titleType == _titleList[n].titleType)
                  {
                     temp = n;
                     break;
                  }
                  n++;
               }
               tempArray = PlayerManager.Instance.getOnlineFriendForCustom(titleType);
               tempArr = [];
               tempArr1 = [];
               for(i = 0; i < tempArray.length; )
               {
                  info = tempArray[i] as FriendListPlayer;
                  if(info.IsVIP)
                  {
                     tempArr.push(info);
                  }
                  else
                  {
                     tempArr1.push(info);
                  }
                  i++;
               }
               tempArr = sort(tempArr);
               tempArr1 = sort(tempArr1);
               tempArray = tempArr.concat(tempArr1);
               tempArray = IMManager.Instance.sortAcademyPlayer(tempArray);
               _playerArray = _playerArray.concat(tempArray);
               for(j = temp + 1; j < _titleList.length; )
               {
                  _playerArray.push(_titleList[j]);
                  j++;
               }
            }
            var _loc15_:int = 0;
            var _loc14_:* = _titleSelectStatus;
            for(var tmpStr in _titleSelectStatus)
            {
               if(int(tmpStr) == titleType)
               {
                  _titleSelectStatus[tmpStr] = !_titleSelectStatus[tmpStr];
               }
               else
               {
                  _titleSelectStatus[tmpStr] = false;
               }
            }
            updateList(2,_playerArray);
         }
      }
      
      private function sort(arr:Array) : Array
      {
         return arr.sortOn("Grade",16 | 2);
      }
      
      private function updateList(type:int, list:Array) : void
      {
         var invitePlayer:* = null;
         var i:int = 0;
         var cpInfo:* = null;
         var friendList:* = null;
         var intPoint:* = null;
         _changeComplete = true;
         var tmpPosY:int = _list.list.viewPosition.y;
         clearList();
         _invitePlayerInfos = [];
         for(i = 0; i < list.length; )
         {
            cpInfo = list[i] as BasePlayer;
            if(cpInfo.ID != PlayerManager.Instance.Self.ID)
            {
               invitePlayer = new InvitePlayerInfo();
               invitePlayer.NickName = cpInfo.NickName;
               invitePlayer.typeVIP = cpInfo.typeVIP;
               invitePlayer.Sex = cpInfo.Sex;
               invitePlayer.Grade = cpInfo.Grade;
               invitePlayer.Repute = cpInfo.Repute;
               invitePlayer.WinCount = cpInfo.WinCount;
               invitePlayer.TotalCount = cpInfo.TotalCount;
               invitePlayer.FightPower = cpInfo.FightPower;
               invitePlayer.ID = cpInfo.ID;
               invitePlayer.Offer = cpInfo.Offer;
               invitePlayer.isOld = cpInfo.isOld;
               invitePlayer.isAttest = cpInfo.isAttest;
               if(type == 2)
               {
                  invitePlayer.titleType = (cpInfo as FriendListPlayer).titleType;
                  invitePlayer.type = (cpInfo as FriendListPlayer).type;
                  invitePlayer.titleText = (cpInfo as FriendListPlayer).titleText;
                  invitePlayer.titleNumText = (cpInfo as FriendListPlayer).titleNumText;
                  if(_titleSelectStatus.hasOwnProperty(invitePlayer.titleType.toString()))
                  {
                     invitePlayer.titleIsSelected = _titleSelectStatus[invitePlayer.titleType.toString()];
                  }
                  else
                  {
                     invitePlayer.titleIsSelected = false;
                  }
               }
               if(type != 2)
               {
                  _list.vectorListModel.insertElementAt(invitePlayer,getInsertIndex(cpInfo));
               }
               _invitePlayerInfos.push(invitePlayer);
            }
            i++;
         }
         if(type == 2)
         {
            friendList = _invitePlayerInfos;
            _list.vectorListModel.clear();
            _list.vectorListModel.appendAll(friendList);
         }
         _list.list.updateListView();
         if(type == 2)
         {
            intPoint = new IntPoint(0,tmpPosY);
            _list.list.viewPosition = intPoint;
         }
      }
      
      private function clearList() : void
      {
         _list.vectorListModel.clear();
      }
      
      private function getInsertIndex(info:BasePlayer) : int
      {
         var tempIndex:int = 0;
         var i:int = 0;
         var tempInfo:* = null;
         var tempArray:Array = _list.vectorListModel.elements;
         if(tempArray.length == 0)
         {
            return 0;
         }
         for(i = tempArray.length - 1; i >= 0; )
         {
            tempInfo = tempArray[i] as PlayerInfo;
            if(!(info.IsVIP && !tempInfo.IsVIP))
            {
               if(!info.IsVIP && tempInfo.IsVIP)
               {
                  return i + 1;
               }
            }
            i--;
         }
         return tempIndex;
      }
      
      private function __onResError(evt:UIModuleEvent) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onResComplete);
         UIModuleLoader.Instance.removeEventListener("uiModuleError",__onResError);
      }
      
      private function __onResComplete(evt:UIModuleEvent) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onResComplete);
         UIModuleLoader.Instance.removeEventListener("uiModuleError",__onResError);
         if(evt.module == "ddtinvite" && _visible)
         {
            _resState = "complete";
            configUi();
            addEvent();
            if(PlayerManager.Instance.Self.ConsortiaID != 0)
            {
               refleshList(1);
            }
            else
            {
               refleshList(2);
            }
         }
      }
      
      private function refleshList(type:int, count:int = 0) : void
      {
         var titleList:* = null;
         _btnGroup.selectIndex = type;
         _oldSelected = type;
         if(type == 3)
         {
            GameInSocketOut.sendGetScenePlayer(count);
         }
         else if(type == 2)
         {
            titleList = PlayerManager.Instance.friendAndCustomTitle;
            _titleSelectStatus = {};
            var _loc6_:int = 0;
            var _loc5_:* = titleList;
            for each(var tmpFInfo in titleList)
            {
               _titleSelectStatus[tmpFInfo.titleType] = false;
            }
            updateList(2,titleList);
         }
         else if(type == 1)
         {
            updateList(1,ConsortionModelManager.Instance.model.onlineConsortiaMemberList);
         }
         else if(type == 0)
         {
            updateList(0,rerecentContactList);
         }
         else if(type == 4)
         {
            updateList(4,TeamManager.instance.model.onlineTeamMemberList);
         }
      }
      
      private function get rerecentContactList() : Array
      {
         var tempInfo:* = null;
         var i:int = 0;
         var state:* = null;
         var tempDictionaryData:DictionaryData = PlayerManager.Instance.recentContacts;
         var recentContactsList:Array = IMManager.Instance.recentContactsList;
         var tempArray:Array = [];
         if(recentContactsList)
         {
            for(i = 0; i < recentContactsList.length; )
            {
               if(recentContactsList[i] != 0)
               {
                  tempInfo = tempDictionaryData[recentContactsList[i]];
                  if(tempInfo && tempArray.indexOf(tempInfo) == -1)
                  {
                     if(PlayerManager.Instance.findPlayer(tempInfo.ID,PlayerManager.Instance.Self.ZoneID))
                     {
                        state = new PlayerState(PlayerManager.Instance.findPlayer(tempInfo.ID,PlayerManager.Instance.Self.ZoneID).playerState.StateID);
                        tempInfo.playerState = state;
                     }
                     if(tempInfo.playerState.StateID != 0)
                     {
                        tempArray.push(tempInfo);
                     }
                  }
               }
               i++;
            }
         }
         return tempArray;
      }
      
      override public function dispose() : void
      {
         _visible = false;
         if(_resState == "loading")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onResComplete);
            UIModuleLoader.Instance.removeEventListener("uiModuleError",__onResError);
         }
         else
         {
            removeEvent();
            if(_list)
            {
               ObjectUtils.disposeObject(_list);
               _list = null;
            }
            if(_hbox)
            {
               ObjectUtils.disposeObject(_hbox);
               _hbox = null;
            }
            if(_brotherhoodButton)
            {
               ObjectUtils.disposeObject(_brotherhoodButton);
               _brotherhoodButton = null;
            }
            if(_frientButton)
            {
               ObjectUtils.disposeObject(_frientButton);
               _frientButton = null;
            }
            if(_hallButton)
            {
               ObjectUtils.disposeObject(_hallButton);
               _hallButton = null;
            }
            if(_fastInviteBtn)
            {
               ObjectUtils.disposeObject(_fastInviteBtn);
               _fastInviteBtn = null;
            }
            if(_refreshButton)
            {
               ObjectUtils.disposeObject(_refreshButton);
               _refreshButton = null;
            }
            if(_listBack)
            {
               ObjectUtils.disposeObject(_listBack);
               _listBack = null;
            }
            if(_recentContactBtn)
            {
               ObjectUtils.disposeObject(_recentContactBtn);
               _recentContactBtn = null;
            }
            if(_teamButton)
            {
               ObjectUtils.disposeObject(_teamButton);
               _teamButton = null;
            }
         }
         super.dispose();
      }
   }
}
