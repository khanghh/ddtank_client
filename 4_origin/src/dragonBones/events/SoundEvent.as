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
      
      public function SoundEvent(param1:String, param2:Boolean = false)
      {
         super(param1,false,param2);
      }
      
      override public function clone() : Event
      {
         var _loc1_:SoundEvent = new SoundEvent(type,cancelable);
         _loc1_.armature = armature;
         _loc1_.animationState = animationState;
         _loc1_.sound = sound;
         return _loc1_;
      }
   }
}
