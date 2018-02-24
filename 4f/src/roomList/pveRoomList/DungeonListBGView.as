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
      
      public function DungeonListBGView(param1:DungeonListController, param2:DungeonListModel){super();}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function initControl() : void{}
      
      private function removeEvent() : void{}
      
      private function __loginRoomRes(param1:Event) : void{}
      
      private function __rivalshipBtnClick(param1:MouseEvent) : void{}
      
      private function __stageClick(param1:MouseEvent) : void{}
      
      private function __lookupClick(param1:MouseEvent) : void{}
      
      private function __fbChange(param1:Event) : void{}
      
      private function __hardLvChange(param1:Event) : void{}
      
      private function __siftReset(param1:MouseEvent) : void{}
      
      private function sendSift() : void{}
      
      private function resetSift() : void{}
      
      private function setTxtCbFb(param1:String) : void{}
      
      private function setTxtCbHardLv(param1:String) : void{}
      
      private function getHardLvTxt(param1:int) : String{return null;}
      
      private function addTipPanel() : void{}
      
      private function __clearRoom(param1:DictionaryEvent) : void{}
      
      private function __addRoom(param1:Event) : void{}
      
      private function upadteItemPos() : void{}
      
      private function getSelectItemPos(param1:int) : int{return 0;}
      
      public function get currentDataList() : Array{return null;}
      
      private function getInfosPos(param1:int) : int{return 0;}
      
      private function __iconBtnIIClick(param1:MouseEvent) : void{}
      
      private function __iconBtnIIIClick(param1:MouseEvent) : void{}
      
      private function __updateClick(param1:MouseEvent) : void{}
      
      private function __itemClick(param1:MouseEvent) : void{}
      
      public function gotoIntoRoom(param1:RoomInfo) : void{}
      
      private function __createClick(param1:MouseEvent) : void{}
      
      private function cleanItem() : void{}
      
      public function dispose() : void{}
   }
}
