package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   
   public class AbstractTypeProvider implements ITypeProvider
   {
       
      
      protected var typeCache:TypeCache;
      
      public function AbstractTypeProvider(){super();}
      
      public function getTypeCache() : TypeCache{return null;}
      
      public function clearCache() : void{}
      
      public function getType(param1:Class, param2:ApplicationDomain) : Type{return null;}
   }
}
