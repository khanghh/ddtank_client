package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaApplyInfo;
   
   public class ConsortionApplyListAnalyzer extends DataAnalyzer
   {
       
      
      public var applyList:Vector.<ConsortiaApplyInfo>;
      
      public var totalCount:int;
      
      public function ConsortionApplyListAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         applyList = new Vector.<ConsortiaApplyInfo>();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            totalCount = int(xml.@total);
            xmllist = XML(xml)..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new ConsortiaApplyInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               info.IsOld = int(xmllist[i].@OldPlayer) == 1;
               info.ddtKingGrade = int(xmllist[i].@MaxLevelLevel);
               applyList.push(info);
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
