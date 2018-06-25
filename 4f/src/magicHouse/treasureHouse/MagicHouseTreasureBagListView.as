package magicHouse.treasureHouse{   import bagAndInfo.bag.BagListView;   import bagAndInfo.cell.CellFactory;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.player.SelfInfo;   import ddt.events.CellEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import flash.events.MouseEvent;   import flash.utils.Dictionary;   import magicHouse.MagicHouseModel;   import magicHouse.MagicHouseTipFrame;      public class MagicHouseTreasureBagListView extends BagListView   {            private static var MAX_LINE_NUM:int = 10;            private static const baseDepotCount:int = 10;                   private var _depotNum:int;            private var _needMoney:int = 0;            private var _pos:int = 0;            private var _frame:MagicHouseTipFrame;            private var _selfInfo:SelfInfo;            private var IsOK:Boolean;            public function MagicHouseTreasureBagListView(bagType:int, num:int = 0) { super(null,null); }
            public function addDepot(num:int) : void { }
            override protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            override protected function __clickHandler(e:InteractiveEvent) : void { }
            private function __okBtnHandler(e:MouseEvent) : void { }
            protected function onCompleteHandler() : void { }
            private function __cancelBtnHandler(e:MouseEvent) : void { }
            private function __confirmResponse(e:FrameEvent) : void { }
            override protected function createCells() : void { }
            public function checkMagicHouseStoreCell() : int { return 0; }
            public function set depotNum(value:int) : void { }
            override public function dispose() : void { }
   }}