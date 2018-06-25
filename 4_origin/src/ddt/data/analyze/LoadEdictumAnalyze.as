package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class LoadEdictumAnalyze extends DataAnalyzer
   {
       
      
      public var edictumDataList:Array;
      
      public function LoadEdictumAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var len:int = 0;
         var i:int = 0;
         var item:* = null;
         edictumDataList = [];
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            len = xmllist.length();
            for(i = 0; i < len; )
            {
               item = {};
               item["id"] = xmllist[i].@ID.toString();
               item["Title"] = xmllist[i].@Title.toString();
               item["Text"] = xmllist[i].@Text.toString();
               item["IsExist"] = xmllist[i].@IsExist.toString();
               item["BeginTime"] = xmllist[i].@BeginTime.toString();
               edictumDataList.push(item);
               i++;
            }
            edictumDataList.sortOn("id",16);
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
