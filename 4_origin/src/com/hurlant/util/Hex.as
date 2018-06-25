package com.hurlant.util
{
   import flash.utils.ByteArray;
   
   public class Hex
   {
       
      
      public function Hex()
      {
         super();
      }
      
      public static function dump(array:ByteArray) : String
      {
         var v:int = 0;
         var s:String = "";
         var a:String = "";
         for(var i:uint = 0; i < array.length; i++)
         {
            if(i % 16 == 0)
            {
               s = s + (("00000000" + i.toString(16)).substr(-8,8) + " ");
            }
            if(i % 8 == 0)
            {
               s = s + " ";
            }
            v = array[i];
            s = s + (("0" + v.toString(16)).substr(-2,2) + " ");
            a = a + (v < 32 || v > 126?".":String.fromCharCode(v));
            if((i + 1) % 16 == 0 || i == array.length - 1)
            {
               s = s + (" |" + a + "|\n");
               a = "";
            }
         }
         return s;
      }
      
      public static function fromString(str:String, colons:Boolean = false) : String
      {
         var a:ByteArray = new ByteArray();
         a.writeUTFBytes(str);
         return fromArray(a,colons);
      }
      
      public static function toString(hex:String) : String
      {
         var a:ByteArray = toArray(hex);
         return a.readUTFBytes(a.length);
      }
      
      public static function undump(str:String) : ByteArray
      {
         var stuff:Array = null;
         var bytes:ByteArray = new ByteArray();
         var lines:Array = str.split(/(\n|\r)+/);
         while(lines.length > 0 && lines[0].length > 0)
         {
            stuff = lines.shift().substr(10).split("  |")[0].split(/\s+/);
            while(stuff.length > 0 && stuff[0].length > 0)
            {
               bytes.writeByte(parseInt(stuff.shift(),16));
            }
         }
         bytes.position = 0;
         return bytes;
      }
      
      public static function toArray(hex:String) : ByteArray
      {
         hex = hex.replace(/\s|:/gm,"");
         var a:ByteArray = new ByteArray();
         if(hex.length & 1 == 1)
         {
            hex = "0" + hex;
         }
         for(var i:uint = 0; i < hex.length; i = i + 2)
         {
            a[i / 2] = parseInt(hex.substr(i,2),16);
         }
         return a;
      }
      
      public static function fromArray(array:ByteArray, colons:Boolean = false) : String
      {
         var s:String = "";
         for(var i:uint = 0; i < array.length; i++)
         {
            s = s + ("0" + array[i].toString(16)).substr(-2,2);
            if(colons)
            {
               if(i < array.length - 1)
               {
                  s = s + ":";
               }
            }
         }
         return s;
      }
   }
}
