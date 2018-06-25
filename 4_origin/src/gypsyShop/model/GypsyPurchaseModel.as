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
      
      public function GypsyPurchaseModel(single:inner)
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
      
      public function updateIsUseBindRmbTicket(isBind:Boolean) : void
      {
         _useBindRmbTicket = isBind;
      }
      
      public function updateShowAlertHonourRefresh(show:Boolean) : void
      {
         _showAlertHonourRefresh = show;
      }
      
      public function updateShowAlertRMBRefresh(show:Boolean) : void
      {
         _showAlertRMBRefresh = show;
      }
      
      public function updateShowAlertRmbTicketBuy(show:Boolean) : void
      {
         _showAlertRmbTicketBuy = show;
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
      
      public function getRmbTicketNeeded(id:int) : int
      {
         var len:int = 0;
         var i:int = 0;
         var list:Vector.<GypsyItemData> = GypsyShopModel.getInstance().itemDataList;
         if(list == null)
         {
            return 0;
         }
         len = list.length;
         for(i = 0; i < len; )
         {
            if(list[i].id == id)
            {
               if(list[i].unit == 1)
               {
                  return list[i].price;
               }
            }
            i++;
         }
         return 0;
      }
      
      public function getHonourNeeded() : int
      {
         return GypsyShopModel.getInstance().getNeedMoneyTotal();
      }
      
      public function isBindMoneyEnough(id:int) : Boolean
      {
         if(PlayerManager.Instance.Self.BandMoney < getRmbTicketNeeded(id))
         {
            return false;
         }
         return true;
      }
      
      public function isMoneyEnough(id:int) : Boolean
      {
         if(PlayerManager.Instance.Self.Money < getRmbTicketNeeded(id))
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
