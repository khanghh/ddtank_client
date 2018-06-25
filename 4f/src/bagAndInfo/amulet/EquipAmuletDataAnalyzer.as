package bagAndInfo.amulet{   import bagAndInfo.amulet.vo.EquipAmuletVo;   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import road7th.data.DictionaryData;      public class EquipAmuletDataAnalyzer extends DataAnalyzer   {                   private var _data:DictionaryData;            public function EquipAmuletDataAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get data() : DictionaryData { return null; }
   }}