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
      
      public function CodeLoader(){super();}
      
      public static function loaded(param1:String) : Boolean{return false;}
      
      public static function removeURL(param1:String) : void{}
      
      public static function addLoadURL(param1:String) : void{}
      
      public function loadPNG(param1:String, param2:Function, param3:Function) : void{}
      
      public function stop() : void{}
      
      private function startLoad() : void{}
      
      protected function __onLoadCoreProgress(param1:LoaderEvent) : void{}
      
      private function __onloadCoreComplete(param1:LoaderEvent) : void{}
   }
}
