package character.action
{
   import flash.events.EventDispatcher;
   
   public class ActionSet extends EventDispatcher
   {
       
      
      private var _actions:Array;
      
      private var _currentAction:BaseAction;
      
      public function ActionSet(param1:XML = null)
      {
         super();
         this._actions = [];
         if(param1)
         {
            this.parseFromXml(param1);
         }
      }
      
      public function addAction(param1:BaseAction) : void
      {
         if(param1)
         {
            this._actions.push(param1);
         }
      }
      
      public function getAction(param1:String) : BaseAction
      {
         var _loc2_:BaseAction = null;
         for each(_loc2_ in this._actions)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get next() : BaseAction
      {
         var _loc1_:BaseAction = null;
         for each(_loc1_ in this._actions)
         {
            if(_loc1_.name == this._currentAction.name)
            {
               return _loc1_;
            }
         }
         return this._currentAction;
      }
      
      public function get currentAction() : BaseAction
      {
         if(this._currentAction)
         {
            return this._currentAction;
         }
         if(this._actions.length > 0)
         {
            this._currentAction = this._actions[0];
         }
         return this._currentAction;
      }
      
      public function get stringActions() : Array
      {
         var _loc2_:BaseAction = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this._actions)
         {
            _loc1_.push(_loc2_.name);
         }
         return _loc1_;
      }
      
      public function get actions() : Array
      {
         return this._actions;
      }
      
      public function removeAction(param1:String) : void
      {
         var _loc2_:BaseAction = null;
         for each(_loc2_ in this._actions)
         {
            if(_loc2_.name == param1)
            {
               this._actions.splice(this._actions.indexOf(_loc2_),1);
               _loc2_.dispose();
            }
         }
      }
      
      private function parseFromXml(param1:XML) : void
      {
      }
      
      public function toXml() : XML
      {
         var _loc3_:BaseAction = null;
         var _loc1_:XML = <actionSet></actionSet>;
         var _loc2_:int = 0;
         while(_loc2_ < this._actions.length)
         {
            _loc3_ = this._actions[_loc2_];
            _loc1_.appendChild(_loc3_.toXml());
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function dispose() : void
      {
         var _loc1_:BaseAction = null;
         for each(_loc1_ in this._actions)
         {
            _loc1_.dispose();
         }
      }
   }
}
