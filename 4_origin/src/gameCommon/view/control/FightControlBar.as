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
      
      public function FightControlBar(param1:LocalPlayer, param2:DisplayObjectContainer)
      {
         _statePool = {};
         _self = param1;
         _container = param2;
         configUI();
         addEvent();
         super();
      }
      
      private static function getFightControlState(param1:int, param2:LocalPlayer) : ControlState
      {
         switch(int(param1))
         {
            case 0:
               return new LiveState(param2);
            case 1:
               return new SoulState(param2);
         }
      }
      
      private function configUI() : void
      {
      }
      
      private function addEvent() : void
      {
      }
      
      private function __die(param1:LivingEvent) : void
      {
         setState(1);
      }
      
      private function removeEvent() : void
      {
      }
      
      public function setState(param1:int) : ControlState
      {
         var _loc2_:* = null;
         if(!hasState(param1))
         {
            _loc2_ = getFightControlState(param1,_self);
            _next = _loc2_;
            _statePool[param1] = _loc2_;
         }
         else
         {
            _next = _statePool[param1];
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
      
      private function hasState(param1:int) : Boolean
      {
         return _statePool.hasOwnProperty(String(param1)) && _statePool[param1];
      }
      
      private function enterNext(param1:ControlState) : void
      {
         if(param1)
         {
            _current = param1;
         }
         if(_current)
         {
            _current.enter(_container);
         }
         _next = null;
      }
      
      private function __stateClicked(param1:MouseEvent) : void
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
         for(var _loc1_ in _statePool)
         {
            ObjectUtils.disposeObject(_statePool[_loc1_]);
            delete _statePool[_loc1_];
         }
      }
   }
}
