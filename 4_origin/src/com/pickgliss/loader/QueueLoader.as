package com.pickgliss.loader
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   [Event(name="complete",type="flash.events.Event")]
   [Event(name="change",type="flash.events.Event")]
   public class QueueLoader extends EventDispatcher implements Disposeable
   {
       
      
      private var _loaders:Vector.<BaseLoader>;
      
      public function QueueLoader()
      {
         super();
         _loaders = new Vector.<BaseLoader>();
      }
      
      public function addLoader(loader:BaseLoader) : void
      {
         _loaders.push(loader);
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
      
      public function start() : void
      {
         tryLoadNext();
      }
      
      private function __loadNext(event:LoaderEvent) : void
      {
         var loader:BaseLoader = event.loader as BaseLoader;
         loader.removeEventListener("complete",__loadNext);
         dispatchEvent(new Event("change"));
         tryLoadNext();
      }
      
      private function tryLoadNext() : void
      {
         var i:int = 0;
         if(_loaders == null)
         {
            return;
         }
         var loaderCount:int = _loaders.length;
         for(i = 0; i < loaderCount; )
         {
            if(!_loaders[i].isComplete)
            {
               _loaders[i].addEventListener("complete",__loadNext);
               LoadResourceManager.Instance.startLoad(_loaders[i]);
               return;
            }
            i++;
         }
         dispatchEvent(new Event("complete"));
      }
   }
}
