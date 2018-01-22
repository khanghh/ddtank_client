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
      
      public function FrameEvent(param1:String, param2:Boolean = false)
      {
         super(param1,false,param2);
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
         var _loc1_:FrameEvent = new FrameEvent(type,cancelable);
         _loc1_.animationState = animationState;
         _loc1_.bone = bone;
         _loc1_.animationState = animationState;
         _loc1_.frameLabel = frameLabel;
         return _loc1_;
      }
   }
}
