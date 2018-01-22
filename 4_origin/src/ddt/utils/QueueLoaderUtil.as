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
      
      public function addLoader(param1:BaseLoader) : void
      {
         _loaders.push(param1);
      }
      
      public function start(param1:Boolean = true) : void
      {
         _isSmallLoading = param1;
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
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _loaders.length)
         {
            _loaders[_loc1_].removeEventListener("complete",__loadNext);
            if(_isSmallLoading)
            {
               _loaders[_loc1_].removeEventListener("progress",__progress);
            }
            _loc1_++;
         }
      }
      
      public function isAllComplete() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _loaders.length)
         {
            if(!_loaders[_loc1_].isComplete)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function isLoading() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _loaders.length)
         {
            if(_loaders[_loc1_].isLoading)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function get completeCount() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _loaders.length)
         {
            if(_loaders[_loc2_].isComplete)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get length() : int
      {
         return _loaders.length;
      }
      
      public function get loaders() : Vector.<BaseLoader>
      {
         return _loaders;
      }
      
      private function __loadNext(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.loader as BaseLoader;
         _loc2_.removeEventListener("complete",__loadNext);
         if(_isSmallLoading)
         {
            _loc2_.removeEventListener("progress",__progress);
         }
         dispatchEvent(new Event("change"));
         tryLoadNext();
      }
      
      private function __progress(param1:LoaderEvent) : void
      {
         var _loc3_:int = _loaders.length;
         var _loc4_:int = completeCount;
         var _loc2_:Number = (_loc4_ / _loc3_ + 1 / _loc3_ * param1.loader.progress) * 100;
         UIModuleSmallLoading.Instance.progress = _loc2_;
         if(!UIModuleSmallLoading.Instance.isShow && _loc2_ < 100)
         {
            UIModuleSmallLoading.Instance.show();
         }
      }
      
      private function tryLoadNext() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _loaders.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(!_loaders[_loc2_].isComplete)
            {
               _loaders[_loc2_].addEventListener("complete",__loadNext);
               if(_isSmallLoading)
               {
                  _loaders[_loc2_].addEventListener("progress",__progress);
               }
               LoadResourceManager.Instance.startLoad(_loaders[_loc2_]);
               return;
            }
            _loc2_++;
         }
         reset();
         dispatchEvent(new Event("complete"));
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
      }
      
      private function __onClose(param1:Event) : void
      {
         reset();
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         dispatchEvent(new Event("close"));
      }
   }
}
