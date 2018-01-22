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
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:uint = _loc3_.position;
         var _loc2_:int = _loc3_.readByte();
         var _loc5_:* = _loc2_;
         if(1 !== _loc5_)
         {
            if(7 !== _loc5_)
            {
               if(35 !== _loc5_)
               {
                  _loc3_.position = _loc4_;
                  dispatchEvent(new CrazyTankSocketEvent("escort",_loc3_));
               }
               else
               {
                  canEnterHandler(_loc3_);
               }
            }
            else
            {
               dispatchEvent(new Event("escortCancelGame"));
            }
         }
         else
         {
            openOrCloseHandler(_loc3_);
         }
      }
      
      private function openOrCloseHandler(param1:PackageIn) : void
      {
         param1.readInt();
         _isStart = param1.readBoolean();
         if(_isStart)
         {
            _isInGame = param1.readBoolean();
            pkgs["show_frame"] = param1;
         }
         else
         {
            _isInGame = false;
            dispatchEvent(new Event("escortEnd"));
         }
      }
      
      private function canEnterHandler(param1:PackageIn) : void
      {
         _isInGame = param1.readBoolean();
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
      
      public function set isInGame(param1:Boolean) : void
      {
         _isInGame = param1;
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["escortframe","escortgame","ddtroom"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         dispatchEvent(new Event("show_frame"));
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
         return PathManager.SITE_MAIN + "image/escort/" + "escort" + _loc3_ + param2 + ".swf";
      }
      
      public function loadSound() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.SITE_MAIN + "image/escort/escortAudio.swf",4);
         _loc1_.addEventListener("complete",loadSoundCompleteHandler);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function loadSoundCompleteHandler(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",loadSoundCompleteHandler);
         SoundManager.instance.initEscortSound();
      }
   }
}
