package store.analyze{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import road7th.data.DictionaryData;   import store.data.EvolutionData;      public class EvolutionDataAnalyzer extends DataAnalyzer   {                   private var _data:DictionaryData;            public function EvolutionDataAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get data() : DictionaryData { return null; }
   }}