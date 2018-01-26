package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.map.OpenMapInfo;
   
   public class WeekOpenMapAnalyze extends DataAnalyzer
   {
      
      public static const PATH:String = "MapServerList.xml";
       
      
      public var list:Vector.<OpenMapInfo>;
      
      public function WeekOpenMapAnalyze(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
