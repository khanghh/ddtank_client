package com.pickgliss.loader
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class LoaderQueue extends EventDispatcher
   {
       
      
      private var _loaders:Vector.<BaseLoader>;
      
      public function LoaderQueue()
      {
         super();
         _loaders = new Vector.<BaseLoader>();
      }
      
      public function addLoader(loader:BaseLoader) : void
      {
         _loaders.push(loader);
      }
      
      public function start() : void
      {
         var i:int = 0;
         var count:int = _loaders.length;
         for(i = 0; i < count; )
         {
            if(_loaders == null)
            {
               return;
            }
            _loaders[i].addEventListener("complete",__loadComplete);
            LoadResourceManager.Instance.startLoad(_loaders[i]);
            i++;
         }
         if(count == 0)
         {
            dispatchEvent(new Event("complete"));
         }
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
            _loaders[i].removeEventListener("complete",__loadComplete);
            i++;
         }
      }
      
      public function get length() : int
      {
         return _loaders.length;
      }
      
      public function get loaders() : Vector.<BaseLoader>
      {
         return _loaders;
      }
      
      private function __loadComplete(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("complete",__loadComplete);
         if(isComplete)
         {
            removeEvent();
            dispatchEvent(new Event("complete"));
         }
      }
      
      public function get isComplete() : Boolean
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
   }
}
