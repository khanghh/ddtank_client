package horse.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import horse.data.HorseSkillGetVo;   import road7th.data.DictionaryData;      public class HorseSkillGetDataAnalyzer extends DataAnalyzer   {                   private var _horseSkillGetList:DictionaryData;            private var _horseSkillGetIdList:DictionaryData;            public function HorseSkillGetDataAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            private function compareFunc(tmpA:HorseSkillGetVo, tmpB:HorseSkillGetVo) : int { return 0; }
            public function get horseSkillGetList() : DictionaryData { return null; }
            public function get horseSkillGetIdList() : DictionaryData { return null; }
   }}