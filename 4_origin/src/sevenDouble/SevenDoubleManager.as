package sevenDouble
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.CoreManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import road7th.comm.PackageIn;
   
   public class SevenDoubleManager extends CoreManager
   {
      
      public static const SHOW_FRAME:String = "showFrame";
      
      public static const END:String = "sevenDoubleEnd";
      
      public static const ICON_RES_LOAD_COMPLETE:String = "sevenDoubleIconResLoadComplete";
      
      public static const CAN_ENTER:String = "sevenDoubleCanEnter";
      
      public static const LEAVEMAINVIEW:String = "leaveMainView";
      
      private static var _instance:SevenDoubleManager;
       
      
      public var pkgs:Object;
      
      public var isShowDungeonTip:Boolean = true;
      
      private var _isStart:Boolean;
      
      private var _isLoadIconComplete:Boolean;
      
      private var _isInGame:Boolean;
      
      public function SevenDoubleManager(target:IEventDispatcher = null)
      {
         pkgs = {};
         super(target);
      }
      
      public static function get instance() : SevenDoubleManager
      {
         if(_instance == null)
         {
            _instance = new SevenDoubleManager();
         }
         return _instance;
      }
      
      public function get isInGame() : Boolean
      {
         return _isInGame;
      }
      
      public function set isInGame(value:Boolean) : void
      {
         _isInGame = value;
      }
      
      public function get isStart() : Boolean
      {
         return _isStart;
      }
      
      public function get isLoadIconComplete() : Boolean
      {
         return _isLoadIconComplete;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener("seven_double",pkgHandler);
      }
      
      private function pkgHandler(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var currentPosition:uint = pkg.position;
         var cmd:int = pkg.readByte();
         var _loc5_:* = cmd;
         if(1 !== _loc5_)
         {
            if(35 !== _loc5_)
            {
               pkg.position = currentPosition;
               dispatchEvent(new CrazyTankSocketEvent("seven_double",pkg));
            }
            else
            {
               canEnterHandler(pkg);
            }
         }
         else
         {
            openOrCloseHandler(pkg);
         }
      }
      
      private function canEnterHandler(pkg:PackageIn) : void
      {
         _isInGame = pkg.readBoolean();
         if(_isInGame)
         {
            dispatchEvent(new Event("sevenDoubleCanEnter"));
         }
         else
         {
            show();
         }
      }
      
      private function openOrCloseHandler(pkg:PackageIn) : void
      {
         pkg.readInt();
         _isStart = pkg.readBoolean();
         if(_isStart)
         {
            _isInGame = pkg.readBoolean();
            pkgs["showFrame"] = pkg;
            loadIcon();
         }
         else
         {
            _isInGame = false;
            dispatchEvent(new Event("sevenDoubleEnd"));
         }
      }
      
      public function enterMainViewHandler() : void
      {
      }
      
      public function leaveMainViewHandler() : void
      {
         dispatchEvent(new Event("leaveMainView"));
      }
      
      public function loadIcon() : void
      {
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadIconCompleteHandler);
         UIModuleLoader.Instance.addUIModuleImp("sevendoubleicon");
      }
      
      private function loadIconCompleteHandler(event:UIModuleEvent) : void
      {
         event = event;
         if(event.module == "sevendoubleicon")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadIconCompleteHandler);
            _isLoadIconComplete = true;
            dispatchEvent(new Event("sevenDoubleIconResLoadComplete"));
            new HelperUIModuleLoad().loadUIModule(["sevendoublegame","sevendoubleframe","ddtroom"],function():void
            {
            });
         }
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["sevendoubleframe","sevendoublegame","ddtroom"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         dispatchEvent(new Event("showFrame"));
      }
      
      public function getPlayerResUrl(isSelf:Boolean, carType:int) : String
      {
         var tmpStr:* = null;
         if(isSelf)
         {
            tmpStr = "self";
         }
         else
         {
            tmpStr = "other";
         }
         return PathManager.SITE_MAIN + "image/sevendouble/" + "sevendouble" + tmpStr + carType + ".swf";
      }
      
      public function loadSound() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.SITE_MAIN + "image/sevendouble/sevenDoubleAudio.swf",4);
         loader.addEventListener("complete",loadSoundCompleteHandler);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function loadSoundCompleteHandler(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("complete",loadSoundCompleteHandler);
         SoundManager.instance.initSevenDoubleSound();
      }
   }
}
