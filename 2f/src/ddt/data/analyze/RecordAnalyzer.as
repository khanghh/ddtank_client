package ddt.data.analyze{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.RecordInfo;   import ddt.data.RecordItemInfo;      public class RecordAnalyzer extends DataAnalyzer   {                   private var _info:RecordInfo;            public function RecordAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get info() : RecordInfo { return null; }
   }}