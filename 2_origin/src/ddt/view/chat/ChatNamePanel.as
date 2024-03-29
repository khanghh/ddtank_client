package ddt.view.chat
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import flash.events.MouseEvent;
   import game.GameManager;
   import room.RoomManager;
   import room.model.RoomInfo;
   
   public class ChatNamePanel extends ChatBasePanel
   {
       
      
      public var _playerName:String;
      
      public var channel:String = "";
      
      public var message:String = "";
      
      private var _bg:Image;
      
      private var _blackListBtn:IconButton;
      
      private var _viewInfoBtn:IconButton;
      
      private var _addFriendBtn:IconButton;
      
      private var _privateChat:IconButton;
      
      private var _reportBtn:IconButton;
      
      private var _inviteBtn:IconButton;
      
      private var _btnContainer:VBox;
      
      private var _data:PlayerInfo;
      
      public function ChatNamePanel()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _btnContainer = ComponentFactory.Instance.creatComponentByStylename("chat.NamePanelList");
         _blackListBtn = ComponentFactory.Instance.creatComponentByStylename("chat.ItemBlackList");
         _viewInfoBtn = ComponentFactory.Instance.creatComponentByStylename("chat.ItemInfo");
         _privateChat = ComponentFactory.Instance.creatComponentByStylename("chat.ItemPrivateChat");
         _addFriendBtn = ComponentFactory.Instance.creatComponentByStylename("chat.ItemMakeFriend");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("chat.ItemInvite");
         update();
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _blackListBtn.addEventListener("click",__onBtnClicked);
         _viewInfoBtn.addEventListener("click",__onBtnClicked);
         _addFriendBtn.addEventListener("click",__onBtnClicked);
         _inviteBtn.addEventListener("click",__onBtnClicked);
         _privateChat.addEventListener("click",__onBtnClicked);
      }
      
      public function get getHeight() : int
      {
         return _bg.height;
      }
      
      private function __onBtnClicked(param1:MouseEvent) : void
      {
         event = param1;
         var _loc3_:* = event.currentTarget;
         if(_blackListBtn !== _loc3_)
         {
            if(_viewInfoBtn !== _loc3_)
            {
               if(_addFriendBtn !== _loc3_)
               {
                  if(_privateChat !== _loc3_)
                  {
                     if(_inviteBtn === _loc3_)
                     {
                        var roominfo:RoomInfo = RoomManager.Instance.current;
                        if(roominfo)
                        {
                           if(roominfo && roominfo.placeCount < 1)
                           {
                              if(roominfo.players.length > 1)
                              {
                                 MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIIBGView.room"));
                              }
                              else
                              {
                                 MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIView2.noplacetoinvite"));
                              }
                              return;
                           }
                           if(playerName == PlayerManager.Instance.Self.NickName)
                           {
                              MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.im.IMController.cannotInviteSelf"));
                              return;
                           }
                           _data = new PlayerInfo();
                           _data = PlayerManager.Instance.findPlayerByNickName(_data,playerName);
                           if(_data.Grade == 0)
                           {
                              SocketManager.Instance.out.sendItemEquip(playerName,true);
                              _data.addEventListener("propertychange",function(param1:PlayerPropertyEvent):void
                              {
                                 param1.currentTarget.removeEventListener("propertychange",arguments.callee);
                                 exeInvite();
                              });
                           }
                           else
                           {
                              exeInvite();
                           }
                        }
                     }
                  }
                  else
                  {
                     ChatManager.Instance.privateChatTo(playerName);
                  }
               }
               else
               {
                  IMManager.Instance.addFriend(playerName);
               }
            }
            else
            {
               PlayerInfoViewControl.viewByNickName(playerName);
               PlayerInfoViewControl.isOpenFromBag = false;
            }
         }
         else
         {
            IMManager.Instance.addBlackList(playerName);
         }
      }
      
      private function exeInvite() : void
      {
         var _loc1_:RoomInfo = RoomManager.Instance.current;
         if(_loc1_.type == 0)
         {
            if(inviteLvTip(6))
            {
               return;
            }
         }
         else if(_loc1_.type == 1)
         {
            if(inviteLvTip(12))
            {
               return;
            }
         }
         if((_loc1_.type == 4 || _loc1_.type == 11 || _loc1_.type == 23 || _loc1_.type == 123) && _data.Grade < GameManager.MinLevelDuplicate)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.gradeLow",GameManager.MinLevelDuplicate));
            return;
         }
         if(_loc1_.type == 21 && _data.Grade < GameManager.MinLevelActivity)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.activityLow"));
            return;
         }
         if(checkLevel(_data.Grade))
         {
            GameInSocketOut.sendInviteGame(_data.ID);
         }
      }
      
      public function set playerName(param1:String) : void
      {
         _playerName = param1;
         update();
      }
      
      public function get playerName() : String
      {
         return _playerName;
      }
      
      private function update() : void
      {
         if(!IMManager.Instance.isFriend(playerName))
         {
            _bg.width = 110;
            _bg.height = 90;
         }
         else
         {
            _bg.width = 110;
            _bg.height = 70;
         }
         addChild(_bg);
         addChild(_btnContainer);
         if(_privateChat.parent)
         {
            _privateChat.parent.removeChild(_privateChat);
         }
         if(_addFriendBtn.parent)
         {
            _addFriendBtn.parent.removeChild(_addFriendBtn);
         }
         if(_viewInfoBtn.parent)
         {
            _viewInfoBtn.parent.removeChild(_viewInfoBtn);
         }
         if(_blackListBtn.parent)
         {
            _blackListBtn.parent.removeChild(_blackListBtn);
         }
         if(_inviteBtn.parent)
         {
            _inviteBtn.parent.removeChild(_inviteBtn);
         }
         _btnContainer.addChild(_privateChat);
         if(!IMManager.Instance.isFriend(playerName))
         {
            _btnContainer.addChild(_addFriendBtn);
         }
         _btnContainer.addChild(_viewInfoBtn);
         _btnContainer.addChild(_blackListBtn);
         var _loc1_:RoomInfo = RoomManager.Instance.current;
         if(_loc1_ && StateManager.currentStateType != "fighting")
         {
            if(_loc1_.type == 0 || _loc1_.type == 1 || _loc1_.type == 4 || _loc1_.type == 123 || _loc1_.type == 11 || _loc1_.type == 21 || _loc1_.type == 23)
            {
               _bg.height = _bg.height + 20;
               if(_loc1_.type != 25)
               {
                  _btnContainer.addChild(_inviteBtn);
               }
            }
         }
      }
      
      private function checkLevel(param1:int) : Boolean
      {
         var _loc2_:RoomInfo = RoomManager.Instance.current;
         if(_loc2_.type > 2)
         {
            if(param1 < GameManager.MinLevelDuplicate)
            {
               return false;
            }
         }
         else if(_loc2_.type == 2)
         {
            if((_loc2_.levelLimits - 1) * 10 > param1)
            {
               return false;
            }
         }
         return true;
      }
      
      private function inviteLvTip(param1:int) : Boolean
      {
         if(_data.Grade < param1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.invite.InvitePlayerItem.cannot",param1));
            return true;
         }
         return false;
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _blackListBtn.removeEventListener("click",__onBtnClicked);
         _viewInfoBtn.removeEventListener("click",__onBtnClicked);
         _addFriendBtn.removeEventListener("click",__onBtnClicked);
         _privateChat.removeEventListener("click",__onBtnClicked);
      }
   }
}
