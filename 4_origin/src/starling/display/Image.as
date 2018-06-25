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
      
      public function Image(texture:Texture)
      {
         var frame:* = null;
         var width:Number = NaN;
         var height:Number = NaN;
         var pma:Boolean = false;
         if(texture)
         {
            frame = texture.frame;
            width = !!frame?frame.width:Number(texture.width);
            height = !!frame?frame.height:Number(texture.height);
            pma = texture.premultipliedAlpha;
            super(width,height,16777215,pma);
            mVertexData.setTexCoords(0,0,0);
            mVertexData.setTexCoords(1,1,0);
            mVertexData.setTexCoords(2,0,1);
            mVertexData.setTexCoords(3,1,1);
            mTexture = texture;
            mSmoothing = "bilinear";
            mVertexDataCache = new VertexData(4,pma);
            mVertexDataCacheInvalid = true;
            return;
         }
         throw new ArgumentError("Texture cannot be null");
      }
      
      public static function fromBitmap(bitmap:Bitmap, generateMipMaps:Boolean = true, scale:Number = 1) : Image
      {
         return new Image(Texture.fromBitmap(bitmap,generateMipMaps,false,scale));
      }
      
      public static function fromBitmapData(bitmapData:BitmapData, generateMipMaps:Boolean = true, scale:Number = 1) : Image
      {
         return new Image(Texture.fromBitmapData(bitmapData,generateMipMaps,false,scale));
      }
      
      override protected function onVertexDataChanged() : void
      {
         mVertexDataCacheInvalid = true;
      }
      
      public function readjustSize() : void
      {
         var frame:Rectangle = texture.frame;
         var width:Number = !!frame?frame.width:Number(texture.width);
         var height:Number = !!frame?frame.height:Number(texture.height);
         mVertexData.setPosition(0,0,0);
         mVertexData.setPosition(1,width,0);
         mVertexData.setPosition(2,0,height);
         mVertexData.setPosition(3,width,height);
         onVertexDataChanged();
      }
      
      public function setTexCoords(vertexID:int, coords:Point) : void
      {
         mVertexData.setTexCoords(vertexID,coords.x,coords.y);
         onVertexDataChanged();
      }
      
      public function setTexCoordsTo(vertexID:int, u:Number, v:Number) : void
      {
         mVertexData.setTexCoords(vertexID,u,v);
         onVertexDataChanged();
      }
      
      public function getTexCoords(vertexID:int, resultPoint:Point = null) : Point
      {
         if(resultPoint == null)
         {
            resultPoint = new Point();
         }
         mVertexData.getTexCoords(vertexID,resultPoint);
         return resultPoint;
      }
      
      override public function copyVertexDataTo(targetData:VertexData, targetVertexID:int = 0) : void
      {
         copyVertexDataTransformedTo(targetData,targetVertexID,null);
      }
      
      override public function copyVertexDataTransformedTo(targetData:VertexData, targetVertexID:int = 0, matrix:Matrix = null) : void
      {
         if(mVertexDataCacheInvalid)
         {
            mVertexDataCacheInvalid = false;
            mVertexData.copyTo(mVertexDataCache);
            mTexture.adjustVertexData(mVertexDataCache,0,4);
         }
         mVertexDataCache.copyTransformedTo(targetData,targetVertexID,matrix,0,4);
      }
      
      public function get texture() : Texture
      {
         return mTexture;
      }
      
      public function set texture(value:Texture) : void
      {
         if(value == null)
         {
            throw new ArgumentError("Texture cannot be null");
         }
         if(value != mTexture)
         {
            mTexture = value;
            mVertexData.setPremultipliedAlpha(mTexture.premultipliedAlpha);
            mVertexDataCache.setPremultipliedAlpha(mTexture.premultipliedAlpha,false);
            onVertexDataChanged();
         }
      }
      
      public function get smoothing() : String
      {
         return mSmoothing;
      }
      
      public function set smoothing(value:String) : void
      {
         if(TextureSmoothing.isValid(value))
         {
            mSmoothing = value;
            return;
         }
         throw new ArgumentError("Invalid smoothing mode: " + value);
      }
      
      override public function render(support:RenderSupport, parentAlpha:Number) : void
      {
         support.batchQuad(this,parentAlpha,mTexture,mSmoothing);
      }
   }
}
