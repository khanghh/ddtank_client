package tofflist.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.describeType;
   import tofflist.data.TofflistConsortiaData;
   import tofflist.data.TofflistConsortiaInfo;
   import tofflist.data.TofflistListData;
   import tofflist.data.TofflistPlayerInfo;
   
   public class TofflistListAnalyzer extends DataAnalyzer
   {
       
      
      public var data:TofflistListData;
      
      private var _xml:XML;
      
      public function TofflistListAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
