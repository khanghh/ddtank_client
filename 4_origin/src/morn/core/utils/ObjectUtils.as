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
      
      public static function addFilter(param1:DisplayObject, param2:BitmapFilter) : void
      {
         var _loc3_:Array = param1.filters || [];
         _loc3_.push(param2);
         param1.filters = _loc3_;
      }
      
      public static function clearFilter(param1:DisplayObject, param2:Class) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc3_:Array = param1.filters;
         if(_loc3_ != null && _loc3_.length > 0)
         {
            _loc4_ = _loc3_.length - 1;
            while(_loc4_ > -1)
            {
               _loc5_ = _loc3_[_loc4_];
               if(_loc5_ is param2)
               {
                  _loc3_.splice(_loc4_,1);
               }
               _loc4_--;
            }
            param1.filters = _loc3_;
         }
      }
      
      public static function clone(param1:*) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function createBitmap(param1:int, param2:int, param3:uint = 0, param4:Number = 1) : Bitmap
      {
         var _loc5_:Bitmap = new Bitmap(new BitmapData(1,1,false,param3));
         _loc5_.alpha = param4;
         _loc5_.width = param1;
         _loc5_.height = param2;
         return _loc5_;
      }
      
      public static function readAMF(param1:ByteArray) : Object
      {
         if(param1 && param1.length > 0 && param1.readByte() == 17)
         {
            return param1.readObject();
         }
         return null;
      }
      
      public static function writeAMF(param1:Object) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeByte(17);
         _loc2_.writeObject(param1);
         return _loc2_;
      }
      
      public static function gray(param1:DisplayObject, param2:Boolean = true) : void
      {
         if(param2)
         {
            addFilter(param1,grayFilter);
         }
         else
         {
            clearFilter(param1,ColorMatrixFilter);
         }
      }
      
      public static function getTextField(param1:TextFormat, param2:String = "Test") : TextField
      {
         _tf.autoSize = "left";
         _tf.defaultTextFormat = param1;
         _tf.text = param2;
         return _tf;
      }
   }
}
