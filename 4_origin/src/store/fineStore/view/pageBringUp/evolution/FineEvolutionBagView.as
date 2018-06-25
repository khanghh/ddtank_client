package store.fineStore.view.pageBringUp.evolution
{
   import bagAndInfo.bag.RichesButton;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import store.StoreBagBgWHPoint;
   import store.data.StoreModel;
   import store.view.storeBag.StoreBagCell;
   import store.view.storeBag.StoreBagController;
   import store.view.storeBag.StoreBagListView;
   import store.view.storeBag.StoreBagbgbmp;
   import store.view.storeBag.StoreSingleBagListView;
   
   public class FineEvolutionBagView extends Sprite implements Disposeable
   {
       
      
      private var _bitmapBg:StoreBagbgbmp;
      
      private var bagBg:ScaleFrameImage;
      
      private var _equipmentTitleText:FilterFrameText;
      
      private var _itemTitleText:FilterFrameText;
      
      private var _equipmentTipText:FilterFrameText;
      
      private var _itemTipText:FilterFrameText;
      
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
      
      private var _equipmentView:StoreBagListView;
      
      private var _propView:StoreBagListView;
      
      private var _transerViewUp:StoreSingleBagListView;
      
      private var _transerViewDown:StoreSingleBagListView;
      
      private var _controller:StoreBagController;
      
      private var _model:StoreModel;
      
      public function FineEvolutionBagView()
      {
         super();
      }
      
      public function setup(controller:StoreBagController) : void
      {
         _controller = controller;
         _model = _controller.model;
         init();
         initEvents();
      }
      
      private function initEvents() : void
      {
         _equipmentView.addEventListener("itemclick",__cellClick);
         _equipmentView.addEventListener("doubleclick",__cellDoubleClick);
         _propView.addEventListener("itemclick",__cellClick);
         _transerViewUp.addEventListener("itemclick",__cellClick);
         _transerViewDown.addEventListener("itemclick",__cellClick);
         _model.info.addEventListener("propertychange",__propertyChange);
      }
      
      private function __cellDoubleClick(evt:CellEvent) : void
      {
         var tmp:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var cell:StoreBagCell = evt.data as StoreBagCell;
         if(cell.info && cell.info is InventoryItemInfo)
         {
            tmp = cell.info as InventoryItemInfo;
            SocketManager.Instance.out.sendMoveGoods(tmp.BagType,tmp.Place,12,0);
         }
      }
      
      private function __cellClick(evt:CellEvent) : void
      {
         var info:* = null;
         evt.stopImmediatePropagation();
         var cell:BagCell = evt.data as BagCell;
         if(cell)
         {
            info = cell.info as InventoryItemInfo;
         }
         if(info == null || info && info.TemplateID == 12572)
         {
            return;
         }
         if(!cell.locked)
         {
            SoundManager.instance.play("008");
            cell.dragStart();
         }
      }
      
      private function removeEvent() : void
      {
         if(_equipmentView)
         {
            _equipmentView.removeEventListener("itemclick",__cellClick);
            _equipmentView.removeEventListener("doubleclick",__cellDoubleClick);
         }
         if(_propView)
         {
            _propView.removeEventListener("itemclick",__cellClick);
         }
         if(_transerViewUp)
         {
            _transerViewUp.removeEventListener("itemclick",__cellClick);
         }
         if(_transerViewDown)
         {
            _transerViewDown.removeEventListener("itemclick",__cellClick);
         }
         if(_model && _model.info)
         {
            _model.info.removeEventListener("propertychange",__propertyChange);
         }
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
         var showMoneyBG:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.MoneyPanelBg");
         addChild(showMoneyBG);
         moneyTxt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.TicketText");
         addChild(moneyTxt);
         _goldButton = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreBagView.GoldButton");
         _goldButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GoldDirections");
         addChild(_goldButton);
         giftTxt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.GiftText");
         addChild(giftTxt);
         _giftButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.bag.GiftButton");
         _giftButton = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreBagView.GiftButton");
         var levelNum:int = 6000;
         var vipNum:int = ServerConfigManager.instance.VIPExtraBindMoneyUpper[PlayerManager.Instance.Self.VIPLevel - 1];
         if(PlayerManager.Instance.Self.IsVIP)
         {
            _giftButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GiftDirections",(levelNum + vipNum).toString());
         }
         else
         {
            _giftButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GiftDirections",levelNum.toString());
         }
         addChild(_giftButton);
         _moneyButton = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreBagView.MoneyButton");
         _moneyButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.MoneyDirections");
         addChild(_moneyButton);
         goldTxt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.GoldText");
         addChild(goldTxt);
         _equipmentView = new StoreBagListView(true);
         PositionUtils.setPos(_equipmentView,"ddtstore.StoreEveolutionBagList.pos");
         _propView = new StoreBagListView(true);
         PositionUtils.setPos(_propView,"ddtstore.StoreEveolutionBagListII.pos");
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
      
      private function updateMoney() : void
      {
         goldTxt.text = String(PlayerManager.Instance.Self.Gold);
         moneyTxt.text = String(PlayerManager.Instance.Self.Money);
         giftTxt.text = String(PlayerManager.Instance.Self.BandMoney);
      }
      
      public function __propertyChange(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["Money"] || evt.changedProperties["Gold"] || evt.changedProperties["Money"] || evt.changedProperties["BandMoney"])
         {
            updateMoney();
         }
      }
      
      public function setData(storeModel:StoreModel) : void
      {
         this.visible = true;
         _equipmentView.setData(_model.canExaltAssistEqpmtList);
         _propView.setData(_model.evolutionMaterialList);
         bagBg.setFrame(1);
         showStoreBagViewText("store.StoreBagView.AssistantEquipmentTitleText","store.StoreBagView.ItemTip.Text1");
         _itemTitleText.text = LanguageMgr.GetTranslation("store.StoreBagView.ItemTitleText");
         changeToDoubleBagView();
      }
      
      private function changeToDoubleBagView() : void
      {
         _equipmentView.visible = true;
         _propView.visible = true;
         var _loc1_:Boolean = false;
         _transerViewDown.visible = _loc1_;
         _transerViewUp.visible = _loc1_;
      }
      
      private function changeToSingleBagView() : void
      {
         _equipmentView.visible = false;
         _propView.visible = false;
         var _loc1_:Boolean = true;
         _transerViewDown.visible = _loc1_;
         _transerViewUp.visible = _loc1_;
      }
      
      private function showStoreBagViewText(equipmentTip:String, itemTip:String, isShowItemTip:Boolean = true) : void
      {
         _equipmentTipText.text = LanguageMgr.GetTranslation(equipmentTip);
         if(isShowItemTip)
         {
            _itemTipText.visible = isShowItemTip;
         }
         _itemTitleText.visible = isShowItemTip;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _controller = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
