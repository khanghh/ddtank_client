package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.RecordInfo;
   import ddt.data.RecordItemInfo;
   
   public class RecordAnalyzer extends DataAnalyzer
   {
       
      
      private var _info:RecordInfo;
      
      public function RecordAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get info() : RecordInfo{return null;}
   }
}
