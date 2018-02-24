package character.action
{
   import flash.events.EventDispatcher;
   
   public class ActionSet extends EventDispatcher
   {
       
      
      private var _actions:Array;
      
      private var _currentAction:BaseAction;
      
      public function ActionSet(param1:XML = null){super();}
      
      public function addAction(param1:BaseAction) : void{}
      
      public function getAction(param1:String) : BaseAction{return null;}
      
      public function get next() : BaseAction{return null;}
      
      public function get currentAction() : BaseAction{return null;}
      
      public function get stringActions() : Array{return null;}
      
      public function get actions() : Array{return null;}
      
      public function removeAction(param1:String) : void{}
      
      private function parseFromXml(param1:XML) : void{}
      
      public function toXml() : XML{return null;}
      
      public function dispose() : void{}
   }
}
