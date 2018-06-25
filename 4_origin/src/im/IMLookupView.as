package im
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.CMFriendInfo;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.PlayerTip;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class IMLookupView extends Sprite implements Disposeable
   {
       
      
      public const MAX_ITEM_NUM:int = 8;
      
      public const ITEM_MAX_HEIGHT:int = 33;
      
      public const ITEM_MIN_HEIGHT:int = 28;
      
      private var _bg:Scale9CornerImage;
      
      private var _cleanUpBtn:BaseButton;
      
      private var _inputText:TextInput;
      
      private var _bg2:ScaleBitmapImage;
      
      private var _currentList:Array;
      
      private var _itemArray:Array;
      
      private var _listType:int;
      
      private var _currentItemInfo;
      
      private var _currentItem:IMLookupItem;
      
      private var _list:VBox;
      
      private var _NAN:FilterFrameText;
      
      private var _lookBtn:Bitmap;
      
      public function IMLookupView()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("im.Browse.baiduBG");
         addChild(_bg);
         _lookBtn = ComponentFactory.Instance.creatBitmap("asset.core.searchIcon");
         PositionUtils.setPos(_lookBtn,"ListItemView.lookBtn");
         addChild(_lookBtn);
         _cleanUpBtn = ComponentFactory.Instance.creatComponentByStylename("IM.IMLookup.cleanUpBtn");
         _cleanUpBtn.visible = false;
         addChild(_cleanUpBtn);
         _inputText = ComponentFactory.Instance.creatComponentByStylename("IM.IMLookup.textinput");
         addChild(_inputText);
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("IM.IMLookup.lookUpBG");
         _bg2.visible = false;
         addChild(_bg2);
         _list = ComponentFactory.Instance.creat("IM.IMLookup.lookupList");
         addChild(_list);
         _NAN = ComponentFactory.Instance.creatComponentByStylename("IM.IMLookup.IMLookupItemName");
         _NAN.text = LanguageMgr.GetTranslation("ddt.FriendDropListCell.noFriend");
         _NAN.visible = false;
         _NAN.x = _bg2.x + 10;
         _NAN.y = _bg2.y + 7;
         addChild(_NAN);
      }
      
      private function initEvent() : void
      {
         _inputText.addEventListener("change",__textInput);
         _inputText.addEventListener("click",__inputClick);
         _inputText.addEventListener("keyDown",__stopEvent);
         PlayerManager.Instance.friendList.addEventListener("remove",__updateList);
         if(PlayerManager.Instance.blackList)
         {
            PlayerManager.Instance.blackList.addEventListener("remove",__updateList);
         }
         if(PlayerManager.Instance.recentContacts)
         {
            PlayerManager.Instance.recentContacts.addEventListener("remove",__updateList);
         }
         _cleanUpBtn.addEventListener("click",__cleanUpClick);
         StageReferance.stage.addEventListener("click",__stageClick);
      }
      
      private function __inputClick(event:MouseEvent) : void
      {
         strTest();
      }
      
      private function __stageClick(event:MouseEvent) : void
      {
         if(DisplayUtils.isTargetOrContain(event.target as DisplayObject,_inputText) || event.target is ScaleFrameImage || event.target is PlayerTip || event.target is SimpleBitmapButton)
         {
            return;
         }
         hide();
      }
      
      private function hide() : void
      {
         _bg2.visible = false;
         _NAN.visible = false;
         _cleanUpBtn.visible = false;
         _list.visible = false;
         _lookBtn.visible = true;
      }
      
      private function __stopEvent(event:KeyboardEvent) : void
      {
         event.stopImmediatePropagation();
         event.stopPropagation();
      }
      
      private function __cleanUpClick(event:MouseEvent) : void
      {
         _inputText.text = "";
         strTest();
         SoundManager.instance.play("008");
      }
      
      private function __updateList(event:Event) : void
      {
         if(_list && _list.visible)
         {
            strTest();
         }
      }
      
      private function __textInput(event:Event) : void
      {
         strTest();
      }
      
      private function strTest() : void
      {
         disposeItems();
         updateList();
         if(_listType == 0)
         {
            friendStrTest();
         }
         else if(_listType == 2)
         {
            CMFriendStrTest();
         }
         setFlexBg();
      }
      
      private function friendStrTest() : void
      {
         var i:int = 0;
         var name:* = null;
         var temp:* = null;
         var item:* = null;
         var itemI:* = null;
         for(i = 0; i < _currentList.length; )
         {
            if(_itemArray.length >= 8)
            {
               setFlexBg();
               return;
            }
            name = "";
            temp = "";
            if(_currentList[i] is PlayerInfo)
            {
               name = (_currentList[i] as PlayerInfo).NickName;
               temp = _inputText.text;
            }
            else if(_currentList[i] is ConsortiaPlayerInfo)
            {
               name = (_currentList[i] as ConsortiaPlayerInfo).NickName;
               temp = _inputText.text;
            }
            if(temp == "")
            {
               setFlexBg();
               return;
            }
            if(!name)
            {
               setFlexBg();
               return;
            }
            if(name.indexOf(_inputText.text) != -1)
            {
               if(_currentList[i] is PlayerInfo)
               {
                  item = new IMLookupItem(_currentList[i] as PlayerInfo);
                  item.addEventListener("click",__clickHandler);
                  _list.addChild(item);
                  _itemArray.push(item);
               }
               else if(_currentList[i] is ConsortiaPlayerInfo)
               {
                  if(testAlikeName((_currentList[i] as ConsortiaPlayerInfo).NickName))
                  {
                     itemI = new IMLookupItem(_currentList[i] as ConsortiaPlayerInfo);
                     itemI.addEventListener("click",__clickHandler);
                     _list.addChild(itemI);
                     _itemArray.push(itemI);
                  }
               }
            }
            i++;
         }
      }
      
      private function __doubleClickHandler(event:InteractiveEvent) : void
      {
         ChatManager.Instance.privateChatTo((event.currentTarget as IMLookupItem).info.NickName,(event.currentTarget as IMLookupItem).info.ID);
      }
      
      private function __clickHandler(event:MouseEvent) : void
      {
         _currentItemInfo = (event.currentTarget as IMLookupItem).info;
         dispatchEvent(new Event("change"));
      }
      
      private function CMFriendStrTest() : void
      {
         var j:int = 0;
         var name:* = null;
         var tempII:* = null;
         var item:* = null;
         for(j = 0; j < _currentList.length; )
         {
            if(_itemArray.length >= 8)
            {
               setFlexBg();
               return;
            }
            name = (_currentList[j] as CMFriendInfo).NickName;
            if(name == "")
            {
               name = (_currentList[j] as CMFriendInfo).OtherName;
            }
            tempII = _inputText.text;
            if(tempII == "")
            {
               setFlexBg();
               return;
            }
            if(name.indexOf(_inputText.text) != -1)
            {
               item = new IMLookupItem(_currentList[j] as CMFriendInfo);
               item.addEventListener("click",__clickHandler);
               _list.addChild(item);
               _itemArray.push(item);
            }
            j++;
         }
      }
      
      private function setFlexBg() : void
      {
         if(_inputText.text == "")
         {
            _bg2.visible = false;
            _NAN.visible = false;
            _cleanUpBtn.visible = false;
            _lookBtn.visible = true;
         }
         else if(_inputText.text != "" && _itemArray.length == 0)
         {
            _bg2.visible = true;
            _bg2.height = 33;
            _NAN.visible = true;
            _cleanUpBtn.visible = true;
            _list.visible = true;
            _lookBtn.visible = false;
         }
         else
         {
            _NAN.visible = false;
            _cleanUpBtn.visible = true;
            _bg2.visible = true;
            _list.visible = true;
            _lookBtn.visible = false;
            if(_itemArray)
            {
               _bg2.height = _itemArray.length * 28 == 0?33:_itemArray.length * 28;
            }
         }
      }
      
      private function disposeItems() : void
      {
         var i:int = 0;
         if(_itemArray)
         {
            for(i = 0; i < _itemArray.length; )
            {
               (_itemArray[i] as IMLookupItem).removeEventListener("click",__clickHandler);
               (_itemArray[i] as IMLookupItem).dispose();
               i++;
            }
         }
         _list.disposeAllChildren();
         _itemArray = [];
      }
      
      private function updateList() : void
      {
         if(_listType == 0)
         {
            _currentList = [];
            _currentList = PlayerManager.Instance.friendList.list;
            _currentList = _currentList.concat(ConsortionModelManager.Instance.model.memberList.list);
            if(PlayerManager.Instance.blackList && PlayerManager.Instance.blackList.list)
            {
               _currentList = _currentList.concat(PlayerManager.Instance.blackList.list);
            }
            if(PlayerManager.Instance.recentContacts && PlayerManager.Instance.recentContacts.list)
            {
               _currentList = _currentList.concat(IMControl.Instance.getRecentContactsStranger());
            }
         }
         else if(_listType == 2)
         {
            _currentList = [];
            if(!PlayerManager.Instance.CMFriendList)
            {
               return;
            }
            _currentList = PlayerManager.Instance.CMFriendList.list;
         }
      }
      
      private function testAlikeName(name:String) : Boolean
      {
         var i:int = 0;
         var temList:Array = [];
         temList = PlayerManager.Instance.friendList.list;
         temList = temList.concat(PlayerManager.Instance.blackList.list);
         for(i = 0; i < temList.length; )
         {
            if((temList[i] as FriendListPlayer).NickName == name)
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function set listType(value:int) : void
      {
         _listType = value;
         updateList();
      }
      
      public function get currentItemInfo() : *
      {
         return _currentItemInfo;
      }
      
      public function dispose() : void
      {
         _inputText.removeEventListener("change",__textInput);
         _inputText.removeEventListener("click",__inputClick);
         _inputText.removeEventListener("keyDown",__stopEvent);
         PlayerManager.Instance.friendList.removeEventListener("remove",__updateList);
         if(PlayerManager.Instance.blackList)
         {
            PlayerManager.Instance.blackList.removeEventListener("remove",__updateList);
         }
         if(PlayerManager.Instance.recentContacts)
         {
            PlayerManager.Instance.recentContacts.addEventListener("remove",__updateList);
         }
         _cleanUpBtn.removeEventListener("click",__cleanUpClick);
         StageReferance.stage.removeEventListener("click",__stageClick);
         disposeItems();
         if(_bg2)
         {
            _bg2.dispose();
            _bg2 = null;
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_cleanUpBtn)
         {
            _cleanUpBtn.dispose();
            _cleanUpBtn = null;
         }
         if(_inputText)
         {
            _inputText.dispose();
            _inputText = null;
         }
         if(_currentItem)
         {
            _currentItem.dispose();
            _currentItem = null;
         }
         if(_list)
         {
            _list.dispose();
            _list = null;
         }
         if(_NAN)
         {
            ObjectUtils.disposeObject(_NAN);
            _NAN = null;
         }
      }
   }
}
