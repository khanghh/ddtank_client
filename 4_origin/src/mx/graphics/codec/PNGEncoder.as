package mx.graphics.codec
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class PNGEncoder implements IImageEncoder
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      private static const CONTENT_TYPE:String = "image/png";
       
      
      private var crcTable:Array;
      
      public function PNGEncoder()
      {
         super();
         this.initializeCRCTable();
      }
      
      public function get contentType() : String
      {
         return CONTENT_TYPE;
      }
      
      public function encode(bitmapData:BitmapData) : ByteArray
      {
         return this.internalEncode(bitmapData,bitmapData.width,bitmapData.height,bitmapData.transparent);
      }
      
      public function encodeByteArray(byteArray:ByteArray, width:int, height:int, transparent:Boolean = true) : ByteArray
      {
         return this.internalEncode(byteArray,width,height,transparent);
      }
      
      private function initializeCRCTable() : void
      {
         var c:uint = 0;
         var k:uint = 0;
         this.crcTable = [];
         for(var n:uint = 0; n < 256; n++)
         {
            c = n;
            for(k = 0; k < 8; k++)
            {
               if(c & 1)
               {
                  c = uint(uint(3988292384) ^ uint(c >>> 1));
               }
               else
               {
                  c = uint(c >>> 1);
               }
            }
            this.crcTable[n] = c;
         }
      }
      
      private function internalEncode(source:Object, width:int, height:int, transparent:Boolean = true) : ByteArray
      {
         var x:int = 0;
         var pixel:uint = 0;
         var sourceBitmapData:BitmapData = source as BitmapData;
         var sourceByteArray:ByteArray = source as ByteArray;
         if(sourceByteArray)
         {
            sourceByteArray.position = 0;
         }
         var png:ByteArray = new ByteArray();
         png.writeUnsignedInt(2303741511);
         png.writeUnsignedInt(218765834);
         var IHDR:ByteArray = new ByteArray();
         IHDR.writeInt(width);
         IHDR.writeInt(height);
         IHDR.writeByte(8);
         IHDR.writeByte(6);
         IHDR.writeByte(0);
         IHDR.writeByte(0);
         IHDR.writeByte(0);
         this.writeChunk(png,1229472850,IHDR);
         var IDAT:ByteArray = new ByteArray();
         for(var y:int = 0; y < height; y++)
         {
            IDAT.writeByte(0);
            if(!transparent)
            {
               for(x = 0; x < width; x++)
               {
                  if(sourceBitmapData)
                  {
                     pixel = sourceBitmapData.getPixel(x,y);
                  }
                  else
                  {
                     pixel = sourceByteArray.readUnsignedInt();
                  }
                  IDAT.writeUnsignedInt(uint((pixel & 16777215) << 8 | 255));
               }
            }
            else
            {
               for(x = 0; x < width; x++)
               {
                  if(sourceBitmapData)
                  {
                     pixel = sourceBitmapData.getPixel32(x,y);
                  }
                  else
                  {
                     pixel = sourceByteArray.readUnsignedInt();
                  }
                  IDAT.writeUnsignedInt(uint((pixel & 16777215) << 8 | pixel >>> 24));
               }
            }
         }
         IDAT.compress();
         this.writeChunk(png,1229209940,IDAT);
         this.writeChunk(png,1229278788,null);
         png.position = 0;
         return png;
      }
      
      private function writeChunk(png:ByteArray, type:uint, data:ByteArray) : void
      {
         var len:uint = 0;
         if(data)
         {
            len = data.length;
         }
         png.writeUnsignedInt(len);
         var typePos:uint = png.position;
         png.writeUnsignedInt(type);
         if(data)
         {
            png.writeBytes(data);
         }
         var crcPos:uint = png.position;
         png.position = typePos;
         var crc:uint = 4294967295;
         for(var i:uint = typePos; i < crcPos; i++)
         {
            crc = uint(this.crcTable[(crc ^ png.readUnsignedByte()) & uint(255)] ^ uint(crc >>> 8));
         }
         crc = uint(crc ^ uint(4294967295));
         png.position = crcPos;
         png.writeUnsignedInt(crc);
      }
   }
}
