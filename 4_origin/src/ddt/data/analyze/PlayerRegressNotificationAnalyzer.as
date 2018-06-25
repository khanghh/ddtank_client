package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class PlayerRegressNotificationAnalyzer extends DataAnalyzer
   {
       
      
      public var updateContent:String;
      
      public function PlayerRegressNotificationAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         updateContent = String(data);
         onAnalyzeComplete();
      }
   }
}
