package cardSystem.analyze
{
   import cardSystem.data.SetsInfo;
   import com.pickgliss.loader.DataAnalyzer;
   
   public class SetsSortRuleAnalyzer extends DataAnalyzer
   {
       
      
      public var setsVector:Vector.<SetsInfo>;
      
      public function SetsSortRuleAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         data = data;
         setsVector = new Vector.<SetsInfo>();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            var xmllist1:XMLList = xml..Item;
            for(var i:int = 0; i < xmllist1.length(); )
            {
               var info:SetsInfo = new SetsInfo();
               info.ID = xmllist1[i].@ID;
               info.name = xmllist1[i].@Name;
               info.storyDescript = xmllist1[i].@Description;
               var suitID:int = parseInt(xmllist1[i].@SuitID) - 1;
               var xmlList2:XMLList = xmllist1[i]..Card;
               for(var j:int = 0; j < xmlList2.length(); )
               {
                  if(xmlList2[j].@ID != "0")
                  {
                     info.cardIdVec.push(parseInt(xmlList2[j].@ID));
                  }
                  j = Number(j) + 1;
               }
               setsVector.push(info);
               i = Number(i) + 1;
            }
            setsVector.sort(function(a:SetsInfo, b:SetsInfo):int
            {
               if(int(a.ID) < int(b.ID))
               {
                  return -1;
               }
               return 1;
            });
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
