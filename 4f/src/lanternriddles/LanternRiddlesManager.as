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
      
      public function LanternRiddlesManager(){super();}
      
      public static function get instance() : LanternRiddlesManager{return null;}
      
      public function setup() : void{}
      
      private function initEvent() : void{}
      
      protected function __onBeginTips(param1:PkgEvent) : void{}
      
      protected function __onAddLanternIcon(param1:CrazyTankSocketEvent) : void{}
      
      protected function onBeginTips(param1:PackageIn) : void{}
      
      private function openOrclose(param1:PackageIn) : void{}
      
      private function smallBugleTips() : void{}
      
      private function showLanternBtn() : void{}
      
      public function onLanternShow(param1:MouseEvent = null) : void{}
      
      private function createLanternBtn(param1:Boolean) : void{}
      
      protected function __onSetLanternTime(param1:LanternEvent) : void{}
      
      public function deleteLanternBtn() : void{}
      
      public function questionInfo(param1:LanternDataAnalyzer) : void{}
      
      public function get info() : Object{return null;}
      
      override protected function start() : void{}
      
      private function removeEvent() : void{}
      
      public function get isBegin() : Boolean{return false;}
      
      public function get showIcon() : DdtIconTxt{return null;}
   }
}
