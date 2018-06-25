package com.pickgliss.loader
{
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.utils.ClassUtils;
   import flash.utils.Dictionary;
   
   public class CodeLoader
   {
      
      private static var _loadedDic:Dictionary = new Dictionary();
       
      
      private const DDT_CLASS_PATH:String = "DDT_Core";
      
      private var _onLoaded:Function;
      
      private var _url:String;
      
      private var _onProgress:Function;
      
      private var _coreLoader:BaseLoader;
      
      public function CodeLoader()
      {
         super();
      }
      
      public static function loaded(url:String) : Boolean
      {
         return _loadedDic[url] != null;
      }
      
      public static function removeURL(url:String) : void
      {
      }
      
      public static function addLoadURL(url:String) : void
      {
         _loadedDic[url] = 1;
      }
      
      public function loadPNG($url:String, $onLoaded:Function, $onProgress:Function) : void
      {
         _url = $url;
         _onLoaded = $onLoaded;
         _onProgress = $onProgress;
         startLoad();
      }
      
      public function stop() : void
      {
         _coreLoader.removeEventListener("complete",__onloadCoreComplete);
         _coreLoader.removeEventListener("progress",__onLoadCoreProgress);
      }
      
      private function startLoad() : void
      {
         var url:String = ComponentSetting.FLASHSITE + _url;
         _coreLoader = LoadResourceManager.Instance.createLoader(url,4);
         _coreLoader.addEventListener("complete",__onloadCoreComplete);
         _coreLoader.addEventListener("progress",__onLoadCoreProgress);
         LoadResourceManager.Instance.startLoad(_coreLoader);
      }
      
      protected function __onLoadCoreProgress(event:LoaderEvent) : void
      {
      }
      
      private function __onloadCoreComplete(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("complete",__onloadCoreComplete);
         event.loader.removeEventListener("progress",__onLoadCoreProgress);
         var ddtCoreInstance:* = ClassUtils.CreatInstance("DDT_Core");
         if(ddtCoreInstance != null)
         {
            LoaderSavingManager.saveFilesToLocal();
            ddtCoreInstance["setup"]();
            _loadedDic[_url] = 1;
            if(_onLoaded != null)
            {
               _onLoaded();
            }
            _coreLoader = null;
            _onLoaded = null;
            _onProgress = null;
            return;
         }
         throw "断网了，请刷新页面重试。";
      }
   }
}
