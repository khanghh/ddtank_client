package dragonBones.objects{   import dragonBones.utils.DBDataUtil;   import flash.geom.ColorTransform;   import flash.geom.Point;   import flash.utils.Dictionary;      public final class Object3DataParser   {            private static var tempDragonBonesData:DragonBonesData;                   public function Object3DataParser() { super(); }
            public static function parseSkeletonData(rawData:Object, ifSkipAnimationData:Boolean = false, outputAnimationDictionary:Dictionary = null) : DragonBonesData { return null; }
            private static function parseArmatureData(armatureObject:Object, data:DragonBonesData, frameRate:uint, isGlobalData:Boolean, ifSkipAnimationData:Boolean, outputAnimationDictionary:Dictionary) : ArmatureData { return null; }
            private static function parseBoneData(boneObject:Object, isGlobalData:Boolean) : BoneData { return null; }
            private static function parseRectangleData(rectangleObject:Object) : RectangleData { return null; }
            private static function parseEllipseData(ellipseObject:Object) : EllipseData { return null; }
            private static function parseSlotData(slotObject:Object) : SlotData { return null; }
            private static function parseSkinData(skinObject:Object, data:DragonBonesData) : SkinData { return null; }
            private static function parseSkinSlotData(slotObject:Object, data:DragonBonesData) : SlotData { return null; }
            private static function parseDisplayData(displayObject:Object, data:DragonBonesData) : DisplayData { return null; }
            static function parseAnimationData(animationObject:Object, armatureData:ArmatureData, frameRate:uint, isGlobalData:Boolean) : AnimationData { return null; }
            private static function parseSlotTimeline(timelineObject:Object, duration:int, frameRate:uint, isGlobalData:Boolean) : SlotTimeline { return null; }
            private static function parseSlotFrame(frameObject:Object, frameRate:uint, isGlobalData:Boolean) : SlotFrame { return null; }
            private static function parseTransformTimeline(timelineObject:Object, duration:int, frameRate:uint, isGlobalData:Boolean) : TransformTimeline { return null; }
            private static function parseMainFrame(frameObject:Object, frameRate:uint) : Frame { return null; }
            private static function parseTransformFrame(frameObject:Object, frameRate:uint, isGlobalData:Boolean) : TransformFrame { return null; }
            private static function parseTimeline(timelineObject:Object, timeline:Timeline) : void { }
            private static function parseFrame(frameObject:Object, frame:Frame, frameRate:uint) : void { }
            private static function parseTransform(transformObject:Object, transform:DBTransform, pivot:Point = null) : void { }
            private static function parseColorTransform(colorTransformObject:Object, colorTransform:ColorTransform) : void { }
            private static function getBoolean(data:Object, key:String, defaultValue:Boolean) : Boolean { return false; }
            private static function getNumber(data:Object, key:String, defaultValue:Number) : Number { return 0; }
   }}