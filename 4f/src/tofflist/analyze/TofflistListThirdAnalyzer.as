package tofflist.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.describeType;
   import team.model.TeamRankInfo;
   import tofflist.data.TofflistListData;
   import tofflist.data.TofflistPlayerInfo;
   
   public class TofflistListThirdAnalyzer extends DataAnalyzer
   {
       
      
      private var _xml:XML;
      
      public var data:TofflistListData;
      
      public function TofflistListThirdAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
