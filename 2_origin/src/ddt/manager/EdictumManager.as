package ddt.manager
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import ddt.data.analyze.LoadEdictumAnalyze;
   import ddt.events.PkgEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.comm.PackageIn;
   import times.TimesManager;
   
   public class EdictumManager extends EventDispatcher
   {
      
      private static var _instance:EdictumManager;
       
      
      private var unShowArr:Array;
      
      private var edictumDataList:Array;
      
      public function EdictumManager(param1:IEventDispatcher = null)
      {
         unShowArr = [];
         super();
      }
      
      public static function get Instance() : EdictumManager
      {
         if(_instance == null)
         {
            _instance = new EdictumManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvents();
      }
      
      private function initEvents() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(75),__getEdictumVersion);
      }
      
      private function __getEdictumVersion(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_.push(_loc4_.readInt());
            _loc5_++;
         }
         __checkVersion(_loc3_);
      }
      
      private function __checkVersion(param1:Array) : void
      {
         unShowArr = param1;
         if(unShowArr.length > 0)
         {
            __loadEdictumData();
         }
      }
      
      private function __loadEdictumData() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(__getURL(),6);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingBuddyListFailure");
         _loc1_.analyzer = new LoadEdictumAnalyze(__returnWebSiteInfoHandler);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function __returnWebSiteInfoHandler(param1:LoadEdictumAnalyze) : void
      {
         edictumDataList = param1.edictumDataList;
         TimesManager.Instance.checkLoadUpdateRes(edictumDataList,unShowArr);
      }
      
      private function __getURL() : String
      {
         return PathManager.solveRequestPath("GMTipAllByIDs.ashx?ids=" + unShowArr.join(","));
      }
   }
}
