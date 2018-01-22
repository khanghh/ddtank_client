package ddt.utils
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class HelperUIModuleLoad
   {
      
      private static var _loadedDic:Dictionary = new Dictionary();
       
      
      private var _loadProgress:int = 0;
      
      private var _UILoadComplete:Boolean = false;
      
      private var _loadlist:Array;
      
      private var _update:Function;
      
      private var _params:Array;
      
      public function HelperUIModuleLoad(){super();}
      
      public function loadUIModule(param1:Array, param2:Function, param3:Array = null) : void{}
      
      protected function __onProgress(param1:UIModuleEvent) : void{}
      
      protected function __onUIModuleComplete(param1:UIModuleEvent) : void{}
      
      private function checkComplete(param1:String) : void{}
      
      protected function __onClose(param1:Event) : void{}
      
      private function dispose() : void{}
   }
}
