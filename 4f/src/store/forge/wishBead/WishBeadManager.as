package store.forge.wishBead
{
   import ddt.data.BagInfo;
   import ddt.data.analyze.WishInfoAnalyzer;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.data.DictionaryData;
   
   public class WishBeadManager extends EventDispatcher
   {
      
      public static const EQUIP_MOVE:String = "wishBead_equip_move";
      
      public static const EQUIP_MOVE2:String = "wishBead_equip_move2";
      
      public static const ITEM_MOVE:String = "wishBead_item_move";
      
      public static const ITEM_MOVE2:String = "wishBead_item_move2";
      
      private static var _instance:WishBeadManager;
       
      
      public var wishInfoList:Vector.<WishChangeInfo>;
      
      public function WishBeadManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : WishBeadManager{return null;}
      
      public function getCanWishBeadData() : BagInfo{return null;}
      
      public function getWishBeadItemData() : BagInfo{return null;}
      
      public function getIsEquipMatchWishBead(param1:int, param2:int, param3:Boolean) : Boolean{return false;}
      
      public function getwishInfo(param1:WishInfoAnalyzer) : void{}
      
      public function getWishInfoByTemplateID(param1:int, param2:int) : WishChangeInfo{return null;}
   }
}
