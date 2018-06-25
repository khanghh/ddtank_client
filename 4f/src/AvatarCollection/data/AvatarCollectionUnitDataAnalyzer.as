package AvatarCollection.data{   import com.pickgliss.loader.DataAnalyzer;   import road7th.data.DictionaryData;      public class AvatarCollectionUnitDataAnalyzer extends DataAnalyzer   {                   private var _maleUnitDic:DictionaryData;            private var _femaleUnitDic:DictionaryData;            private var _weaponUnitDic:DictionaryData;            public function AvatarCollectionUnitDataAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get maleUnitDic() : DictionaryData { return null; }
            public function get femaleUnitDic() : DictionaryData { return null; }
            public function get weaponUnitDic() : DictionaryData { return null; }
   }}