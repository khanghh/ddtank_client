package league.view{   import ddt.command.QuickBuyAlertBase;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.MouseEvent;      public class LeagueShopBuySubmitAlert extends QuickBuyAlertBase   {                   private var _buyNum:int;            private var _goodsId:int;            public function LeagueShopBuySubmitAlert() { super(); }
            override protected function initView() : void { }
            override protected function refreshNumText() : void { }
            override public function setData(templateId:int, goodsId:int, perPrice:int) : void { }
            public function setBuyNum(value:int) : void { }
            override protected function __buy(event:MouseEvent) : void { }
   }}