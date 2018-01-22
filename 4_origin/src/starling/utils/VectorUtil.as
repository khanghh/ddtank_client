package starling.utils
{
   import starling.errors.AbstractClassError;
   
   public class VectorUtil
   {
       
      
      public function VectorUtil()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function insertIntAt(param1:Vector.<int>, param2:int, param3:uint) : void
      {
         var _loc5_:int = 0;
         var _loc4_:uint = param1.length;
         if(param2 < 0)
         {
            param2 = param2 + (_loc4_ + 1);
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         _loc5_ = param2 - 1;
         while(_loc5_ >= _loc4_)
         {
            param1[_loc5_] = 0;
            _loc5_--;
         }
         _loc5_ = _loc4_;
         while(_loc5_ > param2)
         {
            param1[_loc5_] = param1[_loc5_ - 1];
            _loc5_--;
         }
         param1[param2] = param3;
      }
      
      public static function removeIntAt(param1:Vector.<int>, param2:int) : int
      {
         var _loc5_:int = 0;
         var _loc4_:uint = param1.length;
         if(param2 < 0)
         {
            param2 = param2 + _loc4_;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         else if(param2 >= _loc4_)
         {
            param2 = _loc4_ - 1;
         }
         var _loc3_:int = param1[param2];
         _loc5_ = param2 + 1;
         while(_loc5_ < _loc4_)
         {
            param1[_loc5_ - 1] = param1[_loc5_];
            _loc5_++;
         }
         param1.length = _loc4_ - 1;
         return _loc3_;
      }
      
      public static function insertUnsignedIntAt(param1:Vector.<uint>, param2:int, param3:uint) : void
      {
         var _loc5_:int = 0;
         var _loc4_:uint = param1.length;
         if(param2 < 0)
         {
            param2 = param2 + (_loc4_ + 1);
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         _loc5_ = param2 - 1;
         while(_loc5_ >= _loc4_)
         {
            param1[_loc5_] = 0;
            _loc5_--;
         }
         _loc5_ = _loc4_;
         while(_loc5_ > param2)
         {
            param1[_loc5_] = param1[_loc5_ - 1];
            _loc5_--;
         }
         param1[param2] = param3;
      }
      
      public static function removeUnsignedIntAt(param1:Vector.<uint>, param2:int) : uint
      {
         var _loc5_:int = 0;
         var _loc4_:uint = param1.length;
         if(param2 < 0)
         {
            param2 = param2 + _loc4_;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         else if(param2 >= _loc4_)
         {
            param2 = _loc4_ - 1;
         }
         var _loc3_:uint = param1[param2];
         _loc5_ = param2 + 1;
         while(_loc5_ < _loc4_)
         {
            param1[_loc5_ - 1] = param1[_loc5_];
            _loc5_++;
         }
         param1.length = _loc4_ - 1;
         return _loc3_;
      }
      
      public static function insertNumberAt(param1:Vector.<Number>, param2:int, param3:Number) : void
      {
         var _loc5_:int = 0;
         var _loc4_:uint = param1.length;
         if(param2 < 0)
         {
            param2 = param2 + (_loc4_ + 1);
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         _loc5_ = param2 - 1;
         while(_loc5_ >= _loc4_)
         {
            param1[_loc5_] = NaN;
            _loc5_--;
         }
         _loc5_ = _loc4_;
         while(_loc5_ > param2)
         {
            param1[_loc5_] = param1[_loc5_ - 1];
            _loc5_--;
         }
         param1[param2] = param3;
      }
      
      public static function removeNumberAt(param1:Vector.<Number>, param2:int) : Number
      {
         var _loc5_:int = 0;
         var _loc4_:uint = param1.length;
         if(param2 < 0)
         {
            param2 = param2 + _loc4_;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         else if(param2 >= _loc4_)
         {
            param2 = _loc4_ - 1;
         }
         var _loc3_:Number = param1[param2];
         _loc5_ = param2 + 1;
         while(_loc5_ < _loc4_)
         {
            param1[_loc5_ - 1] = param1[_loc5_];
            _loc5_++;
         }
         param1.length = _loc4_ - 1;
         return _loc3_;
      }
   }
}
