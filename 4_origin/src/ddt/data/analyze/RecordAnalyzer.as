package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.RecordInfo;
   import ddt.data.RecordItemInfo;
   
   public class RecordAnalyzer extends DataAnalyzer
   {
       
      
      private var _info:RecordInfo;
      
      public function RecordAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var itemInfo:* = null;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            _info = new RecordInfo();
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               itemInfo = new RecordItemInfo();
               ObjectUtils.copyPorpertiesByXML(itemInfo,xmllist[i]);
               _info.recordList.push(itemInfo);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      public function get info() : RecordInfo
      {
         return _info;
      }
   }
}
