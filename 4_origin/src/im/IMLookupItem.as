package im
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.CMFriendInfo;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.PlayerTipManager;
   import ddt.manager.SoundManager;
   import ddt.view.common.SexIcon;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class IMLookupItem extends Sprite implements Disposeable
   {
      
      public static const OUT:int = 1;
      
      public static const OVER:int = 2;
       
      
      private var _info:Object;
      
      private var _sex_icon:SexIcon;
      
      private var _selected:Boolean;
      
      private var _bg:ScaleFrameImage;
      
      private var _name:FilterFrameText;
      
      private var _privateChatBtn:SimpleBitmapButton;
      
      private var _deleteBtn:SimpleBitmapButton;
      
      private var _addFriendBtn:BaseButton;
      
      private var _inviteBtn:BaseButton;
      
      public function IMLookupItem(param1:Object)
      {
         _info = param1;
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("IM.IMLookup.IMLookupItemBg");
         _bg.setFrame(1);
         addChild(_bg);
         _sex_icon = new SexIcon();
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("IM.IMLookup.SexPos");
         _sex_icon.x = _loc1_.x;
         _sex_icon.y = _loc1_.y;
         addChild(_sex_icon);
         if(info is CMFriendInfo)
         {
            _sex_icon.setSex(_info.sex);
         }
         else
         {
            _sex_icon.setSex(_info.Sex);
         }
         _name = ComponentFactory.Instance.creatComponentByStylename("IM.IMLookup.IMLookupItemName");
         if(info is CMFriendInfo)
         {
            _name.text = info.NickName == ""?info.OtherName:info.NickName;
         }
         else
         {
            _name.text = info.NickName;
         }
         addChild(_name);
         if(!(info is CMFriendInfo))
         {
            _deleteBtn = ComponentFactory.Instance.creat("IM.LookItem.deleteBtn");
            _deleteBtn.tipData = LanguageMgr.GetTranslation("tank.view.im.IMFriendItem.delete");
            addChild(_deleteBtn);
            _privateChatBtn = ComponentFactory.Instance.creat("IM.LookItem.privateChatBtn");
            _privateChatBtn.tipData = LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.private");
            addChild(_privateChatBtn);
         }
         else if(info.IsExist)
         {
            _addFriendBtn = ComponentFactory.Instance.creat("IM.IMLookupItem.addFriendBtn");
            _addFriendBtn.tipData = LanguageMgr.GetTranslation("tank.view.im.IMFriendList.addFriend");
            addChild(_addFriendBtn);
            _privateChatBtn = ComponentFactory.Instance.creat("IM.LookItem.privateChatBtn");
            _privateChatBtn.tipData = LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.private");
            addChild(_privateChatBtn);
         }
         else
         {
            _inviteBtn = ComponentFactory.Instance.creat("IM.IMLookupItem.inviteBtn");
            _inviteBtn.tipData = LanguageMgr.GetTranslation("im.IMView.inviteBtnText");
            addChild(_inviteBtn);
         }
      }
      
      public function styleForJustName() : void
      {
         _privateChatBtn.visible = false;
         _deleteBtn.visible = false;
         _sex_icon.visible = false;
         _name.x = 15;
         _bg.width = 131;
         _bg.removeEventListener("interactive_click",__bgClick);
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__itemOver);
         addEventListener("mouseOut",__itemOut);
         _bg.addEventListener("interactive_click",__bgClick);
         _bg.addEventListener("interactive_double_click",__privateChatClick);
         DoubleClickManager.Instance.enableDoubleClick(_bg);
         if(_privateChatBtn)
         {
            _privateChatBtn.addEventListener("click",__privateChatBtnClick);
         }
         if(_deleteBtn)
         {
            _deleteBtn.addEventListener("click",_deleteBtnClick);
         }
         if(_inviteBtn)
         {
            _inviteBtn.addEventListener("click",__invite);
         }
         if(_addFriendBtn)
         {
            _addFriendBtn.addEventListener("click",__addFriend);
         }
      }
      
      private function __addFriend(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         IMManager.Instance.addFriend(info.NickName);
      }
      
      private function __invite(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:InviteDialogFrame = ComponentFactory.Instance.creatComponentByStylename("InviteDialogFrame");
         _loc2_.setInfo(_info.UserName);
         _loc2_.show();
      }
      
      private function __bgClick(param1:InteractiveEvent) : void
      {
         SoundManager.instance.play("008");
         if(info is PlayerInfo)
         {
            PlayerTipManager.show(info as PlayerInfo,localToGlobal(new Point(0,0)).y);
         }
         if(info is ConsortiaPlayerInfo)
         {
            PlayerTipManager.show(info as ConsortiaPlayerInfo,localToGlobal(new Point(0,0)).y);
         }
      }
      
      private function _deleteBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!(info is CMFriendInfo) && IMControl.Instance.testAlikeName(info.NickName))
         {
            IMManager.Instance.deleteRecentContacts(info.ID);
            return;
         }
         if(info is PlayerInfo)
         {
            if(PlayerManager.Instance.friendList[info.ID])
            {
               IMManager.Instance.deleteFriend(info.ID);
            }
            else
            {
               IMManager.Instance.deleteFriend(info.ID,true);
            }
            return;
         }
         if(info is CMFriendInfo)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("im.IMLookupItem.CMFriendInfo"));
            return;
         }
         if(info is ConsortiaPlayerInfo && IMManager.Instance.testIdentical(info.ID) != -1)
         {
            IMManager.Instance.deleteRecentContacts(info.ID);
            return;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("im.IMLookupItem.ConsortiaPlayerInfo"));
      }
      
      private function __privateChatClick(param1:InteractiveEvent) : void
      {
         SoundManager.instance.play("008");
         if(info is PlayerInfo || info is ConsortiaPlayerInfo)
         {
            ChatManager.Instance.privateChatTo(info.NickName,info.ID);
            ChatManager.Instance.setFocus();
         }
      }
      
      private function __privateChatBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(info is PlayerInfo || info is ConsortiaPlayerInfo)
         {
            ChatManager.Instance.privateChatTo(info.NickName,info.ID);
            ChatManager.Instance.setFocus();
         }
         else if(info is CMFriendInfo && info.IsExist)
         {
            ChatManager.Instance.privateChatTo(info.NickName,info.UserId);
            ChatManager.Instance.setFocus();
         }
      }
      
      private function __itemOut(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      private function __itemOver(param1:MouseEvent) : void
      {
         _bg.setFrame(2);
      }
      
      public function get info() : Object
      {
         return _info;
      }
      
      public function get text() : String
      {
         return _info.NickName;
      }
      
      public function dispose() : void
      {
         removeEventListener("mouseOver",__itemOver);
         removeEventListener("mouseOut",__itemOut);
         if(_privateChatBtn)
         {
            _privateChatBtn.removeEventListener("click",__privateChatBtnClick);
         }
         if(_deleteBtn)
         {
            _deleteBtn.removeEventListener("click",_deleteBtnClick);
         }
         if(_inviteBtn)
         {
            _inviteBtn.removeEventListener("click",__invite);
         }
         if(_addFriendBtn)
         {
            _addFriendBtn.removeEventListener("click",__addFriend);
         }
         if(_deleteBtn)
         {
            _deleteBtn.removeEventListener("click",_deleteBtnClick);
         }
         _bg.removeEventListener("interactive_click",__bgClick);
         _bg.removeEventListener("interactive_double_click",__privateChatClick);
         DoubleClickManager.Instance.disableDoubleClick(_bg);
         if(_sex_icon && _sex_icon.parent)
         {
            _sex_icon.parent.removeChild(_sex_icon);
            _sex_icon.dispose();
            _sex_icon = null;
         }
         if(_bg && _bg.parent)
         {
            _bg.parent.removeChild(_bg);
            _bg.dispose();
            _bg = null;
         }
         if(_name && _name.parent)
         {
            _name.parent.removeChild(_name);
            _name.dispose();
            _name = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
