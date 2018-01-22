package roomList.pveRoomList
{
   import LimitAward.LimitAwardButton;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Scrollbar;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import road7th.data.DictionaryEvent;
   import room.RoomManager;
   import room.model.RoomInfo;
   import roomList.RoomListEnumerate;
   import roomList.RoomListMapTipPanel;
   import roomList.RoomListTipPanel;
   import roomList.pvpRoomList.RoomLookUpView;
   import serverlist.view.RoomListServerDropList;
   
   public class DungeonListBGView extends Sprite implements Disposeable
   {
       
      
      private var _dungeonListBG:Bitmap;
      
      private var _roomlistWord:Bitmap;
      
      private var _model:DungeonListModel;
      
      private var _bmpSiftFb:FilterFrameText;
      
      private var _bmpSiftHardLv:FilterFrameText;
      
      private var _btnSiftReset:TextButton;
      
      private var _bmpCbFb:BaseButton;
      
      private var _bmpCbHardLv:BaseButton;
      
      private var _txtCbFb:FilterFrameText;
      
      private var _txtCbHardLv:FilterFrameText;
      
      private var _iconBtnII:SimpleBitmapButton;
      
      private var _iconBtnIII:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _preBtn:SimpleBitmapButton;
      
      private var _createBtn:SimpleBitmapButton;
      
      private var _rivalshipBtn:SimpleBitmapButton;
      
      private var _itemList:SimpleTileList;
      
      private var _itemArray:Array;
      
      private var _pveHardLeveRoomListTipPanel:RoomListTipPanel;
      
      private var _pveMapRoomListTipPanel:RoomListMapTipPanel;
      
      private var _controlle:DungeonListController;
      
      private var _limitAwardButton:LimitAwardButton;
      
      private var _tempDataList:Array;
      
      private var _serverlist:RoomListServerDropList;
      
      private var _cut:Bitmap;
      
      private var _isPermissionEnter:Boolean;
      
      private var _bottom:ScaleBitmapImage;
      
      private var _lookUpView:RoomLookUpView;
      
      private var _selectItemPos:int;
      
      private var _selectItemID:int;
      
      private var _last_creat:uint;
      
      public function DungeonListBGView(param1:DungeonListController, param2:DungeonListModel)
      {
         _controlle = param1;
         _model = param2;
         super();
         init();
         initEvent();
         initControl();
      }
      
      private function init() : void
      {
         _itemArray = [];
         _bottom = ComponentFactory.Instance.creatComponentByStylename("roomList.dungeonListView.frameBottom");
         addChild(_bottom);
         _dungeonListBG = ComponentFactory.Instance.creat("asset.ddtroomlist.pve.moviebg");
         PositionUtils.setPos(_dungeonListBG,"asset.ddtRoomlist.pve.roomlistBgPos");
         addChild(_dungeonListBG);
         _roomlistWord = ComponentFactory.Instance.creatBitmap("asset.ddtroomlist.pve.pveRoomlist");
         addChild(_roomlistWord);
         _bmpSiftFb = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.itemlist.siftFB");
         _bmpSiftFb.text = LanguageMgr.GetTranslation("ddt.pve.roomlist.itemlist.siftFb");
         addChild(_bmpSiftFb);
         _bmpSiftHardLv = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.itemlist.siftHard");
         _bmpSiftHardLv.text = LanguageMgr.GetTranslation("ddt.pve.roomlist.itemlist.siftHard");
         addChild(_bmpSiftHardLv);
         _btnSiftReset = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.itemlist.resetBtn");
         _btnSiftReset.text = LanguageMgr.GetTranslation("ddt.pve.roomlist.itemlist.reset");
         addChild(_btnSiftReset);
         _bmpCbFb = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.itemlist.bmpCbFb");
         addChild(_bmpCbFb);
         _bmpCbHardLv = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.itemlist.bmpCbHardLv");
         addChild(_bmpCbHardLv);
         _txtCbFb = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.itemlist.txtCbFb");
         _txtCbFb.mouseEnabled = false;
         addChild(_txtCbFb);
         _txtCbHardLv = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.itemlist.txtHardLv");
         _txtCbHardLv.mouseEnabled = false;
         addChild(_txtCbHardLv);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.itemlist.nextBtn");
         addChild(_nextBtn);
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.itemlist.preBtn");
         addChild(_preBtn);
         _createBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.createBtn");
         _createBtn.tipData = LanguageMgr.GetTranslation("tank.roomlist.RoomListIIRoomBtnPanel.createRoom");
         addChild(_createBtn);
         _rivalshipBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.quickBtn");
         _rivalshipBtn.tipData = LanguageMgr.GetTranslation("tank.roomlist.joinDuplicateQuickly");
         addChild(_rivalshipBtn);
         _iconBtnII = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.itemlist.iconbtn2");
         addChild(_iconBtnII);
         _iconBtnIII = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.itemlist.iconbtn3");
         addChild(_iconBtnIII);
         _cut = UICreatShortcut.creatAndAdd("asset.ddtroomList.cut",this);
         var _loc2_:String = String(ServerManager.Instance.current.Name);
         var _loc1_:int = _loc2_.indexOf("(");
         _loc1_ = _loc1_ == -1?_loc2_.length:int(_loc1_);
         _itemList = ComponentFactory.Instance.creat("asset.ddtroomList.DungeonList.ItemList",[2]);
         addChild(_itemList);
         _serverlist = ComponentFactory.Instance.creat("asset.ddtRoomlist.pvp.serverlist");
         addChild(_serverlist);
         _lookUpView = new RoomLookUpView(__updateClick,2);
         PositionUtils.setPos(_lookUpView,"dungeonList.lookupView.Pos");
         addChild(_lookUpView);
         addTipPanel();
         resetSift();
         _isPermissionEnter = true;
      }
      
      private function initEvent() : void
      {
         _createBtn.addEventListener("click",__createClick);
         _rivalshipBtn.addEventListener("click",__rivalshipBtnClick);
         _iconBtnII.addEventListener("click",__iconBtnIIClick);
         _iconBtnIII.addEventListener("click",__iconBtnIIIClick);
         _bmpCbFb.addEventListener("click",__iconBtnIIClick);
         _bmpCbHardLv.addEventListener("click",__iconBtnIIIClick);
         _btnSiftReset.addEventListener("click",__siftReset);
         _pveMapRoomListTipPanel.addEventListener("fbChange",__fbChange);
         _pveHardLeveRoomListTipPanel.addEventListener("hardLvChange",__hardLvChange);
         _nextBtn.addEventListener("click",__updateClick);
         _preBtn.addEventListener("click",__updateClick);
         _model.addEventListener("DungeonListUpdate",__addRoom);
         _model.getRoomList().addEventListener("clear",__clearRoom);
         StageReferance.stage.addEventListener("click",__stageClick);
         RoomManager.Instance.addEventListener("loginRoomResult",__loginRoomRes);
      }
      
      private function initControl() : void
      {
         sendSift();
      }
      
      private function removeEvent() : void
      {
         _createBtn.removeEventListener("click",__createClick);
         _rivalshipBtn.removeEventListener("click",__rivalshipBtnClick);
         _iconBtnII.removeEventListener("click",__iconBtnIIClick);
         _iconBtnIII.removeEventListener("click",__iconBtnIIIClick);
         _bmpCbFb.removeEventListener("click",__iconBtnIIClick);
         _bmpCbHardLv.removeEventListener("click",__iconBtnIIIClick);
         _btnSiftReset.removeEventListener("click",__siftReset);
         _pveMapRoomListTipPanel.removeEventListener("fbChange",__fbChange);
         _pveHardLeveRoomListTipPanel.removeEventListener("hardLvChange",__hardLvChange);
         _nextBtn.removeEventListener("click",__updateClick);
         _preBtn.removeEventListener("click",__updateClick);
         _model.removeEventListener("DungeonListUpdate",__addRoom);
         StageReferance.stage.removeEventListener("click",__stageClick);
         RoomManager.Instance.removeEventListener("loginRoomResult",__loginRoomRes);
         if(_model.getRoomList())
         {
            _model.getRoomList().removeEventListener("clear",__clearRoom);
         }
      }
      
      private function __loginRoomRes(param1:Event) : void
      {
         _isPermissionEnter = true;
      }
      
      private function __rivalshipBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_isPermissionEnter)
         {
            return;
         }
         SocketManager.Instance.out.sendGameLogin(2,4);
         _isPermissionEnter = false;
      }
      
      private function __stageClick(param1:MouseEvent) : void
      {
         if(!DisplayUtils.isTargetOrContain(param1.target as DisplayObject,_iconBtnII) && !DisplayUtils.isTargetOrContain(param1.target as DisplayObject,_iconBtnIII) && !DisplayUtils.isTargetOrContain(param1.target as DisplayObject,_bmpCbFb) && !DisplayUtils.isTargetOrContain(param1.target as DisplayObject,_bmpCbHardLv) && !(param1.target is BaseButton) && !(param1.target is ScaleBitmapImage && (param1.target as DisplayObject).parent is Scrollbar))
         {
            _pveMapRoomListTipPanel.visible = false;
            _pveHardLeveRoomListTipPanel.visible = false;
         }
      }
      
      private function __lookupClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _controlle.showFindRoom();
      }
      
      private function __fbChange(param1:Event) : void
      {
         sendSift();
         if(_pveMapRoomListTipPanel.value == 10000)
         {
            setTxtCbFb(LanguageMgr.GetTranslation("tank.roomlist.siftAllFb"));
         }
         else
         {
            setTxtCbFb(MapManager.getMapName(_pveMapRoomListTipPanel.value));
         }
      }
      
      private function __hardLvChange(param1:Event) : void
      {
         sendSift();
         setTxtCbHardLv(getHardLvTxt(_pveHardLeveRoomListTipPanel.value));
      }
      
      private function __siftReset(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         resetSift();
         sendSift();
      }
      
      private function sendSift() : void
      {
         SocketManager.Instance.out.sendUpdateRoomList(2,-2,_pveMapRoomListTipPanel.value,_pveHardLeveRoomListTipPanel.value);
      }
      
      private function resetSift() : void
      {
         _pveMapRoomListTipPanel.resetValue();
         _pveHardLeveRoomListTipPanel.resetValue();
         setTxtCbFb(LanguageMgr.GetTranslation("tank.roomlist.siftAllFb"));
         setTxtCbHardLv("tank.room.difficulty.all");
      }
      
      private function setTxtCbFb(param1:String) : void
      {
         _txtCbFb.text = param1;
         _txtCbFb.x = _bmpCbFb.x + (_bmpCbFb.width - _iconBtnII.width - _txtCbFb.width) / 2;
      }
      
      private function setTxtCbHardLv(param1:String) : void
      {
         _txtCbHardLv.text = LanguageMgr.GetTranslation(param1);
         _txtCbHardLv.x = _bmpCbHardLv.x + (_bmpCbHardLv.width - _iconBtnIII.width - _txtCbHardLv.width) / 2;
      }
      
      private function getHardLvTxt(param1:int) : String
      {
         switch(int(param1) - 1007)
         {
            case 0:
               return "tank.room.difficulty.simple";
            case 1:
               return "tank.room.difficulty.normal";
            case 2:
               return "tank.room.difficulty.hard";
            case 3:
               return "tank.room.difficulty.hero";
            case 4:
               return "tank.room.difficulty.nightmare";
         }
      }
      
      private function addTipPanel() : void
      {
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroomList.hardLevel_01");
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroomList.hardLevel_02");
         var _loc4_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroomList.hardLevel_03");
         var _loc11_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroomList.hardLevel_04");
         var _loc10_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroomList.hardLevel_05");
         var _loc13_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroomList.hardLevel_06");
         var _loc12_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroomList.hardLevel_07");
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroomList.pve.DungeonListTipPanelSizeII");
         _pveHardLeveRoomListTipPanel = new RoomListTipPanel(_loc1_.x,_loc1_.y);
         _pveHardLeveRoomListTipPanel.addItem(_loc10_,1013);
         _pveHardLeveRoomListTipPanel.addItem(_loc2_,1007);
         _pveHardLeveRoomListTipPanel.addItem(_loc3_,1008);
         _pveHardLeveRoomListTipPanel.addItem(_loc4_,1009);
         _pveHardLeveRoomListTipPanel.addItem(_loc11_,1010);
         _pveHardLeveRoomListTipPanel.addItem(_loc12_,1011);
         _pveHardLeveRoomListTipPanel.addItem(_loc13_,1012);
         var _loc7_:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroomList.pve.pveHardLeveRoomListTipPanelPos");
         _pveHardLeveRoomListTipPanel.x = _loc7_.x;
         _pveHardLeveRoomListTipPanel.y = _loc7_.y;
         _pveHardLeveRoomListTipPanel.visible = false;
         addChild(_pveHardLeveRoomListTipPanel);
         var _loc9_:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroomList.pve.pveMapPanelPos");
         var _loc14_:Point = ComponentFactory.Instance.creatCustomObject("roomList.DungeonList.DungeonListTipPanelSizeIII");
         _pveMapRoomListTipPanel = new RoomListMapTipPanel(_loc14_.x,_loc14_.y);
         _pveMapRoomListTipPanel.x = _loc9_.x;
         _pveMapRoomListTipPanel.y = _loc9_.y;
         _pveMapRoomListTipPanel.addItem(10000);
         _loc8_ = 1;
         while(_loc8_ < 13)
         {
            if(MapManager.getByOrderingDungeonInfo(_loc8_))
            {
               _pveMapRoomListTipPanel.addItem(MapManager.getByOrderingDungeonInfo(_loc8_).ID);
            }
            _loc8_++;
         }
         _loc5_ = 1;
         while(_loc5_ < 13)
         {
            if(MapManager.getByOrderingAcademyDungeonInfo(_loc5_))
            {
               _pveMapRoomListTipPanel.addItem(MapManager.getByOrderingAcademyDungeonInfo(_loc5_).ID);
            }
            _loc5_++;
         }
         _loc6_ = 1;
         while(_loc6_ < 13)
         {
            if(MapManager.getByOrderingActivityDungeonInfo(_loc6_))
            {
               if(MapManager.Instance.activeDoubleIds.indexOf(MapManager.getByOrderingActivityDungeonInfo(_loc6_).ID) == -1)
               {
                  _pveMapRoomListTipPanel.addItem(MapManager.getByOrderingActivityDungeonInfo(_loc6_).ID);
               }
            }
            _loc6_++;
         }
         _pveMapRoomListTipPanel.visible = false;
         addChild(_pveMapRoomListTipPanel);
      }
      
      private function __clearRoom(param1:DictionaryEvent) : void
      {
         cleanItem();
         _isPermissionEnter = true;
      }
      
      private function __addRoom(param1:Event) : void
      {
         upadteItemPos();
         _isPermissionEnter = true;
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
            cleanItem();
            var _loc6_:int = 0;
            var _loc5_:* = _tempDataList;
            for each(var _loc4_ in _tempDataList)
            {
               if(_loc4_)
               {
                  _loc3_ = new DungeonListItemView(_loc4_);
                  _loc3_.addEventListener("click",__itemClick,false,0,true);
                  _itemList.addChild(_loc3_);
                  _itemArray.push(_loc3_);
               }
            }
         }
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
            if(!(_itemArray[_loc2_] as DungeonListItemView))
            {
               return 0;
            }
            if((_itemArray[_loc2_] as DungeonListItemView).id == param1)
            {
               _selectItemPos = _loc2_;
               _selectItemID = (_itemArray[_loc2_] as DungeonListItemView).id;
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
      
      private function __iconBtnIIClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _pveMapRoomListTipPanel.visible = !_pveMapRoomListTipPanel.visible;
         _pveHardLeveRoomListTipPanel.visible = false;
      }
      
      private function __iconBtnIIIClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _pveHardLeveRoomListTipPanel.visible = !_pveHardLeveRoomListTipPanel.visible;
         _pveMapRoomListTipPanel.visible = false;
      }
      
      private function __updateClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendSift();
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         if(!_isPermissionEnter)
         {
            return;
         }
         SoundManager.instance.play("008");
         var _loc2_:DungeonListItemView = param1.currentTarget as DungeonListItemView;
         if(PlayerManager.Instance.Self.Grade < 25 && _loc2_.info.type == 21)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.ActivityDungeon.promptInfo",25));
            return;
         }
         gotoIntoRoom(_loc2_.info);
         getSelectItemPos(_loc2_.id);
      }
      
      public function gotoIntoRoom(param1:RoomInfo) : void
      {
         SocketManager.Instance.out.sendGameLogin(2,-1,param1.ID,"");
         _isPermissionEnter = false;
      }
      
      private function __createClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(getTimer() - _last_creat >= 2000)
         {
            _last_creat = getTimer();
            GameInSocketOut.sendCreateRoom(RoomListEnumerate.PREWORD[int(Math.random() * RoomListEnumerate.PREWORD.length)],4,3);
         }
      }
      
      private function cleanItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _itemArray.length)
         {
            (_itemArray[_loc1_] as DungeonListItemView).removeEventListener("click",__itemClick);
            (_itemArray[_loc1_] as DungeonListItemView).dispose();
            _loc1_++;
         }
         _itemList.disposeAllChildren();
         _itemArray = [];
      }
      
      public function dispose() : void
      {
         removeEvent();
         cleanItem();
         if(_bottom)
         {
            _bottom.dispose();
            _bottom = null;
         }
         if(_lookUpView)
         {
            _lookUpView.dispose();
            _lookUpView = null;
         }
         _itemList.dispose();
         _itemList = null;
         _iconBtnII.dispose();
         _iconBtnII = null;
         _iconBtnIII.dispose();
         _iconBtnIII = null;
         if(_roomlistWord)
         {
            ObjectUtils.disposeObject(_roomlistWord);
         }
         _roomlistWord = null;
         if(_cut)
         {
            ObjectUtils.disposeObject(_cut);
         }
         _cut = null;
         ObjectUtils.disposeObject(_bmpSiftFb);
         _bmpSiftFb = null;
         ObjectUtils.disposeObject(_bmpSiftHardLv);
         _bmpSiftHardLv = null;
         ObjectUtils.disposeObject(_bmpCbFb);
         _bmpCbFb = null;
         ObjectUtils.disposeObject(_bmpCbHardLv);
         _bmpCbHardLv = null;
         ObjectUtils.disposeObject(_txtCbFb);
         _txtCbFb = null;
         ObjectUtils.disposeObject(_txtCbHardLv);
         _txtCbHardLv = null;
         ObjectUtils.disposeObject(_btnSiftReset);
         _btnSiftReset = null;
         _nextBtn.dispose();
         _nextBtn = null;
         _preBtn.dispose();
         _preBtn = null;
         _createBtn.dispose();
         _createBtn = null;
         _rivalshipBtn.dispose();
         _rivalshipBtn = null;
         if(_limitAwardButton)
         {
            ObjectUtils.disposeObject(_limitAwardButton);
         }
         _limitAwardButton = null;
         if(_pveHardLeveRoomListTipPanel && _pveHardLeveRoomListTipPanel.parent)
         {
            _pveHardLeveRoomListTipPanel.parent.removeChild(_pveHardLeveRoomListTipPanel);
         }
         _pveHardLeveRoomListTipPanel.dispose();
         _pveHardLeveRoomListTipPanel = null;
         if(_pveMapRoomListTipPanel && _pveMapRoomListTipPanel.parent)
         {
            _pveMapRoomListTipPanel.parent.removeChild(_pveMapRoomListTipPanel);
         }
         _pveMapRoomListTipPanel.dispose();
         _pveMapRoomListTipPanel = null;
         if(_serverlist)
         {
            ObjectUtils.disposeObject(_serverlist);
            _serverlist = null;
         }
         if(_dungeonListBG)
         {
            ObjectUtils.disposeObject(_dungeonListBG);
            _dungeonListBG = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
