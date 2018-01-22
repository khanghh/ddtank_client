package flash.utils
{
   import dragonBones.textures.NativeTextureAtlas;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class NativeTextureAssetManager
   {
       
      
      private var _btmds:Dictionary;
      
      private var _btmdAtlas:Dictionary;
      
      public function NativeTextureAssetManager()
      {
         super();
         _btmds = new Dictionary();
         _btmdAtlas = new Dictionary();
      }
      
      public function addBitmapData(param1:String, param2:BitmapData) : void
      {
         if(param1 in param2)
         {
            _btmds[param1].dispose();
         }
         _btmds[param1] = param2;
      }
      
      public function addBitmapDataAtlas(param1:String, param2:NativeTextureAtlas) : void
      {
         if(param1 in _btmdAtlas)
         {
            _btmdAtlas[param1].dispose();
         }
         _btmdAtlas[param1] = param2;
      }
      
      public function removeBitmapData(param1:String, param2:Boolean = true) : void
      {
         if(param2 && param1 in _btmds)
         {
            _btmds[param1].dispose();
         }
      }
      
      public function removeBitmapDataAtlas(param1:String, param2:Boolean = true) : void
      {
         if(param2 && param1 in _btmdAtlas)
         {
            _btmdAtlas[param1].dispose();
         }
      }
      
      public function getBitmapData(param1:String) : BitmapData
      {
         if(param1 in _btmds)
         {
            return (_btmds[param1] as BitmapData).clone();
         }
         var _loc4_:int = 0;
         var _loc3_:* = _btmdAtlas;
         for each(var _loc2_ in _btmdAtlas)
         {
            if(_loc2_.getRegion(param1))
            {
               return parseNativeTexture(param1,_loc2_);
            }
         }
         return null;
      }
      
      private function parseNativeTexture(param1:String, param2:NativeTextureAtlas) : BitmapData
      {
         var _loc3_:Rectangle = param2.getRegion(param1);
         var _loc4_:Rectangle = param2.getFrame(param1) || new Rectangle();
         var _loc6_:Rectangle = new Rectangle(_loc3_.x,_loc3_.y);
         _loc6_.width = _loc4_.width || Number(_loc3_.width);
         _loc6_.height = _loc4_.height || Number(_loc3_.height);
         var _loc5_:BitmapData = new BitmapData(_loc6_.width,_loc6_.height,true,0);
         _loc5_.copyPixels(param2.bitmapData,_loc6_,new Point(Math.abs(_loc4_.x),Math.abs(_loc4_.y)));
         return _loc5_;
      }
      
      public function getBitmap(param1:String) : Bitmap
      {
         var _loc2_:BitmapData = getBitmapData(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return new Bitmap(_loc2_);
      }
      
      public function getBitmapDataAtlas(param1:String) : NativeTextureAtlas
      {
         if(param1 in _btmdAtlas)
         {
            return _btmdAtlas[param1];
         }
         return null;
      }
      
      public function purge() : void
      {
         dispose();
         _btmdAtlas = new Dictionary();
         _btmds = new Dictionary();
      }
      
      public function dispose() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _btmdAtlas;
         for each(var _loc2_ in _btmdAtlas)
         {
            _loc2_.dispose();
         }
         var _loc6_:int = 0;
         var _loc5_:* = _btmds;
         for each(var _loc1_ in _btmds)
         {
            _loc1_.dispose();
         }
         _btmdAtlas = null;
         _btmds = null;
      }
      
      public function get btmdAtlas() : Dictionary
      {
         return _btmdAtlas;
      }
   }
}
