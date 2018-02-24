package ddt.utils
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.QueueLoader;
   import ddt.manager.PathManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class HelperDataModuleLoad
   {
      
      private static var _loadedDic:Dictionary = new Dictionary();
       
      
      private var _loaderQueue:QueueLoader;
      
      private var _loadProgress:int = 0;
      
      private var _list:Array;
      
      private var _update:Function;
      
      private var _params:Array;
      
      public function HelperDataModuleLoad(){super();}
      
      public function loadDataModule(param1:Array, param2:Function, param3:Array = null, param4:Boolean = false, param5:Boolean = true) : void{}
      
      protected function __onClose(param1:Event) : void{}
      
      private function removeSmallLoading() : void{}
      
      private function __onDataLoadProgress(param1:LoaderEvent) : void{}
      
      private function __onDataLoadComplete(param1:Event) : void{}
      
      private function dispose() : void{}
   }
}
