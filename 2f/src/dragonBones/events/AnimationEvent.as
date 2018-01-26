package dragonBones.events
{
   import dragonBones.Armature;
   import flash.events.Event;
   
   public class AnimationEvent extends Event
   {
      
      public static const FADE_IN:String = "fadeIn";
      
      public static const FADE_OUT:String = "fadeOut";
      
      public static const START:String = "start";
      
      public static const COMPLETE:String = "complete";
      
      public static const LOOP_COMPLETE:String = "loopComplete";
      
      public static const FADE_IN_COMPLETE:String = "fadeInComplete";
      
      public static const FADE_OUT_COMPLETE:String = "fadeOutComplete";
       
      
      public var animationState:Object;
      
      public function AnimationEvent(param1:String, param2:Boolean = false){super(null,null,null);}
      
      public static function get MOVEMENT_CHANGE() : String{return null;}
      
      public function get movementID() : String{return null;}
      
      public function get armature() : Armature{return null;}
      
      public function get animationName() : String{return null;}
      
      override public function clone() : Event{return null;}
   }
}
