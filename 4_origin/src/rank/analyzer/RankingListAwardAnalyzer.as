package rank.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import rank.data.RankAwardInfo;
   
   public class RankingListAwardAnalyzer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<RankAwardInfo>;
      
      public var lastUpdateTime:String;
      
      public function RankingListAwardAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var itemData:* = null;
         XML.ignoreWhitespace = true;
         itemList = new Vector.<RankAwardInfo>();
         var xml:XML = new XML(data);
         var len:int = xml.Item.length();
         var xmllist:XMLList = xml..Item;
         lastUpdateTime = xml.@lastUpdateTime;
         for(i = 0; i < xmllist.length(); )
         {
            itemData = new RankAwardInfo();
            itemData.activeParam1 = xmllist[i].@ActiveParam1;
            itemData.activeParam2 = xmllist[i].@ActiveParam2;
            itemData.activeType = xmllist[i].@ActiveType;
            itemData.activeValue = xmllist[i].@ActiveValue;
            itemData.itemName = xmllist[i].@ItemName;
            itemData.nickName = xmllist[i].@NickName;
            itemData.subType = xmllist[i].@SubType;
            itemData.userID = xmllist[i].@UserID;
            itemData.rank = xmllist[i].@Rank;
            itemList.push(itemData);
            i++;
         }
         onAnalyzeComplete();
      }
   }
}
