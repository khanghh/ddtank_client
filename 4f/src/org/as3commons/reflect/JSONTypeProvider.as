package org.as3commons.reflect
{
   import avmplus.DescribeType;
   import flash.errors.IllegalOperationError;
   import flash.system.ApplicationDomain;
   import org.as3commons.lang.ClassUtils;
   
   public class JSONTypeProvider extends AbstractTypeProvider
   {
      
      public static const ALIAS_NOT_AVAILABLE:String = "Alias not available when using JSONTypeProvider";
       
      
      private var _describeTypeJSON:Function;
      
      private var _ignoredMetadata:Array;
      
      public function JSONTypeProvider(){super();}
      
      protected function initJSONTypeProvider() : void{}
      
      override public function getType(param1:Class, param2:ApplicationDomain) : Type{return null;}
      
      protected function parseConstructor(param1:Type, param2:Array, param3:ApplicationDomain) : Constructor{return null;}
      
      private function concatMetadata(param1:Type, param2:Array, param3:String) : void{}
      
      private function parseImplementedInterfaces(param1:Array) : Array{return null;}
      
      private function parseMethods(param1:Type, param2:Array, param3:ApplicationDomain, param4:Boolean) : Array{return null;}
      
      private function parseParameters(param1:Array, param2:ApplicationDomain) : Array{return null;}
      
      private function parseAccessors(param1:Type, param2:Array, param3:ApplicationDomain, param4:Boolean) : Array{return null;}
      
      private function parseMetadata(param1:Array, param2:IMetadataContainer) : void{}
      
      private function isIgnoredMetadata(param1:String) : Boolean{return false;}
      
      private function parseMembers(param1:Type, param2:Class, param3:Array, param4:String, param5:Boolean, param6:Boolean, param7:ApplicationDomain) : Array{return null;}
   }
}
