package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   
   public class AbstractTypeProvider implements ITypeProvider
   {
       
      
      protected var typeCache:TypeCache;
      
      public function AbstractTypeProvider()
      {
         super();
         if(this.typeCache == null)
         {
            this.typeCache = new TypeCache();
         }
      }
      
      public function getTypeCache() : TypeCache
      {
         return this.typeCache;
      }
      
      public function clearCache() : void
      {
         this.typeCache.clear();
      }
      
      public function getType(cls:Class, applicationDomain:ApplicationDomain) : Type
      {
         throw new Error("Not implemented in abstract base class");
      }
   }
}
