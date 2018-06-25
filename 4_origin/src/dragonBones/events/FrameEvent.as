package dragonBones.events
{
   import dragonBones.Armature;
   import flash.events.Event;
   
   public class FrameEvent extends Event
   {
      
      public static const ANIMATION_FRAME_EVENT:String = "animationFrameEvent";
      
      public static const BONE_FRAME_EVENT:String = "boneFrameEvent";
       
      
      public var frameLabel:String;
      
      public var bone:Object;
      
      public var animationState:Object;
      
      public function FrameEvent(type:String, cancelable:Boolean = false)
      {
         super(type,false,cancelable);
      }
      
      public static function get MOVEMENT_FRAME_EVENT() : String
      {
         return "animationFrameEvent";
      }
      
      public function get armature() : Armature
      {
         return target as Armature;
      }
      
      override public function clone() : Event
      {
         var event:FrameEvent = new FrameEvent(type,cancelable);
         event.animationState = animationState;
         event.bone = bone;
         event.animationState = animationState;
         event.frameLabel = frameLabel;
         return event;
      }
   }
}
