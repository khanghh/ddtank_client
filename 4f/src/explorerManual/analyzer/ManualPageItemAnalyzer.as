package explorerManual.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import explorerManual.data.model.ManualPageItemInfo;   import road7th.data.DictionaryData;      public class ManualPageItemAnalyzer extends DataAnalyzer   {                   private var _data:DictionaryData;            public function ManualPageItemAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get data() : DictionaryData { return null; }
   }}