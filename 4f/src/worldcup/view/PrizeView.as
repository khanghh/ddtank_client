package worldcup.view{   import ddt.events.CEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.ServerConfigManager;   import morn.core.handlers.Handler;   import worldcup.WorldcupManager;   import worldcup.view.item.PrizeItem;   import worldcup.view.mornui.PrizeViewUI;      public class PrizeView extends PrizeViewUI   {                   public function PrizeView() { super(); }
            override protected function initialize() : void { }
            private function toArray() : Array { return null; }
            private function __getPrizeHandler(evt:CEvent) : void { }
            private function render(item:PrizeItem, index:int) : void { }
            override public function dispose() : void { }
   }}