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
      
      public function EdictumManager(target:IEventDispatcher = null)
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
      
      private function __getEdictumVersion(e:PkgEvent) : void
      {
         var i:int = 0;
         var pkg:PackageIn = e.pkg;
         var count:int = pkg.readInt();
         var arr:Array = [];
         for(i = 0; i < count; )
         {
            arr.push(pkg.readInt());
            i++;
         }
         __checkVersion(arr);
      }
      
      private function __checkVersion(arr:Array) : void
      {
         unShowArr = arr;
         if(unShowArr.length > 0)
         {
            __loadEdictumData();
         }
      }
      
      private function __loadEdictumData() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(__getURL(),6);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingBuddyListFailure");
         loader.analyzer = new LoadEdictumAnalyze(__returnWebSiteInfoHandler);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function __returnWebSiteInfoHandler(action:LoadEdictumAnalyze) : void
      {
         edictumDataList = action.edictumDataList;
         TimesManager.Instance.checkLoadUpdateRes(edictumDataList,unShowArr);
      }
      
      private function __getURL() : String
      {
         return PathManager.solveRequestPath("GMTipAllByIDs.ashx?ids=" + unShowArr.join(","));
      }
   }
}
