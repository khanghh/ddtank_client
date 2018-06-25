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
      
      private function __init(event:PkgEvent) : void
      {
         var i:int = 0;
         var j:int = 0;
         _isOpen = true;
         showNewBoxBtn();
         var pkg:PackageIn = event.pkg;
         var currentPosition:uint = pkg.position;
         var length:int = pkg.readInt();
         for(i = 0; i < length; )
         {
            pkg.readInt();
            i++;
         }
         var length2:int = pkg.readInt();
         for(j = 0; j < length2; )
         {
            pkg.readInt();
            j++;
         }
         pkg.readInt();
         var endTime:Date = pkg.readDate();
         pkg.position = currentPosition;
         pkgs["init"] = pkg;
         WonderfulActivityManager.Instance.chickenEndTime = endTime;
         WonderfulActivityManager.Instance.addElement(4);
         SocketManager.Instance.addEventListener(PkgEvent.format(87,3),__getItem);
      }
      
      public function enterNewBoxView(e:MouseEvent) : void
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
      
      private function __getItem(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         pkgs["getItem"] = pkg;
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
      
      private function __closeActivity(e:PkgEvent) : void
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
