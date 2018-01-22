package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import org.as3commons.lang.Assert;
   
   public class TypeCache
   {
       
      
      protected var cache:Dictionary;
      
      public function TypeCache()
      {
         super();
         this.clear();
      }
      
      public function clear(param1:ApplicationDomain = null) : void
      {
         if(param1 == null)
         {
            this.cache = new Dictionary();
         }
         else
         {
            delete this.cache[param1];
         }
      }
      
      public function contains(param1:String, param2:ApplicationDomain) : Boolean
      {
         Assert.hasText(param1,"argument \'key\' cannot be empty");
         var _loc3_:Object = this.cache[param2] as Object;
         return _loc3_ != null && _loc3_[param1] != null;
      }
      
      public function getKeys(param1:ApplicationDomain) : Array
      {
         var _loc4_:String = null;
         var _loc2_:Object = this.cache[param1] as Object;
         var _loc3_:Array = [];
         if(_loc2_ != null)
         {
            for(_loc3_[_loc3_.length] in _loc2_)
            {
            }
         }
         return _loc3_;
      }
      
      public function get(param1:String, param2:ApplicationDomain) : Type
      {
         Assert.hasText(param1,"argument \'key\' cannot be empty");
         var _loc3_:Object = this.cache[param2] as Object;
         return _loc3_ != null?_loc3_[param1]:null;
      }
      
      public function put(param1:String, param2:Type, param3:ApplicationDomain) : void
      {
         Assert.notNull(param1,"argument \'key\' cannot be null");
         Assert.hasText(param1,"argument \'key\' cannot be empty");
         Assert.notNull(param2,"argument \'type\' cannot be null");
         var _loc4_:Object = this.cache[param3] = this.cache[param3] || {};
         _loc4_[param1] = param2;
      }
      
      public function size(param1:ApplicationDomain) : int
      {
         var _loc4_:* = null;
         var _loc2_:Object = this.cache[param1] as Object;
         var _loc3_:int = 0;
         if(_loc2_ != null)
         {
            for(_loc4_ in _loc2_)
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
   }
}
