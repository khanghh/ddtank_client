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
      
      override protected function generateTextureAtlas(param1:Object, param2:Object) : ITextureAtlas
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:* = null;
         if(param1 is BitmapData)
         {
            _loc4_ = param1 as BitmapData;
            _loc6_ = Texture.fromBitmapData(_loc4_,generateMipMaps,optimizeForRenderToTexture);
         }
         else if(param1 is MovieClip)
         {
            _loc7_ = getNearest2N(param1.width) * scaleForTexture;
            _loc3_ = getNearest2N(param1.height) * scaleForTexture;
            _helpMatrix.scale(scaleForTexture,scaleForTexture);
            _helpMatrix.tx = 0;
            _helpMatrix.ty = 0;
            _loc8_ = param1 as MovieClip;
            _loc8_.gotoAndStop(1);
            _loc4_ = new BitmapData(_loc7_,_loc3_,true,16711935);
            _loc4_.draw(_loc8_,_helpMatrix);
            _loc8_.gotoAndStop(_loc8_.totalFrames);
            _loc6_ = Texture.fromBitmapData(_loc4_,generateMipMaps,optimizeForRenderToTexture,scaleForTexture);
         }
         else
         {
            throw new Error();
         }
         var _loc5_:StarlingTextureAtlas = new StarlingTextureAtlas(_loc6_,param2,false);
         if(Starling.handleLostContext)
         {
            _loc5_._bitmapData = _loc4_;
         }
         else
         {
            _loc4_.dispose();
         }
         return _loc5_;
      }
      
      override protected function generateArmature() : Armature
      {
         var _loc1_:Armature = new Armature(new Sprite());
         return _loc1_;
      }
      
      override protected function generateFastArmature() : FastArmature
      {
         var _loc1_:FastArmature = new FastArmature(new Sprite());
         return _loc1_;
      }
      
      override protected function generateSlot() : Slot
      {
         var _loc1_:Slot = new StarlingSlot();
         return _loc1_;
      }
      
      override protected function generateFastSlot() : FastSlot
      {
         var _loc1_:FastSlot = new StarlingFastSlot();
         return _loc1_;
      }
      
      override protected function generateDisplay(param1:Object, param2:String, param3:Number, param4:Number) : Object
      {
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc7_:SubTexture = (param1 as TextureAtlas).getTexture(param2) as SubTexture;
         if(_loc7_)
         {
            _loc6_ = new Image(_loc7_);
            if(isNaN(param3) || isNaN(param4))
            {
               _loc5_ = (param1 as TextureAtlas).getFrame(param2);
               if(_loc5_)
               {
                  param3 = _loc5_.width / 2;
                  param4 = _loc5_.height / 2;
               }
               else
               {
                  param3 = _loc7_.width / 2;
                  param4 = _loc7_.height / 2;
               }
            }
            _loc6_.pivotX = param3;
            _loc6_.pivotY = param4;
            return _loc6_;
         }
         return null;
      }
      
      private function getNearest2N(param1:uint) : uint
      {
         return !!(param1 & param1 - 1)?1 << param1.toString(2).length:param1;
      }
      
      override protected function get textureAtlasDic() : Dictionary
      {
         return DDTAssetManager.instance.starlingAsset.atlases;
      }
   }
}
