package escort
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import ddt.CoreManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.PathManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import road7th.comm.PackageIn;
   
   public class EscortManager extends CoreManager
   {
      
      public static const END:String = "escortEnd";
      
      public static const SHOW_FRAME:String = "show_frame";
      
      public static const ICON_RES_LOAD_COMPLETE:String = "escortIconResLoadComplete";
      
      public static const CANCEL_GAME:String = "escortCancelGame";
      
      public static const CAN_ENTER:String = "escortCanEnter";
      
      public static const LEAVEMAINVIEW:String = "leaveMainView";
      
      private static var _instance:EscortManager;
       
      
      public var pkgs:Object;
      
      public var isShowDungeonTip:Boolean = true;
      
      private var _isStart:Boolean;
      
      private var _isInGame:Boolean;
      
      private var _isLoadIconComplete:Boolean;
      
      public function EscortManager()
      {
         pkgs = {};
         super();
      }
      
      public static function get instance() : EscortManager
      {
         if(_instance == null)
         {
            _instance = new EscortManager();
         }
         return _instance;
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
      }
      
      private function pkgHandler(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var currentPosition:uint = pkg.position;
         var cmd:int = pkg.readByte();
         var _loc5_:* = cmd;
         if(1 !== _loc5_)
         {
            if(7 !== _loc5_)
            {
               if(35 !== _loc5_)
               {
                  pkg.position = currentPosition;
                  dispatchEvent(new CrazyTankSocketEvent("escort",pkg));
               }
               else
               {
                  canEnterHandler(pkg);
               }
            }
            else
            {
               dispatchEvent(new Event("escortCancelGame"));
            }
         }
         else
         {
            openOrCloseHandler(pkg);
         }
      }
      
      private function openOrCloseHandler(pkg:PackageIn) : void
      {
         pkg.readInt();
         _isStart = pkg.readBoolean();
         if(_isStart)
         {
            _isInGame = pkg.readBoolean();
            pkgs["show_frame"] = pkg;
         }
         else
         {
            _isInGame = false;
            dispatchEvent(new Event("escortEnd"));
         }
      }
      
      private function canEnterHandler(pkg:PackageIn) : void
      {
         _isInGame = pkg.readBoolean();
         if(_isInGame)
         {
            dispatchEvent(new Event("escortCanEnter"));
         }
         else
         {
            show();
         }
      }
      
      public function enterMainViewHandler() : void
      {
      }
      
      public function leaveMainViewHandler() : void
      {
         dispatchEvent(new Event("leaveMainView"));
      }
      
      public function get isInGame() : Boolean
      {
         return _isInGame;
      }
      
      public function set isInGame(value:Boolean) : void
      {
         _isInGame = value;
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["escortframe","escortgame","ddtroom"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         dispatchEvent(new Event("show_frame"));
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
         return PathManager.SITE_MAIN + "image/escort/" + "escort" + tmpStr + carType + ".swf";
      }
      
      public function loadSound() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.SITE_MAIN + "image/escort/escortAudio.swf",4);
         loader.addEventListener("complete",loadSoundCompleteHandler);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function loadSoundCompleteHandler(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("complete",loadSoundCompleteHandler);
         SoundManager.instance.initEscortSound();
      }
   }
}
