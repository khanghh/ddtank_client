package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.effort.EffortInfo;
   import ddt.data.effort.EffortQualificationInfo;
   import ddt.data.effort.EffortRewardInfo;
   import road7th.data.DictionaryData;
   
   public class EffortItemTemplateInfoAnalyzer extends DataAnalyzer
   {
      
      private static const PATH:String = "AchievementList.xml";
       
      
      public var list:DictionaryData;
      
      public function EffortItemTemplateInfoAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      private function getBoolean(param1:String) : Boolean{return false;}
   }
}
