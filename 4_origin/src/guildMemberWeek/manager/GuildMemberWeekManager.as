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
      
      public function GuildMemberWeekManager(param1:PrivateClass)
      {
         super();
         if(param1 == null)
         {
            throw new Error("错误:GuildMemberWeekManager为单例，请使用instance获取实例!");
         }
      }
      
      public static function get instance() : GuildMemberWeekManager
      {
         if(_instance == null)
         {
            _instance = new GuildMemberWeekManager(new PrivateClass());
         }
         return _instance;
      }
      
      public function get MainFrame() : GuildMemberWeekFrame
      {
         return _WorkFrame;
      }
      
      public function get Controller() : GuildMemberWeekController
      {
         return _Controller;
      }
      
      public function setup() : void
      {
         if(_model == null)
         {
            _model = new GuildMemberWeekModel();
         }
         _Controller = GuildMemberWeekController.instance;
         SocketManager.Instance.addEventListener("guildmemberweek_system",pkgHandler);
      }
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = param1._cmd;
         var _loc3_:CrazyTankSocketEvent = null;
         switch(int(_loc2_) - 7)
         {
            case 0:
               openOrclose(_loc4_);
               break;
            case 1:
               _loc3_ = new CrazyTankSocketEvent("guildmemberweek_playertop10",_loc4_);
               break;
            case 2:
               _loc3_ = new CrazyTankSocketEvent("guildmemberweek_AddPointBook",_loc4_);
               break;
            case 3:
               _loc3_ = new CrazyTankSocketEvent("guildmemberweek_addpointbookrecord",_loc4_);
               break;
            case 4:
               _loc3_ = new CrazyTankSocketEvent("guildmemberweek_getmyrunking",_loc4_);
               break;
            case 5:
               _loc3_ = new CrazyTankSocketEvent("guildmemberweek_upaddpointbookrecord",_loc4_);
               break;
            case 6:
               _loc3_ = new CrazyTankSocketEvent("guildmemberweek_showactivityend",_loc4_);
         }
         if(_loc3_)
         {
            dispatchEvent(_loc3_);
         }
      }
      
      private function openOrclose(param1:PackageIn) : void
      {
         if(param1 != null)
         {
            _model.isOpen = param1.readBoolean();
            _isShowIcon = _model.isOpen;
            if(_model.isOpen)
            {
               _model.ActivityStartTime = param1.readUTF();
               _model.ActivityEndTime = param1.readUTF();
            }
         }
         if(_model.isOpen)
         {
            showEnterIcon();
         }
         else
         {
            hideEnterIcon();
         }
      }
      
      public function showEnterIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("guildMemberWeek",true);
      }
      
      public function hideEnterIcon() : void
      {
         _isShowIcon = false;
         HallIconManager.instance.updateSwitchHandler("guildMemberWeek",false);
         disposeEnterIcon();
      }
      
      private function disposeEnterIcon() : void
      {
         if(_WorkFrame)
         {
            _WorkFrame.dispose();
            _WorkFrame = null;
         }
         if(_AddRankingFrame)
         {
            _AddRankingFrame.dispose();
            _AddRankingFrame = null;
         }
         if(_FinishActivityFrame)
         {
            _FinishActivityFrame.dispose();
            _FinishActivityFrame = null;
         }
      }
      
      public function onClickguildMemberWeekIcon(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.ConsortiaID == 0)
         {
            if(PlayerManager.Instance.Self.Grade < 17)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("guildMemberWeek.player.Level.CannotInActivity"));
               return;
            }
            StateManager.setState("consortia");
            return;
         }
         if(StateManager.currentStateType == "main")
         {
            LoaderGuildMemberWeekUIModule.Instance.loadUIModule(doOpenGuildMemberWeekFrame);
         }
      }
      
      public function doOpenGuildMemberWeekFrame() : void
      {
         if(PlayerManager.Instance.Self.DutyLevel <= 3)
         {
            _model.CanAddPointBook = true;
         }
         else
         {
            _model.CanAddPointBook = false;
         }
         if(_isShowIcon)
         {
            if(_AddRankingFrame)
            {
               _AddRankingFrame.dispose();
               _AddRankingFrame = null;
            }
            _WorkFrame = ComponentFactory.Instance.creatComponentByStylename("Window.guildmemberweek.GuildMemberWeekFrame");
            LayerManager.Instance.addToLayer(_WorkFrame,3,true,1);
            SocketManager.Instance.out.sendGuildMemberWeekStarEnter();
         }
      }
      
      public function LoadAndOpenGuildMemberWeekFinishActivity() : void
      {
         LoaderGuildMemberWeekUIModule.Instance.loadUIModule(doOpenGuildMemberWeekFinishActivity);
      }
      
      public function get FinishActivityFrame() : GuildMemberWeekShowRankingFrame
      {
         return _FinishActivityFrame;
      }
      
      public function doOpenGuildMemberWeekFinishActivity() : void
      {
         var _loc1_:* = null;
         if(_WorkFrame)
         {
            _WorkFrame.dispose();
            _WorkFrame = null;
         }
         _FinishActivityFrame = ComponentFactory.Instance.creatComponentByStylename("Window.guildmemberweek.GuildMemberWeekShowRankingFrame");
         if(CacheSysManager.isLock("alertInFight"))
         {
            _loc1_ = new AlertAction(_FinishActivityFrame,4,1);
            CacheSysManager.getInstance().cache("alertInFight",_loc1_);
            return;
         }
         LayerManager.Instance.addToLayer(_FinishActivityFrame,3,true,1);
      }
      
      public function get AddRankingFrame() : GuildMemberWeekAddRankingFrame
      {
         return _AddRankingFrame;
      }
      
      public function doOpenaddRankingFrame() : void
      {
         if(PlayerManager.Instance.Self.DutyLevel > 3 || !_model.CanAddPointBook)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("guildMemberWeek.AddRankingFrame.CantNotAddPointBook"));
            return;
         }
         _AddRankingFrame = ComponentFactory.Instance.creatComponentByStylename("Window.guildmemberweek.GuildMemberWeekAddRankingFrame");
         LayerManager.Instance.addToLayer(_AddRankingFrame,3,true,1);
      }
      
      public function CloseAddRankingFrame() : void
      {
         if(_AddRankingFrame == null)
         {
            return;
         }
         _AddRankingFrame.dispose();
         _AddRankingFrame = null;
      }
      
      public function get model() : GuildMemberWeekModel
      {
         if(_model == null)
         {
            _model = new GuildMemberWeekModel();
         }
         return this._model;
      }
      
      public function returnComponentBnt(param1:Sprite, param2:Boolean = true) : BaseButton
      {
         var _loc3_:BaseButton = new BaseButton();
         if(param2)
         {
            _loc3_.tipDirctions = "0,5";
            _loc3_.tipStyle = "ddt.view.tips.OneLineTip";
         }
         _loc3_.filterString = "null,lightFilter,lightFilter,grayFilter";
         _loc3_.backgound = param1;
         _loc3_.tipGapV = 20;
         _loc3_.addChild(param1);
         return _loc3_;
      }
      
      public function LoadAndOpenShowTop10PromptFrame() : void
      {
         LoaderGuildMemberWeekUIModule.Instance.loadUIModule(doOpenGuildMemberWeekTop10PromptFrame);
      }
      
      public function doOpenGuildMemberWeekTop10PromptFrame() : void
      {
         var _loc1_:* = null;
         var _loc2_:String = "";
         _Top10PromptFrame = ComponentFactory.Instance.creatComponentByStylename("guildMemberWeek.view.GuildMemberWeekPromptFrame");
         _loc2_ = LanguageMgr.GetTranslation("guildMemberWeek.AddRankingFrame.PromptFrameF");
         _Top10PromptFrame.setPromptFrameTxt(_loc2_);
         if(CacheSysManager.isLock("alertInFight"))
         {
            _loc1_ = new AlertAction(_Top10PromptFrame,4,1);
            CacheSysManager.getInstance().cache("alertInFight",_loc1_);
            return;
         }
         LayerManager.Instance.addToLayer(_Top10PromptFrame,3,true,2);
      }
      
      public function CloseShowTop10PromptFrame() : void
      {
         _Top10PromptFrame.dispose();
         _Top10PromptFrame = null;
         var _loc1_:CrazyTankSocketEvent = new CrazyTankSocketEvent("guildmemberweek_showrunking");
         dispatchEvent(_loc1_);
      }
      
      public function get getGiftType() : int
      {
         return 15;
      }
      
      public function templateDataSetup(param1:Array) : void
      {
         model.TopTenGiftData = [];
         var _loc2_:String = "";
         var _loc3_:* = param1;
         var _loc7_:int = 0;
         var _loc5_:int = _loc3_.length;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc4_ = _loc3_[_loc7_].length;
            _loc2_ = "";
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               if(_loc6_ < 3)
               {
                  _loc2_ = _loc2_ + (_loc3_[_loc7_][_loc6_].TemplateID + "," + _loc3_[_loc7_][_loc6_].Count + ",");
               }
               else if(_loc6_ == 3)
               {
                  _loc2_ = _loc2_ + (_loc3_[_loc7_][_loc6_].TemplateID + "," + _loc3_[_loc7_][_loc6_].Count);
                  break;
               }
               _loc6_++;
            }
            model.TopTenGiftData.push(_loc2_);
            _loc7_++;
         }
         while(model.TopTenGiftData.length < 10)
         {
            model.TopTenGiftData.push("");
         }
         model.items = param1;
      }
      
      public function CheckShowEndFrame(param1:Boolean) : void
      {
         if(param1)
         {
            LoadAndOpenShowTop10PromptFrame();
         }
         else
         {
            LoadAndOpenGuildMemberWeekFinishActivity();
         }
      }
      
      public function disposeAllFrame(param1:Boolean = false) : void
      {
         if(_WorkFrame)
         {
            _WorkFrame.dispose();
            _WorkFrame = null;
         }
         if(_AddRankingFrame)
         {
            _AddRankingFrame.dispose();
            _AddRankingFrame = null;
         }
         if(_FinishActivityFrame)
         {
            _FinishActivityFrame.dispose();
            _FinishActivityFrame = null;
         }
         _model.AddRanking.splice(0);
         _model.TopTenMemberData.splice(0);
         _model.TopTenAddPointBook = [0,0,0,0,0,0,0,0,0,0];
         _model.PlayerAddPointBook = [0,0,0,0,0,0,0,0,0,0];
         _model.PlayerAddPointBookBefor = [0,0,0,0,0,0,0,0,0,0];
         SocketManager.Instance.out.sendGuildMemberWeekStarClose();
         if(param1)
         {
            if(_Controller)
            {
               _Controller.dispose();
            }
         }
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
