package mines.view{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.manager.ItemManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.events.MouseEvent;   import mines.analyzer.ShopExchangeInfo;      public class MinesExchangeCell extends MinesBuyCell   {                   private var _infoExchange:ShopExchangeInfo;            public function MinesExchangeCell() { super(); }
            public function get infoExchange() : ShopExchangeInfo { return null; }
            public function set infoExchange(value:ShopExchangeInfo) : void { }
            override protected function initView() : void { }
            override protected function __exchangeHandler(e:MouseEvent) : void { }
   }}