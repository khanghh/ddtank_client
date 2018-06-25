package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PyramidSystemItemsInfo;
   
   public class PyramidAnalyze extends DataAnalyzer
   {
       
      
      public var pyramidSystemDataList:Array;
      
      public function PyramidAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var itemInfo1:* = null;
         var arr1:* = null;
         pyramidSystemDataList = [];
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               if(xmllist[i].@ActivityType == "8")
               {
                  itemInfo1 = new PyramidSystemItemsInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo1,xmllist[i]);
                  arr1 = pyramidSystemDataList[itemInfo1.Quality - 1];
                  if(!arr1)
                  {
                     arr1 = [];
                  }
                  arr1.push(itemInfo1);
                  pyramidSystemDataList[itemInfo1.Quality - 1] = arr1;
               }
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
      }
   }
}
