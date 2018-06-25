package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.map.DungeonInfo;
   
   public class DungeonAnalyzer extends DataAnalyzer
   {
      
      private static const PATH:String = "LoadPVEItems.xml";
       
      
      public var list:Vector.<DungeonInfo>;
      
      public function DungeonAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            list = new Vector.<DungeonInfo>();
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new DungeonInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               if(info.Name != "")
               {
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
