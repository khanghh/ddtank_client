package horse.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import horse.data.HorseSkillElementVo;
   import road7th.data.DictionaryData;
   
   public class HorseSkillElementDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _horseSkillElementList:DictionaryData;
      
      public function HorseSkillElementDataAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get horseSkillElementList() : DictionaryData{return null;}
   }
}
