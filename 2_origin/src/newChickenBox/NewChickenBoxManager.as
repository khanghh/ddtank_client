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
      
      public function NewChickenBoxManager()
      {
         pkgs = {};
         super();
      }
      
      public static function get instance() : NewChickenBoxManager
      {
         if(_instance == null)
         {
            _instance = new NewChickenBoxManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(87,1),__init);
         SocketManager.Instance.addEventListener(PkgEvent.format(87,2),__closeActivity);
      }
      
      private function __init(param1:PkgEvent) : void
      {
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         _isOpen = true;
         showNewBoxBtn();
         var _loc3_:PackageIn = param1.pkg;
         var _loc7_:uint = _loc3_.position;
         var _loc2_:int = _loc3_.readInt();
         _loc8_ = 0;
         while(_loc8_ < _loc2_)
         {
            _loc3_.readInt();
            _loc8_++;
         }
         var _loc6_:int = _loc3_.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc3_.readInt();
            _loc5_++;
         }
         _loc3_.readInt();
         var _loc4_:Date = _loc3_.readDate();
         _loc3_.position = _loc7_;
         pkgs["init"] = _loc3_;
         WonderfulActivityManager.Instance.chickenEndTime = _loc4_;
         WonderfulActivityManager.Instance.addElement(4);
         SocketManager.Instance.addEventListener(PkgEvent.format(87,3),__getItem);
      }
      
      public function enterNewBoxView(param1:MouseEvent) : void
      {
         SocketManager.Instance.out.sendNewChickenBox();
      }
      
      public function showNewBoxBtn() : void
      {
         if(_isOpen && PlayerManager.Instance.Self.Grade >= 10)
         {
            HallIconManager.instance.updateSwitchHandler("newChickenBox",true);
         }
         else
         {
            HallIconManager.instance.executeCacheRightIconLevelLimit("newChickenBox",true,10);
         }
      }
      
      private function __getItem(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         pkgs["getItem"] = _loc2_;
         show();
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["newchickenbox"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         dispatchEvent(new Event("showBoxFrame"));
      }
      
      private function __closeActivity(param1:PkgEvent) : void
      {
         _isOpen = false;
         Mouse.show();
         HallIconManager.instance.updateSwitchHandler("newChickenBox",false);
         HallIconManager.instance.executeCacheRightIconLevelLimit("newChickenBox",false);
         dispatchEvent(new Event("closeActivity"));
         SocketManager.Instance.removeEventListener(PkgEvent.format(87,3),__getItem);
      }
   }
}
