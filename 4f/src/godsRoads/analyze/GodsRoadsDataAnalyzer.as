package godsRoads.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import godsRoads.data.GodsRoadsMissionInfo;
   import godsRoads.manager.GodsRoadsManager;
   
   public class GodsRoadsDataAnalyzer extends DataAnalyzer
   {
       
      
      public var dataList:Vector.<GodsRoadsMissionInfo>;
      
      public function GodsRoadsDataAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
