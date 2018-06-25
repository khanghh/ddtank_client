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
      
      public function clear(applicationDomain:ApplicationDomain = null) : void
      {
         if(applicationDomain == null)
         {
            this.cache = new Dictionary();
         }
         else
         {
            delete this.cache[applicationDomain];
         }
      }
      
      public function contains(key:String, applicationDomain:ApplicationDomain) : Boolean
      {
         Assert.hasText(key,"argument \'key\' cannot be empty");
         var subCache:Object = this.cache[applicationDomain] as Object;
         return subCache != null && subCache[key] != null;
      }
      
      public function getKeys(applicationDomain:ApplicationDomain) : Array
      {
         var key:String = null;
         var subCache:Object = this.cache[applicationDomain] as Object;
         var keys:Array = [];
         if(subCache != null)
         {
            for(keys[keys.length] in subCache)
            {
            }
         }
         return keys;
      }
      
      public function get(key:String, applicationDomain:ApplicationDomain) : Type
      {
         Assert.hasText(key,"argument \'key\' cannot be empty");
         var subCache:Object = this.cache[applicationDomain] as Object;
         return subCache != null?subCache[key]:null;
      }
      
      public function put(key:String, type:Type, applicationDomain:ApplicationDomain) : void
      {
         Assert.notNull(key,"argument \'key\' cannot be null");
         Assert.hasText(key,"argument \'key\' cannot be empty");
         Assert.notNull(type,"argument \'type\' cannot be null");
         var subCache:Object = this.cache[applicationDomain] = this.cache[applicationDomain] || {};
         subCache[key] = type;
      }
      
      public function size(applicationDomain:ApplicationDomain) : int
      {
         var prop:* = null;
         var subCache:Object = this.cache[applicationDomain] as Object;
         var index:int = 0;
         if(subCache != null)
         {
            for(prop in subCache)
            {
               index++;
            }
         }
         return index;
      }
   }
}
