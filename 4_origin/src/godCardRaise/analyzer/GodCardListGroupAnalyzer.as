package godCardRaise.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import godCardRaise.info.GodCardListGroupInfo;
   
   public class GodCardListGroupAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Array;
      
      public function GodCardListGroupAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var list:* = null;
         var i:int = 0;
         var info:* = null;
         var cards:* = null;
         var detailList:* = null;
         var j:int = 0;
         var cardId:int = 0;
         var cardCount:int = 0;
         var xml:XML = new XML(data);
         _list = [];
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new GodCardListGroupInfo();
               cards = [];
               detailList = xmllist[i]..ItemDetail;
               for(j = 0; j < detailList.length(); )
               {
                  cardId = detailList[j].@CardID;
                  cardCount = detailList[j].@Number;
                  cards.push({
                     "cardId":cardId,
                     "cardCount":cardCount
                  });
                  j++;
               }
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               info.Cards = cards;
               _list.push(info);
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
      
      public function get list() : Array
      {
         return _list;
      }
   }
}
