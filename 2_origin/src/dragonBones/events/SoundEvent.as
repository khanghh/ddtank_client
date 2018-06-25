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
      
      public function SoundEvent(type:String, cancelable:Boolean = false)
      {
         super(type,false,cancelable);
      }
      
      override public function clone() : Event
      {
         var event:SoundEvent = new SoundEvent(type,cancelable);
         event.armature = armature;
         event.animationState = animationState;
         event.sound = sound;
         return event;
      }
   }
}
