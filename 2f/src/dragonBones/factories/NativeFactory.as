package dragonBones.factories{   import dragonBones.Armature;   import dragonBones.Slot;   import dragonBones.display.NativeFastSlot;   import dragonBones.display.NativeSlot;   import dragonBones.fast.FastArmature;   import dragonBones.fast.FastSlot;   import dragonBones.textures.ITextureAtlas;   import dragonBones.textures.NativeTextureAtlas;   import flash.display.MovieClip;   import flash.display.Shape;   import flash.display.Sprite;   import flash.geom.Rectangle;   import flash.utils.Dictionary;   import road7th.DDTAssetManager;      public class NativeFactory extends BaseFactory   {                   public var fillBitmapSmooth:Boolean;            public var useBitmapDataTexture:Boolean;            public function NativeFactory() { super(null); }
            override protected function generateTextureAtlas(content:Object, textureAtlasRawData:Object) : ITextureAtlas { return null; }
            override protected function generateArmature() : Armature { return null; }
            override protected function generateFastArmature() : FastArmature { return null; }
            override protected function generateFastSlot() : FastSlot { return null; }
            override protected function generateSlot() : Slot { return null; }
            override protected function generateDisplay(textureAtlas:Object, fullName:String, pivotX:Number, pivotY:Number) : Object { return null; }
            override protected function get textureAtlasDic() : Dictionary { return null; }
   }}