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
      
      public static function insertIntAt(vector:Vector.<int>, index:int, value:uint) : void
      {
         var i:int = 0;
         var length:uint = vector.length;
         if(index < 0)
         {
            index = index + (length + 1);
         }
         if(index < 0)
         {
            index = 0;
         }
         for(i = index - 1; i >= length; )
         {
            vector[i] = 0;
            i--;
         }
         for(i = length; i > index; )
         {
            vector[i] = vector[i - 1];
            i--;
         }
         vector[index] = value;
      }
      
      public static function removeIntAt(vector:Vector.<int>, index:int) : int
      {
         var i:int = 0;
         var length:uint = vector.length;
         if(index < 0)
         {
            index = index + length;
         }
         if(index < 0)
         {
            index = 0;
         }
         else if(index >= length)
         {
            index = length - 1;
         }
         var value:int = vector[index];
         for(i = index + 1; i < length; )
         {
            vector[i - 1] = vector[i];
            i++;
         }
         vector.length = length - 1;
         return value;
      }
      
      public static function insertUnsignedIntAt(vector:Vector.<uint>, index:int, value:uint) : void
      {
         var i:int = 0;
         var length:uint = vector.length;
         if(index < 0)
         {
            index = index + (length + 1);
         }
         if(index < 0)
         {
            index = 0;
         }
         for(i = index - 1; i >= length; )
         {
            vector[i] = 0;
            i--;
         }
         for(i = length; i > index; )
         {
            vector[i] = vector[i - 1];
            i--;
         }
         vector[index] = value;
      }
      
      public static function removeUnsignedIntAt(vector:Vector.<uint>, index:int) : uint
      {
         var i:int = 0;
         var length:uint = vector.length;
         if(index < 0)
         {
            index = index + length;
         }
         if(index < 0)
         {
            index = 0;
         }
         else if(index >= length)
         {
            index = length - 1;
         }
         var value:uint = vector[index];
         for(i = index + 1; i < length; )
         {
            vector[i - 1] = vector[i];
            i++;
         }
         vector.length = length - 1;
         return value;
      }
      
      public static function insertNumberAt(vector:Vector.<Number>, index:int, value:Number) : void
      {
         var i:int = 0;
         var length:uint = vector.length;
         if(index < 0)
         {
            index = index + (length + 1);
         }
         if(index < 0)
         {
            index = 0;
         }
         for(i = index - 1; i >= length; )
         {
            vector[i] = NaN;
            i--;
         }
         for(i = length; i > index; )
         {
            vector[i] = vector[i - 1];
            i--;
         }
         vector[index] = value;
      }
      
      public static function removeNumberAt(vector:Vector.<Number>, index:int) : Number
      {
         var i:int = 0;
         var length:uint = vector.length;
         if(index < 0)
         {
            index = index + length;
         }
         if(index < 0)
         {
            index = 0;
         }
         else if(index >= length)
         {
            index = length - 1;
         }
         var value:Number = vector[index];
         for(i = index + 1; i < length; )
         {
            vector[i - 1] = vector[i];
            i++;
         }
         vector.length = length - 1;
         return value;
      }
   }
}
