package horse.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import horse.data.HorseSkillGetVo;
   import road7th.data.DictionaryData;
   
   public class HorseSkillGetDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _horseSkillGetList:DictionaryData;
      
      private var _horseSkillGetIdList:DictionaryData;
      
      public function HorseSkillGetDataAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      private function compareFunc(param1:HorseSkillGetVo, param2:HorseSkillGetVo) : int{return 0;}
      
      public function get horseSkillGetList() : DictionaryData{return null;}
      
      public function get horseSkillGetIdList() : DictionaryData{return null;}
   }
}
