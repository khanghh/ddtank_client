package dragonBones.objects
{
   import dragonBones.textures.TextureData;
   import dragonBones.utils.DBDataUtil;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public final class XMLDataParser
   {
      
      private static var tempDragonBonesData:DragonBonesData;
       
      
      public function XMLDataParser(){super();}
      
      public static function parseTextureAtlasData(param1:XML, param2:Number = 1) : Object{return null;}
      
      public static function parseDragonBonesData(param1:XML) : DragonBonesData{return null;}
      
      private static function parseArmatureData(param1:XML, param2:uint) : ArmatureData{return null;}
      
      private static function parseBoneData(param1:XML) : BoneData{return null;}
      
      private static function parseSkinData(param1:XML) : SkinData{return null;}
      
      private static function parseSlotDisplayData(param1:XML) : SlotData{return null;}
      
      private static function parseSlotData(param1:XML) : SlotData{return null;}
      
      private static function parseDisplayData(param1:XML) : DisplayData{return null;}
      
      static function parseAnimationData(param1:XML, param2:uint) : AnimationData{return null;}
      
      private static function parseTransformTimeline(param1:XML, param2:int, param3:uint) : TransformTimeline{return null;}
      
      private static function parseSlotTimeline(param1:XML, param2:int, param3:uint) : SlotTimeline{return null;}
      
      private static function parseMainFrame(param1:XML, param2:uint) : Frame{return null;}
      
      private static function parseSlotFrame(param1:XML, param2:uint) : SlotFrame{return null;}
      
      private static function parseTransformFrame(param1:XML, param2:uint) : TransformFrame{return null;}
      
      private static function parseTimeline(param1:XML, param2:Timeline) : void{}
      
      private static function parseFrame(param1:XML, param2:Frame, param3:uint) : void{}
      
      private static function parseTransform(param1:XML, param2:DBTransform, param3:Point = null) : void{}
      
      private static function parseColorTransform(param1:XML, param2:ColorTransform) : void{}
      
      private static function getBoolean(param1:XML, param2:String, param3:Boolean) : Boolean{return false;}
      
      private static function getNumber(param1:XML, param2:String, param3:Number) : Number{return 0;}
   }
}
