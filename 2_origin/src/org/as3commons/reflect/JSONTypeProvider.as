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
      
      public function JSONTypeProvider()
      {
         this._ignoredMetadata = ["__go_to_definition_help","__go_to_ctor_definition_help"];
         super();
         this.initJSONTypeProvider();
      }
      
      protected function initJSONTypeProvider() : void
      {
         this._describeTypeJSON = DescribeType.getJSONFunction();
         if(this._describeTypeJSON == null)
         {
            throw new IllegalOperationError("describeTypeJSON not supported in currently installed flash player");
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
         var instanceInfo:Object = this._describeTypeJSON(cls,DescribeType.GET_INSTANCE_INFO);
         var classInfo:Object = this._describeTypeJSON(cls,DescribeType.GET_CLASS_INFO);
         type.fullName = fullyQualifiedClassName;
         type.name = ClassUtils.getNameFromFullyQualifiedName(fullyQualifiedClassName);
         var param:Class = ClassUtils.getClassParameterFromFullyQualifiedName(instanceInfo.name,applicationDomain);
         if(param != null)
         {
            type.parameters[type.parameters.length] = param;
         }
         type.clazz = cls;
         type.isDynamic = instanceInfo.isDynamic;
         type.isFinal = instanceInfo.isFinal;
         type.isStatic = instanceInfo.isStatic;
         type.alias = ALIAS_NOT_AVAILABLE;
         type.isInterface = instanceInfo.traits.bases.length == 0;
         type.constructor = this.parseConstructor(type,instanceInfo.traits.constructor,applicationDomain);
         type.accessors = this.parseAccessors(type,instanceInfo.traits.accessors,applicationDomain,false).concat(this.parseAccessors(type,classInfo.traits.accessors,applicationDomain,true));
         type.methods = this.parseMethods(type,instanceInfo.traits.methods,applicationDomain,false).concat(this.parseMethods(type,classInfo.traits.methods,applicationDomain,true));
         type.staticConstants = this.parseMembers(type,Constant,classInfo.traits.variables,fullyQualifiedClassName,true,true,applicationDomain);
         type.constants = this.parseMembers(type,Constant,instanceInfo.traits.variables,fullyQualifiedClassName,false,true,applicationDomain);
         type.staticVariables = this.parseMembers(type,Variable,classInfo.traits.variables,fullyQualifiedClassName,true,false,applicationDomain);
         type.variables = this.parseMembers(type,Variable,instanceInfo.traits.variables,fullyQualifiedClassName,false,false,applicationDomain);
         type.extendsClasses = instanceInfo.traits.bases.concat();
         this.parseMetadata(instanceInfo.traits.metadata,type);
         type.interfaces = this.parseImplementedInterfaces(instanceInfo.traits.interfaces);
         var numInterfaces:int = type.interfaces.length;
         for(var i:int = 0; i < numInterfaces; i++)
         {
            interfaze = Type.forName(type.interfaces[int(i)],applicationDomain);
            if(interfaze != null)
            {
               this.concatMetadata(type,interfaze.methods,"methods");
               this.concatMetadata(type,interfaze.accessors,"accessors");
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
      
      protected function parseConstructor(type:Type, constructor:Array, applicationDomain:ApplicationDomain) : Constructor
      {
         var params:Array = null;
         if(constructor != null && constructor.length > 0)
         {
            params = this.parseParameters(constructor,applicationDomain);
            return new Constructor(type.fullName,applicationDomain,params);
         }
         return new Constructor(type.fullName,applicationDomain);
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
      
      private function parseImplementedInterfaces(interfacesDescription:Array) : Array
      {
         var fullyQualifiedInterfaceName:String = null;
         var result:Array = [];
         for each(fullyQualifiedInterfaceName in interfacesDescription)
         {
            result[result.length] = ClassUtils.convertFullyQualifiedName(fullyQualifiedInterfaceName);
         }
         return result;
      }
      
      private function parseMethods(type:Type, methods:Array, applicationDomain:ApplicationDomain, isStatic:Boolean) : Array
      {
         var methodObj:Object = null;
         var params:Array = null;
         var method:Method = null;
         var result:Array = [];
         for each(methodObj in methods)
         {
            params = this.parseParameters(methodObj.parameters,applicationDomain);
            method = new Method(methodObj.declaredBy,methodObj.name,isStatic,params,methodObj.returnType,applicationDomain);
            method.as3commons_reflect::setNamespaceURI(methodObj.uri);
            this.parseMetadata(methodObj.metadata,method);
            result[result.length] = method;
         }
         return result;
      }
      
      private function parseParameters(params:Array, applicationDomain:ApplicationDomain) : Array
      {
         var paramObj:Object = null;
         var param:BaseParameter = null;
         var result:Array = [];
         for each(paramObj in params)
         {
            param = BaseParameter.newInstance(paramObj.type,applicationDomain,paramObj.optional);
            result[result.length] = param;
         }
         return result;
      }
      
      private function parseAccessors(type:Type, accessors:Array, applicationDomain:ApplicationDomain, isStatic:Boolean) : Array
      {
         var acc:Object = null;
         var accessor:Accessor = null;
         var result:Array = [];
         for each(acc in accessors)
         {
            accessor = Accessor.newInstance(acc.name,AccessorAccess.fromString(acc.access),acc.type,acc.declaredBy,isStatic,applicationDomain);
            accessor.as3commons_reflect::setNamespaceURI(acc.uri);
            this.parseMetadata(acc.metadata,accessor);
            result[result.length] = accessor;
         }
         return result;
      }
      
      private function parseMetadata(metadataNodes:Array, metadata:IMetadataContainer) : void
      {
         var metadataObj:Object = null;
         var metadataName:String = null;
         var metadataArgs:Array = null;
         var metadataArgNode:Object = null;
         for each(metadataObj in metadataNodes)
         {
            metadataName = metadataObj.name;
            if(!this.isIgnoredMetadata(metadataName))
            {
               metadataArgs = [];
               for each(metadataArgNode in metadataObj.value)
               {
                  metadataArgs[metadataArgs.length] = MetadataArgument.newInstance(metadataArgNode.key,metadataArgNode.value);
               }
               metadata.addMetadata(Metadata.newInstance(metadataName,metadataArgs));
            }
         }
      }
      
      private function isIgnoredMetadata(metadataName:String) : Boolean
      {
         return this._ignoredMetadata.indexOf(metadataName) > -1;
      }
      
      private function parseMembers(type:Type, memberClass:Class, members:Array, declaringType:String, isStatic:Boolean, isConstant:Boolean, applicationDomain:ApplicationDomain) : Array
      {
         var m:Object = null;
         var member:IMember = null;
         var result:Array = [];
         for each(m in members)
         {
            if(!(isConstant && m.access != AccessorAccess.READ_ONLY.name))
            {
               if(!(!isConstant && m.access == AccessorAccess.READ_ONLY.name))
               {
                  member = memberClass["newInstance"](m.name,m.type,declaringType,isStatic,applicationDomain);
                  if(member is INamespaceOwner)
                  {
                     INamespaceOwner(member).as3commons_reflect::setNamespaceURI(m.uri);
                  }
                  this.parseMetadata(m.metadata,member);
                  result[result.length] = member;
               }
            }
         }
         return result;
      }
   }
}
