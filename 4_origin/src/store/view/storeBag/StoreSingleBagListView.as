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
      
      public function set OtherCells(param1:DictionaryData) : void
      {
         _otherCells = param1;
      }
      
      override protected function createPanel() : void
      {
         ConsortiaRateManager.instance.addEventListener("transferLight",__showLight);
         super.createPanel();
      }
      
      private function __showLight(param1:StoreIIEvent) : void
      {
         if(param1.data)
         {
            _categoryID = param1.data.CategoryID;
            _showLight = param1.bool;
         }
         else
         {
            _categoryID = -1;
            _showLight = param1.bool;
         }
         showLight(_categoryID,_showLight);
      }
      
      private function showLight(param1:Number, param2:Boolean) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = cells;
         for each(var _loc3_ in cells)
         {
            _loc3_.light = false;
         }
         if(param1 != -1)
         {
            var _loc9_:int = 0;
            var _loc8_:* = cells;
            for each(var _loc5_ in cells)
            {
               if(_loc5_.info && _loc5_.info.CategoryID == param1)
               {
                  _loc5_.light = param2;
               }
            }
         }
         else
         {
            var _loc11_:int = 0;
            var _loc10_:* = cells;
            for each(var _loc4_ in cells)
            {
               _loc4_.light = param2;
            }
         }
      }
      
      override public function dispose() : void
      {
         ConsortiaRateManager.instance.removeEventListener("transferLight",__showLight);
         super.dispose();
      }
      
      override protected function __addGoods(param1:DictionaryEvent) : void
      {
         super.__addGoods(param1);
         showLight(_categoryID,_showLight);
      }
      
      override protected function __removeGoods(param1:StoreBagEvent) : void
      {
         super.__removeGoods(param1);
         showLight(_categoryID,_showLight);
      }
   }
}
