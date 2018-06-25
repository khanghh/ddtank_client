package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.ConsortiaEventInfo;
   
   public class ConsortionEventListAnalyzer extends DataAnalyzer
   {
       
      
      public var eventList:Vector.<ConsortiaEventInfo>;
      
      public function ConsortionEventListAnalyzer(onCompleteCall:Function = null)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         eventList = new Vector.<ConsortiaEventInfo>();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new ConsortiaEventInfo();
               info.ID = xmllist[i].@ID;
               info.ConsortiaID = xmllist[i].@ConsortiaID;
               info.Date = xmllist[i].@Date;
               info.Type = xmllist[i].@Type;
               info.NickName = xmllist[i].@NickName;
               info.EventValue = xmllist[i].@EventValue;
               info.ManagerName = xmllist[i].@ManagerName;
               eventList.push(info);
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
