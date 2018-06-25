package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.map.OpenMapInfo;
   
   public class WeekOpenMapAnalyze extends DataAnalyzer
   {
      
      public static const PATH:String = "MapServerList.xml";
       
      
      public var list:Vector.<OpenMapInfo>;
      
      public function WeekOpenMapAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var nodes:* = null;
         var i:int = 0;
         var openMapInfo:* = null;
         var xml:XML = new XML(data);
         var result:String = xml.@value;
         if(result == "true")
         {
            list = new Vector.<OpenMapInfo>();
            nodes = xml..Item;
            for(i = 0; i < nodes.length(); )
            {
               openMapInfo = new OpenMapInfo();
               openMapInfo.maps = nodes[i].@OpenMap.split(",");
               openMapInfo.serverID = nodes[i].@ServerID;
               list.push(openMapInfo);
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
