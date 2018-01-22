package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import consortion.ConsortionModelManager;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.data.player.PlayerState;
   import ddt.manager.PlayerManager;
   import road7th.data.DictionaryData;
   
   public class ConsortionMemberAnalyer extends DataAnalyzer
   {
       
      
      public var consortionMember:DictionaryData;
      
      public function ConsortionMemberAnalyer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      private function converBoolean(param1:String) : Boolean{return false;}
   }
}
