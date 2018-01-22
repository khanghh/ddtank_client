package entertainmentMode.view
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.SimpleDropListTarget;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import entertainmentMode.EntertainmentModeManager;
   import entertainmentMode.model.EntertainmentModel;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.comm.PackageIn;
   import room.RoomManager;
   import room.model.RoomInfo;
   import roomList.pvpRoomList.RoomListBGView;
   import shop.view.ShopItemCell;
   
   public class EntertainmentModeView extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _joinBtn:SimpleBitmapButton;
      
      private var _createBtn:SimpleBitmapButton;
      
      private var _enterBtn:SimpleBitmapButton;
      
      private var _helpBtn:BaseButton;
      
      private var _searchBg:Image;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _preBtn:SimpleBitmapButton;
      
      private var _searchTxt:SimpleDropListTarget;
      
      private var _itemList:SimpleTileList;
      
      private var _itemArray:Array;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _timeTitleTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _isPermissionEnter:Boolean;
      
      private var _box:Sprite;
      
      private var list:ScrollPanel;
      
      private var pkBtn:MovieClip;
      
      public function EntertainmentModeView()
      {
         _box = new Sprite();
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc5_:int = 0;
         var _loc1_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         _itemArray = [];
         titleText = LanguageMgr.GetTranslation("ddt.entertainmentMode.title");
         if(PathManager.pkEnable)
         {
            _bg = ComponentFactory.Instance.creat("asset.Entertainment.mode.bg2");
         }
         else
         {
            _bg = ComponentFactory.Instance.creat("asset.Entertainment.mode.bg");
         }
         addToContent(_bg);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("entertainment.HelpBtn");
         addToContent(_helpBtn);
         _joinBtn = ComponentFactory.Instance.creatComponentByStylename("asset.entertainment.joinBtn");
         _joinBtn.tipData = LanguageMgr.GetTranslation("tank.roomlist.joinBattleQuickly");
         _createBtn = ComponentFactory.Instance.creatComponentByStylename("asset.entertainment.createBtn");
         _createBtn.tipData = LanguageMgr.GetTranslation("tank.roomlist.RoomListIIRoomBtnPanel.createRoom");
         _enterBtn = ComponentFactory.Instance.creatComponentByStylename("asset.entertainment.enterBtn");
         addToContent(_joinBtn);
         addToContent(_createBtn);
         addToContent(_enterBtn);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("asset.entertainment.nextBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("asset.entertainment.preBtn");
         addToContent(_nextBtn);
         addToContent(_preBtn);
         _searchBg = ComponentFactory.Instance.creatComponentByStylename("asset.entertainment.searchBg");
         addToContent(_searchBg);
         _itemList = ComponentFactory.Instance.creat("asset.entertainment.ItemList",[2]);
         addToContent(_itemList);
         _searchTxt = ComponentFactory.Instance.creat("asset.entertainment.searchtxt");
         addToContent(_searchTxt);
         _searchTxt.restrict = "0-9";
         _scoreTxt = ComponentFactory.Instance.creat("asset.entertainment.score");
         addToContent(_scoreTxt);
         _timeTitleTxt = ComponentFactory.Instance.creat("asset.entertainment.time.title");
         addToContent(_timeTitleTxt);
         _timeTitleTxt.text = LanguageMgr.GetTranslation("ddt.entertainmentMode.TimeFieldTitle");
         _timeTxt = ComponentFactory.Instance.creat("asset.entertainment.time");
         addToContent(_timeTxt);
         _timeTxt.text = EntertainmentModeManager.instance.openTime;
         list = ComponentFactory.Instance.creat("asset.entertainment.panel");
         addToContent(list);
         list.hScrollProxy = 2;
         list.vScrollProxy = 0;
         _loc5_ = 0;
         while(_loc5_ < ServerConfigManager.instance.entertainmentScore().length)
         {
            if(_loc5_ % 2 == 0)
            {
               _loc1_ = ComponentFactory.Instance.creat("asset.Entertainment.mode.dark");
            }
            else
            {
               _loc1_ = ComponentFactory.Instance.creat("asset.Entertainment.mode.light");
            }
            _box.addChild(_loc1_);
            _loc4_ = ComponentFactory.Instance.creat("asset.entertainment.list.score");
            _box.addChild(_loc4_);
            _loc4_.text = String(ServerConfigManager.instance.entertainmentScore()[_loc5_].split("|")[0]);
            _loc4_.y = _loc5_ * _loc1_.height + 9;
            _loc1_.y = _loc5_ * _loc1_.height;
            _loc2_ = creatItemCell();
            _loc2_.buttonMode = true;
            _loc2_.cellSize = 39;
            _loc3_ = ItemManager.Instance.getTemplateById(ServerConfigManager.instance.entertainmentScore()[_loc5_].split("|")[1]);
            _loc2_.info = _loc3_;
            _loc2_.x = 126;
            _loc2_.y = _loc5_ * _loc1_.height - 7;
            _box.addChild(_loc2_);
            _loc5_++;
         }
         list.setView(_box);
         if(PathManager.pkEnable)
         {
            list.height = 303;
            pkBtn = ComponentFactory.Instance.creat("asset.Entertainment.mode.pkBtn");
            addToContent(pkBtn);
            PositionUtils.setPos(pkBtn,"asset.Entertainment.pkBtn.Pos");
         }
         list.invalidateViewport();
         _isPermissionEnter = true;
         SocketManager.Instance.out.sendEntertainment();
      }
      
      private function creatItemCell() : ShopItemCell
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,23,23);
         _loc1_.graphics.endFill();
         return CellFactory.instance.createShopItemCell(_loc1_,null,true,true) as ShopItemCell;
      }
      
      private function initEvent() : void
      {
         _preBtn.addEventListener("click",__updateClick);
         _nextBtn.addEventListener("click",__updateClick);
         addEventListener("response",__frameEventHandler);
         _searchTxt.addEventListener("mouseDown",_clickName);
         _searchTxt.addEventListener("addedToStage",setFocus);
         _joinBtn.addEventListener("click",__joinBtnHandler);
         _createBtn.addEventListener("click",__createBtnHandler);
         _enterBtn.addEventListener("click",__enterBtnHandler);
         EntertainmentModel.instance.addEventListener("roomlistchange",__roomListChanger);
         EntertainmentModel.instance.addEventListener("scoreChange",__scoreChanger);
         SocketManager.Instance.addEventListener("gameRoomListUpdate",__onEnter);
         _helpBtn.addEventListener("click",helpBtnClickHandler);
         if(pkBtn)
         {
            pkBtn.addEventListener("click",__pkBtnHandler);
         }
         _scoreTxt.text = EntertainmentModel.instance.score.toString();
         updateRoomList();
      }
      
      private function helpBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:EntertainmentInfoFrame = ComponentFactory.Instance.creatCustomObject("entertainment.infoFrame");
         LayerManager.Instance.addToLayer(_loc2_,2,true,2);
      }
      
      private function __pkBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         GameInSocketOut.sendCreateRoom(RoomListBGView.PREWORD[int(Math.random() * RoomListBGView.PREWORD.length)],42,3);
      }
      
      private function __onEnter(param1:CrazyTankSocketEvent) : void
      {
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:* = null;
         var _loc3_:Array = [];
         var _loc4_:PackageIn = param1.pkg;
         EntertainmentModel.instance.roomTotal = _loc4_.readInt();
         var _loc5_:int = _loc4_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc2_ = _loc4_.readInt();
            _loc6_ = new RoomInfo();
            _loc6_.ID = _loc2_;
            _loc6_.type = _loc4_.readByte();
            _loc6_.timeType = _loc4_.readByte();
            _loc6_.totalPlayer = _loc4_.readByte();
            _loc6_.viewerCnt = _loc4_.readByte();
            _loc6_.maxViewerCnt = _loc4_.readByte();
            _loc6_.placeCount = _loc4_.readByte();
            _loc6_.IsLocked = _loc4_.readBoolean();
            _loc6_.mapId = _loc4_.readInt();
            _loc6_.isPlaying = _loc4_.readBoolean();
            _loc6_.Name = _loc4_.readUTF();
            _loc6_.gameMode = _loc4_.readByte();
            _loc6_.hardLevel = _loc4_.readByte();
            _loc6_.levelLimits = _loc4_.readInt();
            _loc6_.isOpenBoss = _loc4_.readBoolean();
            _loc3_.push(_loc6_);
            _loc7_++;
         }
         EntertainmentModel.instance.updateRoom(_loc3_);
      }
      
      private function __scoreChanger(param1:Event) : void
      {
         _scoreTxt.text = EntertainmentModel.instance.score.toString();
      }
      
      private function __gameStart(param1:CrazyTankSocketEvent) : void
      {
      }
      
      private function __enterBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_searchTxt.text == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIIFindRoomPanel.id"));
            return;
         }
         SocketManager.Instance.out.sendGameLogin(8,-1,int(_searchTxt.text));
      }
      
      private function __createBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         GameInSocketOut.sendCreateRoom(RoomListBGView.PREWORD[int(Math.random() * RoomListBGView.PREWORD.length)],41,3);
      }
      
      private function __joinBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_isPermissionEnter)
         {
            return;
         }
         SocketManager.Instance.out.sendGameLogin(8,41);
         _isPermissionEnter = false;
      }
      
      private function __updateClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendSift();
      }
      
      private function sendSift() : void
      {
         SocketManager.Instance.out.sendSceneLogin(8);
      }
      
      private function __roomListChanger(param1:Event) : void
      {
         updateRoomList();
      }
      
      private function updateRoomList() : void
      {
         var _loc2_:* = null;
         cleanItem();
         var _loc4_:int = 0;
         var _loc3_:* = EntertainmentModel.instance.roomList;
         for each(var _loc1_ in EntertainmentModel.instance.roomList)
         {
            _loc2_ = new EntertainmentListItem(_loc1_);
            _loc2_.addEventListener("click",__itemClick,false,0,true);
            _itemList.addChild(_loc2_);
            _itemArray.push(_loc2_);
         }
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         if(!_isPermissionEnter)
         {
            return;
         }
         SoundManager.instance.play("008");
         var _loc2_:EntertainmentListItem = param1.currentTarget as EntertainmentListItem;
         SocketManager.Instance.out.sendGameLogin(8,-1,_loc2_.info.ID);
         _isPermissionEnter = false;
      }
      
      private function _clickName(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_searchTxt.text == LanguageMgr.GetTranslation("ddt.entertainmentMode.input.roomNumber"))
         {
            _searchTxt.text = "";
         }
      }
      
      private function setFocus(param1:Event) : void
      {
         _searchTxt.text = LanguageMgr.GetTranslation("ddt.entertainmentMode.input.roomNumber");
         _searchTxt.setFocus();
         _searchTxt.setCursor(_searchTxt.text.length);
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               EntertainmentModeManager.instance.hide();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function removeEvent() : void
      {
         _preBtn.removeEventListener("click",__updateClick);
         _nextBtn.removeEventListener("click",__updateClick);
         removeEventListener("response",__frameEventHandler);
         _searchTxt.removeEventListener("mouseDown",_clickName);
         _searchTxt.removeEventListener("addedToStage",setFocus);
         _joinBtn.removeEventListener("click",__joinBtnHandler);
         _createBtn.removeEventListener("click",__createBtnHandler);
         _enterBtn.removeEventListener("click",__enterBtnHandler);
         EntertainmentModel.instance.removeEventListener("roomlistchange",__roomListChanger);
         EntertainmentModel.instance.removeEventListener("scoreChange",__scoreChanger);
         SocketManager.Instance.removeEventListener("gameRoomListUpdate",__onEnter);
         _helpBtn.removeEventListener("click",helpBtnClickHandler);
         if(pkBtn)
         {
            pkBtn.removeEventListener("click",__pkBtnHandler);
         }
      }
      
      private function cleanItem() : void
      {
         var _loc1_:int = 0;
         _isPermissionEnter = true;
         _loc1_ = 0;
         while(_loc1_ < _itemArray.length)
         {
            _itemArray[_loc1_].removeEventListener("click",__itemClick);
            _itemArray[_loc1_].dispose();
            _loc1_++;
         }
         _itemList.disposeAllChildren();
         _itemArray = [];
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         RoomManager.Instance.isEnterTainmentRoom = false;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_searchBg);
         _searchBg = null;
         ObjectUtils.disposeObject(_searchTxt);
         _searchTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_timeTitleTxt);
         _timeTitleTxt = null;
         ObjectUtils.disposeObject(_box);
         _box = null;
         if(pkBtn)
         {
            ObjectUtils.disposeObject(pkBtn);
            pkBtn = null;
         }
         if(list)
         {
            ObjectUtils.disposeObject(list);
            list = null;
         }
         if(_helpBtn)
         {
            _helpBtn.dispose();
            _helpBtn = null;
         }
         if(_joinBtn)
         {
            _joinBtn.dispose();
            _joinBtn = null;
         }
         if(_createBtn)
         {
            _createBtn.dispose();
            _createBtn = null;
         }
         if(_enterBtn)
         {
            _enterBtn.dispose();
            _enterBtn = null;
         }
         if(_nextBtn)
         {
            _nextBtn.dispose();
            _nextBtn = null;
         }
         if(_preBtn)
         {
            _preBtn.dispose();
            _preBtn = null;
         }
         _itemList.dispose();
         _itemList = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
