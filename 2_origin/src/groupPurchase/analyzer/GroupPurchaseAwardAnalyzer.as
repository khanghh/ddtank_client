package groupPurchase.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import groupPurchase.data.GroupPurchaseAwardInfo;
   
   public class GroupPurchaseAwardAnalyzer extends DataAnalyzer
   {
       
      
      private var _awardList:Object;
      
      public function GroupPurchaseAwardAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var awardInfo:* = null;
         var xml:XML = new XML(data);
         _awardList = {};
         if(xml.@value == "true")
         {
            xmllist = xml..item;
            for(i = 0; i < xmllist.length(); )
            {
               awardInfo = new GroupPurchaseAwardInfo();
               ObjectUtils.copyPorpertiesByXML(awardInfo,xmllist[i]);
               _awardList[awardInfo.SortID] = awardInfo;
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      public function get awardList() : Object
      {
         return _awardList;
      }
   }
}
