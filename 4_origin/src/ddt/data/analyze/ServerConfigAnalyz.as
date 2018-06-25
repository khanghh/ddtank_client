package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ServerConfigInfo;
   import road7th.data.DictionaryData;
   
   public class ServerConfigAnalyz extends DataAnalyzer
   {
       
      
      public var serverConfigInfoList:DictionaryData;
      
      public function ServerConfigAnalyz(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         serverConfigInfoList = new DictionaryData();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new ServerConfigInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               serverConfigInfoList.add(info.Name,info);
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
   }
}
