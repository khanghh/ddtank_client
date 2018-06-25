package entertainmentMode.view{   import bagAndInfo.cell.CellFactory;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.SimpleDropListTarget;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import entertainmentMode.EntertainmentModeManager;   import entertainmentMode.model.EntertainmentModel;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import road7th.comm.PackageIn;   import room.RoomManager;   import room.model.RoomInfo;   import roomList.pvpRoomList.RoomListBGView;   import shop.view.ShopItemCell;      public class EntertainmentModeView extends Frame   {                   private var _bg:Bitmap;            private var _joinBtn:SimpleBitmapButton;            private var _createBtn:SimpleBitmapButton;            private var _enterBtn:SimpleBitmapButton;            private var _helpBtn:BaseButton;            private var _searchBg:Image;            private var _nextBtn:SimpleBitmapButton;            private var _preBtn:SimpleBitmapButton;            private var _searchTxt:SimpleDropListTarget;            private var _itemList:SimpleTileList;            private var _itemArray:Array;            private var _scoreTxt:FilterFrameText;            private var _timeTitleTxt:FilterFrameText;            private var _timeTxt:FilterFrameText;            private var _isPermissionEnter:Boolean;            private var _box:Sprite;            private var list:ScrollPanel;            private var pkBtn:MovieClip;            public function EntertainmentModeView() { super(); }
            private function initView() : void { }
            private function creatItemCell() : ShopItemCell { return null; }
            private function initEvent() : void { }
            private function helpBtnClickHandler(e:MouseEvent) : void { }
            private function __pkBtnHandler(e:MouseEvent) : void { }
            private function __onEnter(evt:CrazyTankSocketEvent) : void { }
            private function __scoreChanger(e:Event) : void { }
            private function __gameStart(evt:CrazyTankSocketEvent) : void { }
            private function __enterBtnHandler(e:MouseEvent) : void { }
            private function __createBtnHandler(e:MouseEvent) : void { }
            private function __joinBtnHandler(e:MouseEvent) : void { }
            private function __updateClick(e:MouseEvent) : void { }
            private function sendSift() : void { }
            private function __roomListChanger(e:Event) : void { }
            private function updateRoomList() : void { }
            private function __itemClick(event:MouseEvent) : void { }
            private function _clickName(e:MouseEvent) : void { }
            private function setFocus(e:Event) : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            public function show() : void { }
            private function removeEvent() : void { }
            private function cleanItem() : void { }
            override public function dispose() : void { }
   }}