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
      
      public function DungeonListBGView(controlle:DungeonListController, model:DungeonListModel)
      {
         _controlle = controlle;
         _model = model;
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
         var severName:String = String(ServerManager.Instance.current.Name);
         var num:int = severName.indexOf("(");
         num = num == -1?severName.length:int(num);
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
      
      private function __loginRoomRes(evt:Event) : void
      {
         _isPermissionEnter = true;
      }
      
      private function __rivalshipBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_isPermissionEnter)
         {
            return;
         }
         SocketManager.Instance.out.sendGameLogin(2,4);
         _isPermissionEnter = false;
      }
      
      private function __stageClick(event:MouseEvent) : void
      {
         if(!DisplayUtils.isTargetOrContain(event.target as DisplayObject,_iconBtnII) && !DisplayUtils.isTargetOrContain(event.target as DisplayObject,_iconBtnIII) && !DisplayUtils.isTargetOrContain(event.target as DisplayObject,_bmpCbFb) && !DisplayUtils.isTargetOrContain(event.target as DisplayObject,_bmpCbHardLv) && !(event.target is BaseButton) && !(event.target is ScaleBitmapImage && (event.target as DisplayObject).parent is Scrollbar))
         {
            _pveMapRoomListTipPanel.visible = false;
            _pveHardLeveRoomListTipPanel.visible = false;
         }
      }
      
      private function __lookupClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _controlle.showFindRoom();
      }
      
      private function __fbChange(evt:Event) : void
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
      
      private function __hardLvChange(evt:Event) : void
      {
         sendSift();
         setTxtCbHardLv(getHardLvTxt(_pveHardLeveRoomListTipPanel.value));
      }
      
      private function __siftReset(evt:MouseEvent) : void
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
      
      private function setTxtCbFb(txt:String) : void
      {
         _txtCbFb.text = txt;
         _txtCbFb.x = _bmpCbFb.x + (_bmpCbFb.width - _iconBtnII.width - _txtCbFb.width) / 2;
      }
      
      private function setTxtCbHardLv(txt:String) : void
      {
         _txtCbHardLv.text = LanguageMgr.GetTranslation(txt);
         _txtCbHardLv.x = _bmpCbHardLv.x + (_bmpCbHardLv.width - _iconBtnIII.width - _txtCbHardLv.width) / 2;
      }
      
      private function getHardLvTxt(value:int) : String
      {
         switch(int(value) - 1007)
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
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         var hardLeve_01:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroomList.hardLevel_01");
         var hardLeve_02:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroomList.hardLevel_02");
         var hardLeve_03:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroomList.hardLevel_03");
         var hardLeve_04:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroomList.hardLevel_04");
         var hardLeve_05:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroomList.hardLevel_05");
         var hardLeve_06:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroomList.hardLevel_06");
         var hardLeve_07:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroomList.hardLevel_07");
         var dungeonListTipPanelSizeII:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroomList.pve.DungeonListTipPanelSizeII");
         _pveHardLeveRoomListTipPanel = new RoomListTipPanel(dungeonListTipPanelSizeII.x,dungeonListTipPanelSizeII.y);
         _pveHardLeveRoomListTipPanel.addItem(hardLeve_05,1013);
         _pveHardLeveRoomListTipPanel.addItem(hardLeve_01,1007);
         _pveHardLeveRoomListTipPanel.addItem(hardLeve_02,1008);
         _pveHardLeveRoomListTipPanel.addItem(hardLeve_03,1009);
         _pveHardLeveRoomListTipPanel.addItem(hardLeve_04,1010);
         _pveHardLeveRoomListTipPanel.addItem(hardLeve_07,1011);
         _pveHardLeveRoomListTipPanel.addItem(hardLeve_06,1012);
         var posII:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroomList.pve.pveHardLeveRoomListTipPanelPos");
         _pveHardLeveRoomListTipPanel.x = posII.x;
         _pveHardLeveRoomListTipPanel.y = posII.y;
         _pveHardLeveRoomListTipPanel.visible = false;
         addChild(_pveHardLeveRoomListTipPanel);
         var posIII:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroomList.pve.pveMapPanelPos");
         var dungeonListTipPanelSizeIII:Point = ComponentFactory.Instance.creatCustomObject("roomList.DungeonList.DungeonListTipPanelSizeIII");
         _pveMapRoomListTipPanel = new RoomListMapTipPanel(dungeonListTipPanelSizeIII.x,dungeonListTipPanelSizeIII.y);
         _pveMapRoomListTipPanel.x = posIII.x;
         _pveMapRoomListTipPanel.y = posIII.y;
         _pveMapRoomListTipPanel.addItem(10000);
         for(i = 1; i < 13; )
         {
            if(MapManager.getByOrderingDungeonInfo(i))
            {
               _pveMapRoomListTipPanel.addItem(MapManager.getByOrderingDungeonInfo(i).ID);
            }
            i++;
         }
         for(j = 1; j < 13; )
         {
            if(MapManager.getByOrderingAcademyDungeonInfo(j))
            {
               _pveMapRoomListTipPanel.addItem(MapManager.getByOrderingAcademyDungeonInfo(j).ID);
            }
            j++;
         }
         for(k = 1; k < 13; )
         {
            if(MapManager.getByOrderingActivityDungeonInfo(k))
            {
               if(MapManager.Instance.activeDoubleIds.indexOf(MapManager.getByOrderingActivityDungeonInfo(k).ID) == -1)
               {
                  _pveMapRoomListTipPanel.addItem(MapManager.getByOrderingActivityDungeonInfo(k).ID);
               }
            }
            k++;
         }
         _pveMapRoomListTipPanel.visible = false;
         addChild(_pveMapRoomListTipPanel);
      }
      
      private function __clearRoom(event:DictionaryEvent) : void
      {
         cleanItem();
         _isPermissionEnter = true;
      }
      
      private function __addRoom(event:Event) : void
      {
         upadteItemPos();
         _isPermissionEnter = true;
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
            cleanItem();
            var _loc6_:int = 0;
            var _loc5_:* = _tempDataList;
            for each(var info in _tempDataList)
            {
               if(info)
               {
                  item = new DungeonListItemView(info);
                  item.addEventListener("click",__itemClick,false,0,true);
                  _itemList.addChild(item);
                  _itemArray.push(item);
               }
            }
         }
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
            if(!(_itemArray[i] as DungeonListItemView))
            {
               return 0;
            }
            if((_itemArray[i] as DungeonListItemView).id == id)
            {
               _selectItemPos = i;
               _selectItemID = (_itemArray[i] as DungeonListItemView).id;
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
      
      private function __iconBtnIIClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _pveMapRoomListTipPanel.visible = !_pveMapRoomListTipPanel.visible;
         _pveHardLeveRoomListTipPanel.visible = false;
      }
      
      private function __iconBtnIIIClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _pveHardLeveRoomListTipPanel.visible = !_pveHardLeveRoomListTipPanel.visible;
         _pveMapRoomListTipPanel.visible = false;
      }
      
      private function __updateClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendSift();
      }
      
      private function __itemClick(event:MouseEvent) : void
      {
         if(!_isPermissionEnter)
         {
            return;
         }
         SoundManager.instance.play("008");
         var itemView:DungeonListItemView = event.currentTarget as DungeonListItemView;
         if(PlayerManager.Instance.Self.Grade < 25 && itemView.info.type == 21)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.ActivityDungeon.promptInfo",25));
            return;
         }
         gotoIntoRoom(itemView.info);
         getSelectItemPos(itemView.id);
      }
      
      public function gotoIntoRoom(info:RoomInfo) : void
      {
         SocketManager.Instance.out.sendGameLogin(2,-1,info.ID,"");
         _isPermissionEnter = false;
      }
      
      private function __createClick(event:MouseEvent) : void
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
         var i:int = 0;
         for(i = 0; i < _itemArray.length; )
         {
            (_itemArray[i] as DungeonListItemView).removeEventListener("click",__itemClick);
            (_itemArray[i] as DungeonListItemView).dispose();
            i++;
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
