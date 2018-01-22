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
      
      protected function __addCustomHandler(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:PackageIn = param1.pkg;
         var _loc7_:int = _loc6_.readByte();
         var _loc5_:Boolean = _loc6_.readBoolean();
         var _loc2_:int = _loc6_.readInt();
         var _loc4_:String = _loc6_.readUTF();
         switch(int(_loc7_) - 1)
         {
            case 0:
               if(_loc5_)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.addCustom.success",_loc4_));
                  customInfo = new CustomInfo();
                  customInfo.ID = _loc2_;
                  customInfo.Name = _loc4_;
                  dispatchEvent(new IMEvent("addNewGroup"));
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.addCustom.fail",_loc4_));
               }
               break;
            case 1:
               if(_loc5_)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.deleteCustom.success",_loc4_));
                  PlayerManager.Instance.deleteCustomGroup(_loc2_);
                  _loc3_ = 0;
                  while(_loc3_ < PlayerManager.Instance.customList.length)
                  {
                     if(PlayerManager.Instance.customList[_loc3_].ID == _loc2_)
                     {
                        PlayerManager.Instance.customList.splice(_loc3_,1);
                        break;
                     }
                     _loc3_++;
                  }
                  deleteCustomID = _loc2_;
                  dispatchEvent(new IMEvent("deleteGroup"));
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.deleteCustom.fail",_loc4_));
               }
               break;
            case 2:
               if(_loc5_)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.alertCustom.success"));
                  customInfo = new CustomInfo();
                  customInfo.ID = _loc2_;
                  customInfo.Name = _loc4_;
                  _loc8_ = 0;
                  while(_loc8_ < PlayerManager.Instance.customList.length)
                  {
                     if(PlayerManager.Instance.customList[_loc8_].ID == _loc2_)
                     {
                        PlayerManager.Instance.customList[_loc8_].Name = _loc4_;
                        break;
                     }
                     _loc8_++;
                  }
                  dispatchEvent(new IMEvent("updateGroup"));
                  break;
               }
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.alertCustom.fail"));
               break;
         }
      }
      
      public function checkHasNew(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _manager.existChat.length)
         {
            if(param1 == _manager.existChat[_loc2_].id && _manager.existChat[_loc2_].exist == 2)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function __addNewFriend(param1:IMEvent) : void
      {
         _currentPlayer = param1.data as PlayerInfo;
      }
      
      private function privateChat() : void
      {
         if(_currentPlayer != null)
         {
            ChatManager.Instance.privateChatTo(_currentPlayer.NickName,_currentPlayer.ID);
         }
      }
      
      public function set isShow(param1:Boolean) : void
      {
         _isShow = param1;
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
      
      protected function __onOpenView(param1:IMEvent) : void
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
      
      private function __recentContactsComplete(param1:Event) : void
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
      
      public function set titleType(param1:int) : void
      {
         _titleType = param1;
      }
      
      public function get titleType() : int
      {
         return _titleType;
      }
      
      private function __imviewEvent(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            hide();
         }
      }
      
      public function getRecentContactsStranger() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = PlayerManager.Instance.recentContacts;
         for each(var _loc2_ in PlayerManager.Instance.recentContacts)
         {
            if(testAlikeName(_loc2_.NickName))
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function testAlikeName(param1:String) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc2_ = PlayerManager.Instance.friendList.list;
         _loc2_ = _loc2_.concat(PlayerManager.Instance.blackList.list);
         _loc2_ = _loc2_.concat(ConsortionModelManager.Instance.model.memberList.list);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] is FriendListPlayer && (_loc2_[_loc3_] as FriendListPlayer).NickName == param1)
            {
               return false;
            }
            if(_loc2_[_loc3_] is ConsortiaPlayerInfo && (_loc2_[_loc3_] as ConsortiaPlayerInfo).NickName == param1)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function set likeFriendList(param1:Array) : void
      {
         _likeFriendList = param1;
      }
      
      public function get likeFriendList() : Array
      {
         return _likeFriendList;
      }
   }
}
