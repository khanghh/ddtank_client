package com.hurlant.util
{
   import flash.net.LocalConnection;
   import flash.system.System;
   
   public class Memory
   {
       
      
      public function Memory()
      {
         super();
      }
      
      public static function gc() : void
      {
         try
         {
            new LocalConnection().connect("foo");
            new LocalConnection().connect("foo");
            return;
         }
         catch(e:*)
         {
            return;
         }
      }
      
      public static function get used() : uint
      {
         return System.totalMemory;
      }
   }
}
