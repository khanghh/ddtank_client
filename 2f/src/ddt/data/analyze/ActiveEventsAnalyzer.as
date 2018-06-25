package ddt.data.analyze{   import activeEvents.data.ActiveEventsInfo;   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;      public class ActiveEventsAnalyzer extends DataAnalyzer   {                   private var _list:Array;            private var _xml:XML;            public function ActiveEventsAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get list() : Array { return null; }
   }}