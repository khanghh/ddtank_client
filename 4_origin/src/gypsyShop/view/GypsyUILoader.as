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
      
      public function loadUIModule(loadListID:String, list:Array, update:Function) : void
      {
         var len:int = 0;
         var i:int = 0;
         if(_loadedDic[loadListID] != null)
         {
            update();
            return;
         }
         _loadListID = loadListID;
         _list = list;
         _update = update;
         if(!_UILoadComplete)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onUIModuleComplete);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onProgress);
            len = list.length;
            for(i = 0; i < len; )
            {
               UIModuleLoader.Instance.addUIModuleImp(list[i]);
               i++;
            }
         }
         else
         {
            _update();
         }
      }
      
      protected function __onProgress(event:UIModuleEvent) : void
      {
         UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
      }
      
      protected function __onUIModuleComplete(event:UIModuleEvent) : void
      {
         checkComplete(event.module);
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
      
      private function checkComplete(moduleName:String) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _list;
         for each(var n in _list)
         {
            if(n == moduleName)
            {
               _loadProgress = Number(_loadProgress) + 1;
               if(_loadProgress >= _list.length)
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
      }
   }
}
