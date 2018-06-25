package dragonBones.objects{   import dragonBones.textures.TextureData;   import dragonBones.utils.DBDataUtil;   import flash.geom.ColorTransform;   import flash.geom.Point;   import flash.geom.Rectangle;      public final class ObjectDataParser   {            private static var tempDragonBonesData:DragonBonesData;                   public function ObjectDataParser() { super(); }
            public static function parseTextureAtlasData(rawData:Object, scale:Number = 1) : Object { return null; }
            public static function parseDragonBonesData(rawDataToParse:Object) : DragonBonesData { return null; }
            private static function parseArmatureData(armatureDataToParse:Object, frameRate:uint) : ArmatureData { return null; }
            private static function parseBoneData(boneObject:Object) : BoneData { return null; }
            private static function parseSkinData(skinObject:Object) : SkinData { return null; }
            private static function parseSlotDisplayData(slotObject:Object) : SlotData { return null; }
            private static function parseSlotData(slotObject:Object) : SlotData { return null; }
            private static function parseDisplayData(displayObject:Object) : DisplayData { return null; }
            static function parseAnimationData(animationObject:Object, frameRate:uint) : AnimationData { return null; }
            private static function parseTransformTimeline(timelineObject:Object, duration:int, frameRate:uint) : TransformTimeline { return null; }
            private static function parseSlotTimeline(timelineObject:Object, duration:int, frameRate:uint) : SlotTimeline { return null; }
            private static function parseMainFrame(frameObject:Object, frameRate:uint) : Frame { return null; }
            private static function parseTransformFrame(frameObject:Object, frameRate:uint) : TransformFrame { return null; }
            private static function parseSlotFrame(frameObject:Object, frameRate:uint) : SlotFrame { return null; }
            private static function parseTimeline(timelineObject:Object, outputTimeline:Timeline) : void { }
            private static function parseFrame(frameObject:Object, outputFrame:Frame, frameRate:uint) : void { }
            private static function parseTransform(transformObject:Object, transform:DBTransform, pivot:Point = null) : void { }
            private static function parseColorTransform(colorTransformObject:Object, colorTransform:ColorTransform) : void { }
            private static function getBoolean(data:Object, key:String, defaultValue:Boolean) : Boolean { return false; }
            private static function getNumber(data:Object, key:String, defaultValue:Number) : Number { return 0; }
   }}