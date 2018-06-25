package explorerManual.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import explorerManual.data.model.ManualLevelInfo;   import road7th.data.DictionaryData;      public class ManualLevelAnalyzer extends DataAnalyzer   {                   private var _data:DictionaryData;            public function ManualLevelAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get data() : DictionaryData { return null; }
   }}