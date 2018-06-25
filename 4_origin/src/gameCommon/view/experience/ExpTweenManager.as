package gameCommon.view.experience
{
   import com.greensock.TimelineMax;
   import com.greensock.core.TweenCore;
   
   public class ExpTweenManager
   {
      
      private static var _instance:ExpTweenManager;
       
      
      public var isPlaying:Boolean;
      
      private var _timeline:TimelineMax;
      
      private var _tweens:Vector.<TweenCore>;
      
      public function ExpTweenManager()
      {
         super();
         init();
      }
      
      public static function get Instance() : ExpTweenManager
      {
         if(!_instance)
         {
            _instance = new ExpTweenManager();
         }
         return _instance;
      }
      
      private function init() : void
      {
         _timeline = new TimelineMax();
         _timeline.autoRemoveChildren = true;
         _timeline.stop();
         _tweens = new Vector.<TweenCore>();
      }
      
      public function appendTween(tween:TweenCore, offset:Number = 0, obj:Object = null) : void
      {
         _tweens.push(tween);
         _timeline.append(tween,offset);
         if(obj != null)
         {
            if(obj.onStart != null && obj.onStartParams != null)
            {
               tween.vars.onStart = obj.onStart;
               tween.vars.onStartParams = obj.onStartParams;
            }
            else if(obj.onStart != null)
            {
               tween.vars.onStart = obj.onStart;
            }
            if(obj.onComplete != null && obj.onCompleteParams != null)
            {
               tween.vars.onComplete = obj.onComplete;
               tween.vars.onCompleteParams = obj.onCompleteParams;
            }
            else if(obj.onComplete != null)
            {
               tween.vars.onComplete = obj.onComplete;
            }
         }
      }
      
      public function startTweens() : void
      {
         _timeline.play();
      }
      
      public function completeTweens() : void
      {
         _timeline.timeScale = 100;
      }
      
      public function speedRecover() : void
      {
         _timeline.timeScale = 1;
      }
      
      public function deleteTweens() : void
      {
         var core:* = null;
         _timeline.stop();
         while(_tweens.length > 0)
         {
            core = _tweens.shift();
            core.kill();
            core = null;
         }
         _tweens = new Vector.<TweenCore>();
         _timeline.kill();
         _timeline.clear();
         _timeline.totalProgress = 0;
         _timeline = new TimelineMax();
      }
   }
}
