package shop.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   
   public class ShopRechargeEquipViewItem extends ShopCartItem implements Disposeable
   {
      
      public static const DELETE_ITEM:String = "deleteitem";
      
      public static const CONDITION_CHANGE:String = "conditionchange";
       
      
      private var _moneyRadioBtn:SelectedCheckButton;
      
      private var _orderRadioBtn:SelectedCheckButton;
      
      private var _isDelete:Boolean = false;
      
      private var _radioGroup:SelectedButtonGroup;
      
      private var _shopItems:Array;
      
      private var fileterArr:Array;
      
      public var clieckHander:Function;
      
      public var moneType:int = 1;
      
      public function ShopRechargeEquipViewItem(){super();}
      
      private function init() : void{}
      
      override protected function drawBackground(param1:Boolean = false) : void{}
      
      private function initEventListener() : void{}
      
      public function set itemInfo(param1:InventoryItemInfo) : void{}
      
      override protected function cartItemSelectVBoxInit() : void{}
      
      private function __selectRadioBtn(param1:MouseEvent) : void{}
      
      public function get currentShopItem() : ShopCarItemInfo{return null;}
      
      public function get isDelete() : Boolean{return false;}
      
      private function updateCurrentShopItem(param1:int) : void{}
      
      private function resetRadioBtn(param1:Boolean) : void{}
      
      override protected function __closeClick(param1:MouseEvent) : void{}
      
      private function fillToShopCarInfo(param1:ShopItemInfo) : ShopCarItemInfo{return null;}
      
      override public function dispose() : void{}
   }
}
