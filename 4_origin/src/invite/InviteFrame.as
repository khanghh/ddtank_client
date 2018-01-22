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
      
      private function __freeInvitedHandler(param1:ChatEvent) : void
      {
         if(PlayerManager.Instance.Self.checkFreeInvite())
         {
            _fastInviteBtn.text = LanguageMgr.GetTranslation("tank.invite.InviteView.fastInvite1",PlayerManager.Instance.Self.freeInviteCnt);
            PositionUtils.setPos(_fastInviteBtn,"ddtinvite.inviteBtnPos");
         }
      }
      
      protected function __onFastInviteClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
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
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.game.room.fastInvite.promptTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            _loc2_.moveEnable = false;
            _loc2_.addEventListener("response",__confirmFastInvite);
         }
      }
      
      private function __confirmFastInvite(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__confirmFastInvite);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            ChatManager.Instance.sendBugle("",11101,true);
         }
      }
      
      private function __btnChangeHandler(param1:Event) : void
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
      
      private function __response(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
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
      
      private function __onRefreshClick(param1:MouseEvent) : void
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
      
      private function __onGetList(param1:PkgEvent) : void
      {
         var _loc6_:* = 0;
         var _loc5_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:Array = [];
         var _loc2_:int = _loc3_.readByte();
         _loc6_ = uint(0);
         while(_loc6_ < _loc2_)
         {
            _loc5_ = new PlayerInfo();
            _loc5_.ID = _loc3_.readInt();
            _loc5_.NickName = _loc3_.readUTF();
            _loc5_.typeVIP = _loc3_.readByte();
            _loc5_.VIPLevel = _loc3_.readInt();
            _loc5_.Sex = _loc3_.readBoolean();
            _loc5_.Grade = _loc3_.readInt();
            _loc5_.ConsortiaID = _loc3_.readInt();
            _loc5_.ConsortiaName = _loc3_.readUTF();
            _loc5_.Offer = _loc3_.readInt();
            _loc5_.WinCount = _loc3_.readInt();
            _loc5_.TotalCount = _loc3_.readInt();
            _loc5_.EscapeCount = _loc3_.readInt();
            _loc5_.Repute = _loc3_.readInt();
            _loc5_.FightPower = _loc3_.readInt();
            _loc5_.isOld = _loc3_.readBoolean();
            _loc5_.isAttest = _loc3_.readBoolean();
            _loc4_.push(_loc5_);
            _loc6_++;
         }
         updateList(3,_loc4_);
      }
      
      override protected function __onCloseClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new Event("complete"));
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         var _loc3_:* = null;
         var _loc12_:int = 0;
         var _loc10_:* = null;
         var _loc13_:* = 0;
         var _loc6_:int = 0;
         var _loc11_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc7_:int = 0;
         if((param1.cellValue as InvitePlayerInfo).type == 0)
         {
            SoundManager.instance.play("008");
            _loc3_ = [];
            _loc12_ = (param1.cellValue as InvitePlayerInfo).titleType;
            _loc10_ = PlayerManager.Instance.friendAndCustomTitle;
            if(_titleSelectStatus[_loc12_] == true)
            {
               _loc3_ = _loc10_;
            }
            else
            {
               _loc13_ = 0;
               _loc6_ = 0;
               while(_loc6_ < _loc10_.length)
               {
                  _loc3_.push(_loc10_[_loc6_]);
                  if(_loc12_ == _loc10_[_loc6_].titleType)
                  {
                     _loc13_ = _loc6_;
                     break;
                  }
                  _loc6_++;
               }
               _loc11_ = PlayerManager.Instance.getOnlineFriendForCustom(_loc12_);
               _loc5_ = [];
               _loc4_ = [];
               _loc8_ = 0;
               while(_loc8_ < _loc11_.length)
               {
                  _loc9_ = _loc11_[_loc8_] as FriendListPlayer;
                  if(_loc9_.IsVIP)
                  {
                     _loc5_.push(_loc9_);
                  }
                  else
                  {
                     _loc4_.push(_loc9_);
                  }
                  _loc8_++;
               }
               _loc5_ = sort(_loc5_);
               _loc4_ = sort(_loc4_);
               _loc11_ = _loc5_.concat(_loc4_);
               _loc11_ = IMManager.Instance.sortAcademyPlayer(_loc11_);
               _loc3_ = _loc3_.concat(_loc11_);
               _loc7_ = _loc13_ + 1;
               while(_loc7_ < _loc10_.length)
               {
                  _loc3_.push(_loc10_[_loc7_]);
                  _loc7_++;
               }
            }
            var _loc15_:int = 0;
            var _loc14_:* = _titleSelectStatus;
            for(var _loc2_ in _titleSelectStatus)
            {
               if(int(_loc2_) == _loc12_)
               {
                  _titleSelectStatus[_loc2_] = !_titleSelectStatus[_loc2_];
               }
               else
               {
                  _titleSelectStatus[_loc2_] = false;
               }
            }
            updateList(2,_loc3_);
         }
      }
      
      private function sort(param1:Array) : Array
      {
         return param1.sortOn("Grade",16 | 2);
      }
      
      private function updateList(param1:int, param2:Array) : void
      {
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         _changeComplete = true;
         var _loc8_:int = _list.list.viewPosition.y;
         clearList();
         _invitePlayerInfos = [];
         _loc7_ = 0;
         while(_loc7_ < param2.length)
         {
            _loc3_ = param2[_loc7_] as BasePlayer;
            if(_loc3_.ID != PlayerManager.Instance.Self.ID)
            {
               _loc6_ = new InvitePlayerInfo();
               _loc6_.NickName = _loc3_.NickName;
               _loc6_.typeVIP = _loc3_.typeVIP;
               _loc6_.Sex = _loc3_.Sex;
               _loc6_.Grade = _loc3_.Grade;
               _loc6_.Repute = _loc3_.Repute;
               _loc6_.WinCount = _loc3_.WinCount;
               _loc6_.TotalCount = _loc3_.TotalCount;
               _loc6_.FightPower = _loc3_.FightPower;
               _loc6_.ID = _loc3_.ID;
               _loc6_.Offer = _loc3_.Offer;
               _loc6_.isOld = _loc3_.isOld;
               _loc6_.isAttest = _loc3_.isAttest;
               if(param1 == 2)
               {
                  _loc6_.titleType = (_loc3_ as FriendListPlayer).titleType;
                  _loc6_.type = (_loc3_ as FriendListPlayer).type;
                  _loc6_.titleText = (_loc3_ as FriendListPlayer).titleText;
                  _loc6_.titleNumText = (_loc3_ as FriendListPlayer).titleNumText;
                  if(_titleSelectStatus.hasOwnProperty(_loc6_.titleType.toString()))
                  {
                     _loc6_.titleIsSelected = _titleSelectStatus[_loc6_.titleType.toString()];
                  }
                  else
                  {
                     _loc6_.titleIsSelected = false;
                  }
               }
               if(param1 != 2)
               {
                  _list.vectorListModel.insertElementAt(_loc6_,getInsertIndex(_loc3_));
               }
               _invitePlayerInfos.push(_loc6_);
            }
            _loc7_++;
         }
         if(param1 == 2)
         {
            _loc5_ = _invitePlayerInfos;
            _list.vectorListModel.clear();
            _list.vectorListModel.appendAll(_loc5_);
         }
         _list.list.updateListView();
         if(param1 == 2)
         {
            _loc4_ = new IntPoint(0,_loc8_);
            _list.list.viewPosition = _loc4_;
         }
      }
      
      private function clearList() : void
      {
         _list.vectorListModel.clear();
      }
      
      private function getInsertIndex(param1:BasePlayer) : int
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:Array = _list.vectorListModel.elements;
         if(_loc3_.length == 0)
         {
            return 0;
         }
         _loc5_ = _loc3_.length - 1;
         while(_loc5_ >= 0)
         {
            _loc4_ = _loc3_[_loc5_] as PlayerInfo;
            if(!(param1.IsVIP && !_loc4_.IsVIP))
            {
               if(!param1.IsVIP && _loc4_.IsVIP)
               {
                  return _loc5_ + 1;
               }
            }
            _loc5_--;
         }
         return _loc2_;
      }
      
      private function __onResError(param1:UIModuleEvent) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onResComplete);
         UIModuleLoader.Instance.removeEventListener("uiModuleError",__onResError);
      }
      
      private function __onResComplete(param1:UIModuleEvent) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onResComplete);
         UIModuleLoader.Instance.removeEventListener("uiModuleError",__onResError);
         if(param1.module == "ddtinvite" && _visible)
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
      
      private function refleshList(param1:int, param2:int = 0) : void
      {
         var _loc3_:* = null;
         _btnGroup.selectIndex = param1;
         _oldSelected = param1;
         if(param1 == 3)
         {
            GameInSocketOut.sendGetScenePlayer(param2);
         }
         else if(param1 == 2)
         {
            _loc3_ = PlayerManager.Instance.friendAndCustomTitle;
            _titleSelectStatus = {};
            var _loc6_:int = 0;
            var _loc5_:* = _loc3_;
            for each(var _loc4_ in _loc3_)
            {
               _titleSelectStatus[_loc4_.titleType] = false;
            }
            updateList(2,_loc3_);
         }
         else if(param1 == 1)
         {
            updateList(1,ConsortionModelManager.Instance.model.onlineConsortiaMemberList);
         }
         else if(param1 == 0)
         {
            updateList(0,rerecentContactList);
         }
         else if(param1 == 4)
         {
            updateList(4,TeamManager.instance.model.onlineTeamMemberList);
         }
      }
      
      private function get rerecentContactList() : Array
      {
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc1_:DictionaryData = PlayerManager.Instance.recentContacts;
         var _loc5_:Array = IMManager.Instance.recentContactsList;
         var _loc2_:Array = [];
         if(_loc5_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               if(_loc5_[_loc6_] != 0)
               {
                  _loc3_ = _loc1_[_loc5_[_loc6_]];
                  if(_loc3_ && _loc2_.indexOf(_loc3_) == -1)
                  {
                     if(PlayerManager.Instance.findPlayer(_loc3_.ID,PlayerManager.Instance.Self.ZoneID))
                     {
                        _loc4_ = new PlayerState(PlayerManager.Instance.findPlayer(_loc3_.ID,PlayerManager.Instance.Self.ZoneID).playerState.StateID);
                        _loc3_.playerState = _loc4_;
                     }
                     if(_loc3_.playerState.StateID != 0)
                     {
                        _loc2_.push(_loc3_);
                     }
                  }
               }
               _loc6_++;
            }
         }
         return _loc2_;
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
