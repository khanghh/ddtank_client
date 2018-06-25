package cardSystem.analyze
{
   import cardSystem.data.SetsPropertyInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   
   public class SetsPropertiesAnalyzer extends DataAnalyzer
   {
       
      
      public var setsList:DictionaryData;
      
      public function SetsPropertiesAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmlList1:* = null;
         var i:int = 0;
         var setsId:* = null;
         var setsPropVec:* = undefined;
         var xmlList2:* = null;
         var j:int = 0;
         var info:* = null;
         setsList = new DictionaryData();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmlList1 = xml..Card;
            for(i = 0; i < xmlList1.length(); )
            {
               setsId = xmlList1[i].@CardID;
               setsPropVec = new Vector.<SetsPropertyInfo>();
               xmlList2 = xmlList1[i]..Item;
               for(j = 0; j < xmlList2.length(); )
               {
                  if(xmlList2[j].@condition != "0")
                  {
                     info = new SetsPropertyInfo();
                     ObjectUtils.copyPorpertiesByXML(info,xmlList2[j]);
                     setsPropVec.push(info);
                  }
                  j++;
               }
               setsList.add(setsId,setsPropVec);
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
