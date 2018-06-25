package im
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import consortion.ConsortionModelManager;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.comm.PackageIn;
   
   public class IMControl extends EventDispatcher
   {
      
      private static var _instance:IMControl;
       
      
      private var _imview:IMView;
      
      private var _currentPlayer:PlayerInfo;
      
      private var _panels:Dictionary;
      
      private var _isShow:Boolean;
      
      private var _titleType:int;
      
      private var _manager:IMManager;
      
      public var customInfo:CustomInfo;
      
      public var deleteCustomID:int;
      
      private var _likeFriendList:Array;
      
      public function IMControl()
      {
         super();
         IMListItemView;
         ConsortiaListItemView;
         PlayerStateItem;
         LikeFriendItem;
         _manager = IMManager.Instance;
      }
      
      public static function get Instance() : IMControl
      {
         if(_instance == null)
         {
            _instance = new IMControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         PlayerManager.Instance.addEventListener("addnewfriend",__addNewFriend);
         SocketManager.Instance.addEventListener(PkgEvent.format(160,208),__addCustomHandler);
         IMManager.Instance.addEventListener("imOpenView",__onOpenView);
      }
      
      protected function __addCustomHandler(event:PkgEvent) : void
      {
         var temp2:int = 0;
         var temp4:int = 0;
         var pkg:PackageIn = event.pkg;
         var type:int = pkg.readByte();
         var bol:Boolean = pkg.readBoolean();
         var id:int = pkg.readInt();
         var name:String = pkg.readUTF();
         switch(int(type) - 1)
         {
            case 0:
               if(bol)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.addCustom.success",name));
                  customInfo = new CustomInfo();
                  customInfo.ID = id;
                  customInfo.Name = name;
                  dispatchEvent(new IMEvent("addNewGroup"));
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.addCustom.fail",name));
               }
               break;
            case 1:
               if(bol)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.deleteCustom.success",name));
                  PlayerManager.Instance.deleteCustomGroup(id);
                  for(temp2 = 0; temp2 < PlayerManager.Instance.customList.length; )
                  {
                     if(PlayerManager.Instance.customList[temp2].ID == id)
                     {
                        PlayerManager.Instance.customList.splice(temp2,1);
                        break;
                     }
                     temp2++;
                  }
                  deleteCustomID = id;
                  dispatchEvent(new IMEvent("deleteGroup"));
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.deleteCustom.fail",name));
               }
               break;
            case 2:
               if(bol)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.alertCustom.success"));
                  customInfo = new CustomInfo();
                  customInfo.ID = id;
                  customInfo.Name = name;
                  for(temp4 = 0; temp4 < PlayerManager.Instance.customList.length; )
                  {
                     if(PlayerManager.Instance.customList[temp4].ID == id)
                     {
                        PlayerManager.Instance.customList[temp4].Name = name;
                        break;
                     }
                     temp4++;
                  }
                  dispatchEvent(new IMEvent("updateGroup"));
                  break;
               }
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.alertCustom.fail"));
               break;
         }
      }
      
      public function checkHasNew(id:int) : Boolean
      {
         var i:int = 0;
         for(i = 0; i < _manager.existChat.length; )
         {
            if(id == _manager.existChat[i].id && _manager.existChat[i].exist == 2)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function __addNewFriend(evt:IMEvent) : void
      {
         _currentPlayer = evt.data as PlayerInfo;
      }
      
      private function privateChat() : void
      {
         if(_currentPlayer != null)
         {
            ChatManager.Instance.privateChatTo(_currentPlayer.NickName,_currentPlayer.ID);
         }
      }
      
      public function set isShow(value:Boolean) : void
      {
         _isShow = value;
      }
      
      private function hide() : void
      {
         _imview.dispose();
         _imview = null;
      }
      
      private function show() : void
      {
         _imview = null;
         if(_imview == null)
         {
            _imview = ComponentFactory.Instance.creat("IMFrame");
            _imview.addEventListener("response",__imviewEvent);
         }
         LayerManager.Instance.addToLayer(_imview,3,false);
      }
      
      protected function __onOpenView(event:IMEvent) : void
      {
         if(_manager.isLoadRecentContacts)
         {
            PlayerManager.Instance.addEventListener("recentContactsComplete",__recentContactsComplete);
            _manager.loadRecentContacts();
         }
         else
         {
            if(!_manager.isLoadComplete)
            {
               return;
            }
            if(_isShow)
            {
               hide();
            }
            else
            {
               show();
               _isShow = true;
               _manager.isLoadRecentContacts = false;
            }
         }
      }
      
      private function __recentContactsComplete(event:Event) : void
      {
         PlayerManager.Instance.removeEventListener("recentContactsComplete",__recentContactsComplete);
         if(!_manager.isLoadComplete)
         {
            return;
         }
         if(_isShow)
         {
            hide();
         }
         else
         {
            show();
            _isShow = true;
            _manager.isLoadRecentContacts = false;
         }
      }
      
      public function set titleType(value:int) : void
      {
         _titleType = value;
      }
      
      public function get titleType() : int
      {
         return _titleType;
      }
      
      private function __imviewEvent(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1)
         {
            SoundManager.instance.play("008");
            hide();
         }
      }
      
      public function getRecentContactsStranger() : Array
      {
         var tempArray:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = PlayerManager.Instance.recentContacts;
         for each(var i in PlayerManager.Instance.recentContacts)
         {
            if(testAlikeName(i.NickName))
            {
               tempArray.push(i);
            }
         }
         return tempArray;
      }
      
      public function testAlikeName(name:String) : Boolean
      {
         var i:int = 0;
         var temList:Array = [];
         temList = PlayerManager.Instance.friendList.list;
         temList = temList.concat(PlayerManager.Instance.blackList.list);
         temList = temList.concat(ConsortionModelManager.Instance.model.memberList.list);
         for(i = 0; i < temList.length; )
         {
            if(temList[i] is FriendListPlayer && (temList[i] as FriendListPlayer).NickName == name)
            {
               return false;
            }
            if(temList[i] is ConsortiaPlayerInfo && (temList[i] as ConsortiaPlayerInfo).NickName == name)
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function set likeFriendList(value:Array) : void
      {
         _likeFriendList = value;
      }
      
      public function get likeFriendList() : Array
      {
         return _likeFriendList;
      }
   }
}
