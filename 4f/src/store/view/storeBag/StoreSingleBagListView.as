package store.view.storeBag
{
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import store.events.StoreBagEvent;
   import store.events.StoreIIEvent;
   import store.view.ConsortiaRateManager;
   
   public class StoreSingleBagListView extends StoreBagListView
   {
       
      
      private var _categoryID:Number = -1;
      
      private var _showLight:Boolean = false;
      
      private var _otherCells:DictionaryData;
      
      public function StoreSingleBagListView(){super();}
      
      public function set OtherCells(param1:DictionaryData) : void{}
      
      override protected function createPanel() : void{}
      
      private function __showLight(param1:StoreIIEvent) : void{}
      
      private function showLight(param1:Number, param2:Boolean) : void{}
      
      override public function dispose() : void{}
      
      override protected function __addGoods(param1:DictionaryEvent) : void{}
      
      override protected function __removeGoods(param1:StoreBagEvent) : void{}
   }
}
