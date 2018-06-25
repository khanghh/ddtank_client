package starling.textures
{
   import flash.utils.ByteArray;
   
   public class AtfData
   {
       
      
      private var mFormat:String;
      
      private var mWidth:int;
      
      private var mHeight:int;
      
      private var mNumTextures:int;
      
      private var mIsCubeMap:Boolean;
      
      private var mData:ByteArray;
      
      public function AtfData(data:ByteArray)
      {
         var emptyMipmaps:* = false;
         var numTextures:* = 0;
         super();
         if(!isAtfData(data))
         {
            throw new ArgumentError("Invalid ATF data");
         }
         if(data[6] == 255)
         {
            data.position = 12;
         }
         else
         {
            data.position = 6;
         }
         var format:uint = data.readUnsignedByte();
         switch(int(format & 127))
         {
            case 0:
            case 1:
               mFormat = "bgra";
               break;
            case 2:
            case 3:
               mFormat = "compressed";
               break;
            case 4:
            case 5:
               mFormat = "compressedAlpha";
               break;
            default:
            default:
            default:
            default:
            default:
            default:
            case 12:
            case 13:
               throw new Error("Invalid ATF format");
         }
         mWidth = Math.pow(2,data.readUnsignedByte());
         mHeight = Math.pow(2,data.readUnsignedByte());
         mNumTextures = data.readUnsignedByte();
         mIsCubeMap = (format & 128) != 0;
         mData = data;
         if(data[5] != 0 && data[6] == 255)
         {
            emptyMipmaps = (data[5] & 1) == 1;
            numTextures = data[5] >> 1 & 127;
            mNumTextures = !!emptyMipmaps?1:numTextures;
         }
      }
      
      public static function isAtfData(data:ByteArray) : Boolean
      {
         var signature:* = null;
         if(data.length < 3)
         {
            return false;
         }
         signature = String.fromCharCode(data[0],data[1],data[2]);
         return signature == "ATF";
      }
      
      public function get format() : String
      {
         return mFormat;
      }
      
      public function get width() : int
      {
         return mWidth;
      }
      
      public function get height() : int
      {
         return mHeight;
      }
      
      public function get numTextures() : int
      {
         return mNumTextures;
      }
      
      public function get isCubeMap() : Boolean
      {
         return mIsCubeMap;
      }
      
      public function get data() : ByteArray
      {
         return mData;
      }
   }
}
