package store.view.strength.manager
{
   import flash.utils.Dictionary;
   import store.view.strength.analyzer.ItemStrengthenGoodsInfoAnalyzer;
   import store.view.strength.vo.ItemStrengthenGoodsInfo;
   
   public class ItemStrengthenGoodsInfoManager
   {
      
      private static var _lists:Dictionary;
       
      
      public function ItemStrengthenGoodsInfoManager()
      {
         super();
      }
      
      public static function setup(analyzer:ItemStrengthenGoodsInfoAnalyzer) : void
      {
         _lists = analyzer.list;
      }
      
      public static function findItemStrengthenGoodsInfo(CurrentEquip:int, level:int) : ItemStrengthenGoodsInfo
      {
         if(_lists)
         {
            return _lists[CurrentEquip + "," + level];
         }
         return null;
      }
   }
}
