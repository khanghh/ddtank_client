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
       
      
      public function App()
      {
         super();
      }
      
      public static function init(param1:Stage, param2:ApplicationDomain = null) : void
      {
         var _loc4_:* = null;
         stage = param1;
         stage.frameRate = Config.GAME_FPS;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         stage.stageFocusRect = false;
         stage.tabChildren = false;
         asset.setDomain(param2);
         var _loc3_:Object = stage.loaderInfo.parameters;
         if(_loc3_ != null)
         {
            for(_loc4_ in _loc3_)
            {
               if(Config[_loc4_] != null)
               {
                  Config[_loc4_] = _loc3_[_loc4_];
               }
            }
         }
         stage.addChild(dialog);
         stage.addChild(log);
         stage.doubleClickEnabled = true;
      }
      
      public static function loadUI(param1:String, param2:Function = null) : void
      {
         XML.ignoreWhitespace = true;
         _loadUICall = param2;
         var _loc3_:BaseLoader = LoadResourceManager.Instance.createLoader(param1,BaseLoader.BYTE_LOADER);
         _loc3_.addEventListener(LoaderEvent.COMPLETE,__onLoadUIComplete);
         _loc3_.addEventListener(LoaderEvent.LOAD_ERROR,__onLoadUIError);
         LoadResourceManager.Instance.startLoad(_loc3_);
      }
      
      public static function loadAssets(param1:Array, param2:Function) : void
      {
         var queryLoader:QueueLoader = null;
         var onLoadComplete:Function = null;
         var url:String = null;
         var base:BaseLoader = null;
         var suffix:String = null;
         var urls:Array = param1;
         var complete:Function = param2;
         onLoadComplete = function(param1:Event):void
         {
            queryLoader.removeEventListener(Event.COMPLETE,onLoadComplete);
            queryLoader.dispose();
            if(complete != null)
            {
               complete();
            }
         };
         XML.ignoreWhitespace = true;
         queryLoader = new QueueLoader();
         var i:int = 0;
         while(i < urls.length)
         {
            url = urls[i];
            suffix = StringUtils.getSuffixStr(url);
            if(suffix == "ui")
            {
               base = LoadResourceManager.Instance.createLoader(url,BaseLoader.MORNUI_DATA_LOADER);
               base.addEventListener(LoaderEvent.COMPLETE,__onLoadUIComplete);
               base.addEventListener(LoaderEvent.LOAD_ERROR,__onLoadUIError);
            }
            else if(suffix == "swf")
            {
               base = LoadResourceManager.Instance.createLoader(url,BaseLoader.MODULE_LOADER);
            }
            else if(suffix == "xml")
            {
               base = LoadResourceManager.Instance.createLoader(url,BaseLoader.TEXT_LOADER);
               base.addEventListener(LoaderEvent.COMPLETE,__onLoadXMLComplete);
               base.addEventListener(LoaderEvent.LOAD_ERROR,__onLoadXMLError);
            }
            queryLoader.addLoader(base);
            i++;
         }
         queryLoader.addEventListener(Event.COMPLETE,onLoadComplete);
         queryLoader.start();
      }
      
      private static function __onLoadUIComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener(LoaderEvent.COMPLETE,__onLoadUIComplete);
         param1.loader.removeEventListener(LoaderEvent.LOAD_ERROR,__onLoadUIError);
         if(_loadUICall != null)
         {
            _loadUICall();
         }
         _loadUICall = null;
      }
      
      private static function __onLoadUIError(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener(LoaderEvent.COMPLETE,__onLoadUIComplete);
         param1.loader.removeEventListener(LoaderEvent.LOAD_ERROR,__onLoadUIError);
         trace("------loader morn ui error:" + param1.loader.url);
         _loadUICall = null;
      }
      
      private static function __onLoadXMLComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener(LoaderEvent.COMPLETE,__onLoadXMLComplete);
         param1.loader.removeEventListener(LoaderEvent.LOAD_ERROR,__onLoadXMLError);
         Builder.callBack(XML(param1.loader.content));
      }
      
      private static function __onLoadXMLError(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener(LoaderEvent.COMPLETE,__onLoadXMLComplete);
         param1.loader.removeEventListener(LoaderEvent.LOAD_ERROR,__onLoadXMLError);
         trace("------loader morn xml error:" + param1.loader.url);
      }
      
      public static function getResPath(param1:String) : String
      {
         return !!/^http:\/\//g.test(param1)?param1:Config.resPath + param1;
      }
   }
}
