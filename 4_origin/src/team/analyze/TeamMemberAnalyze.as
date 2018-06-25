package team.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.StringUtils;
   import ddt.data.player.PlayerState;
   import road7th.utils.DateUtils;
   import team.model.TeamMemberInfo;
   
   public class TeamMemberAnalyze extends DataAnalyzer
   {
       
      
      private var _list:Array;
      
      public var id:int;
      
      public function TeamMemberAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var statePlayerState:* = null;
         _list = [];
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            id = xml.@teamID;
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new TeamMemberInfo();
               info.ID = int(xmllist[i].@UserID);
               info.NickName = xmllist[i].@NickName;
               info.Grade = int(xmllist[i].@Grade);
               statePlayerState = new PlayerState(int(xmllist[i].@State));
               info.playerState = statePlayerState;
               info.LastLoginDate = DateUtils.dealWithStringDate(xmllist[i].@LastDate);
               info.typeVIP = int(xmllist[i].@typeVIP);
               info.VIPLevel = int(xmllist[i].@VIPLevel);
               info.isOld = StringUtils.converBoolean(String(xmllist[i].@OldPlayer));
               info.activeScore = int(xmllist[i].@ActiveScore);
               info.weekActiveScore = int(xmllist[i].@ActiveWeekScore);
               info.totalActiveScore = int(xmllist[i].@ActiveTotalScore);
               info.seasonActiveScore = int(xmllist[i].@ActiveSeasonScore);
               info.teamSocre = int(xmllist[i].@BattleScore);
               info.totalTiems = int(xmllist[i].@BattleNum);
               info.FightPower = int(xmllist[i].@FightPower);
               info.ddtKingGrade = int(xmllist[i].@DdtKingLevel);
               info.Rank = int(xmllist[i].@Rank);
               info.Offer = int(xmllist[i].@Offer);
               info.WinCount = int(xmllist[i].@WinCount);
               info.EscapeCount = int(xmllist[i].@EscapeCount);
               info.TotalCount = int(xmllist[i].@TotalCount);
               info.isSignToday = int(xmllist[i].@IsSignToday) != 0;
               info.Sex = StringUtils.converBoolean(String(xmllist[i].@Sex));
               info.teamDuty = !!StringUtils.converBoolean(String(xmllist[i].@IsCaption))?1:0;
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
