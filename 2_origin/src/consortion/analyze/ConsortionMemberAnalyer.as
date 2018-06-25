package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import consortion.ConsortionModelManager;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.data.player.PlayerState;
   import ddt.manager.PlayerManager;
   import road7th.data.DictionaryData;
   
   public class ConsortionMemberAnalyer extends DataAnalyzer
   {
       
      
      public var consortionMember:DictionaryData;
      
      public function ConsortionMemberAnalyer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var statePlayerState:* = null;
         var xml:XML = new XML(data);
         consortionMember = new DictionaryData();
         if(xml.@value == "true")
         {
            ConsortionModelManager.Instance.model.systemDate = XML(xml).@currentDate;
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new ConsortiaPlayerInfo();
               info.beginChanges();
               info.IsVote = converBoolean(xmllist[i].@IsVote);
               info.privateID = xmllist[i].@ID;
               info.ConsortiaID = PlayerManager.Instance.Self.ConsortiaID;
               info.ConsortiaName = PlayerManager.Instance.Self.ConsortiaName;
               info.DutyID = xmllist[i].@DutyID;
               info.DutyName = xmllist[i].@DutyName;
               info.GP = xmllist[i].@GP;
               info.Grade = xmllist[i].@Grade;
               info.FightPower = xmllist[i].@FightPower;
               info.AchievementPoint = xmllist[i].@AchievementPoint;
               info.honor = xmllist[i].@Rank;
               info.IsChat = converBoolean(xmllist[i].@IsChat);
               info.IsDiplomatism = converBoolean(xmllist[i].@IsDiplomatism);
               info.IsDownGrade = converBoolean(xmllist[i].@IsDownGrade);
               info.IsEditorDescription = converBoolean(xmllist[i].@IsEditorDescription);
               info.IsEditorPlacard = converBoolean(xmllist[i].@IsEditorPlacard);
               info.IsEditorUser = converBoolean(xmllist[i].@IsEditorUser);
               info.IsExpel = converBoolean(xmllist[i].@IsExpel);
               info.IsInvite = converBoolean(xmllist[i].@IsInvite);
               info.IsManageDuty = converBoolean(xmllist[i].@IsManageDuty);
               info.IsRatify = converBoolean(xmllist[i].@IsRatify);
               info.IsUpGrade = converBoolean(xmllist[i].@IsUpGrade);
               info.IsBandChat = converBoolean(xmllist[i].@IsBanChat);
               info.Offer = int(xmllist[i].@Offer);
               info.RatifierID = xmllist[i].@RatifierID;
               info.RatifierName = xmllist[i].@RatifierName;
               info.Remark = xmllist[i].@Remark;
               info.Repute = xmllist[i].@Repute;
               statePlayerState = new PlayerState(int(xmllist[i].@State));
               info.playerState = statePlayerState;
               info.LastDate = xmllist[i].@LastDate;
               info.ID = xmllist[i].@UserID;
               info.NickName = xmllist[i].@UserName;
               info.typeVIP = xmllist[i].@typeVIP;
               info.VIPLevel = xmllist[i].@VIPLevel;
               info.LoginName = xmllist[i].@LoginName;
               info.Sex = converBoolean(xmllist[i].@Sex);
               info.isAttest = converBoolean(xmllist[i].@IsBeauty);
               info.EscapeCount = xmllist[i].@EscapeCount;
               info.Right = xmllist[i].@Right;
               info.WinCount = xmllist[i].@WinCount;
               info.TotalCount = xmllist[i].@TotalCount;
               info.RichesOffer = xmllist[i].@RichesOffer;
               info.RichesRob = xmllist[i].@RichesRob;
               info.UseOffer = xmllist[i].@TotalRichesOffer;
               info.DutyLevel = xmllist[i].@DutyLevel;
               info.LastWeekRichesOffer = parseInt(xmllist[i].@LastWeekRichesOffer);
               info.isOld = int(xmllist[i].@OldPlayer) == 1;
               info.commitChanges();
               consortionMember.add(info.ID,info);
               if(info.ID == PlayerManager.Instance.Self.ID)
               {
                  PlayerManager.Instance.Self.ConsortiaID = info.ConsortiaID;
                  PlayerManager.Instance.Self.DutyLevel = info.DutyLevel;
                  PlayerManager.Instance.Self.DutyName = info.DutyName;
                  PlayerManager.Instance.Self.Right = info.Right;
               }
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
      
      private function converBoolean(b:String) : Boolean
      {
         return b == "true"?true:false;
      }
   }
}
