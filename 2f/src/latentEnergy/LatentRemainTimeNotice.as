package latentEnergy{   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.TimeManager;   import flash.events.Event;   import flash.utils.setTimeout;   import playerDress.PlayerDressManager;      public class LatentRemainTimeNotice   {            private static var instance:LatentRemainTimeNotice;                   private var bagUpdated:Boolean = false;            private var dressModelSet:Boolean = false;            public function LatentRemainTimeNotice(single:inner) { super(); }
            public static function getInstance() : LatentRemainTimeNotice { return null; }
            public function ShowNotice() : void { }
            public function init() : void { }
            public function dispose() : void { }
            private function addEvents() : void { }
            private function removeEvents() : void { }
            protected function onDressSet(e:Event) : void { }
            protected function onBagUpdated(e:Event) : void { }
            private function checkItems() : void { }
   }}class inner{          function inner() { super(); }
}