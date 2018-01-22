package rank.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import rank.data.RankAwardInfo;
   
   public class RankingListAwardAnalyzer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<RankAwardInfo>;
      
      public var lastUpdateTime:String;
      
      public function RankingListAwardAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
