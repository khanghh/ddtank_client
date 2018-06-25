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
      
      protected function onMarkClick(e:CEvent) : void
      {
      }
      
      protected function __deleteGroup(event:Event) : void
      {
         var temp1:int = 0;
         for(temp1 = 0; temp1 < _titleList.length; )
         {
            if(_titleList[temp1].titleType == IMControl.Instance.deleteCustomID)
            {
               _titleList.splice(temp1,1);
               break;
            }
            temp1++;
         }
         _currentTitleInfo.titleIsSelected = false;
         updateTitle();
         updateList();
      }
      
      protected function __updaetGroup(event:Event) : void
      {
         var temp3:int = 0;
         for(temp3 = 0; temp3 < _titleList.length; )
         {
            if(_titleList[temp3].titleType == IMControl.Instance.customInfo.ID)
            {
               _titleList[temp3].titleText = IMControl.Instance.customInfo.Name;
               break;
            }
            temp3++;
         }
         _currentTitleInfo.titleIsSelected = false;
         updateTitle();
         updateList();
      }
      
      protected function __addNewGroup(event:Event) : void
      {
         var i:int = 0;
         var title:FriendListPlayer = new FriendListPlayer();
         title.type = 0;
         title.titleType = IMControl.Instance.customInfo.ID;
         title.titleIsSelected = false;
         title.titleText = IMControl.Instance.customInfo.Name;
         if(_titleList.length == 4)
         {
            _titleList.splice(2,0,title);
            PlayerManager.Instance.customList.splice(1,0,IMControl.Instance.customInfo);
         }
         else
         {
            i = 2;
            while(i < _titleList.length - 2)
            {
               if(IMControl.Instance.customInfo.ID < _titleList[i].titleType)
               {
                  _titleList.splice(i,0,title);
                  PlayerManager.Instance.customList.splice(i - 1,0,IMControl.Instance.customInfo);
                  break;
               }
               if(i == _titleList.length - 3)
               {
                  _titleList.splice(i + 1,0,title);
                  PlayerManager.Instance.customList.splice(i,0,IMControl.Instance.customInfo);
                  break;
               }
               i++;
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
      
      protected function __addToStage(event:Event) : void
      {
         var listpos:Point = _listPanel.localToGlobal(new Point(0,0));
         _responseR.x = listpos.x;
         _responseR.y = listpos.y;
      }
      
      protected function __listItemOutHandler(event:ListItemEvent) : void
      {
         _timer.stop();
      }
      
      protected function __listItemUpHandler(event:ListItemEvent) : void
      {
         _timer.stop();
      }
      
      protected function __listItemDownHandler(event:ListItemEvent) : void
      {
         _currentItem = event.cell as IMListItemView;
         var info:FriendListPlayer = _currentItem.getCellValue() as FriendListPlayer;
         if(info.type == 1 && StateManager.currentStateType != "fighting" && StateManager.currentStateType != "fightLabGameView")
         {
            _timer.reset();
            _timer.start();
         }
      }
      
      protected function __onRegressCallApply(event:PkgEvent) : void
      {
         var ur:* = null;
         var variable:* = null;
         var urlLoader:* = null;
         var pkg:PackageIn = event.pkg;
         var callID:int = pkg.readInt();
         if(callID != 1)
         {
            _currentItem.callBackBtn.enable = false;
            _currentItem.callBackBtn.mouseEnabled = true;
            _currentItem.info.callBtnEnable = false;
            trace("召唤老玩家处理");
            ur = new URLRequest(PathManager.callBackInterfacePath());
            variable = new URLVariables();
            variable["gname"] = PlayerManager.Instance.Self.NickName;
            variable["user2"] = _currentItem.info.LoginName;
            variable["gname2"] = _currentItem.info.NickName;
            variable["area"] = _currentItem.info.ZoneID;
            variable["token"] = MD5.hash(PlayerManager.Instance.Self.LoginName + "d!d@t#z$h" + _currentItem.info.LoginName);
            ur.method = "POST";
            ur.data = variable;
            urlLoader = new URLLoader();
            urlLoader.addEventListener("complete",__onComplete);
            urlLoader.load(ur);
         }
      }
      
      protected function __onComplete(event:Event) : void
      {
         var value:int = event.target.data;
         switch(int(value))
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
      
      protected function __topRangeHandler(event:Event) : void
      {
         _listPanel.setViewPosition(-1);
      }
      
      protected function __buttomRangeHandler(event:Event) : void
      {
         _listPanel.setViewPosition(1);
      }
      
      protected function __timerHandler(event:TimerEvent) : void
      {
         _timer.stop();
         var listpos:Point = _listPanel.localToGlobal(new Point(0,0));
         _responseR.x = listpos.x;
         _responseR.y = listpos.y;
         DragManager.startDrag(_currentItem,_currentItem.getCellValue(),createImg(),stage.mouseX,stage.mouseY,"move",true,false,false,true,true,_responseR,_currentItem.height + 10);
         showTitle();
      }
      
      private function createImg() : DisplayObject
      {
         var img:Bitmap = new Bitmap(new BitmapData(_currentItem.width - 6,_currentItem.height - 6,false,0),"auto",true);
         var martix:Matrix = new Matrix(1,0,0,1,-2,-2);
         img.bitmapData.draw(_currentItem,martix);
         return img;
      }
      
      private function initTitle() : void
      {
         var i:int = 0;
         var title:* = null;
         _titleList = new Vector.<FriendListPlayer>();
         var customList:Vector.<CustomInfo> = PlayerManager.Instance.customList;
         for(i = 0; i < customList.length; )
         {
            title = new FriendListPlayer();
            title.type = 0;
            title.titleType = customList[i].ID;
            title.titleIsSelected = false;
            if(i == customList.length - 1)
            {
               title.titleNumText = "[0/" + String(PlayerManager.Instance.blackList.length) + "]";
            }
            else
            {
               title.titleNumText = "[" + String(PlayerManager.Instance.getOnlineFriendForCustom(customList[i].ID).length) + "/" + String(PlayerManager.Instance.getFriendForCustom(customList[i].ID).length) + "]";
            }
            title.titleText = customList[i].Name;
            _titleList.push(title);
            i++;
         }
         var recentContactTitle:FriendListPlayer = new FriendListPlayer();
         recentContactTitle.type = 0;
         recentContactTitle.titleType = 2;
         recentContactTitle.titleIsSelected = false;
         recentContactTitle.titleNumText = "[" + String(PlayerManager.Instance.onlineRecentContactList.length) + "/" + String(PlayerManager.Instance.recentContacts.length) + "]";
         recentContactTitle.titleText = LanguageMgr.GetTranslation("tank.game.ToolStripView.recentContact");
         _titleList.unshift(recentContactTitle);
         var customTitle:FriendListPlayer = new FriendListPlayer();
         customTitle.type = 0;
         customTitle.titleType = 3;
         customTitle.titleText = LanguageMgr.GetTranslation("tank.game.IM.custom");
         _titleList.push(customTitle);
         _titleList[1].titleIsSelected = true;
      }
      
      private function __addBlackItem(event:DictionaryEvent) : void
      {
         if(_currentTitleInfo.titleType == 1 && _currentTitleInfo.titleIsSelected == true && _listPanel && _listPanel.vectorListModel)
         {
            _listPanel.vectorListModel.append(event.data,getInsertIndex(event.data as FriendListPlayer));
            updateTitle();
            _listPanel.list.updateListView();
         }
         else
         {
            updateTitle();
            _listPanel.list.updateListView();
         }
      }
      
      private function __updateItem(event:DictionaryEvent) : void
      {
         updateTitle();
         updateList();
      }
      
      private function __addItem(event:DictionaryEvent) : void
      {
         if((_currentTitleInfo.titleType == 0 || _currentTitleInfo.titleType >= 10) && _currentTitleInfo.titleIsSelected == true && _listPanel && _listPanel.vectorListModel)
         {
            _listPanel.vectorListModel.append(event.data,getInsertIndex(event.data as FriendListPlayer));
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
      
      private function __removeItem(event:DictionaryEvent) : void
      {
         if(_listPanel && _listPanel.vectorListModel)
         {
            _listPanel.vectorListModel.remove(event.data);
            updateTitle();
            _listPanel.list.updateListView();
         }
      }
      
      private function getInsertIndex(info:FriendListPlayer) : int
      {
         var tempIndex:int = 0;
         var tempInfo:* = null;
         var length:int = 0;
         var n:int = 0;
         var i:* = 0;
         var j:* = 0;
         var k:* = 0;
         var tempArray:Array = _listPanel.vectorListModel.elements;
         for(n = 0; n < _titleList.length; )
         {
            if(_titleList[n].titleIsSelected)
            {
               tempIndex = n + 1;
            }
            n++;
         }
         if(tempArray.length == _titleList.length)
         {
            return tempIndex;
         }
         if(_currentTitleInfo.titleType != 1 && _currentTitleInfo.titleIsSelected)
         {
            length = 0;
            if(info.playerState.StateID != 0)
            {
               length = PlayerManager.Instance.getOnlineFriendForCustom(_currentTitleInfo.titleType).length + tempIndex - 1;
               if(length != 0)
               {
                  for(i = tempIndex; i < length; )
                  {
                     tempInfo = tempArray[i] as FriendListPlayer;
                     if(info.IsVIP && tempInfo.IsVIP && info.Grade < tempInfo.Grade)
                     {
                        tempIndex++;
                     }
                     if(!info.IsVIP && tempInfo.IsVIP)
                     {
                        tempIndex++;
                     }
                     if(!info.IsVIP && !tempInfo.IsVIP && info.Grade < tempInfo.Grade)
                     {
                        tempIndex++;
                     }
                     i++;
                  }
               }
               return tempIndex;
            }
            tempIndex = PlayerManager.Instance.getOnlineFriendForCustom(_currentTitleInfo.titleType).length + tempIndex;
            length = PlayerManager.Instance.getOfflineFriendForCustom(_currentTitleInfo.titleType).length + tempIndex - 1;
            if(length != 0)
            {
               for(j = tempIndex; j < length; )
               {
                  tempInfo = tempArray[j] as FriendListPlayer;
                  if(info.Grade <= tempInfo.Grade)
                  {
                     tempIndex++;
                     j++;
                     continue;
                  }
                  break;
               }
            }
            return tempIndex;
         }
         length = PlayerManager.Instance.blackList.length + tempIndex - 1;
         if(length != 0)
         {
            for(k = tempIndex; k < length; )
            {
               tempInfo = tempArray[k] as FriendListPlayer;
               if(info.Grade <= tempInfo.Grade)
               {
                  tempIndex++;
                  k++;
                  continue;
               }
               break;
            }
         }
         return tempIndex;
      }
      
      private function __removeRecentContact(event:DictionaryEvent) : void
      {
         updateTitle();
         updateList();
      }
      
      private function updateTitle() : void
      {
         var i:int = 0;
         var elememt:int = 0;
         var deno:int = 0;
         if(PlayerManager.Instance.friendList)
         {
            for(i = 1; i < _titleList.length - 2; )
            {
               elememt = PlayerManager.Instance.getOnlineFriendForCustom(_titleList[i].titleType).length;
               deno = PlayerManager.Instance.getFriendForCustom(_titleList[i].titleType).length;
               _titleList[i].titleNumText = "[" + String(elememt) + "/" + String(deno) + "]";
               i++;
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
      
      private function __itemClick(event:ListItemEvent) : void
      {
         var i:int = 0;
         if((event.cellValue as FriendListPlayer).type == 1)
         {
            if(!_currentItemInfo)
            {
               _currentItemInfo = event.cellValue as FriendListPlayer;
               _currentItemInfo.titleIsSelected = true;
            }
            if(_currentItemInfo != event.cellValue as FriendListPlayer)
            {
               _currentItemInfo.titleIsSelected = false;
               _currentItemInfo = event.cellValue as FriendListPlayer;
               _currentItemInfo.titleIsSelected = true;
            }
         }
         else
         {
            if(!_currentTitleInfo)
            {
               _currentTitleInfo = event.cellValue as FriendListPlayer;
               _currentTitleInfo.titleIsSelected = true;
            }
            if(_currentTitleInfo != event.cellValue as FriendListPlayer)
            {
               _currentTitleInfo.titleIsSelected = false;
               _currentTitleInfo = event.cellValue as FriendListPlayer;
               _currentTitleInfo.titleIsSelected = true;
            }
            else
            {
               _currentTitleInfo.titleIsSelected = !_currentTitleInfo.titleIsSelected;
            }
            for(i = 0; i < _titleList.length; )
            {
               if(_titleList[i] != _currentTitleInfo)
               {
                  _titleList[i].titleIsSelected = false;
               }
               i++;
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
         var intPoint:IntPoint = new IntPoint(0,_pos);
         _listPanel.list.viewPosition = intPoint;
      }
      
      private function showTitle() : void
      {
         var i:int = 0;
         _playerArray = [];
         for(i = 0; i < _titleList.length; )
         {
            _playerArray.push(_titleList[i]);
            _titleList[i].titleIsSelected = false;
            i++;
         }
         _listPanel.vectorListModel.clear();
         _listPanel.vectorListModel.appendAll(_playerArray);
         _listPanel.list.updateListView();
      }
      
      private function updateFriendList(relation:int = 0) : void
      {
         var n:int = 0;
         var i:int = 0;
         var info:* = null;
         var j:int = 0;
         _playerArray = [];
         var temp:* = 0;
         for(n = 0; n < _titleList.length; )
         {
            _playerArray.push(_titleList[n]);
            if(relation == _titleList[n].titleType)
            {
               temp = n;
               break;
            }
            n++;
         }
         var tempArray:Array = PlayerManager.Instance.getOnlineFriendForCustom(relation);
         var tempArr:Array = [];
         var tempArr1:Array = [];
         for(i = 0; i < tempArray.length; )
         {
            info = tempArray[i] as FriendListPlayer;
            if(info.IsVIP)
            {
               tempArr.push(info);
            }
            else
            {
               tempArr1.push(info);
            }
            i++;
         }
         tempArr = sort(tempArr);
         tempArr1 = sort(tempArr1);
         tempArray = tempArr.concat(tempArr1);
         tempArray = IMManager.Instance.sortAcademyPlayer(tempArray);
         _playerArray = _playerArray.concat(tempArray);
         tempArray = PlayerManager.Instance.getOfflineFriendForCustom(relation);
         tempArray = sort(tempArray);
         tempArray = IMManager.Instance.sortAcademyPlayer(tempArray);
         _playerArray = _playerArray.concat(tempArray);
         for(j = temp + 1; j < _titleList.length; )
         {
            _playerArray.push(_titleList[j]);
            j++;
         }
         _listPanel.vectorListModel.clear();
         _listPanel.vectorListModel.appendAll(_playerArray);
         _listPanel.list.updateListView();
      }
      
      private function updateBlackList() : void
      {
         var i:int = 0;
         _playerArray = [];
         for(i = 0; i < _titleList.length - 1; )
         {
            _playerArray.push(_titleList[i]);
            i++;
         }
         var tempArray:Array = PlayerManager.Instance.blackList.list;
         _playerArray = _playerArray.concat(tempArray);
         _playerArray.push(_titleList[_titleList.length - 1]);
         _listPanel.vectorListModel.clear();
         _listPanel.vectorListModel.appendAll(_playerArray);
         _listPanel.list.updateListView();
      }
      
      private function updateRecentContactList() : void
      {
         var tempInfo:* = null;
         var i:int = 0;
         var state:* = null;
         var j:int = 0;
         _playerArray = [];
         _playerArray.unshift(_titleList[0]);
         var tempArray:Array = [];
         var tempDictionaryData:DictionaryData = PlayerManager.Instance.recentContacts;
         var recentContactsList:Array = IMManager.Instance.recentContactsList;
         if(recentContactsList)
         {
            for(i = 0; i < recentContactsList.length; )
            {
               if(recentContactsList[i] != 0)
               {
                  tempInfo = tempDictionaryData[recentContactsList[i]];
                  if(tempInfo && tempArray.indexOf(tempInfo) == -1)
                  {
                     if(PlayerManager.Instance.findPlayer(tempInfo.ID,PlayerManager.Instance.Self.ZoneID))
                     {
                        state = new PlayerState(PlayerManager.Instance.findPlayer(tempInfo.ID,PlayerManager.Instance.Self.ZoneID).playerState.StateID);
                        tempInfo.playerState = state;
                     }
                     tempArray.push(tempInfo);
                  }
               }
               i++;
            }
         }
         _playerArray = _playerArray.concat(tempArray);
         for(j = 1; j < _titleList.length; )
         {
            _playerArray.push(_titleList[j]);
            j++;
         }
         _listPanel.vectorListModel.clear();
         _listPanel.vectorListModel.appendAll(_playerArray);
         _listPanel.list.updateListView();
      }
      
      private function sort(arr:Array) : Array
      {
         return arr.sortOn("Grade",16 | 2);
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
      
      public function set currentItem(value:IMListItemView) : void
      {
         _currentItem = value;
      }
   }
}
