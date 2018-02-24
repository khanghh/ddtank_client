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
      
      public function GypsyPurchaseModel(param1:inner){super();}
      
      public static function getInstance() : GypsyPurchaseModel{return null;}
      
      public function updateIsUseBindRmbTicket(param1:Boolean) : void{}
      
      public function updateShowAlertHonourRefresh(param1:Boolean) : void{}
      
      public function updateShowAlertRMBRefresh(param1:Boolean) : void{}
      
      public function updateShowAlertRmbTicketBuy(param1:Boolean) : void{}
      
      public function isShowRmbTicketBuyAgain() : Boolean{return false;}
      
      public function isShowHonourRefreshAgain() : Boolean{return false;}
      
      public function isShowRMBRefreshAgain() : Boolean{return false;}
      
      public function getUseBind() : Boolean{return false;}
      
      public function getRmbTicketNeeded(param1:int) : int{return 0;}
      
      public function getHonourNeeded() : int{return 0;}
      
      public function isBindMoneyEnough(param1:int) : Boolean{return false;}
      
      public function isMoneyEnough(param1:int) : Boolean{return false;}
      
      public function isHonourEnough() : Boolean{return false;}
      
      public function isRefreshRmbEnough() : Boolean{return false;}
   }
}

class inner
{
    
   
   function inner(){super();}
}
