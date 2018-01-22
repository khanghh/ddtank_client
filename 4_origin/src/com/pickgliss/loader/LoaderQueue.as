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
      
      public function addLoader(param1:BaseLoader) : void
      {
         _loaders.push(param1);
      }
      
      public function start() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _loaders.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_loaders == null)
            {
               return;
            }
            _loaders[_loc2_].addEventListener("complete",__loadComplete);
            LoadResourceManager.Instance.startLoad(_loaders[_loc2_]);
            _loc2_++;
         }
         if(_loc1_ == 0)
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
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _loaders.length)
         {
            _loaders[_loc1_].removeEventListener("complete",__loadComplete);
            _loc1_++;
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
      
      private function __loadComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__loadComplete);
         if(isComplete)
         {
            removeEvent();
            dispatchEvent(new Event("complete"));
         }
      }
      
      public function get isComplete() : Boolean
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
   }
}
