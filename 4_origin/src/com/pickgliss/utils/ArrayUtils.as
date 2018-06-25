package com.pickgliss.utils
{
   public class ArrayUtils
   {
       
      
      public function ArrayUtils()
      {
         super();
      }
      
      public static function each(arr:Array, operation:Function) : void
      {
         var i:int = 0;
         for(i = 0; i < arr.length; )
         {
            operation(arr[i]);
            i++;
         }
      }
      
      public static function setSize(arr:Array, size:int) : void
      {
         if(size < 0)
         {
            size = 0;
         }
         if(size == arr.length)
         {
            return;
         }
         if(size > arr.length)
         {
            arr[size - 1] = undefined;
         }
         else
         {
            arr.splice(size);
         }
      }
      
      public static function removeFromArray(arr:Array, obj:Object) : int
      {
         var i:int = 0;
         for(i = 0; i < arr.length; )
         {
            if(arr[i] == obj)
            {
               arr.splice(i,1);
               return i;
            }
            i++;
         }
         return -1;
      }
      
      public static function removeAllFromArray(arr:Array, obj:Object) : void
      {
         var i:int = 0;
         for(i = 0; i < arr.length; )
         {
            if(arr[i] == obj)
            {
               arr.splice(i,1);
               i--;
            }
            i++;
         }
      }
      
      public static function removeAllBehindSomeIndex(array:Array, index:int) : void
      {
         var i:int = 0;
         if(index <= 0)
         {
            array.splice(0,array.length);
            return;
         }
         var arrLen:int = array.length;
         for(i = index + 1; i < arrLen; )
         {
            array.pop();
            i++;
         }
      }
      
      public static function indexInArray(arr:Array, obj:Object) : int
      {
         var i:int = 0;
         for(i = 0; i < arr.length; )
         {
            if(arr[i] == obj)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      public static function cloneArray(arr:Array) : Array
      {
         return arr.concat();
      }
      
      public static function swapItems(array:Array, item1:Object, item2:Object) : void
      {
         var tempItem:* = null;
         var item1pos:int = array.indexOf(item1);
         var item2pos:int = array.indexOf(item2);
         if(item1pos != -1 && item2pos != -1)
         {
            tempItem = array[item2pos];
            array[item2pos] = array[item1pos];
            array[item1pos] = tempItem;
         }
      }
      
      public static function disorder(arr:Array) : void
      {
         var i:int = 0;
         var random:int = 0;
         var temp:* = undefined;
         for(i = 0; i < arr.length; )
         {
            random = Math.random() * 10000 % arr.length;
            temp = arr[i];
            arr[i] = arr[random];
            arr[random] = temp;
            i++;
         }
      }
   }
}
