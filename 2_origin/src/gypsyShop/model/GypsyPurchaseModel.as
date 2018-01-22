package gypsyShop.model
{
   import ddt.manager.PlayerManager;
   
   public class GypsyPurchaseModel
   {
      
      private static var instance:GypsyPurchaseModel;
       
      
      public const RmbRefreshNeed:int = 300;
      
      private var _useBindRmbTicket:Boolean = false;
      
      private var _showAlertHonourRefresh:Boolean = true;
      
      private var _showAlertRMBRefresh:Boolean = true;
      
      private var _showAlertRmbTicketBuy:Boolean = true;
      
      public function GypsyPurchaseModel(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : GypsyPurchaseModel
      {
         if(!instance)
         {
            instance = new GypsyPurchaseModel(new inner());
         }
         return instance;
      }
      
      public function updateIsUseBindRmbTicket(param1:Boolean) : void
      {
         _useBindRmbTicket = param1;
      }
      
      public function updateShowAlertHonourRefresh(param1:Boolean) : void
      {
         _showAlertHonourRefresh = param1;
      }
      
      public function updateShowAlertRMBRefresh(param1:Boolean) : void
      {
         _showAlertRMBRefresh = param1;
      }
      
      public function updateShowAlertRmbTicketBuy(param1:Boolean) : void
      {
         _showAlertRmbTicketBuy = param1;
      }
      
      public function isShowRmbTicketBuyAgain() : Boolean
      {
         return _showAlertRmbTicketBuy;
      }
      
      public function isShowHonourRefreshAgain() : Boolean
      {
         return _showAlertHonourRefresh;
      }
      
      public function isShowRMBRefreshAgain() : Boolean
      {
         return _showAlertRMBRefresh;
      }
      
      public function getUseBind() : Boolean
      {
         return _useBindRmbTicket;
      }
      
      public function getRmbTicketNeeded(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Vector.<GypsyItemData> = GypsyShopModel.getInstance().itemDataList;
         if(_loc2_ == null)
         {
            return 0;
         }
         _loc3_ = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].id == param1)
            {
               if(_loc2_[_loc4_].unit == 1)
               {
                  return _loc2_[_loc4_].price;
               }
            }
            _loc4_++;
         }
         return 0;
      }
      
      public function getHonourNeeded() : int
      {
         return GypsyShopModel.getInstance().getNeedMoneyTotal();
      }
      
      public function isBindMoneyEnough(param1:int) : Boolean
      {
         if(PlayerManager.Instance.Self.BandMoney < getRmbTicketNeeded(param1))
         {
            return false;
         }
         return true;
      }
      
      public function isMoneyEnough(param1:int) : Boolean
      {
         if(PlayerManager.Instance.Self.Money < getRmbTicketNeeded(param1))
         {
            return false;
         }
         return true;
      }
      
      public function isHonourEnough() : Boolean
      {
         return PlayerManager.Instance.Self.myHonor >= getHonourNeeded();
      }
      
      public function isRefreshRmbEnough() : Boolean
      {
         return PlayerManager.Instance.Self.BandMoney >= 300 || PlayerManager.Instance.Self.Money >= 300;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
