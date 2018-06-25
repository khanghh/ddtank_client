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
      
      public function addBitmapData(name:String, btmd:BitmapData) : void
      {
         if(name in btmd)
         {
            _btmds[name].dispose();
         }
         _btmds[name] = btmd;
      }
      
      public function addBitmapDataAtlas(name:String, atlas:NativeTextureAtlas) : void
      {
         if(name in _btmdAtlas)
         {
            _btmdAtlas[name].dispose();
         }
         _btmdAtlas[name] = atlas;
      }
      
      public function removeBitmapData(name:String, dispose:Boolean = true) : void
      {
         if(dispose && name in _btmds)
         {
            _btmds[name].dispose();
         }
      }
      
      public function removeBitmapDataAtlas(name:String, dispose:Boolean = true) : void
      {
         if(dispose && name in _btmdAtlas)
         {
            _btmdAtlas[name].dispose();
         }
      }
      
      public function getBitmapData(name:String) : BitmapData
      {
         if(name in _btmds)
         {
            return (_btmds[name] as BitmapData).clone();
         }
         var _loc4_:int = 0;
         var _loc3_:* = _btmdAtlas;
         for each(var atlas in _btmdAtlas)
         {
            if(atlas.getRegion(name))
            {
               return parseNativeTexture(name,atlas);
            }
         }
         return null;
      }
      
      private function parseNativeTexture(name:String, atlas:NativeTextureAtlas) : BitmapData
      {
         var region:Rectangle = atlas.getRegion(name);
         var frame:Rectangle = atlas.getFrame(name) || new Rectangle();
         var rect:Rectangle = new Rectangle(region.x,region.y);
         rect.width = frame.width || Number(region.width);
         rect.height = frame.height || Number(region.height);
         var btmd:BitmapData = new BitmapData(rect.width,rect.height,true,0);
         btmd.copyPixels(atlas.bitmapData,rect,new Point(Math.abs(frame.x),Math.abs(frame.y)));
         return btmd;
      }
      
      public function getBitmap(name:String) : Bitmap
      {
         var btmd:BitmapData = getBitmapData(name);
         if(btmd == null)
         {
            return null;
         }
         return new Bitmap(btmd);
      }
      
      public function getBitmapDataAtlas(name:String) : NativeTextureAtlas
      {
         if(name in _btmdAtlas)
         {
            return _btmdAtlas[name];
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
         for each(var atlas in _btmdAtlas)
         {
            atlas.dispose();
         }
         var _loc6_:int = 0;
         var _loc5_:* = _btmds;
         for each(var btmd in _btmds)
         {
            btmd.dispose();
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
