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
      
      public function UIAssetsLoader()
      {
         super();
         _moduleLoadedDic = new Dictionary();
         _loadingIDList = new Dictionary();
      }
      
      public function load(id:String, moduleList:Array) : void
      {
         var len:int = 0;
         var i:int = 0;
         if(_moduleLoadedDic[id] == null && _loadingIDList[id] == null)
         {
            _loadingIDList[id] = moduleList;
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onUIModuleComplete);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onProgress);
            len = moduleList.length;
            for(i = 0; i < len; )
            {
               UIModuleLoader.Instance.addUIModuleImp(moduleList[i]);
               i++;
            }
         }
      }
      
      protected function __onUIModuleComplete(event:UIModuleEvent) : void
      {
         var arr:* = null;
         var len:int = 0;
         var i:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = _loadingIDList;
         loop0:
         for each(var n in _loadingIDList)
         {
            arr = _loadingIDList[n] as Array;
            len = arr.length;
            for(i = 0; i < len; )
            {
               if(event.module == arr[i])
               {
                  arr.splice(i,1);
                  if(arr.length == 0)
                  {
                     delete _loadingIDList[n];
                     _moduleLoadedDic[n] = 1;
                     listLoaded(n);
                     UIModuleSmallLoading.Instance.hide();
                  }
                  break loop0;
               }
               i++;
            }
         }
      }
      
      private function listLoaded(id:String) : void
      {
         dispatchEvent(new Event(""));
      }
      
      protected function __onProgress(event:UIModuleEvent) : void
      {
         UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
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
