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
      
      public function ShopItemAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         _xml = new XML(param1);
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
      
      private function parseShop(param1:Event) : void
      {
         _timer = new Timer(30);
         _timer.addEventListener("timer",__partexceute);
         _timer.start();
      }
      
      private function __partexceute(param1:TimerEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         _loc4_ = 0;
         while(_loc4_ < 150)
         {
            index = Number(index) + 1;
            if(index < _xmlListLength)
            {
               _loc2_ = _shoplist[index];
               _loc3_ = new ShopItemInfo(int(_loc2_.@ID),int(_loc2_.@TemplateID));
               ObjectUtils.copyPorpertiesByXML(_loc3_,_loc2_);
               shopinfolist.add(_loc3_.GoodsID,_loc3_);
               _loc4_++;
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
