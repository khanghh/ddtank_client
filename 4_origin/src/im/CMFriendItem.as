package im
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.CMFriendInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.DesktopManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.SoundManager;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.SexIcon;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.LoaderContext;
   import road7th.utils.StringHelper;
   
   public class CMFriendItem extends Sprite implements Disposeable
   {
       
      
      private var _info:CMFriendInfo;
      
      private var _bg:ScaleFrameImage;
      
      private var _levelIcon:LevelIcon;
      
      private var _sexIcon:SexIcon;
      
      private var _nameText:FilterFrameText;
      
      private var _CMNameText:FilterFrameText;
      
      private var _iconBg:Bitmap;
      
      private var _iconLight:Bitmap;
      
      private var _loader:DisplayLoader;
      
      private var _icon:Bitmap;
      
      private var _iconSprite:Sprite;
      
      private var _isSelected:Boolean;
      
      private var _privateChatBtn:BaseButton;
      
      private var _addFriendBtn:BaseButton;
      
      private var _inviteBtn:BaseButton;
      
      private var _load:Loader;
      
      private var _loaderContext:LoaderContext;
      
      public function CMFriendItem()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         this.graphics.beginFill(0,0);
         this.graphics.drawRect(0,0,235,44);
         this.graphics.endFill();
         this.buttonMode = true;
         _bg = ComponentFactory.Instance.creatComponentByStylename("im.item.CMFriendListBG");
         _bg.setFrame(1);
         addChild(_bg);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("IM.CMFriendListItem.levelIcon");
         _levelIcon.setSize(1);
         addChild(_levelIcon);
         _levelIcon.setInfo(15,0,20,20,20,20,20,false);
         _sexIcon = new SexIcon();
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("IM.CMFriendListItem.sexIconPos");
         _sexIcon.x = _loc1_.x;
         _sexIcon.y = _loc1_.y;
         addChild(_sexIcon);
         _loaderContext = new LoaderContext(true);
         _CMNameText = ComponentFactory.Instance.creatComponentByStylename("IM.CMFriendListItem.name");
         addChild(_CMNameText);
         _nameText = ComponentFactory.Instance.creatComponentByStylename("IM.CMFriendListItem.CMname");
         addChild(_nameText);
         _iconBg = ComponentFactory.Instance.creatBitmap("asset.IM.Noname");
         addChild(_iconBg);
         _iconLight = ComponentFactory.Instance.creatBitmap("asset.IM.iconLight");
         addChild(_iconLight);
         _iconSprite = new Sprite();
         _iconSprite.graphics.beginFill(0,0);
         _iconSprite.graphics.drawRect(_iconBg.x,_iconBg.y,_iconBg.width,_iconBg.height);
         _iconSprite.graphics.endFill();
         addChild(_iconSprite);
         _privateChatBtn = ComponentFactory.Instance.creat("IM.CMFriendListItem.privateChatBtn");
         _privateChatBtn.tipData = LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.private");
         _privateChatBtn.visible = false;
         addChild(_privateChatBtn);
         _addFriendBtn = ComponentFactory.Instance.creat("IM.CMFriendListItem.addFriendBtn");
         _addFriendBtn.tipData = LanguageMgr.GetTranslation("tank.view.im.IMFriendList.addFriend");
         _addFriendBtn.visible = false;
         addChild(_addFriendBtn);
         _inviteBtn = ComponentFactory.Instance.creat("IM.CMFriendListItem.inviteBtn");
         _inviteBtn.tipData = LanguageMgr.GetTranslation("im.IMView.inviteBtnText");
         _inviteBtn.visible = false;
         addChild(_inviteBtn);
         _load = new Loader();
         _load.contentLoaderInfo.addEventListener("complete",__loadCompleteHandler);
         _load.contentLoaderInfo.addEventListener("ioError",__loadIoErrorHandler);
      }
      
      private function __loadIoErrorHandler(param1:IOErrorEvent) : void
      {
      }
      
      private function __loadCompleteHandler(param1:Event) : void
      {
         ObjectUtils.disposeObject(_icon);
         if(!_load.content)
         {
            return;
         }
         _icon = _load.content as Bitmap;
         _icon.scaleX = 35 / _icon.width;
         _icon.scaleY = 35 / _icon.height;
         _icon.x = _iconBg.x;
         _icon.y = _iconBg.y;
         addChild(_icon);
         dispatchEvent(new Event("complete"));
      }
      
      protected function loadIcon() : void
      {
         var _loc1_:URLRequest = new URLRequest(_info.Photo);
         _load.load(_loc1_,_loaderContext);
      }
      
      private function __complete(param1:LoaderEvent) : void
      {
         _loader.removeEventListener("complete",__complete);
         var _loc2_:DisplayLoader = param1.target as DisplayLoader;
         ObjectUtils.disposeObject(_icon);
         if(_loc2_.isSuccess)
         {
            _icon = _loc2_.content as Bitmap;
            _icon.scaleX = 35 / _icon.width;
            _icon.scaleY = 35 / _icon.height;
            _icon.x = _iconBg.x;
            _icon.y = _iconBg.y;
            addChild(_icon);
         }
         dispatchEvent(new Event("complete"));
      }
      
      private function initEvent() : void
      {
         _privateChatBtn.addEventListener("click",__privateChat);
         _addFriendBtn.addEventListener("click",__addFriend);
         _inviteBtn.addEventListener("click",__invite);
         if(PathManager.CommnuntyMicroBlog() && PathManager.CommnuntySinaSecondMicroBlog())
         {
            _iconSprite.addEventListener("click",_iconClick);
         }
      }
      
      private function __invite(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:InviteDialogFrame = ComponentFactory.Instance.creatComponentByStylename("InviteDialogFrame");
         _loc2_.setInfo(_info.UserName);
         _loc2_.show();
      }
      
      private function __addFriend(param1:MouseEvent) : void
      {
         IMManager.Instance.addFriend(_info.NickName);
      }
      
      private function __privateChat(param1:MouseEvent) : void
      {
         ChatManager.Instance.privateChatTo(_info.NickName);
      }
      
      private function _iconClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(!(PathManager.CommnuntyMicroBlog() && PathManager.CommnuntySinaSecondMicroBlog()))
         {
            return;
         }
         SoundManager.instance.play("008");
         dispatchEvent(new Event("change"));
         if(StringHelper.isNullOrEmpty(_info.PersonWeb))
         {
            return;
         }
         if(ExternalInterface.available && !DesktopManager.Instance.isDesktop)
         {
            _loc2_ = "function redict () {window.open(\"" + _info.PersonWeb + "\", \"_blank\")}";
            ExternalInterface.call(_loc2_);
         }
         else
         {
            navigateToURL(new URLRequest(encodeURI(_info.PersonWeb)),"_blank");
         }
      }
      
      private function __itemOver(param1:MouseEvent) : void
      {
         _bg.setFrame(2);
         if(_info && _info.IsExist)
         {
            _privateChatBtn.visible = true;
            _addFriendBtn.visible = true;
            _inviteBtn.visible = false;
         }
         else
         {
            _privateChatBtn.visible = false;
            _addFriendBtn.visible = false;
            if(PathManager.CommunityFriendInvitedSwitch())
            {
               _inviteBtn.visible = true;
            }
            else
            {
               _inviteBtn.visible = false;
            }
         }
      }
      
      private function __itemOut(param1:MouseEvent) : void
      {
         if(_info && !_info.isSelected)
         {
            _bg.setFrame(1);
         }
         _privateChatBtn.visible = false;
         _addFriendBtn.visible = false;
         _inviteBtn.visible = false;
      }
      
      public function itemOver() : void
      {
         _bg.setFrame(2);
         if(_info && _info.IsExist)
         {
            _privateChatBtn.visible = true;
            _addFriendBtn.visible = true;
            _inviteBtn.visible = false;
         }
         else
         {
            _privateChatBtn.visible = false;
            _addFriendBtn.visible = false;
            if(PathManager.CommunityFriendInvitedSwitch())
            {
               _inviteBtn.visible = true;
            }
            else
            {
               _inviteBtn.visible = false;
            }
         }
      }
      
      public function itemOut() : void
      {
         if(_info && !_info.isSelected)
         {
            _bg.setFrame(1);
         }
         _privateChatBtn.visible = false;
         _addFriendBtn.visible = false;
         _inviteBtn.visible = false;
      }
      
      private function update() : void
      {
         if(_info && _info.IsExist)
         {
            var _loc1_:* = true;
            _CMNameText.visible = _loc1_;
            _loc1_ = _loc1_;
            _nameText.visible = _loc1_;
            _loc1_ = _loc1_;
            _levelIcon.visible = _loc1_;
            _sexIcon.visible = _loc1_;
            _nameText.text = _info.NickName;
            _CMNameText.text = _info.OtherName;
            _CMNameText.y = 2;
            _levelIcon.setInfo(_info.level,0,0,0,0,0,0,false);
            _sexIcon.setSex(_info.sex);
         }
         else
         {
            _loc1_ = false;
            _nameText.visible = _loc1_;
            _loc1_ = _loc1_;
            _levelIcon.visible = _loc1_;
            _sexIcon.visible = _loc1_;
            _CMNameText.text = _info.OtherName;
            _CMNameText.y = 15;
         }
         loadIcon();
         if(_info && _info.isSelected)
         {
            _bg.setFrame(2);
         }
         else
         {
            _bg.setFrame(1);
         }
      }
      
      public function set info(param1:CMFriendInfo) : void
      {
         _info = param1;
         update();
      }
      
      public function get info() : CMFriendInfo
      {
         return _info;
      }
      
      public function dispose() : void
      {
         removeEventListener("mouseOver",__itemOver);
         removeEventListener("mouseOut",__itemOut);
         _privateChatBtn.removeEventListener("click",__privateChat);
         _addFriendBtn.removeEventListener("click",__addFriend);
         _inviteBtn.removeEventListener("click",__invite);
         if(_load && _load.contentLoaderInfo)
         {
            _load.contentLoaderInfo.removeEventListener("complete",__loadCompleteHandler);
            _load.contentLoaderInfo.removeEventListener("ioError",__loadIoErrorHandler);
         }
         _load = null;
         _loaderContext = null;
         if(_addFriendBtn)
         {
            _addFriendBtn.dispose();
            _addFriendBtn = null;
         }
         if(_privateChatBtn)
         {
            _privateChatBtn.dispose();
            _privateChatBtn = null;
         }
         if(_inviteBtn)
         {
            _inviteBtn.dispose();
            _inviteBtn = null;
         }
         if(_bg && _bg.parent)
         {
            _bg.parent.removeChild(_bg);
            _bg.dispose();
            _bg = null;
         }
         if(_levelIcon && _levelIcon.parent)
         {
            _levelIcon.parent.removeChild(_levelIcon);
            _levelIcon.dispose();
            _levelIcon = null;
         }
         if(_sexIcon && _sexIcon.parent)
         {
            _sexIcon.parent.removeChild(_sexIcon);
            _sexIcon.dispose();
            _sexIcon = null;
         }
         if(_nameText && _nameText.parent)
         {
            _nameText.parent.removeChild(_nameText);
            _nameText.dispose();
            _nameText = null;
         }
         if(_CMNameText && _CMNameText.parent)
         {
            _CMNameText.parent.removeChild(_CMNameText);
            _CMNameText.dispose();
            _CMNameText = null;
         }
         if(_iconBg && _iconBg.bitmapData)
         {
            _iconBg.bitmapData.dispose();
            _iconBg = null;
         }
         if(_iconLight && _iconLight.bitmapData)
         {
            _iconLight.bitmapData.dispose();
            _iconLight = null;
         }
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         _loader = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
