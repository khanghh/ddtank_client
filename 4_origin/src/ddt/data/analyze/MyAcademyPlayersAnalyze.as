package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerState;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   
   public class MyAcademyPlayersAnalyze extends DataAnalyzer
   {
       
      
      public var myAcademyPlayers:DictionaryData;
      
      public function MyAcademyPlayersAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var state:* = null;
         var lastDateString:* = null;
         var xml:XML = new XML(data);
         myAcademyPlayers = new DictionaryData();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new FriendListPlayer();
               info.ID = xmllist[i].@UserID;
               state = new PlayerState(int(xmllist[i].@State));
               info.playerState = state;
               info.apprenticeshipState = xmllist[i].@ApprenticeshipState;
               info.IsMarried = xmllist[i].@IsMarried;
               lastDateString = xmllist[i].@LastDate;
               info.lastDate = DateUtils.dealWithStringDate(lastDateString);
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               myAcademyPlayers.add(info.ID,info);
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
