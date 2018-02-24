package morn.core.utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.filters.BitmapFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   
   public class ObjectUtils
   {
      
      private static const grayFilter:ColorMatrixFilter = new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0]);
      
      private static var _tf:TextField = new TextField();
       
      
      public function ObjectUtils(){super();}
      
      public static function addFilter(param1:DisplayObject, param2:BitmapFilter) : void{}
      
      public static function clearFilter(param1:DisplayObject, param2:Class) : void{}
      
      public static function clone(param1:*) : *{return null;}
      
      public static function createBitmap(param1:int, param2:int, param3:uint = 0, param4:Number = 1) : Bitmap{return null;}
      
      public static function readAMF(param1:ByteArray) : Object{return null;}
      
      public static function writeAMF(param1:Object) : ByteArray{return null;}
      
      public static function gray(param1:DisplayObject, param2:Boolean = true) : void{}
      
      public static function getTextField(param1:TextFormat, param2:String = "Test") : TextField{return null;}
   }
}
