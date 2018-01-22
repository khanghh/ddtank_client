package starling.display
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.core.RenderSupport;
   import starling.textures.Texture;
   import starling.textures.TextureSmoothing;
   import starling.utils.VertexData;
   
   public class Image extends Quad
   {
       
      
      private var mTexture:Texture;
      
      private var mSmoothing:String;
      
      private var mVertexDataCache:VertexData;
      
      private var mVertexDataCacheInvalid:Boolean;
      
      public function Image(param1:Texture)
      {
         var _loc3_:* = null;
         var _loc4_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc5_:Boolean = false;
         if(param1)
         {
            _loc3_ = param1.frame;
            _loc4_ = !!_loc3_?_loc3_.width:Number(param1.width);
            _loc2_ = !!_loc3_?_loc3_.height:Number(param1.height);
            _loc5_ = param1.premultipliedAlpha;
            super(_loc4_,_loc2_,16777215,_loc5_);
            mVertexData.setTexCoords(0,0,0);
            mVertexData.setTexCoords(1,1,0);
            mVertexData.setTexCoords(2,0,1);
            mVertexData.setTexCoords(3,1,1);
            mTexture = param1;
            mSmoothing = "bilinear";
            mVertexDataCache = new VertexData(4,_loc5_);
            mVertexDataCacheInvalid = true;
            return;
         }
         throw new ArgumentError("Texture cannot be null");
      }
      
      public static function fromBitmap(param1:Bitmap, param2:Boolean = true, param3:Number = 1) : Image
      {
         return new Image(Texture.fromBitmap(param1,param2,false,param3));
      }
      
      public static function fromBitmapData(param1:BitmapData, param2:Boolean = true, param3:Number = 1) : Image
      {
         return new Image(Texture.fromBitmapData(param1,param2,false,param3));
      }
      
      override protected function onVertexDataChanged() : void
      {
         mVertexDataCacheInvalid = true;
      }
      
      public function readjustSize() : void
      {
         var _loc2_:Rectangle = texture.frame;
         var _loc3_:Number = !!_loc2_?_loc2_.width:Number(texture.width);
         var _loc1_:Number = !!_loc2_?_loc2_.height:Number(texture.height);
         mVertexData.setPosition(0,0,0);
         mVertexData.setPosition(1,_loc3_,0);
         mVertexData.setPosition(2,0,_loc1_);
         mVertexData.setPosition(3,_loc3_,_loc1_);
         onVertexDataChanged();
      }
      
      public function setTexCoords(param1:int, param2:Point) : void
      {
         mVertexData.setTexCoords(param1,param2.x,param2.y);
         onVertexDataChanged();
      }
      
      public function setTexCoordsTo(param1:int, param2:Number, param3:Number) : void
      {
         mVertexData.setTexCoords(param1,param2,param3);
         onVertexDataChanged();
      }
      
      public function getTexCoords(param1:int, param2:Point = null) : Point
      {
         if(param2 == null)
         {
            param2 = new Point();
         }
         mVertexData.getTexCoords(param1,param2);
         return param2;
      }
      
      override public function copyVertexDataTo(param1:VertexData, param2:int = 0) : void
      {
         copyVertexDataTransformedTo(param1,param2,null);
      }
      
      override public function copyVertexDataTransformedTo(param1:VertexData, param2:int = 0, param3:Matrix = null) : void
      {
         if(mVertexDataCacheInvalid)
         {
            mVertexDataCacheInvalid = false;
            mVertexData.copyTo(mVertexDataCache);
            mTexture.adjustVertexData(mVertexDataCache,0,4);
         }
         mVertexDataCache.copyTransformedTo(param1,param2,param3,0,4);
      }
      
      public function get texture() : Texture
      {
         return mTexture;
      }
      
      public function set texture(param1:Texture) : void
      {
         if(param1 == null)
         {
            throw new ArgumentError("Texture cannot be null");
         }
         if(param1 != mTexture)
         {
            mTexture = param1;
            mVertexData.setPremultipliedAlpha(mTexture.premultipliedAlpha);
            mVertexDataCache.setPremultipliedAlpha(mTexture.premultipliedAlpha,false);
            onVertexDataChanged();
         }
      }
      
      public function get smoothing() : String
      {
         return mSmoothing;
      }
      
      public function set smoothing(param1:String) : void
      {
         if(TextureSmoothing.isValid(param1))
         {
            mSmoothing = param1;
            return;
         }
         throw new ArgumentError("Invalid smoothing mode: " + param1);
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         param1.batchQuad(this,param2,mTexture,mSmoothing);
      }
   }
}
