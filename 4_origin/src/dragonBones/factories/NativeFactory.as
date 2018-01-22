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
      
      override protected function generateTextureAtlas(param1:Object, param2:Object) : ITextureAtlas
      {
         var _loc3_:NativeTextureAtlas = new NativeTextureAtlas(param1,param2,1,false);
         return _loc3_;
      }
      
      override protected function generateArmature() : Armature
      {
         var _loc2_:Sprite = new Sprite();
         var _loc1_:Armature = new Armature(_loc2_);
         return _loc1_;
      }
      
      override protected function generateFastArmature() : FastArmature
      {
         var _loc1_:FastArmature = new FastArmature(new Sprite());
         return _loc1_;
      }
      
      override protected function generateFastSlot() : FastSlot
      {
         var _loc1_:FastSlot = new NativeFastSlot();
         return _loc1_;
      }
      
      override protected function generateSlot() : Slot
      {
         var _loc1_:Slot = new NativeSlot();
         return _loc1_;
      }
      
      override protected function generateDisplay(param1:Object, param2:String, param3:Number, param4:Number) : Object
      {
         var _loc8_:* = null;
         var _loc10_:* = null;
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc9_:* = null;
         if(param1 is NativeTextureAtlas)
         {
            _loc8_ = param1 as NativeTextureAtlas;
         }
         if(_loc8_)
         {
            _loc10_ = _loc8_.movieClip;
            if(useBitmapDataTexture && _loc10_)
            {
               _loc8_.movieClipToBitmapData();
            }
            if(!useBitmapDataTexture && _loc10_ && _loc10_.totalFrames >= 3)
            {
               _loc10_.gotoAndStop(_loc10_.totalFrames);
               _loc10_.gotoAndStop(param2);
               if(_loc10_.numChildren > 0)
               {
                  try
                  {
                     _loc5_ = _loc10_.getChildAt(0);
                     _loc5_.x = 0;
                     _loc5_.y = 0;
                     var _loc12_:* = _loc5_;
                     return _loc12_;
                  }
                  catch(e:Error)
                  {
                     throw new Error("Can not get the movie clip, please make sure the version of the resource compatible with app version!");
                  }
               }
            }
            else if(_loc8_.bitmapData)
            {
               _loc7_ = _loc8_.getRegion(param2);
               if(_loc7_)
               {
                  _loc6_ = _loc8_.getFrame(param2);
                  if(isNaN(param3) || isNaN(param3))
                  {
                     if(_loc6_)
                     {
                        param3 = _loc6_.width / 2 + _loc6_.x;
                        param4 = _loc6_.height / 2 + _loc6_.y;
                     }
                     else
                     {
                        param3 = _loc7_.width / 2;
                        param4 = _loc7_.height / 2;
                     }
                  }
                  else if(_loc6_)
                  {
                     param3 = param3 + _loc6_.x;
                     param4 = param4 + _loc6_.y;
                  }
                  _loc9_ = new Shape();
                  _helpMatrix.a = 1;
                  _helpMatrix.b = 0;
                  _helpMatrix.c = 0;
                  _helpMatrix.d = 1;
                  _helpMatrix.scale(1 / _loc8_.scale,1 / _loc8_.scale);
                  _helpMatrix.tx = -param3 - _loc7_.x;
                  _helpMatrix.ty = -param4 - _loc7_.y;
                  _loc9_.graphics.beginBitmapFill(_loc8_.bitmapData,_helpMatrix,false,fillBitmapSmooth);
                  _loc9_.graphics.drawRect(-param3,-param4,_loc7_.width,_loc7_.height);
                  return _loc9_;
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
