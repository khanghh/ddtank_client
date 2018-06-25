package guildMemberWeek.controller
{
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import guildMemberWeek.manager.GuildMemberWeekManager;
   import road7th.comm.PackageIn;
   
   public class GuildMemberWeekController
   {
      
      private static var _instance:GuildMemberWeekController;
       
      
      public function GuildMemberWeekController(pct:PrivateClass)
      {
         super();
         if(pct == null)
         {
            throw new Error("错误：GuildMemberWeekController类属于单例，请使用本类的istance获取实例");
         }
         initEvent();
      }
      
      public static function get instance() : GuildMemberWeekController
      {
         if(!_instance)
         {
            _instance = new GuildMemberWeekController(new PrivateClass());
         }
         return _instance;
      }
      
      public function initEvent() : void
      {
         GuildMemberWeekManager.instance.addEventListener("guildmemberweek_finishactivity",__ShowFinishFrame);
         GuildMemberWeekManager.instance.addEventListener("guildmemberweek_showrunking",__ShowRankingFrame);
         GuildMemberWeekManager.instance.addEventListener("guildmemberweek_getmyrunking",__UpMyRanking);
         GuildMemberWeekManager.instance.addEventListener("guildmemberweek_playertop10",__UpTop10Data);
         GuildMemberWeekManager.instance.addEventListener("guildmemberweek_AddPointBook",__UpAddPointBook);
         GuildMemberWeekManager.instance.addEventListener("guildmemberweek_addpointbookrecord",_UpAddPointRecord);
         GuildMemberWeekManager.instance.addEventListener("guildmemberweek_upaddpointbookrecord",_UpImmediatelyRecord);
         GuildMemberWeekManager.instance.addEventListener("guildmemberweek_showactivityend",__activityEndShowRanking);
      }
      
      public function removeEvent() : void
      {
         GuildMemberWeekManager.instance.removeEventListener("guildmemberweek_finishactivity",__ShowFinishFrame);
         GuildMemberWeekManager.instance.removeEventListener("guildmemberweek_showrunking",__ShowRankingFrame);
         GuildMemberWeekManager.instance.removeEventListener("guildmemberweek_getmyrunking",__UpMyRanking);
         GuildMemberWeekManager.instance.removeEventListener("guildmemberweek_playertop10",__UpTop10Data);
         GuildMemberWeekManager.instance.removeEventListener("guildmemberweek_AddPointBook",__UpAddPointBook);
         GuildMemberWeekManager.instance.removeEventListener("guildmemberweek_addpointbookrecord",_UpAddPointRecord);
         GuildMemberWeekManager.instance.removeEventListener("guildmemberweek_showactivityend",__activityEndShowRanking);
      }
      
      private function __ShowFinishFrame(event:CrazyTankSocketEvent) : void
      {
         GuildMemberWeekManager.instance.LoadAndOpenShowTop10PromptFrame();
      }
      
      private function __ShowRankingFrame(event:CrazyTankSocketEvent) : void
      {
         GuildMemberWeekManager.instance.LoadAndOpenGuildMemberWeekFinishActivity();
      }
      
      private function __UpTop10Data(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var PlayerID:int = 0;
         var PlayerName:* = null;
         var PlayerRanking:int = 0;
         var PlayeroCntribute:int = 0;
         var pkg:PackageIn = event.pkg;
         var upTime:String = pkg.readUTF();
         GuildMemberWeekManager.instance.model.upData = upTime;
         var count:int = pkg.readInt();
         if(GuildMemberWeekManager.instance.model)
         {
            GuildMemberWeekManager.instance.model.TopTenMemberData.splice(0);
         }
         if(GuildMemberWeekManager.instance.MainFrame)
         {
            GuildMemberWeekManager.instance.MainFrame.upDataTimeTxt();
         }
         i = 0;
         while(i < count)
         {
            PlayerID = pkg.readInt();
            PlayerName = pkg.readUTF();
            PlayerRanking = pkg.readInt();
            PlayeroCntribute = pkg.readInt();
            GuildMemberWeekManager.instance.model.TopTenMemberData.push([PlayerID,PlayerName,PlayerRanking,PlayeroCntribute]);
            i++;
         }
         UpTop10Data("Member");
      }
      
      private function __UpAddPointBook(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var AddPointBook:int = 0;
         var pkg:PackageIn = event.pkg;
         var count:int = pkg.readInt();
         GuildMemberWeekManager.instance.model.TopTenAddPointBook.splice(0);
         for(i = 0; i < count; )
         {
            AddPointBook = pkg.readInt();
            GuildMemberWeekManager.instance.model.TopTenAddPointBook.push(AddPointBook);
            i++;
         }
         UpTop10Data("PointBook");
      }
      
      private function __activityEndShowRanking(event:CrazyTankSocketEvent) : void
      {
         var count:int = 0;
         var playerID:int = 0;
         var playerName:* = null;
         var playerRanking:int = 0;
         var playerCntribute:int = 0;
         var addPointBook:int = 0;
         GuildMemberWeekManager.instance.model.TopTenMemberData.splice(0);
         GuildMemberWeekManager.instance.model.TopTenAddPointBook.splice(0);
         var getRanking:Boolean = false;
         var i:int = 0;
         var pkg:PackageIn = event.pkg;
         var upTime:String = pkg.readUTF();
         GuildMemberWeekManager.instance.model.upData = upTime;
         if(GuildMemberWeekManager.instance.MainFrame)
         {
            GuildMemberWeekManager.instance.MainFrame.upDataTimeTxt();
         }
         count = pkg.readInt();
         for(i = 0; i < count; )
         {
            playerID = pkg.readInt();
            playerName = pkg.readUTF();
            playerRanking = pkg.readInt();
            playerCntribute = pkg.readInt();
            GuildMemberWeekManager.instance.model.TopTenMemberData.push([playerID,playerName,playerRanking,playerCntribute]);
            if(PlayerManager.Instance.Self.ID == playerID)
            {
               getRanking = true;
            }
            i++;
         }
         count = pkg.readInt();
         for(i = 0; i < count; )
         {
            addPointBook = pkg.readInt();
            GuildMemberWeekManager.instance.model.TopTenAddPointBook.push(addPointBook);
            i++;
         }
         GuildMemberWeekManager.instance.model.MyRanking = pkg.readInt();
         GuildMemberWeekManager.instance.model.MyContribute = pkg.readInt();
         UpTop10Data("Member");
         UpTop10Data("PointBook");
         UpTop10Data("Gift");
         if(GuildMemberWeekManager.instance.MainFrame)
         {
            GuildMemberWeekManager.instance.MainFrame.UpMyRanking();
         }
         if(GuildMemberWeekManager.instance.FinishActivityFrame)
         {
            GuildMemberWeekManager.instance.FinishActivityFrame.UpMyRanking();
         }
         if(getRanking)
         {
            if(GuildMemberWeekManager.instance.model.MyRanking <= 0 || GuildMemberWeekManager.instance.model.MyRanking > 10)
            {
               getRanking = false;
            }
         }
         GuildMemberWeekManager.instance.CheckShowEndFrame(getRanking);
      }
      
      public function _UpAddPointRecord(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var Record:* = null;
         var pkg:PackageIn = event.pkg;
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            Record = pkg.readUTF();
            GuildMemberWeekManager.instance.model.AddRanking.push(Record);
            i++;
         }
         if(GuildMemberWeekManager.instance.MainFrame != null)
         {
            GuildMemberWeekManager.instance.MainFrame.UpRecord();
         }
      }
      
      public function _UpImmediatelyRecord(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var Ranking:int = pkg.readInt() - 1;
         var Money:int = pkg.readInt();
         var Record:String = pkg.readUTF();
         var _loc6_:* = Ranking;
         var _loc7_:* = GuildMemberWeekManager.instance.model.TopTenAddPointBook[_loc6_] + Money;
         GuildMemberWeekManager.instance.model.TopTenAddPointBook[_loc6_] = _loc7_;
         GuildMemberWeekManager.instance.model.AddRanking.push(Record);
         if(GuildMemberWeekManager.instance.MainFrame != null)
         {
            GuildMemberWeekManager.instance.MainFrame.UpRecord();
            UpTop10Data("PointBook");
         }
      }
      
      public function __UpMyRanking(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         GuildMemberWeekManager.instance.model.MyRanking = pkg.readInt();
         GuildMemberWeekManager.instance.model.MyContribute = pkg.readInt();
         if(GuildMemberWeekManager.instance.MainFrame != null)
         {
            GuildMemberWeekManager.instance.MainFrame.UpMyRanking();
         }
         if(GuildMemberWeekManager.instance.FinishActivityFrame != null)
         {
            GuildMemberWeekManager.instance.FinishActivityFrame.UpMyRanking();
         }
      }
      
      private function UpTop10Data(UpType:String) : void
      {
         if(GuildMemberWeekManager.instance.MainFrame != null)
         {
            if(GuildMemberWeekManager.instance.MainFrame.TopTenShowSprite != null)
            {
               GuildMemberWeekManager.instance.MainFrame.TopTenShowSprite.UpTop10data(UpType);
            }
         }
      }
      
      public function CheckAddBookIsOK() : void
      {
         var Type:Boolean = true;
         var HavePointBook:Boolean = false;
         var i:int = 0;
         var TAddPointBook:int = 0;
         var L:int = GuildMemberWeekManager.instance.model.PlayerAddPointBook.length;
         var TAddRankingArray:Array = [];
         for(i = 0; i < L; )
         {
            TAddPointBook = GuildMemberWeekManager.instance.model.PlayerAddPointBook[i];
            TAddRankingArray.push(TAddPointBook);
            if(TAddPointBook >= 10)
            {
               HavePointBook = true;
            }
            else if(TAddPointBook > 0 && TAddPointBook < 10)
            {
               Type = false;
               break;
            }
            i++;
         }
         if(Type)
         {
            if(HavePointBook)
            {
               SocketManager.Instance.out.sendGuildMemberWeekAddRanking(TAddRankingArray.concat());
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("guildMemberWeek.AddRankingFrame.AddOKPointBook"));
               GuildMemberWeekManager.instance.model.PlayerAddPointBook = [0,0,0,0,0,0,0,0,0,0];
               GuildMemberWeekManager.instance.CloseAddRankingFrame();
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("guildMemberWeek.AddRankingFrame.AddNoPointBook"));
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("guildMemberWeek.AddRankingFrame.AddPointBookMustUp100"));
         }
      }
      
      public function upPointBookData(ItemID:int, Money:Number, ChangeMoneyShow:Boolean = true) : void
      {
         var i:int = ItemID - 1;
         var tax:Number = Money / 10;
         var GetMoney:int = 0;
         if(String(tax).indexOf(".") >= 0)
         {
            tax = Math.round(tax);
            GetMoney = Money - tax;
         }
         else
         {
            GetMoney = Money - int(tax);
         }
         GuildMemberWeekManager.instance.model.PlayerAddPointBook[i] = Money;
         GuildMemberWeekManager.instance.AddRankingFrame.ChangePointBookShow(ItemID,GetMoney);
         if(ChangeMoneyShow)
         {
            ChangePlayerMoney();
         }
      }
      
      public function ChangePlayerMoney() : void
      {
         var AddMoney:* = 0;
         var L:int = GuildMemberWeekManager.instance.model.PlayerAddPointBook.length;
         var i:int = 0;
         var N:int = 0;
         for(i = 0; i < L; )
         {
            AddMoney = Number(AddMoney + GuildMemberWeekManager.instance.model.PlayerAddPointBook[i]);
            i++;
         }
         if(AddMoney > PlayerManager.Instance.Self.Money)
         {
            for(i = 0; i < L; )
            {
               N = GuildMemberWeekManager.instance.model.PlayerAddPointBookBefor[i];
               GuildMemberWeekManager.instance.model.PlayerAddPointBook[i] = N;
               upPointBookData(i + 1,N,false);
               i++;
            }
         }
         else
         {
            AddMoney = Number(PlayerManager.Instance.Self.Money - AddMoney);
            for(i = 0; i < L; )
            {
               N = GuildMemberWeekManager.instance.model.PlayerAddPointBook[i];
               GuildMemberWeekManager.instance.model.PlayerAddPointBookBefor[i] = N;
               i++;
            }
            GuildMemberWeekManager.instance.AddRankingFrame.ChangePlayerMoneyShow(AddMoney);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
      }
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
