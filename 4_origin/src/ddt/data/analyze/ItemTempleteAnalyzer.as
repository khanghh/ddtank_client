package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.data.DictionaryData;
   
   public class ItemTempleteAnalyzer extends DataAnalyzer
   {
       
      
      public var list:DictionaryData;
      
      private var _xml:XML;
      
      private var _timer:Timer;
      
      private var _xmllist:XMLList;
      
      private var _index:int;
      
      private var _xmlListLength:int;
      
      public function ItemTempleteAnalyzer(onCompleteCall:Function)
      {
         list = new DictionaryData();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         _xml = new XML(data);
         list = new DictionaryData();
         parseTemplate();
      }
      
      protected function parseTemplate() : void
      {
         if(_xml.@value == "true")
         {
            _xmllist = _xml.ItemTemplate..Item;
            _xmlListLength = _xmllist.length();
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
         for(i = 0; i < 150; )
         {
            _index = Number(_index) + 1;
            if(_index < _xmlListLength)
            {
               info = new ItemTemplateInfo();
               ObjectUtils.copyPorpertiesByXML(info,_xmllist[_index]);
               parseAttachingData(info);
               info.templateAttack = parseInt(_xmllist[_index].@Attack);
               info.templateDefence = parseInt(_xmllist[_index].@Defence);
               info.templateLuck = parseInt(_xmllist[_index].@Luck);
               info.templateAgility = parseInt(_xmllist[_index].@Agility);
               list.add(info.TemplateID,info);
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
      
      private function parseAttachingData(item:ItemTemplateInfo) : void
      {
         var _loc2_:* = item.CategoryID;
         if(17 !== _loc2_)
         {
            if(7 !== _loc2_)
            {
               if(1 !== _loc2_)
               {
                  if(5 !== _loc2_)
                  {
                  }
               }
               item.Arm = parseInt(item.Property7);
            }
            else
            {
               item.AddDamage = parseInt(item.Property7);
            }
         }
         else if(parseInt(item.Property3) == 130)
         {
            item.reducePower = parseInt(item.Property7) / 2;
         }
         else if(parseInt(item.Property6) == 2)
         {
            item.Recover = parseInt(item.Property7);
         }
         else if(parseInt(item.Property6) == 3)
         {
            item.SubDamage = parseInt(item.Property7);
         }
      }
   }
}
