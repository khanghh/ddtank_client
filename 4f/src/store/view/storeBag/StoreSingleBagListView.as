package store.view.storeBag{   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;   import store.events.StoreBagEvent;   import store.events.StoreIIEvent;   import store.view.ConsortiaRateManager;      public class StoreSingleBagListView extends StoreBagListView   {                   private var _categoryID:Number = -1;            private var _showLight:Boolean = false;            private var _otherCells:DictionaryData;            public function StoreSingleBagListView() { super(); }
            public function set OtherCells(value:DictionaryData) : void { }
            override protected function createPanel() : void { }
            private function __showLight(evt:StoreIIEvent) : void { }
            private function showLight(categoryType:Number, isShow:Boolean) : void { }
            override public function dispose() : void { }
            override protected function __addGoods(evt:DictionaryEvent) : void { }
            override protected function __removeGoods(evt:StoreBagEvent) : void { }
   }}