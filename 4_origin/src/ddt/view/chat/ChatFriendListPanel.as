package ddt.view.chat
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.player.BasePlayer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ChatFriendListPanel extends ChatBasePanel implements Disposeable
   {
      
      public static const FRIEND:uint = 0;
      
      public static const CONSORTIA:uint = 1;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _btnConsortia:SelectedTextButton;
      
      private var _btnFriend:SelectedTextButton;
      
      private var _func:Function;
      
      private var _playerList:ListPanel;
      
      private var _showOffLineList:Boolean;
      
      private var _currentType:uint;
      
      public function ChatFriendListPanel()
      {
         super();
      }
      
      public function setup(fun:Function, showOffLineList:Boolean = true) : void
      {
         _func = fun;
         _showOffLineList = showOffLineList;
         __onFriendListComplete();
      }
      
      public function set currentType(value:int) : void
      {
         _currentType = value;
         _btnGroup.selectIndex = _currentType;
         updateBtns();
      }
      
      private function updateBtns() : void
      {
         _btnFriend.buttonMode = _btnGroup.selectIndex == 1;
         _btnConsortia.buttonMode = !_btnFriend.buttonMode;
      }
      
      public function refreshAllList() : void
      {
         _btnGroup.selectIndex = 0;
         __onFriendListComplete();
      }
      
      override public function set visible(value:Boolean) : void
      {
         .super.visible = value;
      }
      
      override protected function __hideThis(event:MouseEvent) : void
      {
         if(!(event.target is ScaleBitmapImage) && !(event.target is BaseButton))
         {
            SoundManager.instance.play("008");
            setVisible = false;
            if(parent)
            {
               parent.removeChild(this);
            }
         }
      }
      
      private function __btnsClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         e.stopImmediatePropagation();
         if(e.currentTarget == _btnFriend)
         {
            __onFriendListComplete();
            _currentType = 0;
         }
         else
         {
            !!_showOffLineList?setList(ConsortionModelManager.Instance.model.memberList.list):setList(ConsortionModelManager.Instance.model.onlineConsortiaMemberList);
            _currentType = 1;
         }
      }
      
      private function _scrollClick(e:MouseEvent) : void
      {
         e.stopImmediatePropagation();
      }
      
      private function __onFriendListComplete(e:Event = null) : void
      {
      }
      
      private function __updateConsortiaList(e:Event) : void
      {
         setList(ConsortionModelManager.Instance.model.onlineConsortiaMemberList);
      }
      
      private function __updateFriendList(e:Event) : void
      {
         setList(PlayerManager.Instance.onlineFriendList);
      }
      
      override protected function init() : void
      {
         super.init();
         _btnGroup = new SelectedButtonGroup();
         _bg = ComponentFactory.Instance.creatComponentByStylename("chat.FriendListBg");
         _playerList = ComponentFactory.Instance.creatComponentByStylename("chat.FriendList");
         _btnFriend = ComponentFactory.Instance.creatComponentByStylename("chat.FriendListFriendBtn");
         _btnConsortia = ComponentFactory.Instance.creatComponentByStylename("chat.FriendListConsortiaBtn");
         _btnFriend.text = LanguageMgr.GetTranslation("chat.ChatFriendList.FriendBtnTxt");
         _btnConsortia.text = LanguageMgr.GetTranslation("chat.ChatFriendList.ConsortiaBtnTxt");
         _btnGroup.addSelectItem(_btnFriend);
         _btnGroup.addSelectItem(_btnConsortia);
         _btnGroup.selectIndex = 0;
         var _loc1_:Boolean = false;
         _btnConsortia.displacement = _loc1_;
         _btnFriend.displacement = _loc1_;
         addChild(_bg);
         addChild(_btnFriend);
         addChild(_btnConsortia);
         addChild(_playerList);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _btnFriend.addEventListener("click",__btnsClick);
         _btnConsortia.addEventListener("click",__btnsClick);
         _playerList.list.addEventListener("listItemClick",__itemClick);
         PlayerManager.Instance.addEventListener("friendListComplete",__onFriendListComplete);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _btnFriend.removeEventListener("click",__btnsClick);
         _btnConsortia.removeEventListener("click",__btnsClick);
         _playerList.list.removeEventListener("listItemClick",__itemClick);
         PlayerManager.Instance.removeEventListener("friendListComplete",__onFriendListComplete);
      }
      
      private function setList(list:Array) : void
      {
         _playerList.vectorListModel.clear();
         _playerList.vectorListModel.appendAll(list);
         _playerList.list.updateListView();
         updateBtns();
      }
      
      private function __itemClick(event:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         var player:BasePlayer = event.cellValue as BasePlayer;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _func = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_btnGroup)
         {
            ObjectUtils.disposeObject(_btnGroup);
         }
         _btnGroup = null;
         if(_btnConsortia)
         {
            ObjectUtils.disposeObject(_btnConsortia);
         }
         _btnConsortia = null;
         if(_btnFriend)
         {
            ObjectUtils.disposeObject(_btnFriend);
         }
         _btnFriend = null;
         if(_playerList)
         {
            ObjectUtils.disposeObject(_playerList);
         }
         _playerList = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
