package dragonBones.utils{   import dragonBones.objects.AnimationData;   import dragonBones.objects.ArmatureData;   import dragonBones.objects.BoneData;   import dragonBones.objects.DBTransform;   import dragonBones.objects.Frame;   import dragonBones.objects.SkinData;   import dragonBones.objects.SlotData;   import dragonBones.objects.SlotFrame;   import dragonBones.objects.SlotTimeline;   import dragonBones.objects.TransformFrame;   import dragonBones.objects.TransformTimeline;   import flash.geom.Matrix;   import flash.geom.Point;      public final class DBDataUtil   {                   public function DBDataUtil() { super(); }
            public static function transformArmatureData(armatureData:ArmatureData) : void { }
            public static function transformArmatureDataAnimations(armatureData:ArmatureData) : void { }
            public static function transformRelativeAnimationData(animationData:AnimationData, armatureData:ArmatureData) : void { }
            public static function transformAnimationData(animationData:AnimationData, armatureData:ArmatureData, isGlobalData:Boolean) : void { }
            private static function setFrameTransform(animationData:AnimationData, armatureData:ArmatureData, boneData:BoneData, frame:TransformFrame) : void { }
            private static function getTimelineTransform(timeline:TransformTimeline, position:int, retult:DBTransform, isGlobal:Boolean) : void { }
            public static function addHideTimeline(animationData:AnimationData, armatureData:ArmatureData) : void { }
   }}