package dragonBones.objects{   import dragonBones.textures.TextureData;   import dragonBones.utils.DBDataUtil;   import flash.geom.ColorTransform;   import flash.geom.Point;   import flash.geom.Rectangle;      public final class XMLDataParser   {            private static var tempDragonBonesData:DragonBonesData;                   public function XMLDataParser() { super(); }
            public static function parseTextureAtlasData(rawData:XML, scale:Number = 1) : Object { return null; }
            public static function parseDragonBonesData(rawData:XML) : DragonBonesData { return null; }
            private static function parseArmatureData(armatureXML:XML, frameRate:uint) : ArmatureData { return null; }
            private static function parseBoneData(boneXML:XML) : BoneData { return null; }
            private static function parseSkinData(skinXML:XML) : SkinData { return null; }
            private static function parseSlotDisplayData(slotXML:XML) : SlotData { return null; }
            private static function parseSlotData(slotXML:XML) : SlotData { return null; }
            private static function parseDisplayData(displayXML:XML) : DisplayData { return null; }
            static function parseAnimationData(animationXML:XML, frameRate:uint) : AnimationData { return null; }
            private static function parseTransformTimeline(timelineXML:XML, duration:int, frameRate:uint) : TransformTimeline { return null; }
            private static function parseSlotTimeline(timelineXML:XML, duration:int, frameRate:uint) : SlotTimeline { return null; }
            private static function parseMainFrame(frameXML:XML, frameRate:uint) : Frame { return null; }
            private static function parseSlotFrame(frameXML:XML, frameRate:uint) : SlotFrame { return null; }
            private static function parseTransformFrame(frameXML:XML, frameRate:uint) : TransformFrame { return null; }
            private static function parseTimeline(timelineXML:XML, timeline:Timeline) : void { }
            private static function parseFrame(frameXML:XML, frame:Frame, frameRate:uint) : void { }
            private static function parseTransform(transformXML:XML, transform:DBTransform, pivot:Point = null) : void { }
            private static function parseColorTransform(colorTransformXML:XML, colorTransform:ColorTransform) : void { }
            private static function getBoolean(data:XML, key:String, defaultValue:Boolean) : Boolean { return false; }
            private static function getNumber(data:XML, key:String, defaultValue:Number) : Number { return 0; }
   }}