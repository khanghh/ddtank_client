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
       
      
      public function GuildMemberWeekController(param1:PrivateClass)
      {
         super();
         if(param1 == null)
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
      
      private function __ShowFinishFrame(param1:CrazyTankSocketEvent) : void
      {
         GuildMemberWeekManager.instance.LoadAndOpenShowTop10PromptFrame();
      }
      
      private function __ShowRankingFrame(param1:CrazyTankSocketEvent) : void
      {
         GuildMemberWeekManager.instance.LoadAndOpenGuildMemberWeekFinishActivity();
      }
      
      private function __UpTop10Data(param1:CrazyTankSocketEvent) : void
      {
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:* = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         var _loc3_:String = _loc4_.readUTF();
         GuildMemberWeekManager.instance.model.upData = _loc3_;
         var _loc2_:int = _loc4_.readInt();
         if(GuildMemberWeekManager.instance.model)
         {
            GuildMemberWeekManager.instance.model.TopTenMemberData.splice(0);
         }
         if(GuildMemberWeekManager.instance.MainFrame)
         {
            GuildMemberWeekManager.instance.MainFrame.upDataTimeTxt();
         }
         _loc9_ = 0;
         while(_loc9_ < _loc2_)
         {
            _loc5_ = _loc4_.readInt();
            _loc8_ = _loc4_.readUTF();
            _loc7_ = _loc4_.readInt();
            _loc6_ = _loc4_.readInt();
            GuildMemberWeekManager.instance.model.TopTenMemberData.push([_loc5_,_loc8_,_loc7_,_loc6_]);
            _loc9_++;
         }
         UpTop10Data("Member");
      }
      
      private function __UpAddPointBook(param1:CrazyTankSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         GuildMemberWeekManager.instance.model.TopTenAddPointBook.splice(0);
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = _loc4_.readInt();
            GuildMemberWeekManager.instance.model.TopTenAddPointBook.push(_loc3_);
            _loc5_++;
         }
         UpTop10Data("PointBook");
      }
      
      private function __activityEndShowRanking(param1:CrazyTankSocketEvent) : void
      {
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         GuildMemberWeekManager.instance.model.TopTenMemberData.splice(0);
         GuildMemberWeekManager.instance.model.TopTenAddPointBook.splice(0);
         var _loc11_:Boolean = false;
         var _loc10_:int = 0;
         var _loc7_:PackageIn = param1.pkg;
         var _loc4_:String = _loc7_.readUTF();
         GuildMemberWeekManager.instance.model.upData = _loc4_;
         if(GuildMemberWeekManager.instance.MainFrame)
         {
            GuildMemberWeekManager.instance.MainFrame.upDataTimeTxt();
         }
         _loc6_ = _loc7_.readInt();
         _loc10_ = 0;
         while(_loc10_ < _loc6_)
         {
            _loc3_ = _loc7_.readInt();
            _loc5_ = _loc7_.readUTF();
            _loc9_ = _loc7_.readInt();
            _loc8_ = _loc7_.readInt();
            GuildMemberWeekManager.instance.model.TopTenMemberData.push([_loc3_,_loc5_,_loc9_,_loc8_]);
            if(PlayerManager.Instance.Self.ID == _loc3_)
            {
               _loc11_ = true;
            }
            _loc10_++;
         }
         _loc6_ = _loc7_.readInt();
         _loc10_ = 0;
         while(_loc10_ < _loc6_)
         {
            _loc2_ = _loc7_.readInt();
            GuildMemberWeekManager.instance.model.TopTenAddPointBook.push(_loc2_);
            _loc10_++;
         }
         GuildMemberWeekManager.instance.model.MyRanking = _loc7_.readInt();
         GuildMemberWeekManager.instance.model.MyContribute = _loc7_.readInt();
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
         if(_loc11_)
         {
            if(GuildMemberWeekManager.instance.model.MyRanking <= 0 || GuildMemberWeekManager.instance.model.MyRanking > 10)
            {
               _loc11_ = false;
            }
         }
         GuildMemberWeekManager.instance.CheckShowEndFrame(_loc11_);
      }
      
      public function _UpAddPointRecord(param1:CrazyTankSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc3_:int = _loc4_.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = _loc4_.readUTF();
            GuildMemberWeekManager.instance.model.AddRanking.push(_loc2_);
            _loc5_++;
         }
         if(GuildMemberWeekManager.instance.MainFrame != null)
         {
            GuildMemberWeekManager.instance.MainFrame.UpRecord();
         }
      }
      
      public function _UpImmediatelyRecord(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc5_:int = _loc4_.readInt() - 1;
         var _loc3_:int = _loc4_.readInt();
         var _loc2_:String = _loc4_.readUTF();
         var _loc6_:* = _loc5_;
         var _loc7_:* = GuildMemberWeekManager.instance.model.TopTenAddPointBook[_loc6_] + _loc3_;
         GuildMemberWeekManager.instance.model.TopTenAddPointBook[_loc6_] = _loc7_;
         GuildMemberWeekManager.instance.model.AddRanking.push(_loc2_);
         if(GuildMemberWeekManager.instance.MainFrame != null)
         {
            GuildMemberWeekManager.instance.MainFrame.UpRecord();
            UpTop10Data("PointBook");
         }
      }
      
      public function __UpMyRanking(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         GuildMemberWeekManager.instance.model.MyRanking = _loc2_.readInt();
         GuildMemberWeekManager.instance.model.MyContribute = _loc2_.readInt();
         if(GuildMemberWeekManager.instance.MainFrame != null)
         {
            GuildMemberWeekManager.instance.MainFrame.UpMyRanking();
         }
         if(GuildMemberWeekManager.instance.FinishActivityFrame != null)
         {
            GuildMemberWeekManager.instance.FinishActivityFrame.UpMyRanking();
         }
      }
      
      private function UpTop10Data(param1:String) : void
      {
         if(GuildMemberWeekManager.instance.MainFrame != null)
         {
            if(GuildMemberWeekManager.instance.MainFrame.TopTenShowSprite != null)
            {
               GuildMemberWeekManager.instance.MainFrame.TopTenShowSprite.UpTop10data(param1);
            }
         }
      }
      
      public function CheckAddBookIsOK() : void
      {
         var _loc4_:Boolean = true;
         var _loc3_:Boolean = false;
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:int = GuildMemberWeekManager.instance.model.PlayerAddPointBook.length;
         var _loc2_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc1_ = GuildMemberWeekManager.instance.model.PlayerAddPointBook[_loc6_];
            _loc2_.push(_loc1_);
            if(_loc1_ >= 10)
            {
               _loc3_ = true;
            }
            else if(_loc1_ > 0 && _loc1_ < 10)
            {
               _loc4_ = false;
               break;
            }
            _loc6_++;
         }
         if(_loc4_)
         {
            if(_loc3_)
            {
               SocketManager.Instance.out.sendGuildMemberWeekAddRanking(_loc2_.concat());
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
      
      public function upPointBookData(param1:int, param2:Number, param3:Boolean = true) : void
      {
         var _loc6_:int = param1 - 1;
         var _loc4_:Number = param2 / 10;
         var _loc5_:int = 0;
         if(String(_loc4_).indexOf(".") >= 0)
         {
            _loc4_ = Math.round(_loc4_);
            _loc5_ = param2 - _loc4_;
         }
         else
         {
            _loc5_ = param2 - int(_loc4_);
         }
         GuildMemberWeekManager.instance.model.PlayerAddPointBook[_loc6_] = param2;
         GuildMemberWeekManager.instance.AddRankingFrame.ChangePointBookShow(param1,_loc5_);
         if(param3)
         {
            ChangePlayerMoney();
         }
      }
      
      public function ChangePlayerMoney() : void
      {
         var _loc3_:* = 0;
         var _loc1_:int = GuildMemberWeekManager.instance.model.PlayerAddPointBook.length;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_ = Number(_loc3_ + GuildMemberWeekManager.instance.model.PlayerAddPointBook[_loc4_]);
            _loc4_++;
         }
         if(_loc3_ > PlayerManager.Instance.Self.Money)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
               _loc2_ = GuildMemberWeekManager.instance.model.PlayerAddPointBookBefor[_loc4_];
               GuildMemberWeekManager.instance.model.PlayerAddPointBook[_loc4_] = _loc2_;
               upPointBookData(_loc4_ + 1,_loc2_,false);
               _loc4_++;
            }
         }
         else
         {
            _loc3_ = Number(PlayerManager.Instance.Self.Money - _loc3_);
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
               _loc2_ = GuildMemberWeekManager.instance.model.PlayerAddPointBook[_loc4_];
               GuildMemberWeekManager.instance.model.PlayerAddPointBookBefor[_loc4_] = _loc2_;
               _loc4_++;
            }
            GuildMemberWeekManager.instance.AddRankingFrame.ChangePlayerMoneyShow(_loc3_);
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
