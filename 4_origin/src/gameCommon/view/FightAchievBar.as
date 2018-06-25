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
      
      public function FightAchievBar()
      {
         _animates = new Vector.<AchieveAnimation>();
         _displays = new Vector.<AchieveAnimation>();
         super();
      }
      
      public function dispose() : void
      {
         removeEventListener("enterFrame",__onFrame);
      }
      
      public function addAnimate(animate:AchieveAnimation) : void
      {
         _animates.push(animate);
         if(animate.interval <= 0)
         {
            playAnimate(animate);
         }
         if(!_started)
         {
            addEventListener("enterFrame",__onFrame);
            _started = true;
         }
      }
      
      private function playAnimate(animate:AchieveAnimation) : void
      {
         var a:* = null;
         animate.play();
         addChild(animate);
         animate.addEventListener("complete",__animateComplete);
         _displays.unshift(animate);
         if(_displays.length > 4)
         {
            a = _displays.pop();
            removeAnimate(a);
            ObjectUtils.disposeObject(a);
         }
         drawLayer();
      }
      
      private function __animateComplete(event:Event) : void
      {
         var animate:AchieveAnimation = event.currentTarget as AchieveAnimation;
         animate.removeEventListener("complete",__animateComplete);
         removeAnimate(animate);
         ObjectUtils.disposeObject(animate);
      }
      
      private function __onFrame(event:Event) : void
      {
         var now:int = getTimer();
         var _loc5_:int = 0;
         var _loc4_:* = _animates;
         for each(var animate in _animates)
         {
            if(!animate.show && animate.delay >= now)
            {
               playAnimate(animate);
            }
         }
      }
      
      public function removeAnimate(animate:AchieveAnimation) : void
      {
         var idx:int = _animates.indexOf(animate);
         if(idx >= 0)
         {
            _animates.splice(idx,1);
         }
         if(animate.show)
         {
            idx = _displays.indexOf(animate);
            if(idx >= 0)
            {
               _displays.splice(idx,1);
            }
         }
         if(_animates.length <= 0)
         {
            removeEventListener("enterFrame",__onFrame);
            _started = false;
         }
      }
      
      public function rePlayAnimate(animate:AchieveAnimation) : void
      {
      }
      
      public function getAnimate(id:int) : AchieveAnimation
      {
         var _loc4_:int = 0;
         var _loc3_:* = _animates;
         for each(var animate in _animates)
         {
            if(animate.id == id)
            {
               return animate;
            }
         }
         return null;
      }
      
      private function drawLayer() : void
      {
         var i:int = 0;
         var len:int = _displays.length;
         for(i = 0; i < len; )
         {
            if(i == 0)
            {
               _displays[i].y = -_displays[i].height;
            }
            else
            {
               _displays[i].y = _displays[i - 1].y - _displays[i].height - 4;
            }
            i++;
         }
      }
   }
}
