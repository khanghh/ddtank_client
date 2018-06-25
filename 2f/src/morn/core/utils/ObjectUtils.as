package morn.core.utils{   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.filters.BitmapFilter;   import flash.filters.ColorMatrixFilter;   import flash.text.TextField;   import flash.text.TextFormat;   import flash.utils.ByteArray;      public class ObjectUtils   {            private static const grayFilter:ColorMatrixFilter = new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0]);            private static var _tf:TextField = new TextField();                   public function ObjectUtils() { super(); }
            public static function addFilter(target:DisplayObject, filter:BitmapFilter) : void { }
            public static function clearFilter(target:DisplayObject, filterType:Class) : void { }
            public static function clone(source:*) : * { return null; }
            public static function createBitmap(width:int, height:int, color:uint = 0, alpha:Number = 1) : Bitmap { return null; }
            public static function readAMF(bytes:ByteArray) : Object { return null; }
            public static function writeAMF(obj:Object) : ByteArray { return null; }
            public static function gray(traget:DisplayObject, isGray:Boolean = true) : void { }
            public static function getTextField(format:TextFormat, text:String = "Test") : TextField { return null; }
   }}