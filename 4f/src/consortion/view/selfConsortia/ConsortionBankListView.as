package consortion.view.selfConsortia{   import bagAndInfo.bag.BagListView;   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.CellFactory;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.utils.DoubleClickManager;   import ddt.events.CellEvent;   import flash.events.MouseEvent;   import flash.utils.Dictionary;      public class ConsortionBankListView extends BagListView   {            private static var MAX_LINE_NUM:int = 10;                   private var _bankLevel:int;            public function ConsortionBankListView(bagType:int, level:int = 0) { super(null,null); }
            override public function updateBankBag(level:int) : void { }
            override protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            override protected function __clickHandler(e:InteractiveEvent) : void { }
            private function __resultHandler(evt:MouseEvent) : void { }
            override protected function createCells() : void { }
            override public function checkBankCell() : int { return 0; }
            override public function dispose() : void { }
   }}