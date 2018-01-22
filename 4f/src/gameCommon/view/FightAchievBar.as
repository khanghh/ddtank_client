package gameCommon.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class FightAchievBar extends Sprite implements Disposeable
   {
       
      
      private var _animates:Vector.<AchieveAnimation>;
      
      private var _displays:Vector.<AchieveAnimation>;
      
      private var _started:Boolean = false;
      
      public function FightAchievBar(){super();}
      
      public function dispose() : void{}
      
      public function addAnimate(param1:AchieveAnimation) : void{}
      
      private function playAnimate(param1:AchieveAnimation) : void{}
      
      private function __animateComplete(param1:Event) : void{}
      
      private function __onFrame(param1:Event) : void{}
      
      public function removeAnimate(param1:AchieveAnimation) : void{}
      
      public function rePlayAnimate(param1:AchieveAnimation) : void{}
      
      public function getAnimate(param1:int) : AchieveAnimation{return null;}
      
      private function drawLayer() : void{}
   }
}
