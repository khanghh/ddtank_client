package ddt.data.analyze{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import flash.events.TimerEvent;   import flash.utils.Timer;   import road7th.data.DictionaryData;      public class ItemTempleteAnalyzer extends DataAnalyzer   {                   public var list:DictionaryData;            private var _xml:XML;            private var _timer:Timer;            private var _xmllist:XMLList;            private var _index:int;            private var _xmlListLength:int;            public function ItemTempleteAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            protected function parseTemplate() : void { }
            private function __partexceute(event:TimerEvent) : void { }
            private function parseAttachingData(item:ItemTemplateInfo) : void { }
   }}