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
      
      public function loadUIModule(param1:Array, param2:Function, param3:Array = null) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         _update = param2;
         _params = param3;
         _loadlist = [];
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc4_ = param1[_loc6_];
            if(_loadedDic[_loc4_] == null)
            {
               _loadlist.push(_loc4_);
            }
            _loc6_++;
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
            for each(var _loc5_ in _loadlist)
            {
               UIModuleLoader.Instance.addUIModuleImp(_loc5_);
            }
         }
         else
         {
            _update.apply(null,_params);
         }
      }
      
      protected function __onProgress(param1:UIModuleEvent) : void
      {
         var _loc2_:Number = (_loadProgress + param1.loader.progress) / _loadlist.length;
         UIModuleSmallLoading.Instance.progress = _loc2_ * 100;
      }
      
      protected function __onUIModuleComplete(param1:UIModuleEvent) : void
      {
         checkComplete(param1.module);
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
      
      private function checkComplete(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _loadlist;
         for each(var _loc2_ in _loadlist)
         {
            if(_loc2_ == param1)
            {
               _loadedDic[param1] = 1;
               _loadProgress = Number(_loadProgress) + 1;
               if(_loadProgress >= _loadlist.length)
               {
                  _UILoadComplete = true;
               }
            }
         }
      }
      
      protected function __onClose(param1:Event) : void
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
