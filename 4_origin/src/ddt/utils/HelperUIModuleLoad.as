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
      
      public function HelperUIModuleLoad()
      {
         super();
      }
      
      public function loadUIModule(list:Array, update:Function, params:Array = null) : void
      {
         var i:int = 0;
         var moduleID:* = null;
         _update = update;
         _params = params;
         _loadlist = [];
         for(i = 0; i < list.length; )
         {
            moduleID = list[i];
            if(_loadedDic[moduleID] == null)
            {
               _loadlist.push(moduleID);
            }
            i++;
         }
         if(_loadlist.length > 0)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onUIModuleComplete);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onProgress);
            var _loc8_:int = 0;
            var _loc7_:* = _loadlist;
            for each(var module in _loadlist)
            {
               UIModuleLoader.Instance.addUIModuleImp(module);
            }
         }
         else
         {
            _update.apply(null,_params);
         }
      }
      
      protected function __onProgress(event:UIModuleEvent) : void
      {
         var realProgress:Number = (_loadProgress + event.loader.progress) / _loadlist.length;
         UIModuleSmallLoading.Instance.progress = realProgress * 100;
      }
      
      protected function __onUIModuleComplete(event:UIModuleEvent) : void
      {
         checkComplete(event.module);
         if(_UILoadComplete)
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onProgress);
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleSmallLoading.Instance.hide();
            _update.apply(null,_params);
            dispose();
         }
      }
      
      private function checkComplete(moduleName:String) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _loadlist;
         for each(var n in _loadlist)
         {
            if(n == moduleName)
            {
               _loadedDic[moduleName] = 1;
               _loadProgress = Number(_loadProgress) + 1;
               if(_loadProgress >= _loadlist.length)
               {
                  _UILoadComplete = true;
               }
            }
         }
      }
      
      protected function __onClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onProgress);
         dispose();
      }
      
      private function dispose() : void
      {
         if(_loadlist.length > 0)
         {
            _loadlist.length = 0;
            _loadlist = null;
         }
         _update = null;
         _params = null;
      }
   }
}
