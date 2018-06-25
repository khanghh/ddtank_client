package mx.graphics.codec{   import flash.display.BitmapData;   import flash.utils.ByteArray;   import mx.core.mx_internal;      use namespace mx_internal;      public class PNGEncoder implements IImageEncoder   {            mx_internal static const VERSION:String = "4.1.0.16076";            private static const CONTENT_TYPE:String = "image/png";                   private var crcTable:Array;            public function PNGEncoder() { super(); }
            public function get contentType() : String { return null; }
            public function encode(bitmapData:BitmapData) : ByteArray { return null; }
            public function encodeByteArray(byteArray:ByteArray, width:int, height:int, transparent:Boolean = true) : ByteArray { return null; }
            private function initializeCRCTable() : void { }
            private function internalEncode(source:Object, width:int, height:int, transparent:Boolean = true) : ByteArray { return null; }
            private function writeChunk(png:ByteArray, type:uint, data:ByteArray) : void { }
   }}