package worldcup.view.item{   import ddt.manager.LanguageMgr;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import morn.core.handlers.Handler;   import worldcup.WorldcupManager;   import worldcup.view.mornui.item.PrizeItemUI;      public class PrizeItem extends PrizeItemUI   {                   private var _index:int;            public function PrizeItem() { super(); }
            override protected function initialize() : void { }
            private function getClickHandler() : void { }
            public function get index() : int { return 0; }
            public function set index(value:int) : void { }
            private function updataInfo() : void { }
            public function refreshInfo() : void { }
   }}