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
      
      public function EdictumManager(param1:IEventDispatcher = null){super();}
      
      public static function get Instance() : EdictumManager{return null;}
      
      public function setup() : void{}
      
      private function initEvents() : void{}
      
      private function __getEdictumVersion(param1:PkgEvent) : void{}
      
      private function __checkVersion(param1:Array) : void{}
      
      private function __loadEdictumData() : void{}
      
      private function __returnWebSiteInfoHandler(param1:LoadEdictumAnalyze) : void{}
      
      private function __getURL() : String{return null;}
   }
}
