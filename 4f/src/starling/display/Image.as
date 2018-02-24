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
      
      public function Image(param1:Texture){super(null,null,null,null);}
      
      public static function fromBitmap(param1:Bitmap, param2:Boolean = true, param3:Number = 1) : Image{return null;}
      
      public static function fromBitmapData(param1:BitmapData, param2:Boolean = true, param3:Number = 1) : Image{return null;}
      
      override protected function onVertexDataChanged() : void{}
      
      public function readjustSize() : void{}
      
      public function setTexCoords(param1:int, param2:Point) : void{}
      
      public function setTexCoordsTo(param1:int, param2:Number, param3:Number) : void{}
      
      public function getTexCoords(param1:int, param2:Point = null) : Point{return null;}
      
      override public function copyVertexDataTo(param1:VertexData, param2:int = 0) : void{}
      
      override public function copyVertexDataTransformedTo(param1:VertexData, param2:int = 0, param3:Matrix = null) : void{}
      
      public function get texture() : Texture{return null;}
      
      public function set texture(param1:Texture) : void{}
      
      public function get smoothing() : String{return null;}
      
      public function set smoothing(param1:String) : void{}
      
      override public function render(param1:RenderSupport, param2:Number) : void{}
   }
}
