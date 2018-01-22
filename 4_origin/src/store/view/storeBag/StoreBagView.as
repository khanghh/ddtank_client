package store.view.storeBag
{
   import bagAndInfo.bag.BreakGoodsView;
   import bagAndInfo.bag.CellMenu;
   import bagAndInfo.bag.RichesButton;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.view.goods.AddPricePanel;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import store.StoreBagBgWHPoint;
   import store.data.StoreModel;
   
   public class StoreBagView extends Sprite implements Disposeable
   {
       
      
      private var _controller:StoreBagController;
      
      private var _model:StoreModel;
      
      private var _equipmentView:StoreBagListView;
      
      private var _propView:StoreBagListView;
      
      private var _transerViewUp:StoreSingleBagListView;
      
      private var _transerViewDown:StoreSingleBagListView;
      
      private var _bitmapBg:StoreBagbgbmp;
      
      private var bagBg:ScaleFrameImage;
      
      private var _equipmentsColumnBg:Image;
      
      private var _itemsColumnBg:Image;
      
      public var msg_txt:ScaleFrameImage;
      
      private var goldTxt:FilterFrameText;
      
      private var moneyTxt:FilterFrameText;
      
      private var giftTxt:FilterFrameText;
      
      private var _goldButton:RichesButton;
      
      private var _giftButton:RichesButton;
      
      private var _moneyButton:RichesButton;
      
      private var _bgPoint:StoreBagBgWHPoint;
      
      private var _bgShape:Shape;
      
      private var _equipmentTitleText:FilterFrameText;
      
      private var _itemTitleText:FilterFrameText;
      
      private var _equipmentTipText:FilterFrameText;
      
      private var _itemTipText:FilterFrameText;
      
      public function StoreBagView()
      {
         super();
      }
      
      public function setup(param1:StoreBagController) : void
      {
         _controller = param1;
         _model = _controller.model;
         init();
         initEvents();
      }
      
      private function init() : void
      {
         _bitmapBg = new StoreBagbgbmp();
         addChildAt(_bitmapBg,0);
         bagBg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagViewBg2");
         addChild(bagBg);
         _equipmentTitleText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.EquipmentTitleText");
         _equipmentTitleText.htmlText = LanguageMgr.GetTranslation("store.StoreBagView.EquipmentTitleText");
         _itemTitleText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.ItemTitleText");
         _itemTitleText.htmlText = LanguageMgr.GetTranslation("store.StoreBagView.ItemTitleText");
         _equipmentTipText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.EquipmentTipText");
         _itemTipText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.ItemTipText");
         addChild(_equipmentTitleText);
         addChild(_itemTitleText);
         addChild(_equipmentTipText);
         addChild(_itemTipText);
         showStoreBagViewText("store.StoreBagView.EquipmentTip.StrengthText","store.StoreBagView.ItemTip.Text1");
         var _loc1_:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.MoneyPanelBg");
         addChild(_loc1_);
         moneyTxt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.TicketText");
         addChild(moneyTxt);
         _goldButton = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreBagView.GoldButton");
         _goldButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GoldDirections");
         addChild(_goldButton);
         giftTxt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.GiftText");
         addChild(giftTxt);
         _giftButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.bag.GiftButton");
         _giftButton = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreBagView.GiftButton");
         var _loc3_:int = 6000;
         var _loc2_:int = ServerConfigManager.instance.VIPExtraBindMoneyUpper[PlayerManager.Instance.Self.VIPLevel - 1];
         if(PlayerManager.Instance.Self.IsVIP)
         {
            _giftButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GiftDirections",(_loc3_ + _loc2_).toString());
         }
         else
         {
            _giftButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GiftDirections",_loc3_.toString());
         }
         addChild(_giftButton);
         _moneyButton = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreBagView.MoneyButton");
         _moneyButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.MoneyDirections");
         addChild(_moneyButton);
         goldTxt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.GoldText");
         addChild(goldTxt);
         _equipmentView = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreBagListViewEquip");
         _propView = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreBagListViewProp");
         _transerViewUp = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreSingleBagListView");
         _transerViewDown = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreSingleBagListView");
         _transerViewDown.y = _propView.y;
         _equipmentView.setup(0,_controller,21);
         _propView.setup(1,_controller,21);
         _transerViewUp.setup(0,_controller,21);
         _transerViewDown.setup(0,_controller,21);
         addChild(_equipmentView);
         addChild(_propView);
         addChild(_transerViewUp);
         addChild(_transerViewDown);
         updateMoney();
      }
      
      private function showStoreBagViewText(param1:String, param2:String, param3:Boolean = true) : void
      {
         _equipmentTipText.text = LanguageMgr.GetTranslation(param1);
         if(param3)
         {
            _itemTipText.text = LanguageMgr.GetTranslation(param2);
         }
         _itemTipText.visible = param3;
         _itemTitleText.visible = param3;
      }
      
      private function initEvents() : void
      {
         _equipmentView.addEventListener("itemclick",__cellClick);
         _propView.addEventListener("itemclick",__cellClick);
         _transerViewUp.addEventListener("itemclick",__cellClick);
         _transerViewDown.addEventListener("itemclick",__cellClick);
         CellMenu.instance.addEventListener("addprice",__cellAddPrice);
         CellMenu.instance.addEventListener("move",__cellMove);
         _model.info.addEventListener("propertychange",__propertyChange);
      }
      
      public function enableCellDoubleClick(param1:Boolean, param2:Function) : void
      {
         if(param1 && param2)
         {
            _equipmentView.addEventListener("doubleclick",param2);
            _propView.addEventListener("doubleclick",param2);
         }
         else
         {
            _equipmentView.removeEventListener("doubleclick",param2);
            _propView.removeEventListener("doubleclick",param2);
         }
      }
      
      private function removeEvents() : void
      {
         _equipmentView.removeEventListener("itemclick",__cellClick);
         _propView.removeEventListener("itemclick",__cellClick);
         _transerViewUp.removeEventListener("itemclick",__cellClick);
         _transerViewDown.removeEventListener("itemclick",__cellClick);
         CellMenu.instance.removeEventListener("addprice",__cellAddPrice);
         CellMenu.instance.removeEventListener("move",__cellMove);
         _model.info.removeEventListener("propertychange",__propertyChange);
      }
      
      public function setData(param1:StoreModel) : void
      {
         this.visible = true;
         if(_controller.currentPanel == 0)
         {
            _equipmentView.setData(_model.canStrthEqpmtList);
            _propView.setData(_model.strthList);
            bagBg.setFrame(1);
            showStoreBagViewText("store.StoreBagView.EquipmentTip.StrengthText","store.StoreBagView.ItemTip.Text1");
            _itemTitleText.htmlText = LanguageMgr.GetTranslation("store.StoreBagView.ItemTitleText");
            changeToDoubleBagView();
         }
         else if(_controller.currentPanel == 7)
         {
            bagBg.setFrame(1);
            showStoreBagViewText("store.StoreBagView.EquipmentTip.GhostText","store.StoreBagView.ItemTip.Text1");
            _itemTitleText.htmlText = LanguageMgr.GetTranslation("store.StoreBagView.ItemTitleText");
            changeToDoubleBagView();
         }
         else if(_controller.currentPanel == 2)
         {
            _equipmentView.setData(_model.canCpsEquipmentList);
            _propView.setData(_model.cpsAndANchList);
            bagBg.setFrame(1);
            showStoreBagViewText("store.StoreBagView.EquipmentTip.ComposeText","store.StoreBagView.ItemTip.Text1");
            _itemTitleText.text = LanguageMgr.GetTranslation("store.StoreBagView.ItemTitleText");
            changeToDoubleBagView();
         }
         else if(_controller.currentPanel == 4)
         {
            this.visible = false;
            _equipmentView.setData(_model.canRongLiangEquipmengtList);
            _propView.setData(_model.canRongLiangPropList);
            bagBg.setFrame(1);
            showStoreBagViewText("store.StoreBagView.EquipmentTip.FusionText","store.StoreBagView.ItemTip.Text3");
            _itemTitleText.htmlText = LanguageMgr.GetTranslation("store.StoreBagView.ItemTitleText");
            changeToDoubleBagView();
         }
         else if(_controller.currentPanel == 1)
         {
            _equipmentView.setData(_model.canExaltEqpmtList);
            _propView.setData(_model.exaltRock);
            showStoreBagViewText("store.StoreBagView.EquipmentTip.ExaltText","store.StoreBagView.ItemTip.Text2");
            _itemTitleText.htmlText = LanguageMgr.GetTranslation("store.StoreBagView.ItemTitleText");
            bagBg.setFrame(1);
            changeToDoubleBagView();
         }
         else
         {
            _transerViewUp.setData(_model.canTransEquipmengtList);
            _itemTitleText.htmlText = LanguageMgr.GetTranslation("store.StoreBagView.EquipmentTitleText");
            _transerViewDown.setData(_model.canNotTransEquipmengtList);
            bagBg.setFrame(1);
            showStoreBagViewText("store.StoreBagView.EquipmentTip.TransferText","store.StoreBagView.ItemTip.Text4");
            changeToSingleBagView();
         }
      }
      
      private function changeToSingleBagView() : void
      {
         _equipmentView.visible = false;
         _propView.visible = false;
         var _loc1_:Boolean = true;
         _transerViewDown.visible = _loc1_;
         _transerViewUp.visible = _loc1_;
      }
      
      private function changeToDoubleBagView() : void
      {
         _equipmentView.visible = true;
         _propView.visible = true;
         var _loc1_:Boolean = false;
         _transerViewDown.visible = _loc1_;
         _transerViewUp.visible = _loc1_;
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
            if(!EquipType.isPackage(_loc3_))
            {
               _loc2_.dragStart();
            }
         }
      }
      
      private function createBreakWin(param1:BagCell) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BreakGoodsView = new BreakGoodsView();
         _loc2_.cell = param1;
         _loc2_.show();
      }
      
      private function __cellAddPrice(param1:Event) : void
      {
         var _loc2_:BagCell = CellMenu.instance.cell;
         if(_loc2_)
         {
            AddPricePanel.Instance.setInfo(_loc2_.itemInfo,false);
            LayerManager.Instance.addToLayer(AddPricePanel.Instance,1,true);
         }
      }
      
      private function __cellMove(param1:Event) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BagCell = CellMenu.instance.cell;
         if(_loc2_)
         {
            _loc2_.dragStart();
         }
      }
      
      public function getPropCell(param1:int) : BagCell
      {
         return _propView.getCellByPos(param1);
      }
      
      public function getEquipCell(param1:int) : BagCell
      {
         return _equipmentView.getCellByPos(param1);
      }
      
      public function get EquipList() : StoreBagListView
      {
         return _equipmentView;
      }
      
      public function get PropList() : StoreBagListView
      {
         return _propView;
      }
      
      public function __propertyChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Money"] || param1.changedProperties["Gold"] || param1.changedProperties["Money"] || param1.changedProperties["BandMoney"])
         {
            updateMoney();
         }
      }
      
      private function updateMoney() : void
      {
         goldTxt.text = String(PlayerManager.Instance.Self.Gold);
         moneyTxt.text = String(PlayerManager.Instance.Self.Money);
         giftTxt.text = String(PlayerManager.Instance.Self.BandMoney);
      }
      
      public function dispose() : void
      {
         removeEvents();
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
         if(_equipmentsColumnBg)
         {
            ObjectUtils.disposeObject(_equipmentsColumnBg);
         }
         _equipmentsColumnBg = null;
         if(_itemsColumnBg)
         {
            ObjectUtils.disposeAllChildren(_itemsColumnBg);
         }
         _itemsColumnBg = null;
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
         if(msg_txt)
         {
            ObjectUtils.disposeObject(msg_txt);
         }
         msg_txt = null;
         if(_equipmentView)
         {
            ObjectUtils.disposeObject(_equipmentView);
         }
         _equipmentView = null;
         if(_propView)
         {
            ObjectUtils.disposeObject(_propView);
         }
         _propView = null;
         if(_transerViewUp)
         {
            ObjectUtils.disposeObject(_transerViewUp);
         }
         _transerViewUp = null;
         if(_transerViewDown)
         {
            ObjectUtils.disposeObject(_transerViewDown);
         }
         _transerViewDown = null;
         if(goldTxt)
         {
            ObjectUtils.disposeObject(goldTxt);
         }
         goldTxt = null;
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
         if(_bgShape)
         {
            ObjectUtils.disposeObject(_bgShape);
         }
         _bgShape = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
