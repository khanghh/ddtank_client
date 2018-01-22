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
      
      public function HelperDataModuleLoad()
      {
         super();
      }
      
      public function loadDataModule(param1:Array, param2:Function, param3:Array = null, param4:Boolean = false, param5:Boolean = true) : void
      {
         var _loc9_:int = 0;
         var _loc8_:* = null;
         var _loc6_:* = null;
         _list = param1;
         _update = param2;
         _params = param3;
         _loaderQueue = new QueueLoader();
         var _loc7_:int = param1.length;
         _loc9_ = 0;
         while(_loc9_ < _loc7_)
         {
            if(param1[_loc9_] is BaseLoader)
            {
               _loc8_ = param1[_loc9_] as BaseLoader;
               addr68:
               _loc6_ = PathManager.getLoaderFileName(_loc8_.url);
               if(param4 || _loadedDic[_loc6_] == null)
               {
                  _loc8_.addEventListener("complete",__onDataLoadProgress);
                  _loaderQueue.addLoader(_loc8_);
               }
            }
            else if(param1[_loc9_] is Function)
            {
               _loc8_ = (param1[_loc9_] as Function).call();
               §§goto(addr68);
            }
            else
            {
               trace("数据加载中有数据类型不匹配！");
            }
            _loc9_++;
         }
         if(_loaderQueue.length <= 0)
         {
            param2.apply(null,param3);
            _loaderQueue.dispose();
            _loaderQueue = null;
            return;
         }
         if(param5)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
         }
         _loaderQueue.addEventListener("complete",__onDataLoadComplete);
         _loaderQueue.start();
      }
      
      protected function __onClose(param1:Event) : void
      {
         removeSmallLoading();
         if(_loaderQueue && _loaderQueue.length <= 0)
         {
            _loaderQueue.dispose();
            _loaderQueue = null;
         }
      }
      
      private function removeSmallLoading() : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
      }
      
      private function __onDataLoadProgress(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.currentTarget as BaseLoader;
         _loc2_.removeEventListener("complete",__onDataLoadProgress);
         var _loc4_:String = PathManager.getLoaderFileName(_loc2_.url);
         _loadedDic[_loc4_] = 1;
         _loc2_ = null;
         _loadProgress = Number(_loadProgress) + 1;
         var _loc3_:Number = _loadProgress / _list.length;
         UIModuleSmallLoading.Instance.progress = _loc3_ * 100;
      }
      
      private function __onDataLoadComplete(param1:Event) : void
      {
         _update.apply(null,_params);
         _loaderQueue.removeEventListener("complete",__onDataLoadComplete);
         _loaderQueue.dispose();
         _loaderQueue = null;
         dispose();
      }
      
      private function dispose() : void
      {
         removeSmallLoading();
         if(_list.length > 0)
         {
            _list.length = 0;
            _list = null;
         }
         _update = null;
         _params = null;
      }
   }
}
