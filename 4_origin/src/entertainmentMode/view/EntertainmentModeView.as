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
         var i:int = 0;
         var _bitmap:* = null;
         var _txt:* = null;
         var _itemCell:* = null;
         var _info:* = null;
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
         for(i = 0; i < ServerConfigManager.instance.entertainmentScore().length; )
         {
            if(i % 2 == 0)
            {
               _bitmap = ComponentFactory.Instance.creat("asset.Entertainment.mode.dark");
            }
            else
            {
               _bitmap = ComponentFactory.Instance.creat("asset.Entertainment.mode.light");
            }
            _box.addChild(_bitmap);
            _txt = ComponentFactory.Instance.creat("asset.entertainment.list.score");
            _box.addChild(_txt);
            _txt.text = String(ServerConfigManager.instance.entertainmentScore()[i].split("|")[0]);
            _txt.y = i * _bitmap.height + 9;
            _bitmap.y = i * _bitmap.height;
            _itemCell = creatItemCell();
            _itemCell.buttonMode = true;
            _itemCell.cellSize = 39;
            _info = ItemManager.Instance.getTemplateById(ServerConfigManager.instance.entertainmentScore()[i].split("|")[1]);
            _itemCell.info = _info;
            _itemCell.x = 126;
            _itemCell.y = i * _bitmap.height - 7;
            _box.addChild(_itemCell);
            i++;
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
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,23,23);
         sp.graphics.endFill();
         return CellFactory.instance.createShopItemCell(sp,null,true,true) as ShopItemCell;
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
      
      private function helpBtnClickHandler(e:MouseEvent) : void
      {
         var helpPage:EntertainmentInfoFrame = ComponentFactory.Instance.creatCustomObject("entertainment.infoFrame");
         LayerManager.Instance.addToLayer(helpPage,2,true,2);
      }
      
      private function __pkBtnHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         GameInSocketOut.sendCreateRoom(RoomListBGView.PREWORD[int(Math.random() * RoomListBGView.PREWORD.length)],42,3);
      }
      
      private function __onEnter(evt:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var id:int = 0;
         var info:* = null;
         var listArr:Array = [];
         var pkg:PackageIn = evt.pkg;
         EntertainmentModel.instance.roomTotal = pkg.readInt();
         var len:int = pkg.readInt();
         for(i = 0; i < len; )
         {
            id = pkg.readInt();
            info = new RoomInfo();
            info.ID = id;
            info.type = pkg.readByte();
            info.timeType = pkg.readByte();
            info.totalPlayer = pkg.readByte();
            info.viewerCnt = pkg.readByte();
            info.maxViewerCnt = pkg.readByte();
            info.placeCount = pkg.readByte();
            info.IsLocked = pkg.readBoolean();
            info.mapId = pkg.readInt();
            info.isPlaying = pkg.readBoolean();
            info.Name = pkg.readUTF();
            info.gameMode = pkg.readByte();
            info.hardLevel = pkg.readByte();
            info.levelLimits = pkg.readInt();
            info.isOpenBoss = pkg.readBoolean();
            listArr.push(info);
            i++;
         }
         EntertainmentModel.instance.updateRoom(listArr);
      }
      
      private function __scoreChanger(e:Event) : void
      {
         _scoreTxt.text = EntertainmentModel.instance.score.toString();
      }
      
      private function __gameStart(evt:CrazyTankSocketEvent) : void
      {
      }
      
      private function __enterBtnHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_searchTxt.text == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIIFindRoomPanel.id"));
            return;
         }
         SocketManager.Instance.out.sendGameLogin(8,-1,int(_searchTxt.text));
      }
      
      private function __createBtnHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         GameInSocketOut.sendCreateRoom(RoomListBGView.PREWORD[int(Math.random() * RoomListBGView.PREWORD.length)],41,3);
      }
      
      private function __joinBtnHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_isPermissionEnter)
         {
            return;
         }
         SocketManager.Instance.out.sendGameLogin(8,41);
         _isPermissionEnter = false;
      }
      
      private function __updateClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendSift();
      }
      
      private function sendSift() : void
      {
         SocketManager.Instance.out.sendSceneLogin(8);
      }
      
      private function __roomListChanger(e:Event) : void
      {
         updateRoomList();
      }
      
      private function updateRoomList() : void
      {
         var item:* = null;
         cleanItem();
         var _loc4_:int = 0;
         var _loc3_:* = EntertainmentModel.instance.roomList;
         for each(var room1 in EntertainmentModel.instance.roomList)
         {
            item = new EntertainmentListItem(room1);
            item.addEventListener("click",__itemClick,false,0,true);
            _itemList.addChild(item);
            _itemArray.push(item);
         }
      }
      
      private function __itemClick(event:MouseEvent) : void
      {
         if(!_isPermissionEnter)
         {
            return;
         }
         SoundManager.instance.play("008");
         var itemView:EntertainmentListItem = event.currentTarget as EntertainmentListItem;
         SocketManager.Instance.out.sendGameLogin(8,-1,itemView.info.ID);
         _isPermissionEnter = false;
      }
      
      private function _clickName(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_searchTxt.text == LanguageMgr.GetTranslation("ddt.entertainmentMode.input.roomNumber"))
         {
            _searchTxt.text = "";
         }
      }
      
      private function setFocus(e:Event) : void
      {
         _searchTxt.text = LanguageMgr.GetTranslation("ddt.entertainmentMode.input.roomNumber");
         _searchTxt.setFocus();
         _searchTxt.setCursor(_searchTxt.text.length);
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
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
         var i:int = 0;
         _isPermissionEnter = true;
         for(i = 0; i < _itemArray.length; )
         {
            _itemArray[i].removeEventListener("click",__itemClick);
            _itemArray[i].dispose();
            i++;
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
