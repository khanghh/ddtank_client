package com.pickgliss.loader
{
   import com.pickgliss.events.LoaderResourceEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import deng.fzip.FZip;
   import deng.fzip.FZipFile;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   
   [Event(name="uiModuleComplete",type="com.pickgliss.events.UIModuleEvent")]
   [Event(name="uiModuleError",type="com.pickgliss.events.UIModuleEvent")]
   [Event(name="uiMoudleProgress",type="com.pickgliss.events.UIModuleEvent")]
   public class UIModuleLoader extends EventDispatcher
   {
      
      public static const XMLPNG:String = "xml.png";
      
      public static const CONFIG_ZIP:String = "configZip";
      
      public static const CONFIG_XML:String = "configXml";
      
      private static var _baseUrl:String = "";
      
      private static var _instance:UIModuleLoader;
       
      
      private var _uiModuleLoadMode:String = "configXml";
      
      private var _loadingLoaders:Vector.<BaseLoader>;
      
      private var _queue:Vector.<String>;
      
      private var _backupUrl:String = "";
      
      private var _zipPath:String = "";
      
      private var _zipLoadComplete:Boolean = true;
      
      private var _zipLoader:BaseLoader;
      
      private var _isSecondLoad:Boolean = false;
      
      public function UIModuleLoader()
      {
         super();
         _queue = new Vector.<String>();
         _loadingLoaders = new Vector.<BaseLoader>();
      }
      
      public static function get Instance() : UIModuleLoader
      {
         if(_instance == null)
         {
            _instance = new UIModuleLoader();
         }
         return _instance;
      }
      
      public function addUIModlue(module:String) : void
      {
         if(_queue.indexOf(module) != -1)
         {
            return;
         }
         _queue.push(module);
         if(!isLoading && _zipLoadComplete)
         {
            loadNextModule();
         }
      }
      
      public function addUIModuleImp(module:String, state:String = null) : void
      {
         var index:int = _queue.indexOf(module);
         if(index != -1)
         {
            _queue.splice(index,1);
         }
         if(_zipLoadComplete)
         {
            loadModuleConfig(module,state);
         }
         else
         {
            _queue.unshift(module);
            loadNextModule();
         }
      }
      
      public function setup(baseUrl:String = "", backupUrl:String = "") : void
      {
         _baseUrl = baseUrl;
         _backupUrl = backupUrl;
         ComponentSetting.FLASHSITE = _baseUrl;
         ComponentSetting.BACKUP_FLASHSITE = _backupUrl;
         _zipPath = _baseUrl + ComponentSetting.getUIConfigZIPPath();
         _uiModuleLoadMode = "configZip";
         _zipLoadComplete = false;
         loadZipConfig();
      }
      
      public function get baseUrl() : String
      {
         return _baseUrl;
      }
      
      private function loadZipConfig() : void
      {
         if(_uiModuleLoadMode == "configXml")
         {
            return;
         }
         _zipLoader = LoadResourceManager.Instance.createLoader(_zipPath,3);
         _zipLoader.addEventListener("complete",__onLoadZipComplete);
         LoadResourceManager.Instance.startLoad(_zipLoader);
      }
      
      private function __onLoadZipComplete(event:LoaderEvent) : void
      {
         var temp:ByteArray = _zipLoader.content;
         analyMd5(temp);
      }
      
      public function analyMd5(content:ByteArray) : void
      {
         var temp:* = null;
         if(ComponentSetting.USEMD5 && (ComponentSetting.md5Dic["xml.png"] || hasHead(content)))
         {
            if(compareMD5(content))
            {
               temp = new ByteArray();
               content.position = 37;
               content.readBytes(temp);
               zipLoad(temp);
            }
            else
            {
               if(_isSecondLoad)
               {
                  if(ExternalInterface.available)
                  {
                     ExternalInterface.call("alert",_zipPath + ":is old");
                  }
               }
               else
               {
                  _zipPath = _zipPath.replace(ComponentSetting.FLASHSITE,ComponentSetting.BACKUP_FLASHSITE);
                  _zipLoader.url = _zipPath + "?rnd=" + Math.random();
                  _zipLoader.isLoading = false;
                  _zipLoader.loadFromWeb();
               }
               _isSecondLoad = true;
            }
         }
         else
         {
            zipLoad(content);
         }
      }
      
      private function compareMD5(temp:ByteArray) : Boolean
      {
         var source:int = 0;
         var target:int = 0;
         var md5Bytes:ByteArray = new ByteArray();
         md5Bytes.writeUTFBytes(ComponentSetting.md5Dic["xml.png"]);
         md5Bytes.position = 0;
         temp.position = 5;
         while(md5Bytes.bytesAvailable > 0)
         {
            source = md5Bytes.readByte();
            target = temp.readByte();
            if(source != target)
            {
               return false;
            }
         }
         return true;
      }
      
      private function hasHead(temp:ByteArray) : Boolean
      {
         var source:int = 0;
         var target:int = 0;
         var road7Byte:ByteArray = new ByteArray();
         road7Byte.writeUTFBytes(ComponentSetting.swf_head);
         road7Byte.position = 0;
         temp.position = 0;
         while(road7Byte.bytesAvailable > 0)
         {
            source = road7Byte.readByte();
            target = temp.readByte();
            if(source != target)
            {
               return false;
            }
         }
         return true;
      }
      
      private function zipLoad(content:ByteArray) : void
      {
         var zip:FZip = new FZip();
         zip.addEventListener("complete",__onZipParaComplete);
         zip.loadBytes(content);
      }
      
      private function __onZipParaComplete(event:Event) : void
      {
         var i:int = 0;
         var file:* = null;
         var xml:* = null;
         _zipLoader.removeEventListener("complete",__onLoadZipComplete);
         var zip:FZip = event.currentTarget as FZip;
         zip.removeEventListener("complete",__onZipParaComplete);
         var count:int = zip.getFileCount();
         for(i = 0; i < count; )
         {
            file = zip.getFileAt(i);
            xml = new XML(file.content.toString());
            ComponentFactory.Instance.setup(xml);
            i++;
         }
         _zipLoadComplete = true;
         loadNextModule();
      }
      
      public function get isLoading() : Boolean
      {
         return _loadingLoaders.length > 0;
      }
      
      private function __onConfigLoadComplete(event:LoaderEvent) : void
      {
         var config:* = null;
         var resourcePath:* = null;
         event.loader.removeEventListener("complete",__onConfigLoadComplete);
         event.loader.removeEventListener("loadError",__onLoadError);
         _loadingLoaders.splice(_loadingLoaders.indexOf(event.loader),1);
         if(event.loader.isSuccess)
         {
            config = new XML(event.loader.content);
            resourcePath = config.@source;
            ComponentFactory.Instance.setup(config);
            loadModuleUI(resourcePath,event.loader.loadProgressMessage,event.loader.loadCompleteMessage);
         }
         else
         {
            removeLastLoader(event.loader);
            dispatchEvent(new UIModuleEvent("uiModuleComplete",event.loader));
            loadNextModule();
         }
      }
      
      private function __onLoadError(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("loadError",__onLoadError);
         event.loader.removeEventListener("progress",__onResourceProgress);
         event.loader.removeEventListener("complete",__onResourceComplete);
         dispatchEvent(new UIModuleEvent("uiModuleError",event.loader));
      }
      
      private function __onResourceComplete(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("loadError",__onLoadError);
         event.loader.removeEventListener("progress",__onResourceProgress);
         event.loader.removeEventListener("complete",__onResourceComplete);
         removeLastLoader(event.loader);
         dispatchEvent(new UIModuleEvent("uiModuleComplete",event.loader));
         loadNextModule();
      }
      
      private function removeLastLoader(loader:BaseLoader) : void
      {
         if(_loadingLoaders.indexOf(loader) != -1)
         {
            _loadingLoaders.splice(_loadingLoaders.indexOf(loader),1);
         }
         if(_queue.indexOf(loader.loadProgressMessage) != -1)
         {
            _queue.splice(_queue.indexOf(loader.loadProgressMessage),1);
         }
      }
      
      private function __onResourceProgress(event:LoaderEvent) : void
      {
         dispatchEvent(new UIModuleEvent("uiMoudleProgress",event.loader));
      }
      
      private function loadNextModule() : void
      {
         if(_queue.length <= 0)
         {
            dispatchEvent(new LoaderResourceEvent("loadxmlComplete"));
            return;
         }
         var loadingModule:String = _queue[0];
         if(!isLoadingModule(loadingModule))
         {
            loadModuleConfig(loadingModule);
         }
      }
      
      private function isLoadingModule(module:String) : Boolean
      {
         var i:int = 0;
         for(i = 0; i < _loadingLoaders.length; )
         {
            if(_loadingLoaders[i].loadProgressMessage == module)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function loadModuleConfig(module:String, state:String = "") : void
      {
         var textLoader:* = null;
         if(_uiModuleLoadMode == "configXml")
         {
            textLoader = LoadResourceManager.Instance.createLoader(_baseUrl + ComponentSetting.getUIConfigXMLPath(module),2);
            textLoader.loadProgressMessage = module;
            textLoader.loadCompleteMessage = state;
            textLoader.addEventListener("complete",__onConfigLoadComplete);
            textLoader.addEventListener("loadError",__onLoadError);
            textLoader.loadErrorMessage = "加载UI配置文件" + textLoader.url + "出现错误";
            if(_loadingLoaders.indexOf(textLoader) == -1)
            {
               _loadingLoaders.push(textLoader);
            }
            LoadResourceManager.Instance.startLoad(textLoader,true);
         }
         else
         {
            loadModuleUI(_baseUrl + ComponentSetting.getUISourcePath(module),module,state);
         }
      }
      
      private function loadModuleUI(uipath:String, module:String = "", state:String = "") : void
      {
         var uiResourceLoader:BaseLoader = LoadResourceManager.Instance.createLoader(uipath,4);
         uiResourceLoader.loadProgressMessage = module;
         uiResourceLoader.loadCompleteMessage = state;
         uiResourceLoader.loadErrorMessage = "加载ui资源：" + uiResourceLoader.url + "出现错误";
         uiResourceLoader.addEventListener("loadError",__onLoadError);
         uiResourceLoader.addEventListener("progress",__onResourceProgress);
         uiResourceLoader.addEventListener("complete",__onResourceComplete);
         if(_loadingLoaders.indexOf(uiResourceLoader) == -1)
         {
            _loadingLoaders.push(uiResourceLoader);
         }
         LoadResourceManager.Instance.startLoad(uiResourceLoader,true);
      }
   }
}
