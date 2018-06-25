package luckStar.model
{
   import com.pickgliss.loader.DataAnalyzer;
   import luckStar.manager.LuckStarManager;
   
   public class LuckStarRankAnalyzer extends DataAnalyzer
   {
      
      private static const MAX_LIST:int = 5;
       
      
      public function LuckStarRankAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var rankList:* = undefined;
         var xmllist:* = null;
         var rank:* = null;
         var itme:* = null;
         var i:int = 0;
         var selfInfo:* = null;
         var xml:XML = XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..rankInfo;
            rank = [];
            for(i = 0; i < xmllist.length(); )
            {
               if(i % 5 == 0 || i == 0)
               {
                  rankList = new Vector.<LuckStarPlayerInfo>();
                  rank.push(rankList);
               }
               itme = new LuckStarPlayerInfo();
               itme.name = String(xmllist[i].@nickName);
               itme.rank = int(xmllist[i].@rank);
               itme.starNum = int(xmllist[i].@useStarNum);
               itme.isVip = int(xmllist[i].@isVip) != 0;
               rankList.push(itme);
               i++;
            }
            selfInfo = new LuckStarPlayerInfo();
            selfInfo.rank = int(xml.myRank.@rank);
            selfInfo.starNum = int(xml.myRank.@useStarNum);
            LuckStarManager.Instance.model.selfInfo = selfInfo;
            LuckStarManager.Instance.model.lastDate = String(xml.@lastUpdateTime);
            LuckStarManager.Instance.model.rank = rank;
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
