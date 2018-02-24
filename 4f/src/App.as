package
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.QueueLoader;
   import com.pickgliss.utils.StringUtils;
   import flash.display.Stage;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import morn.core.managers.AssetManager;
   import morn.core.managers.DialogManager;
   import morn.core.managers.DragManager;
   import morn.core.managers.LangManager;
   import morn.core.managers.LogManager;
   import morn.core.managers.RenderManager;
   import morn.core.managers.TimerManager;
   import morn.editor.Builder;
   
   public class App
   {
      
      public static var stage:Stage;
      
      public static var asset:AssetManager = new AssetManager();
      
      public static var timer:TimerManager = new TimerManager();
      
      public static var render:RenderManager = new RenderManager();
      
      public static var dialog:DialogManager = new DialogManager();
      
      public static var log:LogManager = new LogManager();
      
      public static var drag:DragManager = new DragManager();
      
      public static var lang:LangManager = new LangManager();
      
      private static var _loadUICall:Function;
       
      
      public function App(){super();}
      
      public static function init(param1:Stage, param2:ApplicationDomain = null) : void{}
      
      public static function loadUI(param1:String, param2:Function = null) : void{}
      
      public static function loadAssets(param1:Array, param2:Function) : void{}
      
      private static function __onLoadUIComplete(param1:LoaderEvent) : void{}
      
      private static function __onLoadUIError(param1:LoaderEvent) : void{}
      
      private static function __onLoadXMLComplete(param1:LoaderEvent) : void{}
      
      private static function __onLoadXMLError(param1:LoaderEvent) : void{}
      
      public static function getResPath(param1:String) : String{return null;}
   }
}
