package guildMemberWeek.manager
{
   import com.pickgliss.action.AlertAction;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import guildMemberWeek.controller.GuildMemberWeekController;
   import guildMemberWeek.loader.LoaderGuildMemberWeekUIModule;
   import guildMemberWeek.model.GuildMemberWeekModel;
   import guildMemberWeek.view.GuildMemberWeekFrame;
   import guildMemberWeek.view.ShowRankingFrame.GuildMemberWeekShowRankingFrame;
   import guildMemberWeek.view.addRankingFrame.GuildMemberWeekAddRankingFrame;
   import guildMemberWeek.view.mainFrame.GuildMemberWeekPromptFrame;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class GuildMemberWeekManager extends EventDispatcher
   {
      
      private static var _instance:GuildMemberWeekManager;
       
      
      private var _model:GuildMemberWeekModel;
      
      private var _Controller:GuildMemberWeekController;
      
      private var _isShowIcon:Boolean = false;
      
      private var _AddRankingFrame:GuildMemberWeekAddRankingFrame;
      
      private var _FinishActivityFrame:GuildMemberWeekShowRankingFrame;
      
      private var _WorkFrame:GuildMemberWeekFrame;
      
      private var _Top10PromptFrame:GuildMemberWeekPromptFrame;
      
      public function GuildMemberWeekManager(param1:PrivateClass){super();}
      
      public static function get instance() : GuildMemberWeekManager{return null;}
      
      public function get MainFrame() : GuildMemberWeekFrame{return null;}
      
      public function get Controller() : GuildMemberWeekController{return null;}
      
      public function setup() : void{}
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function openOrclose(param1:PackageIn) : void{}
      
      public function showEnterIcon() : void{}
      
      public function hideEnterIcon() : void{}
      
      private function disposeEnterIcon() : void{}
      
      public function onClickguildMemberWeekIcon(param1:MouseEvent) : void{}
      
      public function doOpenGuildMemberWeekFrame() : void{}
      
      public function LoadAndOpenGuildMemberWeekFinishActivity() : void{}
      
      public function get FinishActivityFrame() : GuildMemberWeekShowRankingFrame{return null;}
      
      public function doOpenGuildMemberWeekFinishActivity() : void{}
      
      public function get AddRankingFrame() : GuildMemberWeekAddRankingFrame{return null;}
      
      public function doOpenaddRankingFrame() : void{}
      
      public function CloseAddRankingFrame() : void{}
      
      public function get model() : GuildMemberWeekModel{return null;}
      
      public function returnComponentBnt(param1:Sprite, param2:Boolean = true) : BaseButton{return null;}
      
      public function LoadAndOpenShowTop10PromptFrame() : void{}
      
      public function doOpenGuildMemberWeekTop10PromptFrame() : void{}
      
      public function CloseShowTop10PromptFrame() : void{}
      
      public function get getGiftType() : int{return 0;}
      
      public function templateDataSetup(param1:Array) : void{}
      
      public function CheckShowEndFrame(param1:Boolean) : void{}
      
      public function disposeAllFrame(param1:Boolean = false) : void{}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
