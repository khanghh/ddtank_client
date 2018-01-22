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
      
      public function RoomListBGView(param1:RoomListController, param2:RoomListModel)
      {
         _modeArray = ["ddt.roomList.roomListBG.full","ddt.roomList.roomListBG.Athletics","ddt.roomList.roomListBG.challenge"];
         _model = param2;
         _controller = param1;
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
      
      private function __updateItem(param1:Event) : void
      {
         upadteItemPos();
         _isPermissionEnter = true;
      }
      
      private function __onListClick(param1:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         _currentMode = getCurrentMode(param1.cellValue);
         addTipPanel();
      }
      
      private function getCurrentMode(param1:String) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _modeArray.length)
         {
            if(LanguageMgr.GetTranslation(_modeArray[_loc2_]) == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function addTipPanel() : void
      {
         var _loc1_:VectorListModel = _modeMenu.listPanel.vectorListModel;
         _loc1_.clear();
         switch(int(_currentMode))
         {
            case 0:
               _loc1_.append(LanguageMgr.GetTranslation(_modeArray[1]));
               _loc1_.append(LanguageMgr.GetTranslation(_modeArray[2]));
               SocketManager.Instance.out.sendUpdateRoomList(1,3);
               break;
            case 1:
               _loc1_.append(LanguageMgr.GetTranslation(_modeArray[0]));
               _loc1_.append(LanguageMgr.GetTranslation(_modeArray[2]));
               SocketManager.Instance.out.sendUpdateRoomList(1,4);
               break;
            case 2:
               _loc1_.append(LanguageMgr.GetTranslation(_modeArray[0]));
               _loc1_.append(LanguageMgr.GetTranslation(_modeArray[1]));
               SocketManager.Instance.out.sendUpdateRoomList(1,5);
         }
      }
      
      private function __clearRoom(param1:DictionaryEvent) : void
      {
         cleanItem();
         _isPermissionEnter = true;
      }
      
      private function updateList() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _model.getRoomList().length)
         {
            _loc2_ = _model.getRoomList().list[_loc3_];
            _loc1_ = new RoomListItemView(_loc2_);
            _loc1_.addEventListener("click",__itemClick);
            _itemList.addChild(_loc1_);
            _itemArray.push(_loc1_);
            _loc3_++;
         }
      }
      
      private function cleanItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _itemArray.length)
         {
            (_itemArray[_loc1_] as RoomListItemView).removeEventListener("click",__itemClick);
            (_itemArray[_loc1_] as RoomListItemView).dispose();
            _loc1_++;
         }
         _itemList.disposeAllChildren();
         _itemArray = [];
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         if(!_isPermissionEnter)
         {
            return;
         }
         gotoIntoRoom((param1.currentTarget as RoomListItemView).info);
         getSelectItemPos((param1.currentTarget as RoomListItemView).id);
      }
      
      private function getSelectItemPos(param1:int) : int
      {
         var _loc2_:int = 0;
         if(!_itemList)
         {
            return 0;
         }
         _loc2_ = 0;
         while(_loc2_ < _itemArray.length)
         {
            if(!(_itemArray[_loc2_] as RoomListItemView))
            {
               return 0;
            }
            if((_itemArray[_loc2_] as RoomListItemView).id == param1)
            {
               _selectItemPos = _loc2_;
               _selectItemID = (_itemArray[_loc2_] as RoomListItemView).id;
               return _loc2_;
            }
            _loc2_++;
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
      
      private function getInfosPos(param1:int) : int
      {
         var _loc2_:int = 0;
         _tempDataList = currentDataList;
         if(!_tempDataList)
         {
            return 0;
         }
         _loc2_ = 0;
         while(_loc2_ < _tempDataList.length)
         {
            if((_tempDataList[_loc2_] as RoomInfo).ID == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return 0;
      }
      
      private function upadteItemPos() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc3_:* = null;
         _tempDataList = currentDataList;
         if(_tempDataList)
         {
            _loc2_ = _tempDataList[_selectItemPos];
            _loc1_ = getInfosPos(_selectItemID);
            _tempDataList[_selectItemPos] = _tempDataList[_loc1_];
            _tempDataList[_loc1_] = _loc2_;
            _tempDataList = sortRooInfo(_tempDataList);
            cleanItem();
            var _loc6_:int = 0;
            var _loc5_:* = _tempDataList;
            for each(var _loc4_ in _tempDataList)
            {
               if(!_loc4_)
               {
                  return;
               }
               _loc3_ = new RoomListItemView(_loc4_);
               _loc3_.addEventListener("click",__itemClick,false,0,true);
               _itemList.addChild(_loc3_);
               _itemArray.push(_loc3_);
            }
         }
      }
      
      private function sortRooInfo(param1:Array) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Array = [];
         switch(int(_currentMode) - 1)
         {
            case 0:
               _loc2_ = 0;
               break;
            case 1:
               _loc2_ = 1;
         }
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc4_ in param1)
         {
            if(_loc4_)
            {
               if(_loc4_.type == _loc2_ && !_loc4_.isPlaying)
               {
                  _loc3_.unshift(_loc4_);
               }
               else
               {
                  _loc3_.push(_loc4_);
               }
            }
         }
         return _loc3_;
      }
      
      private function gotoTip(param1:int) : Boolean
      {
         if(param1 == 0)
         {
            if(PlayerManager.Instance.Self.Grade < 6)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.notGotoIntoRoom",6,LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.ream")));
               return true;
            }
         }
         else if(param1 == 1)
         {
            if(PlayerManager.Instance.Self.Grade < 12)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.notGotoIntoRoom",12,LanguageMgr.GetTranslation("tank.roomlist.challenge")));
               return true;
            }
         }
         return false;
      }
      
      public function gotoIntoRoom(param1:RoomInfo) : void
      {
         SoundManager.instance.play("008");
         if(gotoTip(param1.type))
         {
            return;
         }
         SocketManager.Instance.out.sendGameLogin(1,-1,param1.ID,"");
         _isPermissionEnter = false;
      }
      
      private function _rivalshipClick(param1:MouseEvent) : void
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
      
      private function __updateClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendUpdate();
      }
      
      private function __placeCountClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendUpdate();
      }
      
      private function __hardLevelClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendUpdate();
      }
      
      private function __roomModeClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendUpdate();
      }
      
      private function __roomNameClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendUpdate();
      }
      
      private function __idBtnClick(param1:MouseEvent) : void
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
      
      private function __createBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(getTimer() - _lastCreatTime > 2000)
         {
            _lastCreatTime = getTimer();
            GameInSocketOut.sendCreateRoom(RoomListEnumerate.PREWORD[int(Math.random() * RoomListEnumerate.PREWORD.length)],0,3);
         }
      }
      
      protected function __encounterBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CheckWeaponManager.instance.setFunction(this,__encounterBtnClick,[param1]);
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
