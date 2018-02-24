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
      
      public function ExpTweenManager(){super();}
      
      public static function get Instance() : ExpTweenManager{return null;}
      
      private function init() : void{}
      
      public function appendTween(param1:TweenCore, param2:Number = 0, param3:Object = null) : void{}
      
      public function startTweens() : void{}
      
      public function completeTweens() : void{}
      
      public function speedRecover() : void{}
      
      public function deleteTweens() : void{}
   }
}
