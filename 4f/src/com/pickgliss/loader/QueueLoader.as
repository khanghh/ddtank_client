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
      
      public function QueueLoader(){super();}
      
      public function addLoader(param1:BaseLoader) : void{}
      
      public function dispose() : void{}
      
      public function removeEvent() : void{}
      
      public function isAllComplete() : Boolean{return false;}
      
      public function isLoading() : Boolean{return false;}
      
      public function get completeCount() : int{return 0;}
      
      public function get length() : int{return 0;}
      
      public function get loaders() : Vector.<BaseLoader>{return null;}
      
      public function start() : void{}
      
      private function __loadNext(param1:LoaderEvent) : void{}
      
      private function tryLoadNext() : void{}
   }
}
