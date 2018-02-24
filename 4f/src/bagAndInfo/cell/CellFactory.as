package bagAndInfo.cell
{
   import beadSystem.controls.BeadCell;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.interfaces.ICell;
   import ddt.interfaces.ICellFactory;
   import ddt.manager.ItemManager;
   import ddt.manager.ShopManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import magicHouse.treasureHouse.MagicHouseTreasureCell;
   import shop.view.ShopItemCell;
   import shop.view.ShopPlayerCell;
   
   public class CellFactory implements ICellFactory
   {
      
      private static var _instance:CellFactory;
       
      
      public function CellFactory(){super();}
      
      public static function get instance() : CellFactory{return null;}
      
      public function createBagCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null) : ICell{return null;}
      
      public function creteLockableBagCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null) : ICell{return null;}
      
      public function createBankCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true) : ICell{return null;}
      
      public function createPersonalInfoCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true) : ICell{return null;}
      
      public function createTreasureCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true) : ICell{return null;}
      
      public function createBeadCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true) : ICell{return null;}
      
      public function createShopPlayerItemCell() : ICell{return null;}
      
      public function createShopCartItemCell() : ICell{return null;}
      
      public function createShopColorItemCell() : ICell{return null;}
      
      public function createShopItemCell(param1:DisplayObject, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Boolean = true) : ICell{return null;}
      
      public function fillTipProp(param1:ICell) : void{}
      
      public function createWeeklyItemCell(param1:DisplayObject, param2:int) : ICell{return null;}
   }
}
