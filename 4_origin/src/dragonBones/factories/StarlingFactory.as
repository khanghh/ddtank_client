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
      
      public function StarlingFactory()
      {
         super(this);
         scaleForTexture = 1;
      }
      
      override protected function generateTextureAtlas(content:Object, textureAtlasRawData:Object) : ITextureAtlas
      {
         var texture:* = null;
         var bitmapData:* = null;
         var width:int = 0;
         var height:int = 0;
         var movieClip:* = null;
         if(content is BitmapData)
         {
            bitmapData = content as BitmapData;
            texture = Texture.fromBitmapData(bitmapData,generateMipMaps,optimizeForRenderToTexture);
         }
         else if(content is MovieClip)
         {
            width = getNearest2N(content.width) * scaleForTexture;
            height = getNearest2N(content.height) * scaleForTexture;
            _helpMatrix.scale(scaleForTexture,scaleForTexture);
            _helpMatrix.tx = 0;
            _helpMatrix.ty = 0;
            movieClip = content as MovieClip;
            movieClip.gotoAndStop(1);
            bitmapData = new BitmapData(width,height,true,16711935);
            bitmapData.draw(movieClip,_helpMatrix);
            movieClip.gotoAndStop(movieClip.totalFrames);
            texture = Texture.fromBitmapData(bitmapData,generateMipMaps,optimizeForRenderToTexture,scaleForTexture);
         }
         else
         {
            throw new Error();
         }
         var textureAtlas:StarlingTextureAtlas = new StarlingTextureAtlas(texture,textureAtlasRawData,false);
         if(Starling.handleLostContext)
         {
            textureAtlas._bitmapData = bitmapData;
         }
         else
         {
            bitmapData.dispose();
         }
         return textureAtlas;
      }
      
      override protected function generateArmature() : Armature
      {
         var armature:Armature = new Armature(new Sprite());
         return armature;
      }
      
      override protected function generateFastArmature() : FastArmature
      {
         var armature:FastArmature = new FastArmature(new Sprite());
         return armature;
      }
      
      override protected function generateSlot() : Slot
      {
         var slot:Slot = new StarlingSlot();
         return slot;
      }
      
      override protected function generateFastSlot() : FastSlot
      {
         var slot:FastSlot = new StarlingFastSlot();
         return slot;
      }
      
      override protected function generateDisplay(textureAtlas:Object, fullName:String, pivotX:Number, pivotY:Number) : Object
      {
         var image:* = null;
         var subTextureFrame:* = null;
         var subTexture:SubTexture = (textureAtlas as TextureAtlas).getTexture(fullName) as SubTexture;
         if(subTexture)
         {
            image = new Image(subTexture);
            if(isNaN(pivotX) || isNaN(pivotY))
            {
               subTextureFrame = (textureAtlas as TextureAtlas).getFrame(fullName);
               if(subTextureFrame)
               {
                  pivotX = subTextureFrame.width / 2;
                  pivotY = subTextureFrame.height / 2;
               }
               else
               {
                  pivotX = subTexture.width / 2;
                  pivotY = subTexture.height / 2;
               }
            }
            image.pivotX = pivotX;
            image.pivotY = pivotY;
            return image;
         }
         return null;
      }
      
      private function getNearest2N(_n:uint) : uint
      {
         return !!(_n & _n - 1)?1 << _n.toString(2).length:_n;
      }
      
      override protected function get textureAtlasDic() : Dictionary
      {
         return DDTAssetManager.instance.starlingAsset.atlases;
      }
   }
}
