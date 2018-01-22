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
      
      public function load(param1:String, param2:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(_moduleLoadedDic[param1] == null && _loadingIDList[param1] == null)
         {
            _loadingIDList[param1] = param2;
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onUIModuleComplete);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onProgress);
            _loc3_ = param2.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               UIModuleLoader.Instance.addUIModuleImp(param2[_loc4_]);
               _loc4_++;
            }
         }
      }
      
      protected function __onUIModuleComplete(param1:UIModuleEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = _loadingIDList;
         loop0:
         for each(var _loc3_ in _loadingIDList)
         {
            _loc2_ = _loadingIDList[_loc3_] as Array;
            _loc4_ = _loc2_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(param1.module == _loc2_[_loc5_])
               {
                  _loc2_.splice(_loc5_,1);
                  if(_loc2_.length == 0)
                  {
                     delete _loadingIDList[_loc3_];
                     _moduleLoadedDic[_loc3_] = 1;
                     listLoaded(_loc3_);
                     UIModuleSmallLoading.Instance.hide();
                  }
                  break loop0;
               }
               _loc5_++;
            }
         }
      }
      
      private function listLoaded(param1:String) : void
      {
         dispatchEvent(new Event(""));
      }
      
      protected function __onProgress(param1:UIModuleEvent) : void
      {
         UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
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
