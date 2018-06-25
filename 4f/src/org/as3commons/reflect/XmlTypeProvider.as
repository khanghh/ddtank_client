package org.as3commons.reflect{   import flash.system.ApplicationDomain;   import org.as3commons.lang.ClassUtils;   import org.as3commons.lang.StringUtils;      public class XmlTypeProvider extends AbstractTypeProvider   {            private static const TRUE_VALUE:String = "true";            private static const METHODS_NAME:String = "methods";            private static const ACCESSORS_NAME:String = "accessors";                   public function XmlTypeProvider() { super(); }
            private function concatMetadata(type:Type, metadataContainers:Array, propertyName:String) : void { }
            override public function getType(cls:Class, applicationDomain:ApplicationDomain) : Type { return null; }
            private function parseConstructor(type:Type, constructorXML:XMLList, applicationDomain:ApplicationDomain) : Constructor { return null; }
            private function parseMethods(type:Type, xml:XML, applicationDomain:ApplicationDomain) : Array { return null; }
            private function parseAccessors(type:Type, xml:XML, applicationDomain:ApplicationDomain) : Array { return null; }
            private function parseMembers(memberClass:Class, members:XMLList, declaringType:String, isStatic:Boolean, applicationDomain:ApplicationDomain) : Array { return null; }
            private function parseImplementedInterfaces(interfacesDescription:XMLList) : Array { return null; }
            private function parseExtendsClasses(extendedClasses:XMLList, applicationDomain:ApplicationDomain) : Array { return null; }
            private function parseMethodsByModifier(type:Type, methodsXML:XMLList, isStatic:Boolean, applicationDomain:ApplicationDomain) : Array { return null; }
            private function parseParameters(paramsXML:XMLList, applicationDomain:ApplicationDomain) : Array { return null; }
            private function parseAccessorsByModifier(type:Type, accessorsXML:XMLList, isStatic:Boolean, applicationDomain:ApplicationDomain) : Array { return null; }
            private function parseMetadata(metadataNodes:XMLList, metadata:IMetadataContainer) : void { }
   }}