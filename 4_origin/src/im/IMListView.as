package im
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.MD5;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerState;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.DragManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class IMListView extends Sprite implements Disposeable
   {
       
      
      private var _listPanel:ListPanel;
      
      private var _playerArray:Array;
      
      private var _titleList:Vector.<FriendListPlayer>;
      
      private var _currentItemInfo:FriendListPlayer;
      
      private var _currentTitleInfo:FriendListPlayer;
      
      private var _pos:int;
      
      private var _timer:Timer;
      
      private var _responseR:Sprite;
      
      private var _currentItem:IMListItemView;
      
      public function IMListView()
      {
         super();
         init();
         initEvent();
      }
      
      public function get playerArray() : Array
      {
         return _playerArray;
      }
      
      private function init() : void
      {
         IMManager.isInIM = true;
         initTitle();
         _timer = new Timer(200);
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("IM.IMlistPanel");
         _listPanel.vScrollProxy = 1;
         addChild(_listPanel);
         _listPanel.list.updateListView();
         _listPanel.list.addEventListener("listItemClick",__itemClick);
         _currentTitleInfo = _titleList[1];
         _responseR = new Sprite();
         _responseR.graphics.beginFill(16777215,0);
         _responseR.graphics.drawRect(0,0,_listPanel.width,_listPanel.height);
         _responseR.graphics.endFill();
         addChild(_responseR);
         _responseR.mouseChildren = false;
         _responseR.mouseEnabled = false;
         updateList();
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.addEventListener("mark",onMarkClick);
         PlayerManager.Instance.recentContacts.addEventListener("remove",__removeRecentContact);
         PlayerManager.Instance.friendList.addEventListener("add",__addItem);
         PlayerManager.Instance.friendList.addEventListener("remove",__removeItem);
         PlayerManager.Instance.friendList.addEventListener("update",__updateItem);
         PlayerManager.Instance.blackList.addEventListener("remove",__removeItem);
         PlayerManager.Instance.blackList.addEventListener("update",__updateItem);
         PlayerManager.Instance.blackList.addEventListener("add",__addBlackItem);
         _listPanel.list.addEventListener("listItemClick",__itemClick);
         _listPanel.list.addEventListener("listItemMouseDown",__listItemDownHandler);
         _listPanel.list.addEventListener("listItemMouseUp",__listItemUpHandler);
         _listPanel.list.addEventListener("listItemRollOut",__listItemOutHandler);
         _responseR.addEventListener("dragInRangeTop",__topRangeHandler);
         _responseR.addEventListener("dragOutRangeButtom",__buttomRangeHandler);
         _timer.addEventListener("timer",__timerHandler);
         addEventListener("addedToStage",__addToStage);
         IMControl.Instance.addEventListener("addNewGroup",__addNewGroup);
         IMControl.Instance.addEventListener("updateGroup",__updaetGroup);
         IMControl.Instance.addEventListener("deleteGroup",__deleteGroup);
         SocketManager.Instance.addEventListener(PkgEvent.format(149,4),__onRegressCallApply);
      }
      
      protected function onMarkClick(param1:CEvent) : void
      {
      }
      
      protected function __deleteGroup(param1:Event) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _titleList.length)
         {
            if(_titleList[_loc2_].titleType == IMControl.Instance.deleteCustomID)
            {
               _titleList.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
         _currentTitleInfo.titleIsSelected = false;
         updateTitle();
         updateList();
      }
      
      protected function __updaetGroup(param1:Event) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _titleList.length)
         {
            if(_titleList[_loc2_].titleType == IMControl.Instance.customInfo.ID)
            {
               _titleList[_loc2_].titleText = IMControl.Instance.customInfo.Name;
               break;
            }
            _loc2_++;
         }
         _currentTitleInfo.titleIsSelected = false;
         updateTitle();
         updateList();
      }
      
      protected function __addNewGroup(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:FriendListPlayer = new FriendListPlayer();
         _loc2_.type = 0;
         _loc2_.titleType = IMControl.Instance.customInfo.ID;
         _loc2_.titleIsSelected = false;
         _loc2_.titleText = IMControl.Instance.customInfo.Name;
         if(_titleList.length == 4)
         {
            _titleList.splice(2,0,_loc2_);
            PlayerManager.Instance.customList.splice(1,0,IMControl.Instance.customInfo);
         }
         else
         {
            _loc3_ = 2;
            while(_loc3_ < _titleList.length - 2)
            {
               if(IMControl.Instance.customInfo.ID < _titleList[_loc3_].titleType)
               {
                  _titleList.splice(_loc3_,0,_loc2_);
                  PlayerManager.Instance.customList.splice(_loc3_ - 1,0,IMControl.Instance.customInfo);
                  break;
               }
               if(_loc3_ == _titleList.length - 3)
               {
                  _titleList.splice(_loc3_ + 1,0,_loc2_);
                  PlayerManager.Instance.customList.splice(_loc3_,0,IMControl.Instance.customInfo);
                  break;
               }
               _loc3_++;
            }
         }
         updateTitle();
         updateList();
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.addEventListener("mark",onMarkClick);
         PlayerManager.Instance.recentContacts.removeEventListener("remove",__removeRecentContact);
         PlayerManager.Instance.friendList.removeEventListener("add",__addItem);
         PlayerManager.Instance.friendList.removeEventListener("remove",__removeItem);
         PlayerManager.Instance.friendList.removeEventListener("update",__updateItem);
         PlayerManager.Instance.blackList.removeEventListener("remove",__removeItem);
         PlayerManager.Instance.blackList.removeEventListener("update",__updateItem);
         PlayerManager.Instance.blackList.removeEventListener("add",__addBlackItem);
         _listPanel.list.removeEventListener("listItemClick",__itemClick);
         _listPanel.list.removeEventListener("listItemMouseDown",__listItemDownHandler);
         _listPanel.list.removeEventListener("listItemMouseUp",__listItemUpHandler);
         _listPanel.list.removeEventListener("listItemRollOut",__listItemOutHandler);
         _responseR.removeEventListener("dragInRangeTop",__topRangeHandler);
         _responseR.removeEventListener("dragOutRangeButtom",__buttomRangeHandler);
         _timer.removeEventListener("timer",__timerHandler);
         removeEventListener("addedToStage",__addToStage);
         IMControl.Instance.removeEventListener("addNewGroup",__addNewGroup);
         IMControl.Instance.removeEventListener("updateGroup",__updaetGroup);
         IMControl.Instance.removeEventListener("deleteGroup",__deleteGroup);
         SocketManager.Instance.removeEventListener(PkgEvent.format(149,4),__onRegressCallApply);
      }
      
      protected function __addToStage(param1:Event) : void
      {
         var _loc2_:Point = _listPanel.localToGlobal(new Point(0,0));
         _responseR.x = _loc2_.x;
         _responseR.y = _loc2_.y;
      }
      
      protected function __listItemOutHandler(param1:ListItemEvent) : void
      {
         _timer.stop();
      }
      
      protected function __listItemUpHandler(param1:ListItemEvent) : void
      {
         _timer.stop();
      }
      
      protected function __listItemDownHandler(param1:ListItemEvent) : void
      {
         _currentItem = param1.cell as IMListItemView;
         var _loc2_:FriendListPlayer = _currentItem.getCellValue() as FriendListPlayer;
         if(_loc2_.type == 1 && StateManager.currentStateType != "fighting" && StateManager.currentStateType != "fightLabGameView")
         {
            _timer.reset();
            _timer.start();
         }
      }
      
      protected function __onRegressCallApply(param1:PkgEvent) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc6_:int = _loc4_.readInt();
         if(_loc6_ != 1)
         {
            _currentItem.callBackBtn.enable = false;
            _currentItem.callBackBtn.mouseEnabled = true;
            _currentItem.info.callBtnEnable = false;
            trace("召唤老玩家处理");
            _loc3_ = new URLRequest(PathManager.callBackInterfacePath());
            _loc5_ = new URLVariables();
            _loc5_["gname"] = PlayerManager.Instance.Self.NickName;
            _loc5_["user2"] = _currentItem.info.LoginName;
            _loc5_["gname2"] = _currentItem.info.NickName;
            _loc5_["area"] = _currentItem.info.ZoneID;
            _loc5_["token"] = MD5.hash(PlayerManager.Instance.Self.LoginName + "d!d@t#z$h" + _currentItem.info.LoginName);
            _loc3_.method = "POST";
            _loc3_.data = _loc5_;
            _loc2_ = new URLLoader();
            _loc2_.addEventListener("complete",__onComplete);
            _loc2_.load(_loc3_);
         }
      }
      
      protected function __onComplete(param1:Event) : void
      {
         var _loc2_:int = param1.target.data;
         switch(int(_loc2_))
         {
            case 0:
               trace("验证未通过");
               break;
            case 1:
               _currentItem.callBackBtn.enable = false;
               _currentItem.callBackBtn.mouseEnabled = true;
               _currentItem.info.callBtnEnable = false;
               break;
            case 2:
               trace("总次数超过10次");
               break;
            case 3:
               trace("请求用户已经登记召回");
               break;
            case 4:
               trace("被召唤玩家收到召唤消息超过3次");
         }
      }
      
      protected function __topRangeHandler(param1:Event) : void
      {
         _listPanel.setViewPosition(-1);
      }
      
      protected function __buttomRangeHandler(param1:Event) : void
      {
         _listPanel.setViewPosition(1);
      }
      
      protected function __timerHandler(param1:TimerEvent) : void
      {
         _timer.stop();
         var _loc2_:Point = _listPanel.localToGlobal(new Point(0,0));
         _responseR.x = _loc2_.x;
         _responseR.y = _loc2_.y;
         DragManager.startDrag(_currentItem,_currentItem.getCellValue(),createImg(),stage.mouseX,stage.mouseY,"move",true,false,false,true,true,_responseR,_currentItem.height + 10);
         showTitle();
      }
      
      private function createImg() : DisplayObject
      {
         var _loc2_:Bitmap = new Bitmap(new BitmapData(_currentItem.width - 6,_currentItem.height - 6,false,0),"auto",true);
         var _loc1_:Matrix = new Matrix(1,0,0,1,-2,-2);
         _loc2_.bitmapData.draw(_currentItem,_loc1_);
         return _loc2_;
      }
      
      private function initTitle() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         _titleList = new Vector.<FriendListPlayer>();
         var _loc5_:Vector.<CustomInfo> = PlayerManager.Instance.customList;
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc1_ = new FriendListPlayer();
            _loc1_.type = 0;
            _loc1_.titleType = _loc5_[_loc4_].ID;
            _loc1_.titleIsSelected = false;
            if(_loc4_ == _loc5_.length - 1)
            {
               _loc1_.titleNumText = "[0/" + String(PlayerManager.Instance.blackList.length) + "]";
            }
            else
            {
               _loc1_.titleNumText = "[" + String(PlayerManager.Instance.getOnlineFriendForCustom(_loc5_[_loc4_].ID).length) + "/" + String(PlayerManager.Instance.getFriendForCustom(_loc5_[_loc4_].ID).length) + "]";
            }
            _loc1_.titleText = _loc5_[_loc4_].Name;
            _titleList.push(_loc1_);
            _loc4_++;
         }
         var _loc2_:FriendListPlayer = new FriendListPlayer();
         _loc2_.type = 0;
         _loc2_.titleType = 2;
         _loc2_.titleIsSelected = false;
         _loc2_.titleNumText = "[" + String(PlayerManager.Instance.onlineRecentContactList.length) + "/" + String(PlayerManager.Instance.recentContacts.length) + "]";
         _loc2_.titleText = LanguageMgr.GetTranslation("tank.game.ToolStripView.recentContact");
         _titleList.unshift(_loc2_);
         var _loc3_:FriendListPlayer = new FriendListPlayer();
         _loc3_.type = 0;
         _loc3_.titleType = 3;
         _loc3_.titleText = LanguageMgr.GetTranslation("tank.game.IM.custom");
         _titleList.push(_loc3_);
         _titleList[1].titleIsSelected = true;
      }
      
      private function __addBlackItem(param1:DictionaryEvent) : void
      {
         if(_currentTitleInfo.titleType == 1 && _currentTitleInfo.titleIsSelected == true && _listPanel && _listPanel.vectorListModel)
         {
            _listPanel.vectorListModel.append(param1.data,getInsertIndex(param1.data as FriendListPlayer));
            updateTitle();
            _listPanel.list.updateListView();
         }
         else
         {
            updateTitle();
            _listPanel.list.updateListView();
         }
      }
      
      private function __updateItem(param1:DictionaryEvent) : void
      {
         updateTitle();
         updateList();
      }
      
      private function __addItem(param1:DictionaryEvent) : void
      {
         if((_currentTitleInfo.titleType == 0 || _currentTitleInfo.titleType >= 10) && _currentTitleInfo.titleIsSelected == true && _listPanel && _listPanel.vectorListModel)
         {
            _listPanel.vectorListModel.append(param1.data,getInsertIndex(param1.data as FriendListPlayer));
            updateTitle();
            updateList();
            _listPanel.list.updateListView();
         }
         else
         {
            updateTitle();
            updateList();
            _listPanel.list.updateListView();
         }
      }
      
      private function __removeItem(param1:DictionaryEvent) : void
      {
         if(_listPanel && _listPanel.vectorListModel)
         {
            _listPanel.vectorListModel.remove(param1.data);
            updateTitle();
            _listPanel.list.updateListView();
         }
      }
      
      private function getInsertIndex(param1:FriendListPlayer) : int
      {
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc3_:Array = _listPanel.vectorListModel.elements;
         _loc5_ = 0;
         while(_loc5_ < _titleList.length)
         {
            if(_titleList[_loc5_].titleIsSelected)
            {
               _loc2_ = _loc5_ + 1;
            }
            _loc5_++;
         }
         if(_loc3_.length == _titleList.length)
         {
            return _loc2_;
         }
         if(_currentTitleInfo.titleType != 1 && _currentTitleInfo.titleIsSelected)
         {
            _loc6_ = 0;
            if(param1.playerState.StateID != 0)
            {
               _loc6_ = PlayerManager.Instance.getOnlineFriendForCustom(_currentTitleInfo.titleType).length + _loc2_ - 1;
               if(_loc6_ != 0)
               {
                  _loc9_ = _loc2_;
                  while(_loc9_ < _loc6_)
                  {
                     _loc4_ = _loc3_[_loc9_] as FriendListPlayer;
                     if(param1.IsVIP && _loc4_.IsVIP && param1.Grade < _loc4_.Grade)
                     {
                        _loc2_++;
                     }
                     if(!param1.IsVIP && _loc4_.IsVIP)
                     {
                        _loc2_++;
                     }
                     if(!param1.IsVIP && !_loc4_.IsVIP && param1.Grade < _loc4_.Grade)
                     {
                        _loc2_++;
                     }
                     _loc9_++;
                  }
               }
               return _loc2_;
            }
            _loc2_ = PlayerManager.Instance.getOnlineFriendForCustom(_currentTitleInfo.titleType).length + _loc2_;
            _loc6_ = PlayerManager.Instance.getOfflineFriendForCustom(_currentTitleInfo.titleType).length + _loc2_ - 1;
            if(_loc6_ != 0)
            {
               _loc7_ = _loc2_;
               while(_loc7_ < _loc6_)
               {
                  _loc4_ = _loc3_[_loc7_] as FriendListPlayer;
                  if(param1.Grade <= _loc4_.Grade)
                  {
                     _loc2_++;
                     _loc7_++;
                     continue;
                  }
                  break;
               }
            }
            return _loc2_;
         }
         _loc6_ = PlayerManager.Instance.blackList.length + _loc2_ - 1;
         if(_loc6_ != 0)
         {
            _loc8_ = _loc2_;
            while(_loc8_ < _loc6_)
            {
               _loc4_ = _loc3_[_loc8_] as FriendListPlayer;
               if(param1.Grade <= _loc4_.Grade)
               {
                  _loc2_++;
                  _loc8_++;
                  continue;
               }
               break;
            }
         }
         return _loc2_;
      }
      
      private function __removeRecentContact(param1:DictionaryEvent) : void
      {
         updateTitle();
         updateList();
      }
      
      private function updateTitle() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(PlayerManager.Instance.friendList)
         {
            _loc3_ = 1;
            while(_loc3_ < _titleList.length - 2)
            {
               _loc1_ = PlayerManager.Instance.getOnlineFriendForCustom(_titleList[_loc3_].titleType).length;
               _loc2_ = PlayerManager.Instance.getFriendForCustom(_titleList[_loc3_].titleType).length;
               _titleList[_loc3_].titleNumText = "[" + String(_loc1_) + "/" + String(_loc2_) + "]";
               _loc3_++;
            }
         }
         if(PlayerManager.Instance.blackList)
         {
            _titleList[_titleList.length - 2].titleNumText = "[0/" + String(PlayerManager.Instance.blackList.length) + "]";
         }
         if(PlayerManager.Instance.recentContacts)
         {
            _titleList[0].titleNumText = "[" + String(PlayerManager.Instance.onlineRecentContactList.length) + "/" + String(PlayerManager.Instance.recentContacts.length) + "]";
         }
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         var _loc2_:int = 0;
         if((param1.cellValue as FriendListPlayer).type == 1)
         {
            if(!_currentItemInfo)
            {
               _currentItemInfo = param1.cellValue as FriendListPlayer;
               _currentItemInfo.titleIsSelected = true;
            }
            if(_currentItemInfo != param1.cellValue as FriendListPlayer)
            {
               _currentItemInfo.titleIsSelected = false;
               _currentItemInfo = param1.cellValue as FriendListPlayer;
               _currentItemInfo.titleIsSelected = true;
            }
         }
         else
         {
            if(!_currentTitleInfo)
            {
               _currentTitleInfo = param1.cellValue as FriendListPlayer;
               _currentTitleInfo.titleIsSelected = true;
            }
            if(_currentTitleInfo != param1.cellValue as FriendListPlayer)
            {
               _currentTitleInfo.titleIsSelected = false;
               _currentTitleInfo = param1.cellValue as FriendListPlayer;
               _currentTitleInfo.titleIsSelected = true;
            }
            else
            {
               _currentTitleInfo.titleIsSelected = !_currentTitleInfo.titleIsSelected;
            }
            _loc2_ = 0;
            while(_loc2_ < _titleList.length)
            {
               if(_titleList[_loc2_] != _currentTitleInfo)
               {
                  _titleList[_loc2_].titleIsSelected = false;
               }
               _loc2_++;
            }
            updateList();
            SoundManager.instance.play("008");
         }
         _listPanel.list.updateListView();
      }
      
      private function updateList() : void
      {
         _pos = _listPanel.list.viewPosition.y;
         IMControl.Instance.titleType = _currentTitleInfo.titleType;
         if(_currentTitleInfo.titleType != 1 && _currentTitleInfo.titleType != 2 && _currentTitleInfo.titleIsSelected)
         {
            updateFriendList(_currentTitleInfo.titleType);
         }
         else if(_currentTitleInfo.titleType == 1 && _currentTitleInfo.titleIsSelected)
         {
            updateBlackList();
         }
         else if(_currentTitleInfo.titleType == 2 && _currentTitleInfo.titleIsSelected)
         {
            updateRecentContactList();
         }
         else if(!_currentTitleInfo.titleIsSelected)
         {
            showTitle();
         }
         updateTitle();
         _listPanel.list.updateListView();
         var _loc1_:IntPoint = new IntPoint(0,_pos);
         _listPanel.list.viewPosition = _loc1_;
      }
      
      private function showTitle() : void
      {
         var _loc1_:int = 0;
         _playerArray = [];
         _loc1_ = 0;
         while(_loc1_ < _titleList.length)
         {
            _playerArray.push(_titleList[_loc1_]);
            _titleList[_loc1_].titleIsSelected = false;
            _loc1_++;
         }
         _listPanel.vectorListModel.clear();
         _listPanel.vectorListModel.appendAll(_playerArray);
         _listPanel.list.updateListView();
      }
      
      private function updateFriendList(param1:int = 0) : void
      {
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc8_:* = null;
         var _loc7_:int = 0;
         _playerArray = [];
         var _loc6_:* = 0;
         _loc5_ = 0;
         while(_loc5_ < _titleList.length)
         {
            _playerArray.push(_titleList[_loc5_]);
            if(param1 == _titleList[_loc5_].titleType)
            {
               _loc6_ = _loc5_;
               break;
            }
            _loc5_++;
         }
         var _loc4_:Array = PlayerManager.Instance.getOnlineFriendForCustom(param1);
         var _loc3_:Array = [];
         var _loc2_:Array = [];
         _loc9_ = 0;
         while(_loc9_ < _loc4_.length)
         {
            _loc8_ = _loc4_[_loc9_] as FriendListPlayer;
            if(_loc8_.IsVIP)
            {
               _loc3_.push(_loc8_);
            }
            else
            {
               _loc2_.push(_loc8_);
            }
            _loc9_++;
         }
         _loc3_ = sort(_loc3_);
         _loc2_ = sort(_loc2_);
         _loc4_ = _loc3_.concat(_loc2_);
         _loc4_ = IMManager.Instance.sortAcademyPlayer(_loc4_);
         _playerArray = _playerArray.concat(_loc4_);
         _loc4_ = PlayerManager.Instance.getOfflineFriendForCustom(param1);
         _loc4_ = sort(_loc4_);
         _loc4_ = IMManager.Instance.sortAcademyPlayer(_loc4_);
         _playerArray = _playerArray.concat(_loc4_);
         _loc7_ = _loc6_ + 1;
         while(_loc7_ < _titleList.length)
         {
            _playerArray.push(_titleList[_loc7_]);
            _loc7_++;
         }
         _listPanel.vectorListModel.clear();
         _listPanel.vectorListModel.appendAll(_playerArray);
         _listPanel.list.updateListView();
      }
      
      private function updateBlackList() : void
      {
         var _loc2_:int = 0;
         _playerArray = [];
         _loc2_ = 0;
         while(_loc2_ < _titleList.length - 1)
         {
            _playerArray.push(_titleList[_loc2_]);
            _loc2_++;
         }
         var _loc1_:Array = PlayerManager.Instance.blackList.list;
         _playerArray = _playerArray.concat(_loc1_);
         _playerArray.push(_titleList[_titleList.length - 1]);
         _listPanel.vectorListModel.clear();
         _listPanel.vectorListModel.appendAll(_playerArray);
         _listPanel.list.updateListView();
      }
      
      private function updateRecentContactList() : void
      {
         var _loc3_:* = null;
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         _playerArray = [];
         _playerArray.unshift(_titleList[0]);
         var _loc2_:Array = [];
         var _loc1_:DictionaryData = PlayerManager.Instance.recentContacts;
         var _loc5_:Array = IMManager.Instance.recentContactsList;
         if(_loc5_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               if(_loc5_[_loc7_] != 0)
               {
                  _loc3_ = _loc1_[_loc5_[_loc7_]];
                  if(_loc3_ && _loc2_.indexOf(_loc3_) == -1)
                  {
                     if(PlayerManager.Instance.findPlayer(_loc3_.ID,PlayerManager.Instance.Self.ZoneID))
                     {
                        _loc4_ = new PlayerState(PlayerManager.Instance.findPlayer(_loc3_.ID,PlayerManager.Instance.Self.ZoneID).playerState.StateID);
                        _loc3_.playerState = _loc4_;
                     }
                     _loc2_.push(_loc3_);
                  }
               }
               _loc7_++;
            }
         }
         _playerArray = _playerArray.concat(_loc2_);
         _loc6_ = 1;
         while(_loc6_ < _titleList.length)
         {
            _playerArray.push(_titleList[_loc6_]);
            _loc6_++;
         }
         _listPanel.vectorListModel.clear();
         _listPanel.vectorListModel.appendAll(_playerArray);
         _listPanel.list.updateListView();
      }
      
      private function sort(param1:Array) : Array
      {
         return param1.sortOn("Grade",16 | 2);
      }
      
      public function dispose() : void
      {
         IMManager.isInIM = false;
         removeEvent();
         if(_listPanel && _listPanel.parent)
         {
            _listPanel.parent.removeChild(_listPanel);
            _listPanel.dispose();
            _listPanel = null;
         }
         if(_currentItemInfo)
         {
            _currentItemInfo.titleIsSelected = false;
         }
         if(_currentItem)
         {
            _currentItem.dispose();
            _currentItem = null;
         }
      }
      
      public function get currentItem() : IMListItemView
      {
         return _currentItem;
      }
      
      public function set currentItem(param1:IMListItemView) : void
      {
         _currentItem = param1;
      }
   }
}
