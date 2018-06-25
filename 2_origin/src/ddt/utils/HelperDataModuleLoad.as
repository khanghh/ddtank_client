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
      
      public function loadDataModule(list:Array, update:Function, params:Array = null, isReal:Boolean = false, isSmallLoading:Boolean = true) : void
      {
         var i:int = 0;
         var tempLoader:* = null;
         var fileName:* = null;
         _list = list;
         _update = update;
         _params = params;
         _loaderQueue = new QueueLoader();
         var len:int = list.length;
         for(i = 0; i < len; )
         {
            if(list[i] is BaseLoader)
            {
               tempLoader = list[i] as BaseLoader;
               addr91:
               fileName = PathManager.getLoaderFileName(tempLoader.url);
               if(isReal || _loadedDic[fileName] == null)
               {
                  tempLoader.addEventListener("complete",__onDataLoadProgress);
                  _loaderQueue.addLoader(tempLoader);
               }
            }
            else if(list[i] is Function)
            {
               tempLoader = (list[i] as Function).call();
               §§goto(addr91);
            }
            else
            {
               trace("数据加载中有数据类型不匹配！");
            }
            i++;
         }
         if(_loaderQueue.length <= 0)
         {
            update.apply(null,params);
            _loaderQueue.dispose();
            _loaderQueue = null;
            return;
         }
         if(isSmallLoading)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
         }
         _loaderQueue.addEventListener("complete",__onDataLoadComplete);
         _loaderQueue.start();
      }
      
      protected function __onClose(event:Event) : void
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
      
      private function __onDataLoadProgress(event:LoaderEvent) : void
      {
         var loader:BaseLoader = event.currentTarget as BaseLoader;
         loader.removeEventListener("complete",__onDataLoadProgress);
         var fileName:String = PathManager.getLoaderFileName(loader.url);
         _loadedDic[fileName] = 1;
         loader = null;
         _loadProgress = Number(_loadProgress) + 1;
         var realProgress:Number = _loadProgress / _list.length;
         UIModuleSmallLoading.Instance.progress = realProgress * 100;
      }
      
      private function __onDataLoadComplete(event:Event) : void
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
