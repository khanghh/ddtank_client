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
      
      public function StoreBagView(){super();}
      
      public function setup(param1:StoreBagController) : void{}
      
      private function init() : void{}
      
      private function showStoreBagViewText(param1:String, param2:String, param3:Boolean = true) : void{}
      
      private function initEvents() : void{}
      
      public function enableCellDoubleClick(param1:Boolean, param2:Function) : void{}
      
      private function removeEvents() : void{}
      
      public function setData(param1:StoreModel) : void{}
      
      private function changeToSingleBagView() : void{}
      
      private function changeToDoubleBagView() : void{}
      
      private function __cellClick(param1:CellEvent) : void{}
      
      private function createBreakWin(param1:BagCell) : void{}
      
      private function __cellAddPrice(param1:Event) : void{}
      
      private function __cellMove(param1:Event) : void{}
      
      public function getPropCell(param1:int) : BagCell{return null;}
      
      public function getEquipCell(param1:int) : BagCell{return null;}
      
      public function get EquipList() : StoreBagListView{return null;}
      
      public function get PropList() : StoreBagListView{return null;}
      
      public function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      private function updateMoney() : void{}
      
      public function dispose() : void{}
   }
}
