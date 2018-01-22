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
      
      public function addLoader(param1:BaseLoader) : void
      {
         _loaders.push(param1);
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
      
      public function start() : void
      {
         tryLoadNext();
      }
      
      private function __loadNext(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.loader as BaseLoader;
         _loc2_.removeEventListener("complete",__loadNext);
         dispatchEvent(new Event("change"));
         tryLoadNext();
      }
      
      private function tryLoadNext() : void
      {
         var _loc2_:int = 0;
         if(_loaders == null)
         {
            return;
         }
         var _loc1_:int = _loaders.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(!_loaders[_loc2_].isComplete)
            {
               _loaders[_loc2_].addEventListener("complete",__loadNext);
               LoadResourceManager.Instance.startLoad(_loaders[_loc2_]);
               return;
            }
            _loc2_++;
         }
         dispatchEvent(new Event("complete"));
      }
   }
}
