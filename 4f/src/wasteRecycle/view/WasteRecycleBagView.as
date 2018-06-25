package wasteRecycle.view{   import bagAndInfo.bag.BagView;   import bagAndInfo.cell.BaseCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.events.CellEvent;   import ddt.manager.SoundManager;   import flash.events.Event;   import playerDress.PlayerDressControl;   import playerDress.event.PlayerDressEvent;      public class WasteRecycleBagView extends BagView   {                   public function WasteRecycleBagView() { super(); }
            override protected function initBackGround() : void { }
            override protected function initTabButtons() : void { }
            override protected function set_breakBtn_enable() : void { }
            override protected function initBagList() : void { }
            override protected function showDressBagView(event:PlayerDressEvent) : void { }
            override protected function adjustEvent() : void { }
            override protected function __cellOpen(evt:Event) : void { }
            override protected function __onBagUpdatePROPBAG(evt:BagEvent) : void { }
            override protected function __cellClick(evt:CellEvent) : void { }
            override protected function __cellDoubleClick(evt:CellEvent) : void { }
            override public function dispose() : void { }
   }}