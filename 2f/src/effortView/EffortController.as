package effortView
{
   import ddt.manager.EffortManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class EffortController extends EventDispatcher
   {
       
      
      private var _currentRightViewType:int;
      
      private var _currentViewType:int;
      
      private var _isSelf:Boolean;
      
      public function EffortController(){super();}
      
      public function set isSelf(param1:Boolean) : void{}
      
      public function set currentRightViewType(param1:int) : void{}
      
      public function get currentRightViewType() : int{return 0;}
      
      public function set currentViewType(param1:int) : void{}
      
      public function get currentViewType() : int{return 0;}
      
      private function updateRightView(param1:int) : void{}
      
      private function updateView(param1:int) : void{}
      
      private function updateTempRightView(param1:int) : void{}
      
      private function updateTempView(param1:int) : void{}
   }
}
