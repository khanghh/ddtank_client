package roomList.pvpRoomList
{
   import LimitAward.LimitAwardButton;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import road7th.data.DictionaryEvent;
   import room.RoomManager;
   import room.model.RoomInfo;
   import roomList.RoomListEnumerate;
   import serverlist.view.RoomListServerDropList;
   
   public class RoomListBGView extends Sprite implements Disposeable
   {
      
      public static var PREWORD:Array = [LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreatePveRoomView.tank"),LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreatePveRoomView.go"),LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreatePveRoomView.fire")];
      
      public static const FULL_MODE:int = 0;
      
      public static const ATHLETICS_MODE:int = 1;
      
      public static const CHALLENGE_MODE:int = 2;
       
      
      private var _bottom:ScaleBitmapImage;
      
      private var _roomListBG:Bitmap;
      
      private var _listTitle:Bitmap;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _preBtn:SimpleBitmapButton;
      
      private var _createBtn:SimpleBitmapButton;
      
      private var _rivalshipBtn:SimpleBitmapButton;
      
      private var _lookUpView:RoomLookUpView;
      
      private var _encounterBtn:SimpleBitmapButton;
      
      private var _itemList:SimpleTileList;
      
      private var _itemArray:Array;
      
      private var _model:RoomListModel;
      
      private var _controller:RoomListController;
      
      private var _limitAwardButton:LimitAwardButton;
      
      private var _serverlist:RoomListServerDropList;
      
      private var _tempDataList:Array;
      
      private var _modeMenu:ComboBox;
      
      private var _currentMode:int;
      
      private var _isPermissionEnter:Boolean;
      
      private var _modeArray:Array;
      
      private var _selectItemPos:int;
      
      private var _selectItemID:int;
      
      private var _lastCreatTime:int = 0;
      
      public function RoomListBGView(controller:RoomListController, model:RoomListModel)
      {
         _modeArray = ["ddt.roomList.roomListBG.full","ddt.roomList.roomListBG.Athletics","ddt.roomList.roomListBG.challenge"];
         _model = model;
         _controller = controller;
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _bottom = ComponentFactory.Instance.creatComponentByStylename("roomList.roomListView.frameBottom");
         _roomListBG = ComponentFactory.Instance.creat("asset.background.roomlist.right");
         PositionUtils.setPos(_roomListBG,"asset.ddtRoomlist.pvp.listBgpos");
         _listTitle = ComponentFactory.Instance.creatBitmap("asset.ddtroomlist.right.listtitle");
         _modeMenu = ComponentFactory.Instance.creatComponentByStylename("asset.ddtRoomlist.pvp.modeMenu");
         _modeMenu.textField.text = LanguageMgr.GetTranslation(_modeArray[0]);
         _currentMode = 0;
         _itemList = ComponentFactory.Instance.creat("asset.ddtRoomList.pvp.itemContainer",[2]);
         addChild(_bottom);
         addChild(_roomListBG);
         addChild(_listTitle);
         addChild(_modeMenu);
         addChild(_itemList);
         updateList();
         initButton();
         _isPermissionEnter = true;
      }
      
      private function initButton() : void
      {
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.nextBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.preBtn");
         _createBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomlist.pvpBtn.startBtn");
         _createBtn.tipData = LanguageMgr.GetTranslation("tank.roomlist.RoomListIIRoomBtnPanel.createRoom");
         _rivalshipBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomlist.pvpBtn.formAteamBtn");
         _rivalshipBtn.tipData = LanguageMgr.GetTranslation("tank.roomlist.joinBattleQuickly");
         _lookUpView = new RoomLookUpView(__updateClick,1);
         PositionUtils.setPos(_lookUpView,"roomList.lookupView.Pos");
         _encounterBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomlist.pvpBtn.encounterBtn");
         _encounterBtn.tipData = LanguageMgr.GetTranslation("tank.roomlist.RoomListIIRoomBtnPanel.fastMatchTip");
         _serverlist = ComponentFactory.Instance.creat("asset.ddtRoomlist.pvp.serverlist");
         PositionUtils.setPos(_serverlist,"roomList.serverlist.Pos");
         addTipPanel();
         addChild(_nextBtn);
         addChild(_preBtn);
         addChild(_createBtn);
         addChild(_rivalshipBtn);
         addChild(_lookUpView);
         addChild(_encounterBtn);
         addChild(_serverlist);
         _itemArray = [];
      }
      
      private function initEvent() : void
      {
         _encounterBtn.addEventListener("click",__encounterBtnClick);
         _createBtn.addEventListener("click",__createBtnClick);
         _rivalshipBtn.addEventListener("click",_rivalshipClick);
         _nextBtn.addEventListener("click",__updateClick);
         _preBtn.addEventListener("click",__updateClick);
         _model.addEventListener("roomItemUpdate",__updateItem);
         _model.getRoomList().addEventListener("clear",__clearRoom);
         _modeMenu.listPanel.list.addEventListener("listItemClick",__onListClick);
      }
      
      private function removeEvent() : void
      {
         _encounterBtn.removeEventListener("click",__encounterBtnClick);
         _createBtn.removeEventListener("click",__createBtnClick);
         _rivalshipBtn.removeEventListener("click",_rivalshipClick);
         _nextBtn.removeEventListener("click",__updateClick);
         _preBtn.removeEventListener("click",__updateClick);
         _model.removeEventListener("roomItemUpdate",__updateItem);
         if(_model.getRoomList())
         {
            _model.getRoomList().removeEventListener("clear",__clearRoom);
         }
      }
      
      private function __updateItem(event:Event) : void
      {
         upadteItemPos();
         _isPermissionEnter = true;
      }
      
      private function __onListClick(event:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         _currentMode = getCurrentMode(event.cellValue);
         addTipPanel();
      }
      
      private function getCurrentMode(value:String) : int
      {
         var i:int = 0;
         for(i = 0; i < _modeArray.length; )
         {
            if(LanguageMgr.GetTranslation(_modeArray[i]) == value)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function addTipPanel() : void
      {
         var comboxModel:VectorListModel = _modeMenu.listPanel.vectorListModel;
         comboxModel.clear();
         switch(int(_currentMode))
         {
            case 0:
               comboxModel.append(LanguageMgr.GetTranslation(_modeArray[1]));
               comboxModel.append(LanguageMgr.GetTranslation(_modeArray[2]));
               SocketManager.Instance.out.sendUpdateRoomList(1,3);
               break;
            case 1:
               comboxModel.append(LanguageMgr.GetTranslation(_modeArray[0]));
               comboxModel.append(LanguageMgr.GetTranslation(_modeArray[2]));
               SocketManager.Instance.out.sendUpdateRoomList(1,4);
               break;
            case 2:
               comboxModel.append(LanguageMgr.GetTranslation(_modeArray[0]));
               comboxModel.append(LanguageMgr.GetTranslation(_modeArray[1]));
               SocketManager.Instance.out.sendUpdateRoomList(1,5);
         }
      }
      
      private function __clearRoom(event:DictionaryEvent) : void
      {
         cleanItem();
         _isPermissionEnter = true;
      }
      
      private function updateList() : void
      {
         var i:int = 0;
         var info:* = null;
         var item:* = null;
         for(i = 0; i < _model.getRoomList().length; )
         {
            info = _model.getRoomList().list[i];
            item = new RoomListItemView(info);
            item.addEventListener("click",__itemClick);
            _itemList.addChild(item);
            _itemArray.push(item);
            i++;
         }
      }
      
      private function cleanItem() : void
      {
         var i:int = 0;
         for(i = 0; i < _itemArray.length; )
         {
            (_itemArray[i] as RoomListItemView).removeEventListener("click",__itemClick);
            (_itemArray[i] as RoomListItemView).dispose();
            i++;
         }
         _itemList.disposeAllChildren();
         _itemArray = [];
      }
      
      private function __itemClick(event:MouseEvent) : void
      {
         if(!_isPermissionEnter)
         {
            return;
         }
         gotoIntoRoom((event.currentTarget as RoomListItemView).info);
         getSelectItemPos((event.currentTarget as RoomListItemView).id);
      }
      
      private function getSelectItemPos(id:int) : int
      {
         var i:int = 0;
         if(!_itemList)
         {
            return 0;
         }
         i = 0;
         while(i < _itemArray.length)
         {
            if(!(_itemArray[i] as RoomListItemView))
            {
               return 0;
            }
            if((_itemArray[i] as RoomListItemView).id == id)
            {
               _selectItemPos = i;
               _selectItemID = (_itemArray[i] as RoomListItemView).id;
               return i;
            }
            i++;
         }
         return 0;
      }
      
      public function get currentDataList() : Array
      {
         if(_model.roomShowMode == 1)
         {
            return _model.getRoomList().filter("isPlaying",false).concat(_model.getRoomList().filter("isPlaying",true));
         }
         return _model.getRoomList().list;
      }
      
      private function getInfosPos(id:int) : int
      {
         var i:int = 0;
         _tempDataList = currentDataList;
         if(!_tempDataList)
         {
            return 0;
         }
         i = 0;
         while(i < _tempDataList.length)
         {
            if((_tempDataList[i] as RoomInfo).ID == id)
            {
               return i;
            }
            i++;
         }
         return 0;
      }
      
      private function upadteItemPos() : void
      {
         var temInfo:* = null;
         var temPos:int = 0;
         var item:* = null;
         _tempDataList = currentDataList;
         if(_tempDataList)
         {
            temInfo = _tempDataList[_selectItemPos];
            temPos = getInfosPos(_selectItemID);
            _tempDataList[_selectItemPos] = _tempDataList[temPos];
            _tempDataList[temPos] = temInfo;
            _tempDataList = sortRooInfo(_tempDataList);
            cleanItem();
            var _loc6_:int = 0;
            var _loc5_:* = _tempDataList;
            for each(var info in _tempDataList)
            {
               if(!info)
               {
                  return;
               }
               item = new RoomListItemView(info);
               item.addEventListener("click",__itemClick,false,0,true);
               _itemList.addChild(item);
               _itemArray.push(item);
            }
         }
      }
      
      private function sortRooInfo(roomInfos:Array) : Array
      {
         var roomType:int = 0;
         var newRoomInfos:Array = [];
         switch(int(_currentMode) - 1)
         {
            case 0:
               roomType = 0;
               break;
            case 1:
               roomType = 1;
         }
         var _loc6_:int = 0;
         var _loc5_:* = roomInfos;
         for each(var info in roomInfos)
         {
            if(info)
            {
               if(info.type == roomType && !info.isPlaying)
               {
                  newRoomInfos.unshift(info);
               }
               else
               {
                  newRoomInfos.push(info);
               }
            }
         }
         return newRoomInfos;
      }
      
      private function gotoTip(type:int) : Boolean
      {
         if(type == 0)
         {
            if(PlayerManager.Instance.Self.Grade < 6)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.notGotoIntoRoom",6,LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.ream")));
               return true;
            }
         }
         else if(type == 1)
         {
            if(PlayerManager.Instance.Self.Grade < 12)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.notGotoIntoRoom",12,LanguageMgr.GetTranslation("tank.roomlist.challenge")));
               return true;
            }
         }
         return false;
      }
      
      public function gotoIntoRoom(info:RoomInfo) : void
      {
         SoundManager.instance.play("008");
         if(gotoTip(info.type))
         {
            return;
         }
         SocketManager.Instance.out.sendGameLogin(1,-1,info.ID,"");
         _isPermissionEnter = false;
      }
      
      private function _rivalshipClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_isPermissionEnter)
         {
            return;
         }
         if(gotoTip(0))
         {
            return;
         }
         SocketManager.Instance.out.sendGameLogin(1,0);
         _isPermissionEnter = false;
      }
      
      private function __updateClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendUpdate();
      }
      
      private function __placeCountClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendUpdate();
      }
      
      private function __hardLevelClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendUpdate();
      }
      
      private function __roomModeClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendUpdate();
      }
      
      private function __roomNameClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendUpdate();
      }
      
      private function __idBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendUpdate();
      }
      
      public function sendUpdate() : void
      {
         switch(int(_currentMode))
         {
            case 0:
               SocketManager.Instance.out.sendUpdateRoomList(1,3);
               break;
            case 1:
               SocketManager.Instance.out.sendUpdateRoomList(1,4);
               break;
            case 2:
               SocketManager.Instance.out.sendUpdateRoomList(1,5);
         }
      }
      
      private function __createBtnClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(getTimer() - _lastCreatTime > 2000)
         {
            _lastCreatTime = getTimer();
            GameInSocketOut.sendCreateRoom(RoomListEnumerate.PREWORD[int(Math.random() * RoomListEnumerate.PREWORD.length)],0,3);
         }
      }
      
      protected function __encounterBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CheckWeaponManager.instance.setFunction(this,__encounterBtnClick,[event]);
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            CheckWeaponManager.instance.showAlert();
            return;
         }
         openMatch();
      }
      
      public function openMatch() : void
      {
         if(getTimer() - _lastCreatTime > 1000)
         {
            _lastCreatTime = getTimer();
            RoomListManager.instance.openMatch = true;
            RoomManager.Instance.addBattleSingleRoom();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         cleanItem();
         if(_roomListBG)
         {
            ObjectUtils.disposeObject(_roomListBG);
         }
         _roomListBG = null;
         ObjectUtils.disposeObject(_bottom);
         _bottom = null;
         if(_listTitle)
         {
            ObjectUtils.disposeObject(_listTitle);
         }
         _listTitle = null;
         _nextBtn.dispose();
         _nextBtn = null;
         _preBtn.dispose();
         _preBtn = null;
         _createBtn.dispose();
         _createBtn = null;
         _rivalshipBtn.dispose();
         _rivalshipBtn = null;
         _lookUpView.dispose();
         _lookUpView = null;
         if(_itemList)
         {
            _itemList.disposeAllChildren();
         }
         ObjectUtils.disposeObject(_itemList);
         _itemList = null;
         _itemArray = null;
         if(_modeMenu)
         {
            ObjectUtils.disposeObject(_modeMenu);
            _modeMenu = null;
         }
         if(_serverlist)
         {
            _serverlist.dispose();
            _serverlist = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(_limitAwardButton)
         {
            ObjectUtils.disposeObject(_limitAwardButton);
         }
         _limitAwardButton = null;
      }
   }
}
