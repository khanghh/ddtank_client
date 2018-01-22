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
      
      public static function loaded(param1:String) : Boolean
      {
         return _loadedDic[param1] != null;
      }
      
      public static function removeURL(param1:String) : void
      {
      }
      
      public static function addLoadURL(param1:String) : void
      {
         _loadedDic[param1] = 1;
      }
      
      public function loadPNG(param1:String, param2:Function, param3:Function) : void
      {
         _url = param1;
         _onLoaded = param2;
         _onProgress = param3;
         startLoad();
      }
      
      public function stop() : void
      {
         _coreLoader.removeEventListener("complete",__onloadCoreComplete);
         _coreLoader.removeEventListener("progress",__onLoadCoreProgress);
      }
      
      private function startLoad() : void
      {
         var _loc1_:String = ComponentSetting.FLASHSITE + _url;
         _coreLoader = LoadResourceManager.Instance.createLoader(_loc1_,4);
         _coreLoader.addEventListener("complete",__onloadCoreComplete);
         _coreLoader.addEventListener("progress",__onLoadCoreProgress);
         LoadResourceManager.Instance.startLoad(_coreLoader);
      }
      
      protected function __onLoadCoreProgress(param1:LoaderEvent) : void
      {
      }
      
      private function __onloadCoreComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__onloadCoreComplete);
         param1.loader.removeEventListener("progress",__onLoadCoreProgress);
         var _loc2_:* = ClassUtils.CreatInstance("DDT_Core");
         if(_loc2_ != null)
         {
            LoaderSavingManager.saveFilesToLocal();
            _loc2_["setup"]();
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
