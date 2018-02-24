package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   import org.as3commons.lang.ClassUtils;
   import org.as3commons.lang.StringUtils;
   
   public class XmlTypeProvider extends AbstractTypeProvider
   {
      
      private static const TRUE_VALUE:String = "true";
      
      private static const METHODS_NAME:String = "methods";
      
      private static const ACCESSORS_NAME:String = "accessors";
       
      
      public function XmlTypeProvider(){super();}
      
      private function concatMetadata(param1:Type, param2:Array, param3:String) : void{}
      
      override public function getType(param1:Class, param2:ApplicationDomain) : Type{return null;}
      
      private function parseConstructor(param1:Type, param2:XMLList, param3:ApplicationDomain) : Constructor{return null;}
      
      private function parseMethods(param1:Type, param2:XML, param3:ApplicationDomain) : Array{return null;}
      
      private function parseAccessors(param1:Type, param2:XML, param3:ApplicationDomain) : Array{return null;}
      
      private function parseMembers(param1:Class, param2:XMLList, param3:String, param4:Boolean, param5:ApplicationDomain) : Array{return null;}
      
      private function parseImplementedInterfaces(param1:XMLList) : Array{return null;}
      
      private function parseExtendsClasses(param1:XMLList, param2:ApplicationDomain) : Array{return null;}
      
      private function parseMethodsByModifier(param1:Type, param2:XMLList, param3:Boolean, param4:ApplicationDomain) : Array{return null;}
      
      private function parseParameters(param1:XMLList, param2:ApplicationDomain) : Array{return null;}
      
      private function parseAccessorsByModifier(param1:Type, param2:XMLList, param3:Boolean, param4:ApplicationDomain) : Array{return null;}
      
      private function parseMetadata(param1:XMLList, param2:IMetadataContainer) : void{}
   }
}
