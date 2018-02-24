package dragonBones.events
{
   import dragonBones.Armature;
   import dragonBones.animation.AnimationState;
   import flash.events.Event;
   
   public class SoundEvent extends Event
   {
      
      public static const SOUND:String = "sound";
       
      
      public var armature:Armature;
      
      public var animationState:AnimationState;
      
      public var sound:String;
      
      public function SoundEvent(param1:String, param2:Boolean = false){super(null,null,null);}
      
      override public function clone() : Event{return null;}
   }
}
