package gameCommon.view.control
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.LivingEvent;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import gameCommon.model.LocalPlayer;
   
   public class FightControlBar implements Disposeable
   {
      
      public static const LIVE:int = 0;
      
      public static const SOUL:int = 1;
       
      
      private var _statePool:Object;
      
      private var _self:LocalPlayer;
      
      private var _state:int;
      
      private var _container:DisplayObjectContainer;
      
      private var _current:ControlState;
      
      private var _next:ControlState;
      
      public function FightControlBar(self:LocalPlayer, container:DisplayObjectContainer)
      {
         _statePool = {};
         _self = self;
         _container = container;
         configUI();
         addEvent();
         super();
      }
      
      private static function getFightControlState(state:int, self:LocalPlayer) : ControlState
      {
         switch(int(state))
         {
            case 0:
               return new LiveState(self);
            case 1:
               return new SoulState(self);
         }
      }
      
      private function configUI() : void
      {
      }
      
      private function addEvent() : void
      {
      }
      
      private function __die(event:LivingEvent) : void
      {
         setState(1);
      }
      
      private function removeEvent() : void
      {
      }
      
      public function setState(state:int) : ControlState
      {
         var cs:* = null;
         if(!hasState(state))
         {
            cs = getFightControlState(state,_self);
            _next = cs;
            _statePool[state] = cs;
         }
         else
         {
            _next = _statePool[state];
         }
         if(_current == _next)
         {
            _next = null;
            return _current;
         }
         if(_current != null)
         {
            _current.leaving(leavingComplete);
         }
         else
         {
            enterNext(_next);
         }
         return _current;
      }
      
      public function get curControlState() : ControlState
      {
         return _current;
      }
      
      private function hasState(state:int) : Boolean
      {
         return _statePool.hasOwnProperty(String(state)) && _statePool[state];
      }
      
      private function enterNext(next:ControlState) : void
      {
         if(next)
         {
            _current = next;
         }
         if(_current)
         {
            _current.enter(_container);
         }
         _next = null;
      }
      
      private function __stateClicked(event:MouseEvent) : void
      {
         setState(1);
      }
      
      private function leavingComplete() : void
      {
         enterNext(_next);
      }
      
      private function enterComplete() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         var _loc3_:int = 0;
         var _loc2_:* = _statePool;
         for(var key in _statePool)
         {
            ObjectUtils.disposeObject(_statePool[key]);
            delete _statePool[key];
         }
      }
   }
}
