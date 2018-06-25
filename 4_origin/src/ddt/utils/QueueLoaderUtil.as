package ddt.utils
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   [Event(name="complete",type="flash.events.Event")]
   [Event(name="change",type="flash.events.Event")]
   [Event(name="close",type="flash.events.Event")]
   public final class QueueLoaderUtil extends EventDispatcher implements Disposeable
   {
       
      
      private var _loaders:Vector.<BaseLoader>;
      
      private var _isSmallLoading:Boolean;
      
      public function QueueLoaderUtil()
      {
         super();
         _loaders = new Vector.<BaseLoader>();
      }
      
      public function addLoader(loader:BaseLoader) : void
      {
         _loaders.push(loader);
      }
      
      public function start(isSmallLoading:Boolean = true) : void
      {
         _isSmallLoading = isSmallLoading;
         if(_isSmallLoading)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
         }
         tryLoadNext();
      }
      
      public function reset() : void
      {
         removeEvent();
         _loaders.splice(0,_loaders.length);
      }
      
      public function dispose() : void
      {
         removeEvent();
         _loaders = null;
      }
      
      public function removeEvent() : void
      {
         var i:int = 0;
         for(i = 0; i < _loaders.length; )
         {
            _loaders[i].removeEventListener("complete",__loadNext);
            if(_isSmallLoading)
            {
               _loaders[i].removeEventListener("progress",__progress);
            }
            i++;
         }
      }
      
      public function isAllComplete() : Boolean
      {
         var i:int = 0;
         for(i = 0; i < _loaders.length; )
         {
            if(!_loaders[i].isComplete)
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function isLoading() : Boolean
      {
         var i:int = 0;
         for(i = 0; i < _loaders.length; )
         {
            if(_loaders[i].isLoading)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function get completeCount() : int
      {
         var i:int = 0;
         var result:int = 0;
         for(i = 0; i < _loaders.length; )
         {
            if(_loaders[i].isComplete)
            {
               result++;
            }
            i++;
         }
         return result;
      }
      
      public function get length() : int
      {
         return _loaders.length;
      }
      
      public function get loaders() : Vector.<BaseLoader>
      {
         return _loaders;
      }
      
      private function __loadNext(event:LoaderEvent) : void
      {
         var loader:BaseLoader = event.loader as BaseLoader;
         loader.removeEventListener("complete",__loadNext);
         if(_isSmallLoading)
         {
            loader.removeEventListener("progress",__progress);
         }
         dispatchEvent(new Event("change"));
         tryLoadNext();
      }
      
      private function __progress(event:LoaderEvent) : void
      {
         var total:int = _loaders.length;
         var completeTotal:int = completeCount;
         var progress:Number = (completeTotal / total + 1 / total * event.loader.progress) * 100;
         UIModuleSmallLoading.Instance.progress = progress;
         if(!UIModuleSmallLoading.Instance.isShow && progress < 100)
         {
            UIModuleSmallLoading.Instance.show();
         }
      }
      
      private function tryLoadNext() : void
      {
         var i:int = 0;
         var loaderCount:int = _loaders.length;
         for(i = 0; i < loaderCount; )
         {
            if(!_loaders[i].isComplete)
            {
               _loaders[i].addEventListener("complete",__loadNext);
               if(_isSmallLoading)
               {
                  _loaders[i].addEventListener("progress",__progress);
               }
               LoadResourceManager.Instance.startLoad(_loaders[i]);
               return;
            }
            i++;
         }
         reset();
         dispatchEvent(new Event("complete"));
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
      }
      
      private function __onClose(event:Event) : void
      {
         reset();
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         dispatchEvent(new Event("close"));
      }
   }
}
