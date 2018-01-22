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
      
      public function WishBeadManager(param1:IEventDispatcher = null)
      {
         super(param1);
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
         var _loc4_:DictionaryData = PlayerManager.Instance.Self.Bag.items;
         var _loc1_:BagInfo = new BagInfo(0,21);
         var _loc3_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = _loc4_;
         for each(var _loc5_ in _loc4_)
         {
            if(_loc5_.StrengthenLevel >= 12 && (_loc5_.CategoryID == 7 || _loc5_.CategoryID == 5 || _loc5_.CategoryID == 1))
            {
               if(_loc5_.Place < 17)
               {
                  _loc1_.addItem(_loc5_);
               }
               else
               {
                  _loc3_.push(_loc5_);
               }
            }
         }
         var _loc9_:int = 0;
         var _loc8_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            _loc1_.addItem(_loc2_);
         }
         return _loc1_;
      }
      
      public function getWishBeadItemData() : BagInfo
      {
         var _loc2_:DictionaryData = PlayerManager.Instance.Self.PropBag.items;
         var _loc1_:BagInfo = new BagInfo(1,21);
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.TemplateID == 11560 || _loc3_.TemplateID == 11561 || _loc3_.TemplateID == 11562)
            {
               _loc1_.addItem(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function getIsEquipMatchWishBead(param1:int, param2:int, param3:Boolean) : Boolean
      {
         switch(int(param1) - 11560)
         {
            case 0:
               if(param2 == 7)
               {
                  return true;
               }
               if(param3)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wishBeadMainView.noMatchTipTxt"));
               }
               return false;
            case 1:
               if(param2 == 5)
               {
                  return true;
               }
               if(param3)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wishBeadMainView.noMatchTipTxt2"));
               }
               return false;
            case 2:
               if(param2 == 1)
               {
                  return true;
               }
               if(param3)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wishBeadMainView.noMatchTipTxt3"));
               }
               return false;
         }
      }
      
      public function getwishInfo(param1:WishInfoAnalyzer) : void
      {
         wishInfoList = param1._wishChangeInfo;
      }
      
      public function getWishInfoByTemplateID(param1:int, param2:int) : WishChangeInfo
      {
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = wishInfoList;
         for each(var _loc4_ in wishInfoList)
         {
            if(_loc4_.OldTemplateId == param1)
            {
               return _loc4_;
            }
            if(_loc4_.OldTemplateId == -1 && _loc4_.CategoryID == param2)
            {
               _loc3_ = _loc4_;
            }
         }
         return _loc3_;
      }
   }
}
