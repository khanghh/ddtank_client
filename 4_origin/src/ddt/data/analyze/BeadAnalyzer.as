package ddt.data.analyze
{
   import beadSystem.model.BeadInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.data.DictionaryData;
   
   public class BeadAnalyzer extends DataAnalyzer
   {
       
      
      public var list:DictionaryData;
      
      private var _xml:XML;
      
      private var _timer:Timer;
      
      private var _xmllist:XMLList;
      
      private var _index:int;
      
      public function BeadAnalyzer(onCompleteCall:Function)
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
            _xmllist = _xml..Rune;
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
               info = new BeadInfo();
               ObjectUtils.copyPorpertiesByXML(info,_xmllist[_index]);
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
   }
}
