package gameCommon.view.smallMap
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.LivingEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import gameCommon.GameControl;
   import gameCommon.model.Living;
   import gameCommon.model.SimpleBoss;
   import gameCommon.model.SmallEnemy;
   import gameCommon.model.TurnedLiving;
   
   public class SmallMapPlayer extends Sprite
   {
       
      
      private var _info:Living;
      
      private var _player:MovieClip;
      
      public function SmallMapPlayer(param1:Living){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      public function dispose() : void{}
      
      private function createPlayer(param1:MovieClip) : void{}
      
      private function __change(param1:LivingEvent) : void{}
      
      private function __hide(param1:LivingEvent) : void{}
      
      private function __die(param1:LivingEvent) : void{}
   }
}
