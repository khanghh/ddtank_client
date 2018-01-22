package dragonBones.factories
{
   import dragonBones.Armature;
   import dragonBones.Slot;
   import dragonBones.display.StarlingFastSlot;
   import dragonBones.display.StarlingSlot;
   import dragonBones.fast.FastArmature;
   import dragonBones.fast.FastSlot;
   import dragonBones.textures.ITextureAtlas;
   import dragonBones.textures.StarlingTextureAtlas;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import road7th.DDTAssetManager;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.SubTexture;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   public class StarlingFactory extends BaseFactory
   {
       
      
      public var generateMipMaps:Boolean;
      
      public var optimizeForRenderToTexture:Boolean;
      
      public var scaleForTexture:Number;
      
      public function StarlingFactory(){super(null);}
      
      override protected function generateTextureAtlas(param1:Object, param2:Object) : ITextureAtlas{return null;}
      
      override protected function generateArmature() : Armature{return null;}
      
      override protected function generateFastArmature() : FastArmature{return null;}
      
      override protected function generateSlot() : Slot{return null;}
      
      override protected function generateFastSlot() : FastSlot{return null;}
      
      override protected function generateDisplay(param1:Object, param2:String, param3:Number, param4:Number) : Object{return null;}
      
      private function getNearest2N(param1:uint) : uint{return null;}
      
      override protected function get textureAtlasDic() : Dictionary{return null;}
   }
}
