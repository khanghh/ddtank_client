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
       
      
      public function XmlTypeProvider()
      {
         super();
      }
      
      private function concatMetadata(type:Type, metadataContainers:Array, propertyName:String) : void
      {
         var container:IMetadataContainer = null;
         for each(container in metadataContainers)
         {
            type[propertyName].some(function(item:MetadataContainer, index:int, arr:Array):Boolean
            {
               var metadataList:Array = null;
               var numMetadata:int = 0;
               var j:int = 0;
               if(Object(item).name == Object(container).name)
               {
                  metadataList = container.metadata;
                  numMetadata = metadataList.length;
                  for(j = 0; j < numMetadata; j++)
                  {
                     if(!item.hasExactMetadata(metadataList[j]))
                     {
                        item.addMetadata(metadataList[j]);
                     }
                  }
                  return true;
               }
               return false;
            });
         }
      }
      
      override public function getType(cls:Class, applicationDomain:ApplicationDomain) : Type
      {
         var interfaze:Type = null;
         var interfaceMetadata:Array = null;
         var numMetadata:int = 0;
         var j:int = 0;
         var metadata:Metadata = null;
         var type:Type = new Type(applicationDomain);
         var fullyQualifiedClassName:String = ClassUtils.getFullyQualifiedName(cls);
         typeCache.put(fullyQualifiedClassName,type,applicationDomain);
         var description:XML = ReflectionUtils.getTypeDescription(cls);
         type.fullName = fullyQualifiedClassName;
         type.name = ClassUtils.getNameFromFullyQualifiedName(fullyQualifiedClassName);
         var param:Class = ClassUtils.getClassParameterFromFullyQualifiedName(description.@name,applicationDomain);
         if(param != null)
         {
            type.parameters[type.parameters.length] = param;
         }
         type.clazz = cls;
         type.isDynamic = description.@isDynamic.toString() == TRUE_VALUE;
         type.isFinal = description.@isFinal.toString() == TRUE_VALUE;
         type.isStatic = description.@isStatic.toString() == TRUE_VALUE;
         type.alias = description.@alias;
         type.isInterface = cls === Object?false:description.factory.extendsClass.length() == 0;
         type.constructor = this.parseConstructor(type,description.factory.constructor,applicationDomain);
         type.accessors = this.parseAccessors(type,description,applicationDomain);
         type.methods = this.parseMethods(type,description,applicationDomain);
         type.staticConstants = this.parseMembers(Constant,description.constant,fullyQualifiedClassName,true,applicationDomain);
         type.constants = this.parseMembers(Constant,description.factory.constant,fullyQualifiedClassName,false,applicationDomain);
         type.staticVariables = this.parseMembers(Variable,description.variable,fullyQualifiedClassName,true,applicationDomain);
         type.variables = this.parseMembers(Variable,description.factory.variable,fullyQualifiedClassName,false,applicationDomain);
         type.extendsClasses = this.parseExtendsClasses(description.factory.extendsClass,type.applicationDomain);
         this.parseMetadata(description.factory[0].metadata,type);
         type.interfaces = this.parseImplementedInterfaces(description.factory.implementsInterface);
         var numInterfaces:int = type.interfaces.length;
         for(var i:int = 0; i < numInterfaces; i++)
         {
            interfaze = Type.forName(type.interfaces[int(i)],applicationDomain);
            if(interfaze != null)
            {
               this.concatMetadata(type,interfaze.methods,METHODS_NAME);
               this.concatMetadata(type,interfaze.accessors,ACCESSORS_NAME);
               interfaceMetadata = interfaze.metadata;
               numMetadata = interfaceMetadata.length;
               for(j = 0; j < numMetadata; j++)
               {
                  metadata = interfaceMetadata[int(j)];
                  if(!type.hasExactMetadata(metadata))
                  {
                     type.addMetadata(metadata);
                  }
               }
            }
         }
         type.createMetadataLookup();
         return type;
      }
      
      private function parseConstructor(type:Type, constructorXML:XMLList, applicationDomain:ApplicationDomain) : Constructor
      {
         var params:Array = null;
         if(constructorXML.length() > 0)
         {
            params = this.parseParameters(constructorXML[0].parameter,applicationDomain);
            return new Constructor(type.fullName,applicationDomain,params);
         }
         return new Constructor(type.fullName,applicationDomain);
      }
      
      private function parseMethods(type:Type, xml:XML, applicationDomain:ApplicationDomain) : Array
      {
         var classMethods:Array = this.parseMethodsByModifier(type,xml.method,true,applicationDomain);
         var instanceMethods:Array = this.parseMethodsByModifier(type,xml.factory.method,false,applicationDomain);
         return classMethods.concat(instanceMethods);
      }
      
      private function parseAccessors(type:Type, xml:XML, applicationDomain:ApplicationDomain) : Array
      {
         var classAccessors:Array = this.parseAccessorsByModifier(type,xml.accessor,true,applicationDomain);
         var instanceAccessors:Array = this.parseAccessorsByModifier(type,xml.factory.accessor,false,applicationDomain);
         return classAccessors.concat(instanceAccessors);
      }
      
      private function parseMembers(memberClass:Class, members:XMLList, declaringType:String, isStatic:Boolean, applicationDomain:ApplicationDomain) : Array
      {
         var m:XML = null;
         var member:IMember = null;
         var result:Array = [];
         for each(m in members)
         {
            member = memberClass["newInstance"](m.@name,m.@type.toString(),declaringType,isStatic,applicationDomain);
            if(member is INamespaceOwner)
            {
               INamespaceOwner(member).as3commons_reflect::setNamespaceURI(m.@uri.toString());
            }
            this.parseMetadata(m.metadata,member);
            result[result.length] = member;
         }
         return result;
      }
      
      private function parseImplementedInterfaces(interfacesDescription:XMLList) : Array
      {
         var numInterfaces:int = 0;
         var i:int = 0;
         var fullyQualifiedInterfaceName:String = null;
         var result:Array = [];
         if(interfacesDescription)
         {
            numInterfaces = interfacesDescription.length();
            for(i = 0; i < numInterfaces; i++)
            {
               fullyQualifiedInterfaceName = interfacesDescription[i].@type.toString();
               fullyQualifiedInterfaceName = ClassUtils.convertFullyQualifiedName(fullyQualifiedInterfaceName);
               result[result.length] = fullyQualifiedInterfaceName;
            }
         }
         return result;
      }
      
      private function parseExtendsClasses(extendedClasses:XMLList, applicationDomain:ApplicationDomain) : Array
      {
         var node:XML = null;
         var result:Array = [];
         for each(node in extendedClasses)
         {
            result[result.length] = node.@type.toString();
         }
         return result;
      }
      
      private function parseMethodsByModifier(type:Type, methodsXML:XMLList, isStatic:Boolean, applicationDomain:ApplicationDomain) : Array
      {
         var methodXML:XML = null;
         var params:Array = null;
         var method:Method = null;
         var result:Array = [];
         for each(methodXML in methodsXML)
         {
            params = this.parseParameters(methodXML.parameter,applicationDomain);
            method = new Method(type.fullName,methodXML.@name,isStatic,params,methodXML.@returnType,applicationDomain);
            method.as3commons_reflect::setNamespaceURI(methodXML.@uri);
            this.parseMetadata(methodXML.metadata,method);
            result[result.length] = method;
         }
         return result;
      }
      
      private function parseParameters(paramsXML:XMLList, applicationDomain:ApplicationDomain) : Array
      {
         var paramXML:XML = null;
         var param:BaseParameter = null;
         var params:Array = [];
         for each(paramXML in paramsXML)
         {
            param = BaseParameter.newInstance(paramXML.@type,applicationDomain,paramXML.@optional == TRUE_VALUE?true:false);
            params[params.length] = param;
         }
         return params;
      }
      
      private function parseAccessorsByModifier(type:Type, accessorsXML:XMLList, isStatic:Boolean, applicationDomain:ApplicationDomain) : Array
      {
         var accessorXML:XML = null;
         var accessor:Accessor = null;
         var result:Array = [];
         for each(accessorXML in accessorsXML)
         {
            accessor = Accessor.newInstance(accessorXML.@name,AccessorAccess.fromString(accessorXML.@access),accessorXML.@type.toString(),accessorXML.@declaredBy.toString(),isStatic,applicationDomain);
            if(StringUtils.hasText(accessorXML.@uri))
            {
               accessor.as3commons_reflect::setNamespaceURI(accessorXML.@uri.toString());
            }
            this.parseMetadata(accessorXML.metadata,accessor);
            result[result.length] = accessor;
         }
         return result;
      }
      
      private function parseMetadata(metadataNodes:XMLList, metadata:IMetadataContainer) : void
      {
         var metadataXML:XML = null;
         var metadataArgs:Array = null;
         var metadataArgNode:XML = null;
         for each(metadataXML in metadataNodes)
         {
            metadataArgs = [];
            for each(metadataArgNode in metadataXML.arg)
            {
               metadataArgs[metadataArgs.length] = MetadataArgument.newInstance(metadataArgNode.@key,metadataArgNode.@value);
            }
            metadata.addMetadata(Metadata.newInstance(metadataXML.@name,metadataArgs));
         }
      }
   }
}
