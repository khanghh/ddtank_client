package sanXiao.model
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class SanXiaoScoreRewardAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public function SanXiaoScoreRewardAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         list = [];
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new SXRewardItemData();
               info.id = int(xmllist[i].@ID);
               info.TempleteID = int(xmllist[i].@ItemID);
               info.count = int(xmllist[i].@Count);
               info.point = int(xmllist[i].@Point);
               info.Valid = int(xmllist[i].@Valid);
               info.isBind = xmllist[i].@IsBind == "true"?true:false;
               info.gained = false;
               list.push(info);
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
