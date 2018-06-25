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
      
      public function HotSpringMainView(controller:HotSpringRoomListManager, model:HotSpringRoomListModel)
      {
         super();
         _controller = controller;
         _model = model;
         initialize();
      }
      
      protected function initialize() : void
      {
         SoundManager.instance.playMusic("062");
         initBackground();
         initButton();
         _roomCurCount = ComponentFactory.Instance.creat("asset.HotSpringMainView.roomCurCount");
         addChild(_roomCurCount);
         _roomCount = ComponentFactory.Instance.creat("asset.HotSpringMainView.roomCount");
         addChild(_roomCount);
         _roomList = new RoomListView(_controller,_model);
         var pos:Point = ComponentFactory.Instance.creatCustomObject("asset.HotSpringMainView.roomListPos");
         _roomList.x = pos.x;
         _roomList.y = pos.y;
         addChild(_roomList);
         if(BossBoxManager.instance.isShowBoxButton())
         {
            _boxButton = new SmallBoxButton(6);
            addChild(_boxButton);
         }
         roomListUpdateView();
         ChatManager.Instance.state = 17;
         _chatFrame = ChatManager.Instance.view;
         addChild(_chatFrame);
         setEvent();
      }
      
      private function initBackground() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.HotSpringRoomList.bg");
         addChild(_bg);
         _bigBG = ComponentFactory.Instance.creatBitmap("asset.HotSpringMainView.IMGBGAsset");
         addChild(_bigBG);
         _title = ComponentFactory.Instance.creatBitmap("asset.HotSpringMainView.titleBGAsset");
         addChild(_title);
         _freeBG = ComponentFactory.Instance.creatBitmap("asset.HotSpringMainView.freeIMGAsset");
         addChild(_freeBG);
         _roomListBG = ComponentFactory.Instance.creatBitmap("asset.HotSpringMainView.listBG");
         addChild(_roomListBG);
      }
      
      private function initButton() : void
      {
         _quickEnterBtn = ComponentFactory.Instance.creatComponentByStylename("asset.HotSpringMainView.quickEnterBtn");
         addChild(_quickEnterBtn);
         _creatRoomBtn = ComponentFactory.Instance.creatComponentByStylename("asset.HotSpringMainView.creatRoomBtn");
         addChild(_creatRoomBtn);
         _creatRoomBtn.enable = false;
         _firstPageBtn = ComponentFactory.Instance.creatComponentByStylename("asset.HotSpringMainView.firstPageBtn");
         addChild(_firstPageBtn);
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("asset.HotSpringMainView.preBtn");
         addChild(_preBtn);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("asset.HotSpringMainView.nextBtn");
         addChild(_nextBtn);
         _lastPagBtn = ComponentFactory.Instance.creatComponentByStylename("asset.HotSpringMainView.lastPagBtn");
         addChild(_lastPagBtn);
      }
      
      private function setEvent() : void
      {
         _firstPageBtn.addEventListener("click",getPageList);
         _preBtn.addEventListener("click",getPageList);
         _nextBtn.addEventListener("click",getPageList);
         _lastPagBtn.addEventListener("click",getPageList);
         _creatRoomBtn.addEventListener("click",createRoom);
         _quickEnterBtn.addEventListener("click",quickEnterRoom);
         _roomList.addEventListener("roomListUpdateView",roomListUpdateView);
         SocketManager.Instance.addEventListener(PkgEvent.format(212),roomEnterConfirmSucceed);
      }
      
      private function removeEvent() : void
      {
         _firstPageBtn.removeEventListener("click",getPageList);
         _preBtn.removeEventListener("click",getPageList);
         _nextBtn.removeEventListener("click",getPageList);
         _lastPagBtn.removeEventListener("click",getPageList);
         _creatRoomBtn.removeEventListener("click",createRoom);
         _quickEnterBtn.removeEventListener("click",quickEnterRoom);
         _roomList.removeEventListener("roomListUpdateView",roomListUpdateView);
         SocketManager.Instance.removeEventListener(PkgEvent.format(212),roomEnterConfirmSucceed);
      }
      
      private function roomListUpdateView(evt:HotSpringRoomListEvent = null) : void
      {
         _roomCurCount.text = _roomList.pageCount > 0?_roomList.pageIndex.toString():"0";
         _roomCount.text = "/" + _roomList.pageCount.toString();
         var _loc2_:* = _roomList.pageCount > 0 && _roomList.pageIndex > 1;
         _preBtn.enable = _loc2_;
         _firstPageBtn.enable = _loc2_;
         _loc2_ = _roomList.pageCount > 0 && _roomList.pageIndex < _roomList.pageCount;
         _lastPagBtn.enable = _loc2_;
         _nextBtn.enable = _loc2_;
      }
      
      private function getPageList(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = evt.currentTarget;
         if(_firstPageBtn !== _loc2_)
         {
            if(_preBtn !== _loc2_)
            {
               if(_nextBtn !== _loc2_)
               {
                  if(_lastPagBtn === _loc2_)
                  {
                     _roomList.pageIndex = _roomList.pageCount;
                  }
               }
               else
               {
                  _roomList.pageIndex = _roomList.pageIndex + 1 <= _roomList.pageCount?_roomList.pageIndex + 1:_roomList.pageCount;
               }
            }
            else
            {
               _roomList.pageIndex = _roomList.pageIndex - 1 > 0?_roomList.pageIndex - 1:1;
            }
         }
         else
         {
            _roomList.pageIndex = 1;
         }
      }
      
      private function createRoom(evt:MouseEvent) : void
      {
      }
      
      public function roomEnterConfirmSucceed(evt:CrazyTankSocketEvent) : void
      {
         var alert:* = null;
         var pkg:PackageIn = evt.pkg;
         var roomID:int = pkg.readInt();
         _roomVO = _model.roomList[roomID];
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_roomVO.roomType != 3)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.hotSpring.comfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            alert.moveEnable = false;
            alert.addEventListener("response",__alertResponse);
         }
      }
      
      private function __alertResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         ObjectUtils.disposeObject(alert);
         if(alert.parent)
         {
            alert.parent.removeChild(alert);
         }
         if(evt.responseCode == 3)
         {
            confirmRoomEnter();
         }
      }
      
      private function confirmRoomEnter() : void
      {
         var alert:* = null;
         if(PlayerManager.Instance.Self.Gold < 10000)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            alert.moveEnable = false;
            alert.addEventListener("response",__quickBuyResponse);
            return;
         }
         if(_controller)
         {
            _controller.roomEnter(_roomVO.roomID,"");
         }
      }
      
      private function __quickBuyResponse(evt:FrameEvent) : void
      {
         var quickBuy:* = null;
         SoundManager.instance.play("008");
         var frame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__quickBuyResponse);
         frame.dispose();
         if(frame.parent)
         {
            frame.parent.removeChild(frame);
         }
         frame = null;
         if(evt.responseCode == 3)
         {
            quickBuy = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            quickBuy.itemID = 11233;
            quickBuy.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            LayerManager.Instance.addToLayer(quickBuy,3,true,1);
         }
      }
      
      private function quickEnterRoom(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _controller.quickEnterRoom();
      }
      
      private function RoomEnterPassword(inputPassword:String, roomVO:HotSpringRoomInfo) : void
      {
      }
      
      public function show() : void
      {
         _controller.addChild(this);
         _controller.hotSpringEnter();
      }
      
      public function hide() : void
      {
         _controller.removeChild(this);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_quickEnterBtn)
         {
            ObjectUtils.disposeObject(_quickEnterBtn);
         }
         _quickEnterBtn = null;
         if(_creatRoomBtn)
         {
            ObjectUtils.disposeObject(_creatRoomBtn);
         }
         _creatRoomBtn = null;
         if(_firstPageBtn)
         {
            ObjectUtils.disposeObject(_firstPageBtn);
         }
         _firstPageBtn = null;
         if(_preBtn)
         {
            ObjectUtils.disposeObject(_preBtn);
         }
         _preBtn = null;
         if(_nextBtn)
         {
            ObjectUtils.disposeObject(_nextBtn);
         }
         _nextBtn = null;
         if(_lastPagBtn)
         {
            ObjectUtils.disposeObject(_lastPagBtn);
         }
         _lastPagBtn = null;
         if(_roomCurCount)
         {
            ObjectUtils.disposeObject(_roomCurCount);
         }
         _roomCurCount = null;
         if(_roomCount)
         {
            ObjectUtils.disposeObject(_roomCount);
         }
         _roomCount = null;
         if(_roomList)
         {
            ObjectUtils.disposeObject(_roomList);
         }
         _roomList = null;
         if(_boxButton)
         {
            ObjectUtils.disposeObject(_boxButton);
         }
         _boxButton = null;
         _model = null;
         _controller = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_bigBG)
         {
            ObjectUtils.disposeObject(_bigBG);
         }
         _bigBG = null;
         if(_freeBG)
         {
            ObjectUtils.disposeObject(_freeBG);
         }
         _freeBG = null;
         if(_roomListBG)
         {
            ObjectUtils.disposeObject(_roomListBG);
         }
         _roomListBG = null;
         if(_chatFrame)
         {
            ObjectUtils.disposeObject(_chatFrame);
         }
         _chatFrame = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
