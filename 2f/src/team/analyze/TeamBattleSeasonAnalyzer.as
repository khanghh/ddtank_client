package team.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   import team.model.TeamBattleSeasonInfo;
   
   public class TeamBattleSeasonAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function TeamBattleSeasonAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get data() : DictionaryData{return null;}
   }
}
