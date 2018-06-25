package store.equipGhost.data
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public final class GhostDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _dataList:Vector.<GhostData>;
      
      public function GhostDataAnalyzer(onCompleteCall:Function)
      {
         _dataList = new Vector.<GhostData>();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var ghostData:* = null;
         var xmllist:* = null;
         var i:int = 0;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               ghostData = new GhostData();
               ghostData.parseXML(xmllist[i]);
               _dataList.push(ghostData);
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
      
      public function get data() : Vector.<GhostData>
      {
         return _dataList;
      }
   }
}
