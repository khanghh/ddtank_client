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
      
      public function SevenDoubleManager(param1:IEventDispatcher = null)
      {
         pkgs = {};
         super(param1);
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
      
      public function set isInGame(param1:Boolean) : void
      {
         _isInGame = param1;
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
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:uint = _loc3_.position;
         var _loc2_:int = _loc3_.readByte();
         var _loc5_:* = _loc2_;
         if(1 !== _loc5_)
         {
            if(35 !== _loc5_)
            {
               _loc3_.position = _loc4_;
               dispatchEvent(new CrazyTankSocketEvent("seven_double",_loc3_));
            }
            else
            {
               canEnterHandler(_loc3_);
            }
         }
         else
         {
            openOrCloseHandler(_loc3_);
         }
      }
      
      private function canEnterHandler(param1:PackageIn) : void
      {
         _isInGame = param1.readBoolean();
         if(_isInGame)
         {
            dispatchEvent(new Event("sevenDoubleCanEnter"));
         }
         else
         {
            show();
         }
      }
      
      private function openOrCloseHandler(param1:PackageIn) : void
      {
         param1.readInt();
         _isStart = param1.readBoolean();
         if(_isStart)
         {
            _isInGame = param1.readBoolean();
            pkgs["showFrame"] = param1;
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
      
      private function loadIconCompleteHandler(param1:UIModuleEvent) : void
      {
         event = param1;
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
      
      public function getPlayerResUrl(param1:Boolean, param2:int) : String
      {
         var _loc3_:* = null;
         if(param1)
         {
            _loc3_ = "self";
         }
         else
         {
            _loc3_ = "other";
         }
         return PathManager.SITE_MAIN + "image/sevendouble/" + "sevendouble" + _loc3_ + param2 + ".swf";
      }
      
      public function loadSound() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.SITE_MAIN + "image/sevendouble/sevenDoubleAudio.swf",4);
         _loc1_.addEventListener("complete",loadSoundCompleteHandler);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function loadSoundCompleteHandler(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",loadSoundCompleteHandler);
         SoundManager.instance.initSevenDoubleSound();
      }
   }
}
