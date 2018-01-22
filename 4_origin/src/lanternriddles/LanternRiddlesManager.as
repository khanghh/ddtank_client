package lanternriddles
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.CoreManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.view.chat.ChatData;
   import ddtActivityIcon.DdtActivityIconManager;
   import ddtActivityIcon.DdtIconTxt;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import lanternriddles.analyzer.LanternDataAnalyzer;
   import lanternriddles.event.LanternEvent;
   import road7th.comm.PackageIn;
   
   public class LanternRiddlesManager extends CoreManager
   {
      
      private static var _instance:LanternRiddlesManager;
       
      
      private var _isBegin:Boolean;
      
      private var _hallView:HallStateView;
      
      private var _lanternMovie:MovieClip;
      
      private var _showIcon:DdtIconTxt;
      
      private var _questionInfo:Object;
      
      public function LanternRiddlesManager()
      {
         super();
      }
      
      public static function get instance() : LanternRiddlesManager
      {
         if(!_instance)
         {
            _instance = new LanternRiddlesManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         DdtActivityIconManager.Instance.addEventListener("lanternSettime",__onSetLanternTime);
         SocketManager.Instance.addEventListener("lanternRiddles_begin",__onAddLanternIcon);
      }
      
      protected function __onBeginTips(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:int = _loc3_.readInt();
         if(StateManager.currentStateType != "fighting")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("lanternRiddles.view.beginTipsText",_loc4_));
         }
         var _loc2_:ChatData = new ChatData();
         _loc2_.channel = 14;
         _loc2_.msg = LanguageMgr.GetTranslation("lanternRiddles.view.beginTipsText",_loc4_);
         ChatManager.Instance.chat(_loc2_);
      }
      
      protected function __onAddLanternIcon(param1:CrazyTankSocketEvent) : void
      {
         if(ServerConfigManager.instance.getLightRiddleIsNew)
         {
            return;
         }
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = param1._cmd;
         var _loc3_:CrazyTankSocketEvent = null;
         switch(int(_loc2_) - 37)
         {
            case 0:
               openOrclose(_loc4_);
               break;
            case 1:
               _loc3_ = new CrazyTankSocketEvent("lanternRiddles_question",_loc4_);
               break;
            case 2:
               _loc3_ = new CrazyTankSocketEvent("lanternRiddles_answer",_loc4_);
               break;
            default:
               _loc3_ = new CrazyTankSocketEvent("lanternRiddles_answer",_loc4_);
               break;
            case 4:
               _loc3_ = new CrazyTankSocketEvent("lanternRiddles_skill",_loc4_);
               break;
            case 5:
               _loc3_ = new CrazyTankSocketEvent("lanternRiddles_rankinfo",_loc4_);
               break;
            case 6:
               onBeginTips(_loc4_);
         }
         if(_loc3_)
         {
            dispatchEvent(_loc3_);
         }
      }
      
      protected function onBeginTips(param1:PackageIn) : void
      {
         var _loc3_:int = param1.readInt();
         if(StateManager.currentStateType != "fighting")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("lanternRiddles.view.beginTipsText",_loc3_));
         }
         var _loc2_:ChatData = new ChatData();
         _loc2_.channel = 14;
         _loc2_.msg = LanguageMgr.GetTranslation("lanternRiddles.view.beginTipsText",_loc3_);
         ChatManager.Instance.chat(_loc2_);
      }
      
      private function openOrclose(param1:PackageIn) : void
      {
         _isBegin = param1.readBoolean();
         if(_isBegin)
         {
            smallBugleTips();
            showLanternBtn();
         }
         else
         {
            deleteLanternBtn();
         }
      }
      
      private function smallBugleTips() : void
      {
         var _loc1_:ChatData = new ChatData();
         _loc1_.type = 104;
         _loc1_.channel = 1;
         _loc1_.msg = LanguageMgr.GetTranslation("hall.view.LanternBegin");
         ChatManager.Instance.chat(_loc1_);
      }
      
      private function showLanternBtn() : void
      {
         HallIconManager.instance.updateSwitchHandler("lanternRiddles",true);
      }
      
      public function onLanternShow(param1:MouseEvent = null) : void
      {
         SoundManager.instance.playButtonSound();
         show();
      }
      
      private function createLanternBtn(param1:Boolean) : void
      {
         if(!_showIcon)
         {
            _showIcon = new DdtIconTxt();
            _lanternMovie = ComponentFactory.Instance.creat("asset.hall.lanternriddles");
            _showIcon.addActIcon(_lanternMovie);
            _showIcon.resetPos();
         }
         _showIcon.buttonMode = param1;
      }
      
      protected function __onSetLanternTime(param1:LanternEvent) : void
      {
         HallIconManager.instance.updateSwitchHandler("lanternRiddles",true,param1.Time);
      }
      
      public function deleteLanternBtn() : void
      {
         HallIconManager.instance.updateSwitchHandler("lanternRiddles",false);
      }
      
      public function questionInfo(param1:LanternDataAnalyzer) : void
      {
         _questionInfo = param1.data;
      }
      
      public function get info() : Object
      {
         return _questionInfo;
      }
      
      override protected function start() : void
      {
         if(_questionInfo == null)
         {
            new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.loadLanternRiddlesXml()],start);
            return;
         }
         dispatchEvent(new LanternEvent("lanternOpenView"));
      }
      
      private function removeEvent() : void
      {
         DdtActivityIconManager.Instance.removeEventListener("lanternSettime",__onSetLanternTime);
      }
      
      public function get isBegin() : Boolean
      {
         return _isBegin;
      }
      
      public function get showIcon() : DdtIconTxt
      {
         return _showIcon;
      }
   }
}
