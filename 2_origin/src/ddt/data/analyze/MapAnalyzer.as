package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.map.MapInfo;
   
   public class MapAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<MapInfo>;
      
      public function MapAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         list = new Vector.<MapInfo>();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new MapInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               if(info.Name != "")
               {
                  info.canSelect = info.ID <= 2000;
                  list.push(info);
               }
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
