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
      
      public function BeadAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      protected function parseTemplate() : void{}
      
      private function __partexceute(param1:TimerEvent) : void{}
   }
}
