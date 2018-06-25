package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.data.DictionaryData;
   
   public class ShopItemAnalyzer extends DataAnalyzer
   {
       
      
      public var shopinfolist:DictionaryData;
      
      private var _xml:XML;
      
      private var _shoplist:XMLList;
      
      private var index:int = -1;
      
      private var _timer:Timer;
      
      private var _xmlListLength:int;
      
      public function ShopItemAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         _xml = new XML(data);
         if(_xml.@value == "true")
         {
            shopinfolist = new DictionaryData();
            _shoplist = _xml.Store..Item;
            _xmlListLength = _shoplist.length();
            parseShop(null);
         }
         else
         {
            message = _xml.@message;
            onAnalyzeError();
         }
      }
      
      private function parseShop(evt:Event) : void
      {
         _timer = new Timer(30);
         _timer.addEventListener("timer",__partexceute);
         _timer.start();
      }
      
      private function __partexceute(evt:TimerEvent) : void
      {
         var i:int = 0;
         var itemXML:* = null;
         var info:* = null;
         for(i = 0; i < 150; )
         {
            index = Number(index) + 1;
            if(index < _xmlListLength)
            {
               itemXML = _shoplist[index];
               info = new ShopItemInfo(int(itemXML.@ID),int(itemXML.@TemplateID));
               ObjectUtils.copyPorpertiesByXML(info,itemXML);
               shopinfolist.add(info.GoodsID,info);
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
