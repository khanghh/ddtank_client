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
      
      public function StoreSingleBagListView()
      {
         super();
      }
      
      public function set OtherCells(value:DictionaryData) : void
      {
         _otherCells = value;
      }
      
      override protected function createPanel() : void
      {
         ConsortiaRateManager.instance.addEventListener("transferLight",__showLight);
         super.createPanel();
      }
      
      private function __showLight(evt:StoreIIEvent) : void
      {
         if(evt.data)
         {
            _categoryID = evt.data.CategoryID;
            _showLight = evt.bool;
         }
         else
         {
            _categoryID = -1;
            _showLight = evt.bool;
         }
         showLight(_categoryID,_showLight);
      }
      
      private function showLight(categoryType:Number, isShow:Boolean) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = cells;
         for each(var cell in cells)
         {
            cell.light = false;
         }
         if(categoryType != -1)
         {
            var _loc9_:int = 0;
            var _loc8_:* = cells;
            for each(var i in cells)
            {
               if(i.info && i.info.CategoryID == categoryType)
               {
                  i.light = isShow;
               }
            }
         }
         else
         {
            var _loc11_:int = 0;
            var _loc10_:* = cells;
            for each(var j in cells)
            {
               j.light = isShow;
            }
         }
      }
      
      override public function dispose() : void
      {
         ConsortiaRateManager.instance.removeEventListener("transferLight",__showLight);
         super.dispose();
      }
      
      override protected function __addGoods(evt:DictionaryEvent) : void
      {
         super.__addGoods(evt);
         showLight(_categoryID,_showLight);
      }
      
      override protected function __removeGoods(evt:StoreBagEvent) : void
      {
         super.__removeGoods(evt);
         showLight(_categoryID,_showLight);
      }
   }
}
