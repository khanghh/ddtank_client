package com.greensock
{
   import com.greensock.core.SimpleTimeline;
   import com.greensock.core.TweenCore;
   
   public final class OverwriteManager
   {
      
      public static const version:Number = 6.1;
      
      public static const NONE:int = 0;
      
      public static const ALL_IMMEDIATE:int = 1;
      
      public static const AUTO:int = 2;
      
      public static const CONCURRENT:int = 3;
      
      public static const ALL_ONSTART:int = 4;
      
      public static const PREEXISTING:int = 5;
      
      public static var mode:int;
      
      public static var enabled:Boolean;
       
      
      public function OverwriteManager()
      {
         super();
      }
      
      public static function init(defaultMode:int = 2) : int
      {
         TweenLite.overwriteManager = OverwriteManager;
         mode = defaultMode;
         enabled = true;
         return mode;
      }
      
      public static function manageOverwrites(tween:TweenLite, props:Object, targetTweens:Array, mode:int) : Boolean
      {
         var changed:Boolean = false;
         var curTween:* = null;
         var i:* = 0;
         var l:int = 0;
         var cousin:* = null;
         var cousinStartTime:Number = NaN;
         var timeline:* = null;
         var combinedTimeScale:Number = NaN;
         if(mode >= 4)
         {
            l = targetTweens.length;
            for(i = 0; i < l; )
            {
               curTween = targetTweens[i];
               if(curTween != tween)
               {
                  if(curTween.setEnabled(false,false))
                  {
                     changed = true;
                  }
               }
               else if(mode == 5)
               {
                  break;
               }
               i++;
            }
            return changed;
         }
         var startTime:Number = tween.cachedStartTime + 1.0e-10;
         var overlaps:Array = [];
         var cousins:Array = [];
         var cCount:int = 0;
         var oCount:int = 0;
         i = int(targetTweens.length);
         while(true)
         {
            i--;
            if(i <= -1)
            {
               break;
            }
            curTween = targetTweens[i];
            if(!(curTween == tween || curTween.gc || !curTween.initted && startTime - curTween.cachedStartTime <= 2.0e-10))
            {
               if(curTween.timeline != tween.timeline)
               {
                  if(!getGlobalPaused(curTween))
                  {
                     cCount++;
                     cousins[cCount] = curTween;
                  }
               }
               else if(curTween.cachedStartTime <= startTime && curTween.cachedStartTime + curTween.totalDuration + 1.0e-10 > startTime && !curTween.cachedPaused && !(tween.cachedDuration == 0 && startTime - curTween.cachedStartTime <= 2.0e-10))
               {
                  oCount++;
                  overlaps[oCount] = curTween;
               }
            }
         }
         if(cCount != 0)
         {
            combinedTimeScale = tween.cachedTimeScale;
            var combinedStartTime:* = startTime;
            timeline = tween.timeline;
            while(timeline)
            {
               combinedTimeScale = combinedTimeScale * timeline.cachedTimeScale;
               combinedStartTime = Number(combinedStartTime + timeline.cachedStartTime);
               timeline = timeline.timeline;
            }
            startTime = combinedTimeScale * combinedStartTime;
            i = cCount;
            while(true)
            {
               i--;
               if(i <= -1)
               {
                  break;
               }
               cousin = cousins[i];
               combinedTimeScale = cousin.cachedTimeScale;
               combinedStartTime = Number(cousin.cachedStartTime);
               timeline = cousin.timeline;
               while(timeline)
               {
                  combinedTimeScale = combinedTimeScale * timeline.cachedTimeScale;
                  combinedStartTime = Number(combinedStartTime + timeline.cachedStartTime);
                  timeline = timeline.timeline;
               }
               cousinStartTime = combinedTimeScale * combinedStartTime;
               if(cousinStartTime <= startTime && (cousinStartTime + cousin.totalDuration * combinedTimeScale + 1.0e-10 > startTime || cousin.cachedDuration == 0))
               {
                  oCount++;
                  overlaps[oCount] = cousin;
               }
            }
         }
         if(oCount == 0)
         {
            return changed;
         }
         i = oCount;
         if(mode == 2)
         {
            while(true)
            {
               i--;
               if(i <= -1)
               {
                  break;
               }
               curTween = overlaps[i];
               if(curTween.killVars(props))
               {
                  changed = true;
               }
               if(curTween.cachedPT1 == null && curTween.initted)
               {
                  curTween.setEnabled(false,false);
               }
            }
         }
         else
         {
            while(true)
            {
               i--;
               if(i <= -1)
               {
                  break;
               }
               if(TweenLite(overlaps[i]).setEnabled(false,false))
               {
                  changed = true;
               }
            }
         }
         return changed;
      }
      
      public static function getGlobalPaused(tween:TweenCore) : Boolean
      {
         var paused:Boolean = false;
         while(tween)
         {
            if(tween.cachedPaused)
            {
               paused = true;
               break;
            }
            tween = tween.timeline;
         }
         return paused;
      }
   }
}
