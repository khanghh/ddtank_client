package
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.QueueLoader;
   import com.pickgliss.utils.StringUtils;
   import flash.display.Stage;
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
      
      public static function init($stage:Stage, $domain:ApplicationDomain = null) : void
      {
         stage = $stage;
         stage.frameRate = Config.GAME_FPS;
         stage.scaleMode = "noScale";
         stage.align = "TL";
         stage.stageFocusRect = false;
         stage.tabChildren = false;
         asset.setDomain($domain);
         var gameVars:Object = stage.loaderInfo.parameters;
         if(gameVars != null)
         {
            var _loc6_:int = 0;
            var _loc5_:* = gameVars;
            for(var s in gameVars)
            {
               if(Config[s] != null)
               {
                  Config[s] = gameVars[s];
               }
            }
         }
         stage.addChild(dialog);
         stage.addChild(log);
         stage.doubleClickEnabled = true;
      }
      
      public static function loadUI(url:String, complete:Function = null) : void
      {
         XML.ignoreWhitespace = true;
         _loadUICall = complete;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(url,3);
         loader.addEventListener("complete",__onLoadUIComplete);
         loader.addEventListener("loadError",__onLoadUIError);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      public static function loadAssets(urls:Array, complete:Function) : void
      {
         urls = urls;
         complete = complete;
         onLoadComplete = function(e:Event):void
         {
            queryLoader.removeEventListener("complete",onLoadComplete);
            queryLoader.dispose();
            if(complete != null)
            {
               complete();
            }
         };
         XML.ignoreWhitespace = true;
         var queryLoader:QueueLoader = new QueueLoader();
         for(var i:int = 0; i < urls.length; )
         {
            var url:String = urls[i];
            var suffix:String = StringUtils.getSuffixStr(url);
            if(suffix == "ui")
            {
               var base:BaseLoader = LoadResourceManager.Instance.createLoader(url,8);
               base.addEventListener("complete",__onLoadUIComplete);
               base.addEventListener("loadError",__onLoadUIError);
            }
            else if(suffix == "swf")
            {
               base = LoadResourceManager.Instance.createLoader(url,4);
            }
            else if(suffix == "xml")
            {
               base = LoadResourceManager.Instance.createLoader(url,2);
               base.addEventListener("complete",__onLoadXMLComplete);
               base.addEventListener("loadError",__onLoadXMLError);
            }
            queryLoader.addLoader(base);
            i = Number(i) + 1;
         }
         queryLoader.addEventListener("complete",onLoadComplete);
         queryLoader.start();
      }
      
      private static function __onLoadUIComplete(e:LoaderEvent) : void
      {
         e.loader.removeEventListener("complete",__onLoadUIComplete);
         e.loader.removeEventListener("loadError",__onLoadUIError);
         if(_loadUICall != null)
         {
            _loadUICall();
         }
         _loadUICall = null;
      }
      
      private static function __onLoadUIError(e:LoaderEvent) : void
      {
         e.loader.removeEventListener("complete",__onLoadUIComplete);
         e.loader.removeEventListener("loadError",__onLoadUIError);
         trace("------loader morn ui error:" + e.loader.url);
         _loadUICall = null;
      }
      
      private static function __onLoadXMLComplete(e:LoaderEvent) : void
      {
         e.loader.removeEventListener("complete",__onLoadXMLComplete);
         e.loader.removeEventListener("loadError",__onLoadXMLError);
         Builder.callBack(XML(e.loader.content));
      }
      
      private static function __onLoadXMLError(e:LoaderEvent) : void
      {
         e.loader.removeEventListener("complete",__onLoadXMLComplete);
         e.loader.removeEventListener("loadError",__onLoadXMLError);
      }
      
      public static function getResPath(url:String) : String
      {
         return !!/^http:\/\//g.test(url)?url:Config.resPath + url;
      }
   }
}
