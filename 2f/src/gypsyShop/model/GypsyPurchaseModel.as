package gypsyShop.model{   import ddt.manager.PlayerManager;      public class GypsyPurchaseModel   {            private static var instance:GypsyPurchaseModel;                   public const RmbRefreshNeed:int = 300;            private var _useBindRmbTicket:Boolean = false;            private var _showAlertHonourRefresh:Boolean = true;            private var _showAlertRMBRefresh:Boolean = true;            private var _showAlertRmbTicketBuy:Boolean = true;            public function GypsyPurchaseModel(single:inner) { super(); }
            public static function getInstance() : GypsyPurchaseModel { return null; }
            public function updateIsUseBindRmbTicket(isBind:Boolean) : void { }
            public function updateShowAlertHonourRefresh(show:Boolean) : void { }
            public function updateShowAlertRMBRefresh(show:Boolean) : void { }
            public function updateShowAlertRmbTicketBuy(show:Boolean) : void { }
            public function isShowRmbTicketBuyAgain() : Boolean { return false; }
            public function isShowHonourRefreshAgain() : Boolean { return false; }
            public function isShowRMBRefreshAgain() : Boolean { return false; }
            public function getUseBind() : Boolean { return false; }
            public function getRmbTicketNeeded(id:int) : int { return 0; }
            public function getHonourNeeded() : int { return 0; }
            public function isBindMoneyEnough(id:int) : Boolean { return false; }
            public function isMoneyEnough(id:int) : Boolean { return false; }
            public function isHonourEnough() : Boolean { return false; }
            public function isRefreshRmbEnough() : Boolean { return false; }
   }}class inner{          function inner() { super(); }
}