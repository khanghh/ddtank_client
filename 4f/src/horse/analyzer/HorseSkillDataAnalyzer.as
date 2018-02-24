package horse.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import horse.data.HorseSkillVo;
   import road7th.data.DictionaryData;
   
   public class HorseSkillDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _horseSkillList:DictionaryData;
      
      public function HorseSkillDataAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get horseSkillList() : DictionaryData{return null;}
   }
}
