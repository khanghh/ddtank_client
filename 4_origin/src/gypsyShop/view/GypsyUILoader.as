package gypsyShop.view
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class GypsyUILoader
   {
      
      private static var _loadedDic:Dictionary = new Dictionary();
       
      
      private var _loadProgress:int = 0;
      
      private var _UILoadComplete:Boolean = false;
      
      private var _list:Array;
      
      private var _update:Function;
      
      private var _loadListID:String;
      
      public function GypsyUILoader()
      {
         super();
      }
      
      public function loadUIModule(param1:String, param2:Array, param3:Function) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(_loadedDic[param1] != null)
         {
            return;
            §§push(param3());
         }
         else
         {
            _loadListID = param1;
            _list = param2;
            _update = param3;
            if(!_UILoadComplete)
            {
               UIModuleSmallLoading.Instance.progress = 0;
               UIModuleSmallLoading.Instance.show();
               UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
               UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onUIModuleComplete);
               UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onProgress);
               _loc4_ = param2.length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  UIModuleLoader.Instance.addUIModuleImp(param2[_loc5_]);
                  _loc5_++;
               }
            }
            else
            {
               _update();
            }
            return;
         }
      }
      
      protected function __onProgress(param1:UIModuleEvent) : void
      {
         UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
      }
      
      protected function __onUIModuleComplete(param1:UIModuleEvent) : void
      {
         checkComplete(param1.module);
         if(_UILoadComplete)
         {
            _loadedDic[_loadListID] = 1;
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onProgress);
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleSmallLoading.Instance.hide();
            _update();
         }
      }
      
      private function checkComplete(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _list;
         for each(var _loc2_ in _list)
         {
            if(_loc2_ == param1)
            {
               _loadProgress = Number(_loadProgress) + 1;
               if(_loadProgress >= _list.length)
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
      }
   }
}
