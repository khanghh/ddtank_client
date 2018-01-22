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
      
      public function addUIModlue(param1:String) : void
      {
         if(_queue.indexOf(param1) != -1)
         {
            return;
         }
         _queue.push(param1);
         if(!isLoading && _zipLoadComplete)
         {
            loadNextModule();
         }
      }
      
      public function addUIModuleImp(param1:String, param2:String = null) : void
      {
         var _loc3_:int = _queue.indexOf(param1);
         if(_loc3_ != -1)
         {
            _queue.splice(_loc3_,1);
         }
         if(_zipLoadComplete)
         {
            loadModuleConfig(param1,param2);
         }
         else
         {
            _queue.unshift(param1);
            loadNextModule();
         }
      }
      
      public function setup(param1:String = "", param2:String = "") : void
      {
         _baseUrl = param1;
         _backupUrl = param2;
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
      
      private function __onLoadZipComplete(param1:LoaderEvent) : void
      {
         var _loc2_:ByteArray = _zipLoader.content;
         analyMd5(_loc2_);
      }
      
      public function analyMd5(param1:ByteArray) : void
      {
         var _loc2_:* = null;
         if(ComponentSetting.USEMD5 && (ComponentSetting.md5Dic["xml.png"] || hasHead(param1)))
         {
            if(compareMD5(param1))
            {
               _loc2_ = new ByteArray();
               param1.position = 37;
               param1.readBytes(_loc2_);
               zipLoad(_loc2_);
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
            zipLoad(param1);
         }
      }
      
      private function compareMD5(param1:ByteArray) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeUTFBytes(ComponentSetting.md5Dic["xml.png"]);
         _loc4_.position = 0;
         param1.position = 5;
         while(_loc4_.bytesAvailable > 0)
         {
            _loc2_ = _loc4_.readByte();
            _loc3_ = param1.readByte();
            if(_loc2_ != _loc3_)
            {
               return false;
            }
         }
         return true;
      }
      
      private function hasHead(param1:ByteArray) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(ComponentSetting.swf_head);
         _loc2_.position = 0;
         param1.position = 0;
         while(_loc2_.bytesAvailable > 0)
         {
            _loc3_ = _loc2_.readByte();
            _loc4_ = param1.readByte();
            if(_loc3_ != _loc4_)
            {
               return false;
            }
         }
         return true;
      }
      
      private function zipLoad(param1:ByteArray) : void
      {
         var _loc2_:FZip = new FZip();
         _loc2_.addEventListener("complete",__onZipParaComplete);
         _loc2_.loadBytes(param1);
      }
      
      private function __onZipParaComplete(param1:Event) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         _zipLoader.removeEventListener("complete",__onLoadZipComplete);
         var _loc2_:FZip = param1.currentTarget as FZip;
         _loc2_.removeEventListener("complete",__onZipParaComplete);
         var _loc3_:int = _loc2_.getFileCount();
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = _loc2_.getFileAt(_loc6_);
            _loc5_ = new XML(_loc4_.content.toString());
            ComponentFactory.Instance.setup(_loc5_);
            _loc6_++;
         }
         _zipLoadComplete = true;
         loadNextModule();
      }
      
      public function get isLoading() : Boolean
      {
         return _loadingLoaders.length > 0;
      }
      
      private function __onConfigLoadComplete(param1:LoaderEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         param1.loader.removeEventListener("complete",__onConfigLoadComplete);
         param1.loader.removeEventListener("loadError",__onLoadError);
         _loadingLoaders.splice(_loadingLoaders.indexOf(param1.loader),1);
         if(param1.loader.isSuccess)
         {
            _loc3_ = new XML(param1.loader.content);
            _loc2_ = _loc3_.@source;
            ComponentFactory.Instance.setup(_loc3_);
            loadModuleUI(_loc2_,param1.loader.loadProgressMessage,param1.loader.loadCompleteMessage);
         }
         else
         {
            removeLastLoader(param1.loader);
            dispatchEvent(new UIModuleEvent("uiModuleComplete",param1.loader));
            loadNextModule();
         }
      }
      
      private function __onLoadError(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("loadError",__onLoadError);
         param1.loader.removeEventListener("progress",__onResourceProgress);
         param1.loader.removeEventListener("complete",__onResourceComplete);
         dispatchEvent(new UIModuleEvent("uiModuleError",param1.loader));
      }
      
      private function __onResourceComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("loadError",__onLoadError);
         param1.loader.removeEventListener("progress",__onResourceProgress);
         param1.loader.removeEventListener("complete",__onResourceComplete);
         removeLastLoader(param1.loader);
         dispatchEvent(new UIModuleEvent("uiModuleComplete",param1.loader));
         loadNextModule();
      }
      
      private function removeLastLoader(param1:BaseLoader) : void
      {
         if(_loadingLoaders.indexOf(param1) != -1)
         {
            _loadingLoaders.splice(_loadingLoaders.indexOf(param1),1);
         }
         if(_queue.indexOf(param1.loadProgressMessage) != -1)
         {
            _queue.splice(_queue.indexOf(param1.loadProgressMessage),1);
         }
      }
      
      private function __onResourceProgress(param1:LoaderEvent) : void
      {
         dispatchEvent(new UIModuleEvent("uiMoudleProgress",param1.loader));
      }
      
      private function loadNextModule() : void
      {
         if(_queue.length <= 0)
         {
            dispatchEvent(new LoaderResourceEvent("loadxmlComplete"));
            return;
         }
         var _loc1_:String = _queue[0];
         if(!isLoadingModule(_loc1_))
         {
            loadModuleConfig(_loc1_);
         }
      }
      
      private function isLoadingModule(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _loadingLoaders.length)
         {
            if(_loadingLoaders[_loc2_].loadProgressMessage == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function loadModuleConfig(param1:String, param2:String = "") : void
      {
         var _loc3_:* = null;
         if(_uiModuleLoadMode == "configXml")
         {
            _loc3_ = LoadResourceManager.Instance.createLoader(_baseUrl + ComponentSetting.getUIConfigXMLPath(param1),2);
            _loc3_.loadProgressMessage = param1;
            _loc3_.loadCompleteMessage = param2;
            _loc3_.addEventListener("complete",__onConfigLoadComplete);
            _loc3_.addEventListener("loadError",__onLoadError);
            _loc3_.loadErrorMessage = "加载UI配置文件" + _loc3_.url + "出现错误";
            if(_loadingLoaders.indexOf(_loc3_) == -1)
            {
               _loadingLoaders.push(_loc3_);
            }
            LoadResourceManager.Instance.startLoad(_loc3_,true);
         }
         else
         {
            loadModuleUI(_baseUrl + ComponentSetting.getUISourcePath(param1),param1,param2);
         }
      }
      
      private function loadModuleUI(param1:String, param2:String = "", param3:String = "") : void
      {
         var _loc4_:BaseLoader = LoadResourceManager.Instance.createLoader(param1,4);
         _loc4_.loadProgressMessage = param2;
         _loc4_.loadCompleteMessage = param3;
         _loc4_.loadErrorMessage = "加载ui资源：" + _loc4_.url + "出现错误";
         _loc4_.addEventListener("loadError",__onLoadError);
         _loc4_.addEventListener("progress",__onResourceProgress);
         _loc4_.addEventListener("complete",__onResourceComplete);
         if(_loadingLoaders.indexOf(_loc4_) == -1)
         {
            _loadingLoaders.push(_loc4_);
         }
         LoadResourceManager.Instance.startLoad(_loc4_,true);
      }
   }
}
