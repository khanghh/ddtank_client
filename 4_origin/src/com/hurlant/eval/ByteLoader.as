package com.hurlant.eval
{
   import flash.display.Loader;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class ByteLoader
   {
      
      private static var abc_header:Array = [63,18];
      
      private static var swf_start:Array = [70,87,83,9,255,255,255,255,120,0,3,232,0,0,11,184,0,0,12,1,0,68,17,8,0,0,0];
      
      private static var swf_end:Array = [64,0];
       
      
      public function ByteLoader()
      {
         super();
      }
      
      public static function getType(data:ByteArray) : int
      {
         data.endian = "littleEndian";
         var version:uint = data.readUnsignedInt();
         switch(version)
         {
            case 46 << 16 | 14:
            case 46 << 16 | 15:
            case 46 << 16 | 16:
               return 2;
            case 67 | 87 << 8 | 83 << 16 | 9 << 24:
            case 67 | 87 << 8 | 83 << 16 | 8 << 24:
            case 67 | 87 << 8 | 83 << 16 | 7 << 24:
            case 67 | 87 << 8 | 83 << 16 | 6 << 24:
               return 5;
            case 70 | 87 << 8 | 83 << 16 | 9 << 24:
            case 70 | 87 << 8 | 83 << 16 | 8 << 24:
            case 70 | 87 << 8 | 83 << 16 | 7 << 24:
            case 70 | 87 << 8 | 83 << 16 | 6 << 24:
            case 70 | 87 << 8 | 83 << 16 | 5 << 24:
            case 70 | 87 << 8 | 83 << 16 | 4 << 24:
               return 1;
            default:
               return 0;
         }
      }
      
      public static function wrapInSWF(bytes:Array) : ByteArray
      {
         var abc:ByteArray = null;
         var j:int = 0;
         var out:ByteArray = new ByteArray();
         out.endian = Endian.LITTLE_ENDIAN;
         for(var i:int = 0; i < swf_start.length; i++)
         {
            out.writeByte(swf_start[i]);
         }
         for(i = 0; i < bytes.length; i++)
         {
            abc = bytes[i];
            for(j = 0; j < abc_header.length; j++)
            {
               out.writeByte(abc_header[j]);
            }
            out.writeInt(abc.length);
            out.writeBytes(abc,0,abc.length);
         }
         for(i = 0; i < swf_end.length; i++)
         {
            out.writeByte(swf_end[i]);
         }
         out.position = 4;
         out.writeInt(out.length);
         out.position = 0;
         return out;
      }
      
      public static function isSWF(data:ByteArray) : Boolean
      {
         var type:int = getType(data);
         return (type & 1) == 1;
      }
      
      public static function loadBytes(bytes:*, inplace:Boolean = false) : Boolean
      {
         var c:LoaderContext = null;
         var l:Loader = null;
         if(bytes is Array || getType(bytes) == 2)
         {
            if(!(bytes is Array))
            {
               var bytes:* = [bytes];
            }
            bytes = wrapInSWF(bytes);
         }
         try
         {
            c = null;
            if(inplace)
            {
               c = new LoaderContext(false,ApplicationDomain.currentDomain,null);
            }
            l = new Loader();
            l.loadBytes(bytes,c);
            return true;
         }
         catch(e:*)
         {
            Debug.print(e);
         }
         return false;
      }
   }
}
