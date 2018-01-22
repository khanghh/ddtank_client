package dragonBones.utils
{
   import dragonBones.objects.AnimationData;
   import dragonBones.objects.ArmatureData;
   import dragonBones.objects.BoneData;
   import dragonBones.objects.DBTransform;
   import dragonBones.objects.Frame;
   import dragonBones.objects.SkinData;
   import dragonBones.objects.SlotData;
   import dragonBones.objects.SlotFrame;
   import dragonBones.objects.SlotTimeline;
   import dragonBones.objects.TransformFrame;
   import dragonBones.objects.TransformTimeline;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public final class DBDataUtil
   {
       
      
      public function DBDataUtil(){super();}
      
      public static function transformArmatureData(param1:ArmatureData) : void{}
      
      public static function transformArmatureDataAnimations(param1:ArmatureData) : void{}
      
      public static function transformRelativeAnimationData(param1:AnimationData, param2:ArmatureData) : void{}
      
      public static function transformAnimationData(param1:AnimationData, param2:ArmatureData, param3:Boolean) : void{}
      
      private static function setFrameTransform(param1:AnimationData, param2:ArmatureData, param3:BoneData, param4:TransformFrame) : void{}
      
      private static function getTimelineTransform(param1:TransformTimeline, param2:int, param3:DBTransform, param4:Boolean) : void{}
      
      public static function addHideTimeline(param1:AnimationData, param2:ArmatureData) : void{}
   }
}
