package dreamlandChallenge.view.logicView.shop{   import ddt.command.QuickBuyAlertBase;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import dreamlandChallenge.DreamlandChallengeManager;   import flash.events.MouseEvent;      public class DreamLandShopQuickBuy extends QuickBuyAlertBase   {                   private var _buyNum:int;            public function DreamLandShopQuickBuy() { super(); }
            override protected function initView() : void { }
            override protected function refreshNumText() : void { }
            override protected function __buy(event:MouseEvent) : void { }
            override protected function submit(isBand:Boolean) : void { }
            private function checkJampsCurreny(needMoney:int) : Boolean { return false; }
   }}