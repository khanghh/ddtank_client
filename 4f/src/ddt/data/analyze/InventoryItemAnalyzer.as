package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class InventoryItemAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<InventoryItemInfo>;
      
      private var _xml:XML;
      
      private var _timer:Timer;
      
      private var _xmllist:XMLList;
      
      private var _index:int;
      
      public function InventoryItemAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      protected function parseTemplate() : void{}
      
      private function __partexceute(param1:TimerEvent) : void{}
   }
}
