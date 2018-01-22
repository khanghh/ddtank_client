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
      
      private function __inputClick(param1:MouseEvent) : void
      {
         strTest();
      }
      
      private function __stageClick(param1:MouseEvent) : void
      {
         if(DisplayUtils.isTargetOrContain(param1.target as DisplayObject,_inputText) || param1.target is ScaleFrameImage || param1.target is PlayerTip || param1.target is SimpleBitmapButton)
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
      
      private function __stopEvent(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function __cleanUpClick(param1:MouseEvent) : void
      {
         _inputText.text = "";
         strTest();
         SoundManager.instance.play("008");
      }
      
      private function __updateList(param1:Event) : void
      {
         if(_list && _list.visible)
         {
            strTest();
         }
      }
      
      private function __textInput(param1:Event) : void
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
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _loc5_ = 0;
         while(_loc5_ < _currentList.length)
         {
            if(_itemArray.length >= 8)
            {
               setFlexBg();
               return;
            }
            _loc3_ = "";
            _loc4_ = "";
            if(_currentList[_loc5_] is PlayerInfo)
            {
               _loc3_ = (_currentList[_loc5_] as PlayerInfo).NickName;
               _loc4_ = _inputText.text;
            }
            else if(_currentList[_loc5_] is ConsortiaPlayerInfo)
            {
               _loc3_ = (_currentList[_loc5_] as ConsortiaPlayerInfo).NickName;
               _loc4_ = _inputText.text;
            }
            if(_loc4_ == "")
            {
               setFlexBg();
               return;
            }
            if(!_loc3_)
            {
               setFlexBg();
               return;
            }
            if(_loc3_.indexOf(_inputText.text) != -1)
            {
               if(_currentList[_loc5_] is PlayerInfo)
               {
                  _loc2_ = new IMLookupItem(_currentList[_loc5_] as PlayerInfo);
                  _loc2_.addEventListener("click",__clickHandler);
                  _list.addChild(_loc2_);
                  _itemArray.push(_loc2_);
               }
               else if(_currentList[_loc5_] is ConsortiaPlayerInfo)
               {
                  if(testAlikeName((_currentList[_loc5_] as ConsortiaPlayerInfo).NickName))
                  {
                     _loc1_ = new IMLookupItem(_currentList[_loc5_] as ConsortiaPlayerInfo);
                     _loc1_.addEventListener("click",__clickHandler);
                     _list.addChild(_loc1_);
                     _itemArray.push(_loc1_);
                  }
               }
            }
            _loc5_++;
         }
      }
      
      private function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         ChatManager.Instance.privateChatTo((param1.currentTarget as IMLookupItem).info.NickName,(param1.currentTarget as IMLookupItem).info.ID);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         _currentItemInfo = (param1.currentTarget as IMLookupItem).info;
         dispatchEvent(new Event("change"));
      }
      
      private function CMFriendStrTest() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = null;
         _loc4_ = 0;
         while(_loc4_ < _currentList.length)
         {
            if(_itemArray.length >= 8)
            {
               setFlexBg();
               return;
            }
            _loc3_ = (_currentList[_loc4_] as CMFriendInfo).NickName;
            if(_loc3_ == "")
            {
               _loc3_ = (_currentList[_loc4_] as CMFriendInfo).OtherName;
            }
            _loc1_ = _inputText.text;
            if(_loc1_ == "")
            {
               setFlexBg();
               return;
            }
            if(_loc3_.indexOf(_inputText.text) != -1)
            {
               _loc2_ = new IMLookupItem(_currentList[_loc4_] as CMFriendInfo);
               _loc2_.addEventListener("click",__clickHandler);
               _list.addChild(_loc2_);
               _itemArray.push(_loc2_);
            }
            _loc4_++;
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
         var _loc1_:int = 0;
         if(_itemArray)
         {
            _loc1_ = 0;
            while(_loc1_ < _itemArray.length)
            {
               (_itemArray[_loc1_] as IMLookupItem).removeEventListener("click",__clickHandler);
               (_itemArray[_loc1_] as IMLookupItem).dispose();
               _loc1_++;
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
      
      private function testAlikeName(param1:String) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc2_ = PlayerManager.Instance.friendList.list;
         _loc2_ = _loc2_.concat(PlayerManager.Instance.blackList.list);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if((_loc2_[_loc3_] as FriendListPlayer).NickName == param1)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function set listType(param1:int) : void
      {
         _listType = param1;
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
