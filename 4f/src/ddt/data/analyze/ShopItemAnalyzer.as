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
      
      public function ShopItemAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      private function parseShop(param1:Event) : void{}
      
      private function __partexceute(param1:TimerEvent) : void{}
   }
}
