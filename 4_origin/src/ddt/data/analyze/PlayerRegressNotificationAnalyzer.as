package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class PlayerRegressNotificationAnalyzer extends DataAnalyzer
   {
       
      
      public var updateContent:String;
      
      public function PlayerRegressNotificationAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         updateContent = String(param1);
         onAnalyzeComplete();
      }
   }
}
