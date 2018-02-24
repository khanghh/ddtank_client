package hotSpring.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.HotSpringRoomInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.bossbox.SmallBoxButton;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import hotSpring.controller.HotSpringRoomListManager;
   import hotSpring.event.HotSpringRoomListEvent;
   import hotSpring.model.HotSpringRoomListModel;
   import road7th.comm.PackageIn;
   
   public class HotSpringMainView extends Sprite implements Disposeable
   {
       
      
      private var _model:HotSpringRoomListModel;
      
      private var _controller:HotSpringRoomListManager;
      
      private var _roomList:RoomListView;
      
      private var _boxButton:SmallBoxButton;
      
      private var _bg:Bitmap;
      
      private var _title:Bitmap;
      
      private var _bigBG:Bitmap;
      
      private var _freeBG:Bitmap;
      
      private var _roomListBG:Bitmap;
      
      private var _quickEnterBtn:BaseButton;
      
      private var _creatRoomBtn:BaseButton;
      
      private var _firstPageBtn:SimpleBitmapButton;
      
      private var _preBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _lastPagBtn:SimpleBitmapButton;
      
      private var _roomCurCount:FilterFrameText;
      
      private var _roomCount:FilterFrameText;
      
      private var _chatFrame:Sprite;
      
      private var _roomVO:HotSpringRoomInfo;
      
      public function HotSpringMainView(param1:HotSpringRoomListManager, param2:HotSpringRoomListModel){super();}
      
      protected function initialize() : void{}
      
      private function initBackground() : void{}
      
      private function initButton() : void{}
      
      private function setEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function roomListUpdateView(param1:HotSpringRoomListEvent = null) : void{}
      
      private function getPageList(param1:MouseEvent) : void{}
      
      private function createRoom(param1:MouseEvent) : void{}
      
      public function roomEnterConfirmSucceed(param1:CrazyTankSocketEvent) : void{}
      
      private function __alertResponse(param1:FrameEvent) : void{}
      
      private function confirmRoomEnter() : void{}
      
      private function __quickBuyResponse(param1:FrameEvent) : void{}
      
      private function quickEnterRoom(param1:MouseEvent) : void{}
      
      private function RoomEnterPassword(param1:String, param2:HotSpringRoomInfo) : void{}
      
      public function show() : void{}
      
      public function hide() : void{}
      
      public function dispose() : void{}
   }
}
