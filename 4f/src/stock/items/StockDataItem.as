package stock.items
{
   import flash.events.MouseEvent;
   import stock.data.StockData;
   import stock.mornUI.items.StockDataItemUI;
   
   public class StockDataItem extends StockDataItemUI
   {
       
      
      private var _data:StockData = null;
      
      private var _overLabels:Array;
      
      private var _normalLabels:Array;
      
      public function StockDataItem(){super();}
      
      override protected function initialize() : void{}
      
      private function overOrOut(param1:MouseEvent) : void{}
      
      private function validLabel() : void{}
      
      public function set data(param1:StockData) : void{}
      
      public function get data() : StockData{return null;}
      
      override public function dispose() : void{}
      
      private function removeEvent() : void{}
   }
}
