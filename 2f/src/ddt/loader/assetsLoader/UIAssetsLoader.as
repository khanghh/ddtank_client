package ddt.loader.assetsLoader
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class UIAssetsLoader extends EventDispatcher
   {
      
      public static const UI_LIST_LOADED:String = "ui_list_loaded";
       
      
      private var _moduleLoadedDic:Dictionary;
      
      private var _loadingIDList:Dictionary;
      
      public function UIAssetsLoader(){super();}
      
      public function load(param1:String, param2:Array) : void{}
      
      protected function __onUIModuleComplete(param1:UIModuleEvent) : void{}
      
      private function listLoaded(param1:String) : void{}
      
      protected function __onProgress(param1:UIModuleEvent) : void{}
      
      protected function __onClose(param1:Event) : void{}
   }
}
