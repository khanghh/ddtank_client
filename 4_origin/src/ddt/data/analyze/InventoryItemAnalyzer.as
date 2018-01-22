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
      
      public function InventoryItemAnalyzer(param1:Function)
      {
         list = new Vector.<InventoryItemInfo>();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         _xml = new XML(param1);
         list = new Vector.<InventoryItemInfo>();
         parseTemplate();
      }
      
      protected function parseTemplate() : void
      {
         if(_xml.@value == "true")
         {
            _xmllist = _xml..Item;
            _index = -1;
            _timer = new Timer(30);
            _timer.addEventListener("timer",__partexceute);
            _timer.start();
         }
         else
         {
            message = _xml.@message;
            onAnalyzeError();
         }
      }
      
      private function __partexceute(param1:TimerEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < 40)
         {
            _index = Number(_index) + 1;
            if(_index < _xmllist.length())
            {
               _loc2_ = new InventoryItemInfo();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_xmllist[_index]);
               ItemManager.fill(_loc2_);
               list.push(_loc2_);
               _loc3_++;
               continue;
            }
            _timer.removeEventListener("timer",__partexceute);
            _timer.stop();
            _timer = null;
            onAnalyzeComplete();
            return;
         }
      }
   }
}
