package ddt.data.analyze{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.store.FineSuitVo;   import road7th.data.DictionaryData;      public class FineSuitAnalyze extends DataAnalyzer   {                   private var _list:DictionaryData;            private var _data:DictionaryData;            private var _materialIDList:Array;            public function FineSuitAnalyze(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            private function addData(info:FineSuitVo) : void { }
            public function get list() : DictionaryData { return null; }
            public function get materialIDList() : Array { return null; }
            public function get tipsData() : DictionaryData { return null; }
   }}