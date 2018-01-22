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
      
      public function addAnimate(param1:AchieveAnimation) : void
      {
         _animates.push(param1);
         if(param1.interval <= 0)
         {
            playAnimate(param1);
         }
         if(!_started)
         {
            addEventListener("enterFrame",__onFrame);
            _started = true;
         }
      }
      
      private function playAnimate(param1:AchieveAnimation) : void
      {
         var _loc2_:* = null;
         param1.play();
         addChild(param1);
         param1.addEventListener("complete",__animateComplete);
         _displays.unshift(param1);
         if(_displays.length > 4)
         {
            _loc2_ = _displays.pop();
            removeAnimate(_loc2_);
            ObjectUtils.disposeObject(_loc2_);
         }
         drawLayer();
      }
      
      private function __animateComplete(param1:Event) : void
      {
         var _loc2_:AchieveAnimation = param1.currentTarget as AchieveAnimation;
         _loc2_.removeEventListener("complete",__animateComplete);
         removeAnimate(_loc2_);
         ObjectUtils.disposeObject(_loc2_);
      }
      
      private function __onFrame(param1:Event) : void
      {
         var _loc3_:int = getTimer();
         var _loc5_:int = 0;
         var _loc4_:* = _animates;
         for each(var _loc2_ in _animates)
         {
            if(!_loc2_.show && _loc2_.delay >= _loc3_)
            {
               playAnimate(_loc2_);
            }
         }
      }
      
      public function removeAnimate(param1:AchieveAnimation) : void
      {
         var _loc2_:int = _animates.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _animates.splice(_loc2_,1);
         }
         if(param1.show)
         {
            _loc2_ = _displays.indexOf(param1);
            if(_loc2_ >= 0)
            {
               _displays.splice(_loc2_,1);
            }
         }
         if(_animates.length <= 0)
         {
            removeEventListener("enterFrame",__onFrame);
            _started = false;
         }
      }
      
      public function rePlayAnimate(param1:AchieveAnimation) : void
      {
      }
      
      public function getAnimate(param1:int) : AchieveAnimation
      {
         var _loc4_:int = 0;
         var _loc3_:* = _animates;
         for each(var _loc2_ in _animates)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function drawLayer() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _displays.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_loc2_ == 0)
            {
               _displays[_loc2_].y = -_displays[_loc2_].height;
            }
            else
            {
               _displays[_loc2_].y = _displays[_loc2_ - 1].y - _displays[_loc2_].height - 4;
            }
            _loc2_++;
         }
      }
   }
}
