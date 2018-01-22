package team.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   import team.model.TeamShopInfo;
   
   public class TeamShopAnalyze extends DataAnalyzer
   {
       
      
      public var data:DictionaryData;
      
      public var buyLimitLv:Array;
      
      public function TeamShopAnalyze(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
