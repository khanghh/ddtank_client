package dragonBones.objects{   import dragonBones.utils.DBDataUtil;   import flash.geom.ColorTransform;   import flash.geom.Point;   import flash.utils.Dictionary;      public final class XML3DataParser   {            private static var tempDragonBonesData:DragonBonesData;                   public function XML3DataParser() { super(); }
            public static function parseSkeletonData(rawData:XML, ifSkipAnimationData:Boolean = false, outputAnimationDictionary:Dictionary = null) : DragonBonesData { return null; }
            private static function parseArmatureData(armatureXML:XML, data:DragonBonesData, frameRate:uint, isGlobalData:Boolean, ifSkipAnimationData:Boolean, outputAnimationDictionary:Dictionary) : ArmatureData { return null; }
            private static function parseBoneData(boneXML:XML, isGlobalData:Boolean) : BoneData { return null; }
            private static function parseRectangleData(rectangleXML:XML) : RectangleData { return null; }
            private static function parseEllipseData(ellipseXML:XML) : EllipseData { return null; }
            private static function parseSlotData(slotXML:XML) : SlotData { return null; }
            private static function parseSkinData(skinXML:XML, data:DragonBonesData) : SkinData { return null; }
            private static function parseSkinSlotData(slotXML:XML, data:DragonBonesData) : SlotData { return null; }
            private static function parseDisplayData(displayXML:XML, data:DragonBonesData) : DisplayData { return null; }
            static function parseAnimationData(animationXML:XML, armatureData:ArmatureData, frameRate:uint, isGlobalData:Boolean) : AnimationData { return null; }
            private static function parseSlotTimeline(timelineXML:XML, duration:int, frameRate:uint, isGlobalData:Boolean) : SlotTimeline { return null; }
            private static function parseSlotFrame(frameXML:XML, frameRate:uint, isGlobalData:Boolean) : SlotFrame { return null; }
            private static function parseTransformTimeline(timelineXML:XML, duration:int, frameRate:uint, isGlobalData:Boolean) : TransformTimeline { return null; }
            private static function parseMainFrame(frameXML:XML, frameRate:uint) : Frame { return null; }
            private static function parseTransformFrame(frameXML:XML, frameRate:uint, isGlobalData:Boolean) : TransformFrame { return null; }
            private static function parseTimeline(timelineXML:XML, timeline:Timeline) : void { }
            private static function parseFrame(frameXML:XML, frame:Frame, frameRate:uint) : void { }
            private static function parseTransform(transformXML:XML, transform:DBTransform, pivot:Point = null) : void { }
            private static function parseColorTransform(colorTransformXML:XML, colorTransform:ColorTransform) : void { }
            private static function getBoolean(data:XML, key:String, defaultValue:Boolean) : Boolean { return false; }
            private static function getNumber(data:XML, key:String, defaultValue:Number) : Number { return 0; }
   }}