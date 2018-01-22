package petsBag.petsAdvanced
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyAlertBase;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class PetsAdvancedCell extends Sprite implements Disposeable
   {
      
      public static const UPDATEED:String = "pac_updated";
       
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _bagCell:BagCell;
      
      private var _count:int;
      
      public function PetsAdvancedCell()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:InventoryItemInfo = new InventoryItemInfo();
         switch(int(PetsAdvancedControl.Instance.currentViewType) - 1)
         {
            case 0:
               _loc1_.TemplateID = 11162;
               break;
            case 1:
               _loc1_.TemplateID = 11163;
               break;
            default:
               _loc1_.TemplateID = 11163;
               break;
            case 3:
               _loc1_.TemplateID = 201567;
         }
         _loc1_ = ItemManager.fill(_loc1_);
         _loc1_.BindType = 4;
         _bagCell = new BagCell(0);
         _bagCell.info = _loc1_;
         _bagCell.setBgVisible(false);
         var _loc2_:int = 6;
         _bagCell.y = _loc2_;
         _bagCell.x = _loc2_;
         updateCount();
         addChild(_bagCell);
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.advanced.buybtn");
         addChild(_buyBtn);
         _buyBtn.visible = false;
      }
      
      public function set info(param1:InventoryItemInfo) : void
      {
         param1 = ItemManager.fill(param1);
         param1.BindType = 4;
         _bagCell.info = param1;
         _bagCell.PicPos = new Point(9,9);
         updateCount();
      }
      
      public function getExpOfBagcell() : int
      {
         return int(_bagCell.info.Property2);
      }
      
      public function getTempleteId() : int
      {
         return _bagCell.info.TemplateID;
      }
      
      public function getPropName() : String
      {
         return _bagCell.info.Name;
      }
      
      public function getCount() : int
      {
         return _count;
      }
      
      public function updateCount() : void
      {
         var _loc1_:BagInfo = PlayerManager.Instance.Self.getBag(1);
         _count = _loc1_.getItemCountByTemplateId(_bagCell.info.TemplateID);
         _bagCell.setCount(_count);
         _bagCell.refreshTbxPos();
         dispatchEvent(new Event("pac_updated"));
      }
      
      private function addEvent() : void
      {
         _buyBtn.addEventListener("click",__buyHandler);
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",__updateBag);
      }
      
      protected function __updateBag(param1:BagEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:BagInfo = param1.target as BagInfo;
         var _loc5_:Dictionary = param1.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = _loc5_;
         for each(var _loc4_ in _loc5_)
         {
            _loc3_ = _loc2_.getItemAt(_loc4_.Place);
            if(_loc3_ && (_loc3_.TemplateID == 11162 || _loc3_.TemplateID == 11163 || _loc3_.TemplateID == 11167 || _loc3_.TemplateID == 201567))
            {
               updateCount();
            }
            else if(_loc3_)
            {
               updateCount();
            }
         }
      }
      
      protected function __outHandler(param1:MouseEvent) : void
      {
         _buyBtn.visible = false;
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         _buyBtn.visible = true;
      }
      
      protected function __buyHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:ShopItemInfo = ShopManager.Instance.getShopItemByGoodsID(int(_bagCell.info.TemplateID + "01"));
         var _loc3_:QuickBuyAlertBase = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickBuyAlert");
         _loc3_.setData(_loc2_.TemplateID,_loc2_.GoodsID,_loc2_.AValue1);
         LayerManager.Instance.addToLayer(_loc3_,3,true,1);
      }
      
      private function removeEvent() : void
      {
         _buyBtn.removeEventListener("click",__buyHandler);
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",__updateBag);
      }
      
      public function get buyBtn() : SimpleBitmapButton
      {
         return _buyBtn;
      }
      
      public function set buyBtn(param1:SimpleBitmapButton) : void
      {
         _buyBtn = param1;
      }
      
      public function dispose() : void
      {
         removeEvent();
         while(this.numChildren)
         {
            ObjectUtils.disposeObject(this.getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
