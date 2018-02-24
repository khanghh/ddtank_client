package store.view.strength.manager
{
   import flash.utils.Dictionary;
   import store.view.strength.analyzer.ItemStrengthenGoodsInfoAnalyzer;
   import store.view.strength.vo.ItemStrengthenGoodsInfo;
   
   public class ItemStrengthenGoodsInfoManager
   {
      
      private static var _lists:Dictionary;
       
      
      public function ItemStrengthenGoodsInfoManager(){super();}
      
      public static function setup(param1:ItemStrengthenGoodsInfoAnalyzer) : void{}
      
      public static function findItemStrengthenGoodsInfo(param1:int, param2:int) : ItemStrengthenGoodsInfo{return null;}
   }
}
