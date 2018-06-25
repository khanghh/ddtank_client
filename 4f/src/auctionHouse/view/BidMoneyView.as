package auctionHouse.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.PlayerManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.TextEvent;      public class BidMoneyView extends Sprite implements Disposeable   {                   public const MONEY_KEY_UP:String = "money_key_up";            private var _money:FilterFrameText;            private var _canMoney:Boolean;            private var _canGold:Boolean;            public function BidMoneyView() { super(); }
            public function get money() : FilterFrameText { return null; }
            private function initView() : void { }
            private function addEvent() : void { }
            protected function get canMoney() : Boolean { return false; }
            protected function get canGold() : Boolean { return false; }
            private function removeEvent() : void { }
            protected function canMoneyBid(price:int) : void { }
            protected function canGoldBid(price:int) : void { }
            protected function cannotBid() : void { }
            protected function getData() : Number { return 0; }
            private function _moneyUp(e:KeyboardEvent) : void { }
            private function __change(event:Event) : void { }
            private function __inputTextM(event:TextEvent) : void { }
            public function dispose() : void { }
   }}