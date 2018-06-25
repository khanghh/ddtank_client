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
      
      public function InventoryItemAnalyzer(onCompleteCall:Function)
      {
         list = new Vector.<InventoryItemInfo>();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         _xml = new XML(data);
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
      
      private function __partexceute(event:TimerEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         for(i = 0; i < 40; )
         {
            _index = Number(_index) + 1;
            if(_index < _xmllist.length())
            {
               info = new InventoryItemInfo();
               ObjectUtils.copyPorpertiesByXML(info,_xmllist[_index]);
               ItemManager.fill(info);
               list.push(info);
               i++;
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
