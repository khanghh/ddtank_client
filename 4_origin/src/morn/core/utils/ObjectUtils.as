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
       
      
      public function ObjectUtils()
      {
         super();
      }
      
      public static function addFilter(target:DisplayObject, filter:BitmapFilter) : void
      {
         var filters:Array = target.filters || [];
         filters.push(filter);
         target.filters = filters;
      }
      
      public static function clearFilter(target:DisplayObject, filterType:Class) : void
      {
         var i:int = 0;
         var filter:* = undefined;
         var filters:Array = target.filters;
         if(filters != null && filters.length > 0)
         {
            for(i = filters.length - 1; i > -1; )
            {
               filter = filters[i];
               if(filter is filterType)
               {
                  filters.splice(i,1);
               }
               i--;
            }
            target.filters = filters;
         }
      }
      
      public static function clone(source:*) : *
      {
         var bytes:ByteArray = new ByteArray();
         bytes.writeObject(source);
         bytes.position = 0;
         return bytes.readObject();
      }
      
      public static function createBitmap(width:int, height:int, color:uint = 0, alpha:Number = 1) : Bitmap
      {
         var bitmap:Bitmap = new Bitmap(new BitmapData(1,1,false,color));
         bitmap.alpha = alpha;
         bitmap.width = width;
         bitmap.height = height;
         return bitmap;
      }
      
      public static function readAMF(bytes:ByteArray) : Object
      {
         if(bytes && bytes.length > 0 && bytes.readByte() == 17)
         {
            return bytes.readObject();
         }
         return null;
      }
      
      public static function writeAMF(obj:Object) : ByteArray
      {
         var bytes:ByteArray = new ByteArray();
         bytes.writeByte(17);
         bytes.writeObject(obj);
         return bytes;
      }
      
      public static function gray(traget:DisplayObject, isGray:Boolean = true) : void
      {
         if(isGray)
         {
            addFilter(traget,grayFilter);
         }
         else
         {
            clearFilter(traget,ColorMatrixFilter);
         }
      }
      
      public static function getTextField(format:TextFormat, text:String = "Test") : TextField
      {
         _tf.autoSize = "left";
         _tf.defaultTextFormat = format;
         _tf.text = text;
         return _tf;
      }
   }
}
