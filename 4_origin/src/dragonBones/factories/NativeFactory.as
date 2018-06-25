package dragonBones.factories
{
   import dragonBones.Armature;
   import dragonBones.Slot;
   import dragonBones.display.NativeFastSlot;
   import dragonBones.display.NativeSlot;
   import dragonBones.fast.FastArmature;
   import dragonBones.fast.FastSlot;
   import dragonBones.textures.ITextureAtlas;
   import dragonBones.textures.NativeTextureAtlas;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import road7th.DDTAssetManager;
   
   public class NativeFactory extends BaseFactory
   {
       
      
      public var fillBitmapSmooth:Boolean;
      
      public var useBitmapDataTexture:Boolean;
      
      public function NativeFactory()
      {
         super(this);
      }
      
      override protected function generateTextureAtlas(content:Object, textureAtlasRawData:Object) : ITextureAtlas
      {
         var textureAtlas:NativeTextureAtlas = new NativeTextureAtlas(content,textureAtlasRawData,1,false);
         return textureAtlas;
      }
      
      override protected function generateArmature() : Armature
      {
         var display:Sprite = new Sprite();
         var armature:Armature = new Armature(display);
         return armature;
      }
      
      override protected function generateFastArmature() : FastArmature
      {
         var armature:FastArmature = new FastArmature(new Sprite());
         return armature;
      }
      
      override protected function generateFastSlot() : FastSlot
      {
         var slot:FastSlot = new NativeFastSlot();
         return slot;
      }
      
      override protected function generateSlot() : Slot
      {
         var slot:Slot = new NativeSlot();
         return slot;
      }
      
      override protected function generateDisplay(textureAtlas:Object, fullName:String, pivotX:Number, pivotY:Number) : Object
      {
         var nativeTextureAtlas:* = null;
         var movieClip:* = null;
         var displaySWF:* = null;
         var subTextureRegion:* = null;
         var subTextureFrame:* = null;
         var displayShape:* = null;
         if(textureAtlas is NativeTextureAtlas)
         {
            nativeTextureAtlas = textureAtlas as NativeTextureAtlas;
         }
         if(nativeTextureAtlas)
         {
            movieClip = nativeTextureAtlas.movieClip;
            if(useBitmapDataTexture && movieClip)
            {
               nativeTextureAtlas.movieClipToBitmapData();
            }
            if(!useBitmapDataTexture && movieClip && movieClip.totalFrames >= 3)
            {
               movieClip.gotoAndStop(movieClip.totalFrames);
               movieClip.gotoAndStop(fullName);
               if(movieClip.numChildren > 0)
               {
                  try
                  {
                     displaySWF = movieClip.getChildAt(0);
                     displaySWF.x = 0;
                     displaySWF.y = 0;
                     var _loc12_:* = displaySWF;
                     return _loc12_;
                  }
                  catch(e:Error)
                  {
                     throw new Error("Can not get the movie clip, please make sure the version of the resource compatible with app version!");
                  }
               }
            }
            else if(nativeTextureAtlas.bitmapData)
            {
               subTextureRegion = nativeTextureAtlas.getRegion(fullName);
               if(subTextureRegion)
               {
                  subTextureFrame = nativeTextureAtlas.getFrame(fullName);
                  if(isNaN(pivotX) || isNaN(pivotX))
                  {
                     if(subTextureFrame)
                     {
                        pivotX = subTextureFrame.width / 2 + subTextureFrame.x;
                        pivotY = subTextureFrame.height / 2 + subTextureFrame.y;
                     }
                     else
                     {
                        pivotX = subTextureRegion.width / 2;
                        pivotY = subTextureRegion.height / 2;
                     }
                  }
                  else if(subTextureFrame)
                  {
                     pivotX = pivotX + subTextureFrame.x;
                     pivotY = pivotY + subTextureFrame.y;
                  }
                  displayShape = new Shape();
                  _helpMatrix.a = 1;
                  _helpMatrix.b = 0;
                  _helpMatrix.c = 0;
                  _helpMatrix.d = 1;
                  _helpMatrix.scale(1 / nativeTextureAtlas.scale,1 / nativeTextureAtlas.scale);
                  _helpMatrix.tx = -pivotX - subTextureRegion.x;
                  _helpMatrix.ty = -pivotY - subTextureRegion.y;
                  displayShape.graphics.beginBitmapFill(nativeTextureAtlas.bitmapData,_helpMatrix,false,fillBitmapSmooth);
                  displayShape.graphics.drawRect(-pivotX,-pivotY,subTextureRegion.width,subTextureRegion.height);
                  return displayShape;
               }
            }
            else
            {
               throw new Error();
            }
         }
         return null;
      }
      
      override protected function get textureAtlasDic() : Dictionary
      {
         return DDTAssetManager.instance.nativeAsset.btmdAtlas;
      }
   }
}
