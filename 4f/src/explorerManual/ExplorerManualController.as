package explorerManual
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.utils.HelperUIModuleLoad;
   import explorerManual.data.DebrisInfo;
   import explorerManual.data.ExplorerManualInfo;
   import explorerManual.data.ManualPageDebrisInfo;
   import explorerManual.view.ExplorerManualFrame;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import road7th.comm.PackageIn;
   
   public class ExplorerManualController extends EventDispatcher
   {
      
      private static var _instance:ExplorerManualController;
       
      
      private var _frame:ExplorerManualFrame = null;
      
      private var _manaualModel:ExplorerManualInfo;
      
      private var _autoUpgradeing:Boolean = false;
      
      private var _puzzleState:Boolean = false;
      
      public function ExplorerManualController(){super();}
      
      public static function get instance() : ExplorerManualController{return null;}
      
      public function get puzzleState() : Boolean{return false;}
      
      public function set puzzleState(param1:Boolean) : void{}
      
      public function setup() : void{}
      
      private function addEvent() : void{}
      
      private function __initDataHandler(param1:PkgEvent) : void{}
      
      private function updatePlayerManualPro() : void{}
      
      private function __openViewHandler(param1:Event) : void{}
      
      private function __upgradeHandler(param1:PkgEvent) : void{}
      
      private function __pageUpdateHandler(param1:PkgEvent) : void{}
      
      private function __pageActiveHandler(param1:PkgEvent) : void{}
      
      private function loadUIModule() : void{}
      
      private function openView() : void{}
      
      public function startUpgrade(param1:Boolean, param2:Boolean) : void{}
      
      public function autoUpgrade(param1:Boolean, param2:Boolean, param3:Boolean) : void{}
      
      private function upgrade(param1:Boolean, param2:Boolean, param3:Boolean = false) : void{}
      
      public function requestManualPageData(param1:int) : void{}
      
      public function switchChapterView(param1:int) : void{}
      
      public function sendManualPageActive(param1:int, param2:int) : void{}
      
      private function requestInitData() : void{}
      
      public function get autoUpgradeing() : Boolean{return false;}
      
      public function set autoUpgradeing(param1:Boolean) : void{}
   }
}
