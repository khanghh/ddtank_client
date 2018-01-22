package newChickenBox
{
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import wonderfulActivity.WonderfulActivityManager;
   
   public class NewChickenBoxManager extends CoreManager
   {
      
      public static const SHOWBOXFRAME:String = "showBoxFrame";
      
      public static const CLOSEACTIVITY:String = "closeActivity";
      
      private static var _instance:NewChickenBoxManager = null;
       
      
      private var _isOpen:Boolean = false;
      
      public var pkgs:Object;
      
      public function NewChickenBoxManager(){super();}
      
      public static function get instance() : NewChickenBoxManager{return null;}
      
      public function setup() : void{}
      
      private function __init(param1:PkgEvent) : void{}
      
      public function enterNewBoxView(param1:MouseEvent) : void{}
      
      public function showNewBoxBtn() : void{}
      
      private function __getItem(param1:PkgEvent) : void{}
      
      override protected function start() : void{}
      
      private function onLoaded() : void{}
      
      private function __closeActivity(param1:PkgEvent) : void{}
   }
}
