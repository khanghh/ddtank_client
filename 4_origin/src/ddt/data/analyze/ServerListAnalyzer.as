package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ServerInfo;
   
   public class ServerListAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<ServerInfo>;
      
      public var agentId:int;
      
      public var zoneName:String;
      
      public function ServerListAnalyzer(onCompleteCall:Function)
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
            agentId = xml.@agentId;
            zoneName = xml.@AreaName;
            message = xml.@message;
            xmllist = xml..Item;
            list = new Vector.<ServerInfo>();
            if(xmllist.length() > 0)
            {
               for(i = 0; i < xmllist.length(); )
               {
                  info = new ServerInfo();
                  ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
                  list.push(info);
                  i++;
               }
               onAnalyzeComplete();
            }
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
      }
   }
}
