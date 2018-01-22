package magicHouse.magicBox
{
   import bagAndInfo.bag.RichesButton;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import invite.InviteManager;
   import magicHouse.MagicBoxExtractionDragInArea;
   import magicHouse.MagicHouseManager;
   import magicHouse.MagicHouseModel;
   import road7th.data.DictionaryData;
   import store.events.StoreDargEvent;
   import store.view.storeBag.StoreBagCell;
   import store.view.storeBag.StoreBagListView;
   import store.view.storeBag.StoreBagbgbmp;
   
   public class MagicHouseExtraction extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _selfEliteCounts:Bitmap;
      
      private var _selfEliteCountsTxt:FilterFrameText;
      
      private var _selfEliteCountsTxt2:FilterFrameText;
      
      private var _cellContentBg:Bitmap;
      
      private var _getCountBg:Bitmap;
      
      private var _getCounts:Bitmap;
      
      private var _getCountsTxt:FilterFrameText;
      
      private var _tempTxt:FilterFrameText;
      
      private var _extractionBtn:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _helpFrame:Frame;
      
      private var _bgHelp:Scale9CornerImage;
      
      private var _content:MovieClip;
      
      private var _btnOk:TextButton;
      
      private var _equipListView:StoreBagListView;
      
      private var _propListView:StoreBagListView;
      
      private var _equipmentTitleText:FilterFrameText;
      
      private var _equipmentTipText:FilterFrameText;
      
      private var _itemTitleText:FilterFrameText;
      
      private var _itemTipText:FilterFrameText;
      
      private var _bitmapBg:StoreBagbgbmp;
      
      private var bagBg:ScaleFrameImage;
      
      private var moneyTxt:FilterFrameText;
      
      private var giftTxt:FilterFrameText;
      
      private var goldTxt:FilterFrameText;
      
      private var _goldButton:RichesButton;
      
      private var _giftButton:RichesButton;
      
      private var _moneyButton:RichesButton;
      
      private var _extractionCell:MagicBoxExtractionCell;
      
      private var _area:MagicBoxExtractionDragInArea;
      
      private var _extractionMc:MovieClip;
      
      private var _numBox:HBox;
      
      private var _mashArea:MagicBoxMashArea;
      
      private var _aler:MagicBoxExtractionSelectedNumAlertFrame;
      
      public function MagicHouseExtraction()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("magichouse.magicbox.view.bg");
         PositionUtils.setPos(_bg,"magicHouse.magicbox.extractionviewbgPos");
         addChild(_bg);
         _selfEliteCounts = ComponentFactory.Instance.creatBitmap("magichouse.magicbox.selfelitecounttxt");
         addChild(_selfEliteCounts);
         _selfEliteCountsTxt = ComponentFactory.Instance.creatComponentByStylename("magichouse.magicbox.selfEliteCountsTxt");
         addChild(_selfEliteCountsTxt);
         _selfEliteCountsTxt2 = ComponentFactory.Instance.creatComponentByStylename("magichouse.magicbox.selfEliteCountsTxt");
         addChild(_selfEliteCountsTxt2);
         _cellContentBg = ComponentFactory.Instance.creatBitmap("magichouse.magicbox.extractioncellcontent.bg");
         addChild(_cellContentBg);
         _getCountBg = ComponentFactory.Instance.creatBitmap("magichouse.magicbox.getelitebg");
         addChild(_getCountBg);
         _getCounts = ComponentFactory.Instance.creatBitmap("magichouse.magicbox.getelitetxt");
         addChild(_getCounts);
         _getCountsTxt = ComponentFactory.Instance.creatComponentByStylename("magichouse.magicbox.getCountsTxt");
         addChild(_getCountsTxt);
         _tempTxt = ComponentFactory.Instance.creatComponentByStylename("magichouse.magicbox.tempTxt");
         _tempTxt.text = LanguageMgr.GetTranslation("magichouse.magicboxView.extractiontTipTxt");
         addChild(_tempTxt);
         _extractionBtn = ComponentFactory.Instance.creatComponentByStylename("magicHouse.magicbox.extractionBtn");
         addChild(_extractionBtn);
         _bitmapBg = new StoreBagbgbmp();
         PositionUtils.setPos(_bitmapBg,"magicHouse.magicbox.storebagbgPos");
         addChild(_bitmapBg);
         bagBg = ComponentFactory.Instance.creatComponentByStylename("magicbox.StoreBagViewBg2");
         addChild(bagBg);
         _equipListView = ComponentFactory.Instance.creatCustomObject("magicbox.extractionviewEquiplistPos");
         _equipListView.setup(0,null,21);
         addChild(_equipListView);
         _propListView = ComponentFactory.Instance.creatCustomObject("magicbox.extractionviewProplistPos");
         _propListView.setup(1,null,21);
         addChild(_propListView);
         _equipmentTitleText = ComponentFactory.Instance.creatComponentByStylename("magicbox.StoreBagView.EquipmentTitleText");
         _equipmentTitleText.text = LanguageMgr.GetTranslation("store.StoreBagView.EquipmentTitleText");
         _equipmentTipText = ComponentFactory.Instance.creatComponentByStylename("magicbox.StoreBagView.EquipmentTipText");
         _equipmentTipText.text = LanguageMgr.GetTranslation("magichouse.magicboxView.extractionDoubleClickTxt1");
         _itemTitleText = ComponentFactory.Instance.creatComponentByStylename("magicbox.StoreBagView.ItemTitleText");
         _itemTitleText.text = LanguageMgr.GetTranslation("store.StoreBagView.ItemTitleText");
         _itemTipText = ComponentFactory.Instance.creatComponentByStylename("magicbox.StoreBagView.ItemTipText");
         _itemTipText.text = LanguageMgr.GetTranslation("magichouse.magicboxView.extractionDoubleClickTxt2");
         addChild(_equipmentTitleText);
         addChild(_itemTitleText);
         addChild(_equipmentTipText);
         addChild(_itemTipText);
         var _loc1_:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("magicbox.StoreBagView.MoneyPanelBg");
         addChild(_loc1_);
         moneyTxt = ComponentFactory.Instance.creatComponentByStylename("magicbox.StoreBagView.TicketText");
         addChild(moneyTxt);
         giftTxt = ComponentFactory.Instance.creatComponentByStylename("magicbox.StoreBagView.GiftText");
         addChild(giftTxt);
         goldTxt = ComponentFactory.Instance.creatComponentByStylename("magicbox.StoreBagView.GoldText");
         addChild(goldTxt);
         _goldButton = ComponentFactory.Instance.creatCustomObject("magicbox.StoreBagView.GoldButton");
         _goldButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GoldDirections");
         addChild(_goldButton);
         _giftButton = ComponentFactory.Instance.creatCustomObject("magicbox.StoreBagView.GiftButton");
         var _loc4_:int = ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel);
         _giftButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GiftDirections",_loc4_.toString());
         addChild(_giftButton);
         _moneyButton = ComponentFactory.Instance.creatCustomObject("magicbox.StoreBagView.MoneyButton");
         _moneyButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.MoneyDirections");
         addChild(_moneyButton);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionMainView.helpBtn");
         PositionUtils.setPos(_helpBtn,"magicHouse.magicbox.helpbtnPos");
         addChild(_helpBtn);
         var _loc2_:Sprite = new Sprite();
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtstore.EquipCellBG");
         _loc2_.addChild(_loc3_);
         _extractionCell = new MagicBoxExtractionCell(_loc2_,1);
         addChild(_extractionCell);
         PositionUtils.setPos(_extractionCell,"magicbox.extractionview.extractioncellPos");
         _extractionCell.setContentSize(72,72);
         _extractionCell.PicPos = new Point(-3,-3);
         _numBox = ComponentFactory.Instance.creatComponentByStylename("magicbox.extractionview.numMc.Hbox");
         addChild(_numBox);
         _area = new MagicBoxExtractionDragInArea(_extractionCell);
         _area.x = 22;
         _area.y = 54;
         addChildAt(_area,0);
         refreshEquipPropList();
         refreshTxtData();
         _selfEliteCountsTxt2.text = PlayerManager.Instance.Self.essence.toString();
         _selfEliteCountsTxt.text = PlayerManager.Instance.Self.essence.toString();
      }
      
      private function initEvent() : void
      {
         MagicHouseManager.instance.addEventListener("magichouse_updata",__messageUpdate);
         MagicHouseManager.instance.addEventListener("magicbox_extraction_complete",__fusionComplete);
         PlayerManager.Instance.Self.StoreBag.addEventListener("update",__updateStoreBag);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",__updateBag);
         PlayerManager.Instance.Self.Bag.addEventListener("update",__updateBag);
         _extractionBtn.addEventListener("click",__extractionBtnHandler);
         _equipListView.addEventListener("itemclick",__cellClick);
         _propListView.addEventListener("itemclick",__cellClick);
         addEventListener("doubleclick",__cellDoubleClick);
         addEventListener("startDarg",startShine);
         addEventListener("stopDarg",stopShine);
         _extractionCell.addEventListener("change",__itemInfoChange);
         _helpBtn.addEventListener("click",__helpClick);
      }
      
      private function removeEvent() : void
      {
         MagicHouseManager.instance.removeEventListener("magichouse_updata",__messageUpdate);
         MagicHouseManager.instance.removeEventListener("magicbox_extraction_complete",__fusionComplete);
         PlayerManager.Instance.Self.StoreBag.removeEventListener("update",__updateStoreBag);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",__updateBag);
         PlayerManager.Instance.Self.Bag.removeEventListener("update",__updateBag);
         _extractionBtn.removeEventListener("click",__extractionBtnHandler);
         _equipListView.removeEventListener("itemclick",__cellClick);
         _propListView.removeEventListener("itemclick",__cellClick);
         removeEventListener("doubleclick",__cellDoubleClick);
         removeEventListener("startDarg",startShine);
         removeEventListener("stopDarg",stopShine);
         _extractionCell.removeEventListener("change",__itemInfoChange);
         _helpBtn.removeEventListener("click",__helpClick);
         if(this.hasEventListener("enterFrame"))
         {
            removeEventListener("enterFrame",__numberMcProgress);
         }
      }
      
      private function __messageUpdate(param1:Event) : void
      {
         refreshTxtData();
      }
      
      private function __fusionComplete(param1:Event) : void
      {
         _mashArea = new MagicBoxMashArea();
         LayerManager.Instance.addToLayer(_mashArea,2);
         PositionUtils.setPos(_mashArea,"magicbox.mashAreaPos");
         _mashArea.addEventListener("click",__mashAreaClickHandler);
         InviteManager.Instance.enabled = false;
         _extractionMc = ClassUtils.CreatInstance("magichouse.magicboxview.extractionComplete");
         PositionUtils.setPos(_extractionMc,"magicbox.extractionview.extractionCompleteMcPos");
         addChild(_extractionMc);
         _extractionMc.gotoAndPlay(1);
         _extractionMc.addEventListener("COMPLETE_EXTRACTION",__extractionMcComplete);
      }
      
      private function __extractionMcComplete(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _selfEliteCountsTxt2.visible = false;
         _extractionMc.removeEventListener("COMPLETE_EXTRACTION",__extractionMcComplete);
         if(_extractionMc)
         {
            ObjectUtils.disposeObject(_extractionMc);
            _extractionMc = null;
         }
         _extractionCell.info = null;
         _loc3_ = 0;
         while(_loc3_ < _selfEliteCountsTxt.text.length)
         {
            _loc2_ = ClassUtils.CreatInstance("magicbox.extractionview.numMc");
            _loc2_.gotoAndPlay(_selfEliteCountsTxt.text.charAt(_loc3_));
            _numBox.addChild(_loc2_);
            _loc3_++;
         }
         addEventListener("enterFrame",__numberMcProgress);
      }
      
      private function __numberMcProgress(param1:Event) : void
      {
         if((_numBox.getChildAt(_numBox.numChildren - 1) as MovieClip).currentFrame >= 23)
         {
            _selfEliteCountsTxt2.text = _selfEliteCountsTxt.text;
            _selfEliteCountsTxt.visible = true;
            _selfEliteCountsTxt2.visible = true;
            refreshTxtData();
            _numBox.removeAllChild();
            removeEventListener("enterFrame",__numberMcProgress);
            _mashArea.removeEventListener("click",__mashAreaClickHandler);
            if(_mashArea.parent)
            {
               _mashArea.parent.removeChild(_mashArea);
               _mashArea = null;
            }
            InviteManager.Instance.enabled = true;
         }
      }
      
      private function __mashAreaClickHandler(param1:MouseEvent) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magichouse.magicboxView.inExtraction"));
      }
      
      private function __cellDoubleClick(param1:CellEvent) : void
      {
         param1.stopImmediatePropagation();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            SoundManager.instance.play("008");
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:BagCell = param1.data as StoreBagCell;
         dragDrop(_loc2_);
      }
      
      private function __extractionBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_extractionCell.info)
         {
            SocketManager.Instance.out.magicboxExtraction(_extractionCell.info.TemplateID,1);
            _selfEliteCountsTxt.visible = false;
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magichouse.magicboxView.extractionNoItem"));
         }
      }
      
      private function __cellClick(param1:CellEvent) : void
      {
         var _loc3_:* = null;
         param1.stopImmediatePropagation();
         var _loc2_:BagCell = param1.data as BagCell;
         if(_loc2_)
         {
            _loc3_ = _loc2_.info as InventoryItemInfo;
         }
         if(_loc3_ == null)
         {
            return;
         }
         if(!_loc2_.locked)
         {
            SoundManager.instance.play("008");
            _loc2_.dragStart();
         }
      }
      
      private function startShine(param1:StoreDargEvent) : void
      {
      }
      
      private function stopShine(param1:StoreDargEvent) : void
      {
      }
      
      private function __itemInfoChange(param1:Event) : void
      {
      }
      
      private function _getItemInfoByCellInfo(param1:int = 1) : String
      {
         var _loc2_:* = null;
         if(_extractionCell.info)
         {
            _loc2_ = MagicHouseModel.instance.itemExtrationEnableList;
            var _loc5_:int = 0;
            var _loc4_:* = _loc2_;
            for each(var _loc3_ in _loc2_)
            {
               if(_extractionCell.info.TemplateID == _loc3_.ItemID)
               {
                  return (_loc3_.GetKeys * param1).toString();
               }
            }
         }
         return "0";
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(!_helpFrame)
         {
            _helpFrame = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.main");
            _helpFrame.titleText = LanguageMgr.GetTranslation("magichouse.magicboxView.extractiontxt");
            _helpFrame.addEventListener("response",__helpFrameRespose);
            _bgHelp = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.bgHelp");
            _content = ComponentFactory.Instance.creatCustomObject("magichouse.magicbox.help.content");
            _btnOk = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.btnOk");
            _btnOk.text = LanguageMgr.GetTranslation("ok");
            _btnOk.addEventListener("click",__closeHelpFrame);
            _helpFrame.addToContent(_bgHelp);
            _helpFrame.addToContent(_content);
            _helpFrame.addToContent(_btnOk);
         }
         LayerManager.Instance.addToLayer(_helpFrame,3,true,2);
      }
      
      private function __helpFrameRespose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            _helpFrame.parent.removeChild(_helpFrame);
         }
      }
      
      private function __closeHelpFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _helpFrame.parent.removeChild(_helpFrame);
      }
      
      public function refreshEquipPropList() : void
      {
         var _loc5_:* = null;
         var _loc8_:* = null;
         var _loc1_:BagInfo = PlayerManager.Instance.Self.getBag(0);
         var _loc7_:BagInfo = PlayerManager.Instance.Self.getBag(1);
         var _loc9_:Array = MagicHouseModel.instance.itemExtrationEnableList;
         var _loc4_:DictionaryData = new DictionaryData();
         var _loc6_:DictionaryData = new DictionaryData();
         var _loc16_:int = 0;
         var _loc15_:* = _loc9_;
         for each(var _loc10_ in _loc9_)
         {
            _loc5_ = _loc1_.findItemsByTempleteIDNoValidate(_loc10_.ItemID);
            _loc8_ = _loc7_.findItemsByTempleteIDNoValidate(_loc10_.ItemID);
            if(_loc5_.length > 0)
            {
               var _loc12_:int = 0;
               var _loc11_:* = _loc5_;
               for each(var _loc2_ in _loc5_)
               {
                  _loc4_.add(_loc4_.length,_loc2_);
               }
            }
            if(_loc8_.length > 0)
            {
               var _loc14_:int = 0;
               var _loc13_:* = _loc8_;
               for each(var _loc3_ in _loc8_)
               {
                  _loc6_.add(_loc6_.length,_loc3_);
               }
               continue;
            }
         }
         _equipListView.setData(_loc4_);
         _propListView.setData(_loc6_);
      }
      
      private function refreshTxtData() : void
      {
         _selfEliteCountsTxt.text = PlayerManager.Instance.Self.essence.toString();
         _selfEliteCountsTxt2.text = PlayerManager.Instance.Self.essence.toString();
         moneyTxt.text = PlayerManager.Instance.Self.Money.toString();
         giftTxt.text = PlayerManager.Instance.Self.BandMoney.toString();
         goldTxt.text = PlayerManager.Instance.Self.Gold.toString();
         _getCountsTxt.text = "0";
      }
      
      private function dragDrop(param1:BagCell) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:InventoryItemInfo = param1.info as InventoryItemInfo;
         if(_loc2_.Count == 1)
         {
            SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,1,1);
         }
         else
         {
            showNumAlert(_loc2_,1);
         }
      }
      
      private function showNumAlert(param1:InventoryItemInfo, param2:int) : void
      {
         _aler = ComponentFactory.Instance.creatComponentByStylename("magicbox.selectNumAlertFrame");
         _aler.addExeFunction(sellFunction,notSellFunction);
         _aler.goodsinfo = param1;
         _aler.index = param2;
         _aler.show(param1.Count);
      }
      
      private function sellFunction(param1:int, param2:InventoryItemInfo, param3:int) : void
      {
         SocketManager.Instance.out.sendMoveGoods(param2.BagType,param2.Place,12,param3,param1,true);
         if(_aler)
         {
            _aler.dispose();
         }
         if(_aler && _aler.parent)
         {
            removeChild(_aler);
         }
         _aler = null;
      }
      
      private function notSellFunction() : void
      {
         if(_aler)
         {
            _aler.dispose();
         }
         if(_aler && _aler.parent)
         {
            removeChild(_aler);
         }
         _aler = null;
      }
      
      private function __updateStoreBag(param1:BagEvent) : void
      {
         _refreshData(param1.changedSlots);
      }
      
      private function __updateBag(param1:BagEvent) : void
      {
         _refreshData(param1.changedSlots);
      }
      
      private function _refreshData(param1:Dictionary) : void
      {
         var _loc2_:* = 0;
         var _loc4_:* = null;
         _deleteExtractionCell();
         refreshEquipPropList();
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for(_loc2_ in param1)
         {
            _loc4_ = PlayerManager.Instance.Self.StoreBag.items[_loc2_];
            _createExtractionCell(_loc4_);
         }
      }
      
      private function _createExtractionCell(param1:InventoryItemInfo) : void
      {
         _extractionCell.info = param1;
         if(param1)
         {
            _getCountsTxt.text = _getItemInfoByCellInfo(param1.Count);
         }
         else
         {
            _getCountsTxt.text = "0";
         }
      }
      
      private function _deleteExtractionCell() : void
      {
      }
      
      private function __extractionCellClickHandler(param1:InteractiveEvent) : void
      {
         SoundManager.instance.play("008");
         _extractionCell.dragStart();
      }
      
      private function __extractionCellDoubleClickHandler(param1:InteractiveEvent) : void
      {
         SocketManager.Instance.out.sendClearStoreBag();
      }
      
      public function dispose() : void
      {
         removeEvent();
         _deleteExtractionCell();
         SocketManager.Instance.out.sendClearStoreBag();
         if(_area)
         {
            ObjectUtils.disposeObject(_area);
         }
         _area = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_selfEliteCounts)
         {
            ObjectUtils.disposeObject(_selfEliteCounts);
         }
         _selfEliteCounts = null;
         if(_selfEliteCountsTxt)
         {
            ObjectUtils.disposeObject(_selfEliteCountsTxt);
         }
         _selfEliteCountsTxt = null;
         if(_selfEliteCountsTxt2)
         {
            ObjectUtils.disposeObject(_selfEliteCountsTxt2);
         }
         _selfEliteCountsTxt2 = null;
         if(_cellContentBg)
         {
            ObjectUtils.disposeObject(_cellContentBg);
         }
         _cellContentBg = null;
         if(_getCountBg)
         {
            ObjectUtils.disposeObject(_getCountBg);
         }
         _getCountBg = null;
         if(_getCounts)
         {
            ObjectUtils.disposeObject(_getCounts);
         }
         _getCounts = null;
         if(_getCountsTxt)
         {
            ObjectUtils.disposeObject(_getCountsTxt);
         }
         _getCountsTxt = null;
         if(_tempTxt)
         {
            ObjectUtils.disposeObject(_tempTxt);
         }
         _tempTxt = null;
         if(_extractionBtn)
         {
            ObjectUtils.disposeObject(_extractionBtn);
         }
         _extractionBtn = null;
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
         }
         _helpBtn = null;
         if(_equipListView)
         {
            ObjectUtils.disposeObject(_equipListView);
         }
         _equipListView = null;
         if(_propListView)
         {
            ObjectUtils.disposeObject(_propListView);
         }
         _propListView = null;
         if(_bitmapBg)
         {
            ObjectUtils.disposeObject(_bitmapBg);
         }
         _bitmapBg = null;
         if(bagBg)
         {
            ObjectUtils.disposeObject(bagBg);
         }
         bagBg = null;
         if(moneyTxt)
         {
            ObjectUtils.disposeObject(moneyTxt);
         }
         moneyTxt = null;
         if(giftTxt)
         {
            ObjectUtils.disposeObject(giftTxt);
         }
         giftTxt = null;
         if(goldTxt)
         {
            ObjectUtils.disposeObject(goldTxt);
         }
         goldTxt = null;
         if(_equipmentTitleText)
         {
            ObjectUtils.disposeObject(_equipmentTitleText);
         }
         _equipmentTitleText = null;
         if(_equipmentTipText)
         {
            ObjectUtils.disposeObject(_equipmentTipText);
         }
         _equipmentTipText = null;
         if(_itemTitleText)
         {
            ObjectUtils.disposeObject(_itemTitleText);
         }
         _itemTitleText = null;
         if(_itemTipText)
         {
            ObjectUtils.disposeObject(_itemTipText);
         }
         _itemTipText = null;
         if(_goldButton)
         {
            ObjectUtils.disposeObject(_goldButton);
         }
         _goldButton = null;
         if(_giftButton)
         {
            ObjectUtils.disposeObject(_giftButton);
         }
         _giftButton = null;
         if(_moneyButton)
         {
            ObjectUtils.disposeObject(_moneyButton);
         }
         _moneyButton = null;
         if(_extractionMc)
         {
            ObjectUtils.disposeObject(_extractionMc);
         }
         _extractionMc = null;
         if(_mashArea)
         {
            ObjectUtils.disposeObject(_mashArea);
         }
         _mashArea = null;
      }
   }
}
