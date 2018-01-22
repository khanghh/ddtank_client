package cardSystem.analyze
{
   import cardSystem.data.SetsInfo;
   import com.pickgliss.loader.DataAnalyzer;
   
   public class SetsSortRuleAnalyzer extends DataAnalyzer
   {
       
      
      public var setsVector:Vector.<SetsInfo>;
      
      public function SetsSortRuleAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         data = param1;
         setsVector = new Vector.<SetsInfo>();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            var xmllist1:XMLList = xml..Item;
            var i:int = 0;
            while(i < xmllist1.length())
            {
               var info:SetsInfo = new SetsInfo();
               info.ID = xmllist1[i].@ID;
               info.name = xmllist1[i].@Name;
               info.storyDescript = xmllist1[i].@Description;
               var suitID:int = parseInt(xmllist1[i].@SuitID) - 1;
               var xmlList2:XMLList = xmllist1[i]..Card;
               var j:int = 0;
               while(j < xmlList2.length())
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
            setsVector.sort(function(param1:SetsInfo, param2:SetsInfo):int
            {
               if(int(param1.ID) < int(param2.ID))
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
