package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.player.CivilPlayerInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.PlayerState;
   
   public class CivilMemberListAnalyze extends DataAnalyzer
   {
      
      public static const PATH:String = "MarryInfoPageList.ashx";
       
      
      public var civilMemberList:Array;
      
      public var _page:int;
      
      public var _name:String;
      
      public var _sex:Boolean;
      
      public var _totalPage:int;
      
      public function CivilMemberListAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var player:* = null;
         var civilPlayer:* = null;
         civilMemberList = [];
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Info;
            for(i = 0; i < xmllist.length(); )
            {
               player = new PlayerInfo();
               player.beginChanges();
               player.ID = xmllist[i].@UserID;
               player.NickName = xmllist[i].@NickName;
               player.ConsortiaID = xmllist[i].@ConsortiaID;
               player.ConsortiaName = xmllist[i].@ConsortiaName;
               player.Sex = converBoolean(xmllist[i].@Sex);
               player.WinCount = xmllist[i].@Win;
               player.TotalCount = xmllist[i].@Total;
               player.EscapeCount = xmllist[i].@Escape;
               player.GP = xmllist[i].@GP;
               player.Style = xmllist[i].@Style;
               player.Colors = xmllist[i].@Colors;
               player.Hide = xmllist[i].@Hide;
               player.Grade = xmllist[i].@Grade;
               player.ddtKingGrade = int(xmllist[i].@MaxLevelLevel);
               player.playerState = new PlayerState(int(xmllist[i].@State));
               player.Repute = xmllist[i].@Repute;
               player.Skin = xmllist[i].@Skin;
               player.Offer = xmllist[i].@Offer;
               player.IsMarried = converBoolean(xmllist[i].@IsMarried);
               player.Nimbus = int(xmllist[i].@Nimbus);
               player.DutyName = xmllist[i].@DutyName;
               player.FightPower = xmllist[i].@FightPower;
               player.AchievementPoint = xmllist[i].@AchievementPoint;
               player.honor = xmllist[i].@Rank;
               player.typeVIP = xmllist[i].@typeVIP;
               player.VIPLevel = xmllist[i].@VIPLevel;
               player.isOld = int(xmllist[i].@OldPlayer) == 1;
               player.isAttest = converBoolean(xmllist[i].@IsBeauty);
               civilPlayer = new CivilPlayerInfo();
               civilPlayer.UserId = player.ID;
               civilPlayer.MarryInfoID = xmllist[i].@ID;
               civilPlayer.IsPublishEquip = converBoolean(xmllist[i].@IsPublishEquip);
               civilPlayer.Introduction = xmllist[i].@Introduction;
               civilPlayer.IsConsortia = converBoolean(xmllist[i].@IsConsortia);
               civilPlayer.info = player;
               civilMemberList.push(civilPlayer);
               player.commitChanges();
               i++;
            }
            _totalPage = Math.ceil(int(xml.@total) / 12);
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      private function converBoolean(str:String) : Boolean
      {
         if(str == "true")
         {
            return true;
         }
         return false;
      }
   }
}
