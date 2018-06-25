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
      
      protected function __onBeginTips(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var minite:int = pkg.readInt();
         if(StateManager.currentStateType != "fighting")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("lanternRiddles.view.beginTipsText",minite));
         }
         var data:ChatData = new ChatData();
         data.channel = 14;
         data.msg = LanguageMgr.GetTranslation("lanternRiddles.view.beginTipsText",minite);
         ChatManager.Instance.chat(data);
      }
      
      protected function __onAddLanternIcon(e:CrazyTankSocketEvent) : void
      {
         if(ServerConfigManager.instance.getLightRiddleIsNew)
         {
            return;
         }
         var pkg:PackageIn = e.pkg;
         var cmd:int = e._cmd;
         var events:CrazyTankSocketEvent = null;
         switch(int(cmd) - 37)
         {
            case 0:
               openOrclose(pkg);
               break;
            case 1:
               events = new CrazyTankSocketEvent("lanternRiddles_question",pkg);
               break;
            case 2:
               events = new CrazyTankSocketEvent("lanternRiddles_answer",pkg);
               break;
            default:
               events = new CrazyTankSocketEvent("lanternRiddles_answer",pkg);
               break;
            case 4:
               events = new CrazyTankSocketEvent("lanternRiddles_skill",pkg);
               break;
            case 5:
               events = new CrazyTankSocketEvent("lanternRiddles_rankinfo",pkg);
               break;
            case 6:
               onBeginTips(pkg);
         }
         if(events)
         {
            dispatchEvent(events);
         }
      }
      
      protected function onBeginTips(pkg:PackageIn) : void
      {
         var minite:int = pkg.readInt();
         if(StateManager.currentStateType != "fighting")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("lanternRiddles.view.beginTipsText",minite));
         }
         var data:ChatData = new ChatData();
         data.channel = 14;
         data.msg = LanguageMgr.GetTranslation("lanternRiddles.view.beginTipsText",minite);
         ChatManager.Instance.chat(data);
      }
      
      private function openOrclose(pkg:PackageIn) : void
      {
         _isBegin = pkg.readBoolean();
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
         var data:ChatData = new ChatData();
         data.type = 104;
         data.channel = 1;
         data.msg = LanguageMgr.GetTranslation("hall.view.LanternBegin");
         ChatManager.Instance.chat(data);
      }
      
      private function showLanternBtn() : void
      {
         HallIconManager.instance.updateSwitchHandler("lanternRiddles",true);
      }
      
      public function onLanternShow(event:MouseEvent = null) : void
      {
         SoundManager.instance.playButtonSound();
         show();
      }
      
      private function createLanternBtn(flag:Boolean) : void
      {
         if(!_showIcon)
         {
            _showIcon = new DdtIconTxt();
            _lanternMovie = ComponentFactory.Instance.creat("asset.hall.lanternriddles");
            _showIcon.addActIcon(_lanternMovie);
            _showIcon.resetPos();
         }
         _showIcon.buttonMode = flag;
      }
      
      protected function __onSetLanternTime(event:LanternEvent) : void
      {
         HallIconManager.instance.updateSwitchHandler("lanternRiddles",true,event.Time);
      }
      
      public function deleteLanternBtn() : void
      {
         HallIconManager.instance.updateSwitchHandler("lanternRiddles",false);
      }
      
      public function questionInfo(analyer:LanternDataAnalyzer) : void
      {
         _questionInfo = analyer.data;
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
