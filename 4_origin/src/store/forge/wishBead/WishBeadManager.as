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
      
      public function WishBeadManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : WishBeadManager
      {
         if(_instance == null)
         {
            _instance = new WishBeadManager();
         }
         return _instance;
      }
      
      public function getCanWishBeadData() : BagInfo
      {
         var equipBaglist:DictionaryData = PlayerManager.Instance.Self.Bag.items;
         var wishBeadBagList:BagInfo = new BagInfo(0,21);
         var arr:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = equipBaglist;
         for each(var item in equipBaglist)
         {
            if(item.StrengthenLevel >= 12 && (item.CategoryID == 7 || item.CategoryID == 5 || item.CategoryID == 1))
            {
               if(item.Place < 17)
               {
                  wishBeadBagList.addItem(item);
               }
               else
               {
                  arr.push(item);
               }
            }
         }
         var _loc9_:int = 0;
         var _loc8_:* = arr;
         for each(var infoItem in arr)
         {
            wishBeadBagList.addItem(infoItem);
         }
         return wishBeadBagList;
      }
      
      public function getWishBeadItemData() : BagInfo
      {
         var proBaglist:DictionaryData = PlayerManager.Instance.Self.PropBag.items;
         var wishBeadBagList:BagInfo = new BagInfo(1,21);
         var _loc5_:int = 0;
         var _loc4_:* = proBaglist;
         for each(var item in proBaglist)
         {
            if(item.TemplateID == 11560 || item.TemplateID == 11561 || item.TemplateID == 11562)
            {
               wishBeadBagList.addItem(item);
            }
         }
         return wishBeadBagList;
      }
      
      public function getIsEquipMatchWishBead(wishBeadId:int, equipId:int, isShowTip:Boolean) : Boolean
      {
         switch(int(wishBeadId) - 11560)
         {
            case 0:
               if(equipId == 7)
               {
                  return true;
               }
               if(isShowTip)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wishBeadMainView.noMatchTipTxt"));
               }
               return false;
            case 1:
               if(equipId == 5)
               {
                  return true;
               }
               if(isShowTip)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wishBeadMainView.noMatchTipTxt2"));
               }
               return false;
            case 2:
               if(equipId == 1)
               {
                  return true;
               }
               if(isShowTip)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wishBeadMainView.noMatchTipTxt3"));
               }
               return false;
         }
      }
      
      public function getwishInfo(analyzer:WishInfoAnalyzer) : void
      {
         wishInfoList = analyzer._wishChangeInfo;
      }
      
      public function getWishInfoByTemplateID(id:int, categoryID:int) : WishChangeInfo
      {
         var temp:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = wishInfoList;
         for each(var info in wishInfoList)
         {
            if(info.OldTemplateId == id)
            {
               return info;
            }
            if(info.OldTemplateId == -1 && info.CategoryID == categoryID)
            {
               temp = info;
            }
         }
         return temp;
      }
   }
}
