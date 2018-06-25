package sanXiao.view{   import ddt.command.QuickBuyAlertBase;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.events.MouseEvent;      public class SXShopBuyView extends QuickBuyAlertBase   {                   private var _buyNum:int;            private var _ShopID:int;            public function SXShopBuyView() { super(); }
            override protected function initView() : void { }
            override protected function refreshNumText() : void { }
            override public function setData(templateId:int, goodsId:int, perPrice:int) : void { }
            public function setID(id:int) : void { }
            public function setBuyNum(value:int) : void { }
            override protected function __buy(event:MouseEvent) : void { }
   }}