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
      
      public function GuildMemberWeekManager(pct:PrivateClass)
      {
         super();
         if(pct == null)
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
      
      private function pkgHandler(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var cmd:int = e._cmd;
         var event:CrazyTankSocketEvent = null;
         switch(int(cmd) - 7)
         {
            case 0:
               openOrclose(pkg);
               break;
            case 1:
               event = new CrazyTankSocketEvent("guildmemberweek_playertop10",pkg);
               break;
            case 2:
               event = new CrazyTankSocketEvent("guildmemberweek_AddPointBook",pkg);
               break;
            case 3:
               event = new CrazyTankSocketEvent("guildmemberweek_addpointbookrecord",pkg);
               break;
            case 4:
               event = new CrazyTankSocketEvent("guildmemberweek_getmyrunking",pkg);
               break;
            case 5:
               event = new CrazyTankSocketEvent("guildmemberweek_upaddpointbookrecord",pkg);
               break;
            case 6:
               event = new CrazyTankSocketEvent("guildmemberweek_showactivityend",pkg);
         }
         if(event)
         {
            dispatchEvent(event);
         }
      }
      
      private function openOrclose(pkg:PackageIn) : void
      {
         if(pkg != null)
         {
            _model.isOpen = pkg.readBoolean();
            _isShowIcon = _model.isOpen;
            if(_model.isOpen)
            {
               _model.ActivityStartTime = pkg.readUTF();
               _model.ActivityEndTime = pkg.readUTF();
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
      
      public function onClickguildMemberWeekIcon(e:MouseEvent) : void
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
         var tempTAction:* = null;
         if(_WorkFrame)
         {
            _WorkFrame.dispose();
            _WorkFrame = null;
         }
         _FinishActivityFrame = ComponentFactory.Instance.creatComponentByStylename("Window.guildmemberweek.GuildMemberWeekShowRankingFrame");
         if(CacheSysManager.isLock("alertInFight"))
         {
            tempTAction = new AlertAction(_FinishActivityFrame,4,1);
            CacheSysManager.getInstance().cache("alertInFight",tempTAction);
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
      
      public function returnComponentBnt(Spr:Sprite, BtnTip:Boolean = true) : BaseButton
      {
         var Btn:BaseButton = new BaseButton();
         if(BtnTip)
         {
            Btn.tipDirctions = "0,5";
            Btn.tipStyle = "ddt.view.tips.OneLineTip";
         }
         Btn.filterString = "null,lightFilter,lightFilter,grayFilter";
         Btn.backgound = Spr;
         Btn.tipGapV = 20;
         Btn.addChild(Spr);
         return Btn;
      }
      
      public function LoadAndOpenShowTop10PromptFrame() : void
      {
         LoaderGuildMemberWeekUIModule.Instance.loadUIModule(doOpenGuildMemberWeekTop10PromptFrame);
      }
      
      public function doOpenGuildMemberWeekTop10PromptFrame() : void
      {
         var tempTAction:* = null;
         var Str:String = "";
         _Top10PromptFrame = ComponentFactory.Instance.creatComponentByStylename("guildMemberWeek.view.GuildMemberWeekPromptFrame");
         Str = LanguageMgr.GetTranslation("guildMemberWeek.AddRankingFrame.PromptFrameF");
         _Top10PromptFrame.setPromptFrameTxt(Str);
         if(CacheSysManager.isLock("alertInFight"))
         {
            tempTAction = new AlertAction(_Top10PromptFrame,4,1);
            CacheSysManager.getInstance().cache("alertInFight",tempTAction);
            return;
         }
         LayerManager.Instance.addToLayer(_Top10PromptFrame,3,true,2);
      }
      
      public function CloseShowTop10PromptFrame() : void
      {
         _Top10PromptFrame.dispose();
         _Top10PromptFrame = null;
         var evt:CrazyTankSocketEvent = new CrazyTankSocketEvent("guildmemberweek_showrunking");
         dispatchEvent(evt);
      }
      
      public function get getGiftType() : int
      {
         return 15;
      }
      
      public function templateDataSetup(dataList:Array) : void
      {
         model.TopTenGiftData = [];
         var tempStr:String = "";
         var tempArray:* = dataList;
         var i:int = 0;
         var len:int = tempArray.length;
         var j:int = 0;
         var len2:int = 0;
         for(i = 0; i < len; )
         {
            len2 = tempArray[i].length;
            tempStr = "";
            for(j = 0; j < len2; )
            {
               if(j < 3)
               {
                  tempStr = tempStr + (tempArray[i][j].TemplateID + "," + tempArray[i][j].Count + ",");
               }
               else if(j == 3)
               {
                  tempStr = tempStr + (tempArray[i][j].TemplateID + "," + tempArray[i][j].Count);
                  break;
               }
               j++;
            }
            model.TopTenGiftData.push(tempStr);
            i++;
         }
         while(model.TopTenGiftData.length < 10)
         {
            model.TopTenGiftData.push("");
         }
         model.items = dataList;
      }
      
      public function CheckShowEndFrame(playerType:Boolean) : void
      {
         if(playerType)
         {
            LoadAndOpenShowTop10PromptFrame();
         }
         else
         {
            LoadAndOpenGuildMemberWeekFinishActivity();
         }
      }
      
      public function disposeAllFrame(deleteType:Boolean = false) : void
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
         if(deleteType)
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
