package gameCommon.view{   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;   import flash.events.Event;   import flash.utils.getTimer;      public class FightAchievBar extends Sprite implements Disposeable   {                   private var _animates:Vector.<AchieveAnimation>;            private var _displays:Vector.<AchieveAnimation>;            private var _started:Boolean = false;            public function FightAchievBar() { super(); }
            public function dispose() : void { }
            public function addAnimate(animate:AchieveAnimation) : void { }
            private function playAnimate(animate:AchieveAnimation) : void { }
            private function __animateComplete(event:Event) : void { }
            private function __onFrame(event:Event) : void { }
            public function removeAnimate(animate:AchieveAnimation) : void { }
            public function rePlayAnimate(animate:AchieveAnimation) : void { }
            public function getAnimate(id:int) : AchieveAnimation { return null; }
            private function drawLayer() : void { }
   }}