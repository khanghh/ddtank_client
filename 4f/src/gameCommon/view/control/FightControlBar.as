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
      
      public function FightControlBar(param1:LocalPlayer, param2:DisplayObjectContainer){super();}
      
      private static function getFightControlState(param1:int, param2:LocalPlayer) : ControlState{return null;}
      
      private function configUI() : void{}
      
      private function addEvent() : void{}
      
      private function __die(param1:LivingEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function setState(param1:int) : ControlState{return null;}
      
      private function hasState(param1:int) : Boolean{return false;}
      
      private function enterNext(param1:ControlState) : void{}
      
      private function __stateClicked(param1:MouseEvent) : void{}
      
      private function leavingComplete() : void{}
      
      private function enterComplete() : void{}
      
      public function dispose() : void{}
   }
}
