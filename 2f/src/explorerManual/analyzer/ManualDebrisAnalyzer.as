package explorerManual.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import explorerManual.data.model.ManualDebrisInfo;   import road7th.data.DictionaryData;      public class ManualDebrisAnalyzer extends DataAnalyzer   {                   private var _data:DictionaryData;            public function ManualDebrisAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get data() : DictionaryData { return null; }
   }}