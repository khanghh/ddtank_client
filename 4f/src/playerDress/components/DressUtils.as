package playerDress.components{   import ddt.data.goods.InventoryItemInfo;      public class DressUtils   {                   public function DressUtils() { super(); }
            public static function getBagItems($id:int, $isIndex:Boolean = false) : int { return 0; }
            public static function isDress(item:InventoryItemInfo) : Boolean { return false; }
            public static function findItemPlace(item:InventoryItemInfo) : int { return 0; }
            public static function hasNoAddition(item:InventoryItemInfo) : Boolean { return false; }
            public static function getBagGoodsCategoryIDSort(CategoryID:uint) : int { return 0; }
   }}