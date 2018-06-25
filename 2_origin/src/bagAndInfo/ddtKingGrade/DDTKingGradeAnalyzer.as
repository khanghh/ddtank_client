package bagAndInfo.ddtKingGrade
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   
   public class DDTKingGradeAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function DDTKingGradeAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var info:* = null;
         var i:int = 0;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            _data = new DictionaryData();
            xmllist = xml..Item;
            info = new DDTKingGradeInfo();
            _data.add(info.Level,info);
            for(i = 0; i < xmllist.length(); )
            {
               info = new DDTKingGradeInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               _data.add(info.Level,info);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
   }
}
