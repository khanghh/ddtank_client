package org.as3commons.lang
{
   import flash.events.TimerEvent;
   import flash.system.ApplicationDomain;
   import flash.utils.Proxy;
   import flash.utils.Timer;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getQualifiedSuperclassName;
   
   public final class ClassUtils
   {
      
      public static const CLEAR_CACHE_INTERVAL:uint = 60000;
      
      private static const AS3VEC_SUFFIX:String = "__AS3__.vec";
      
      private static const LESS_THAN:String = "<";
      
      private static const CONSTRUCTOR_FIELD_NAME:String = "constructor";
      
      private static const PACKAGE_CLASS_SEPARATOR:String = "::";
      
      public static var clearCacheInterval:uint = CLEAR_CACHE_INTERVAL;
      
      private static var _describeTypeCache:Object = {};
      
      private static var _timer:Timer;
       
      
      public function ClassUtils()
      {
         super();
      }
      
      public static function forInstance(instance:*, applicationDomain:ApplicationDomain = null) : Class
      {
         var className:String = null;
         if(!(instance is Proxy) && instance.hasOwnProperty(CONSTRUCTOR_FIELD_NAME))
         {
            return instance[CONSTRUCTOR_FIELD_NAME] as Class;
         }
         className = getQualifiedClassName(instance);
         return forName(className,applicationDomain);
      }
      
      public static function forName(name:String, applicationDomain:ApplicationDomain = null) : Class
      {
         var result:Class = null;
         var applicationDomain:ApplicationDomain = applicationDomain || ApplicationDomain.currentDomain;
         if(!applicationDomain)
         {
            applicationDomain = ApplicationDomain.currentDomain;
         }
         while(!applicationDomain.hasDefinition(name))
         {
            if(applicationDomain.parentDomain)
            {
               applicationDomain = applicationDomain.parentDomain;
               continue;
            }
            break;
         }
         try
         {
            result = applicationDomain.getDefinition(name) as Class;
         }
         catch(e:ReferenceError)
         {
            throw new ClassNotFoundError("A class with the name \'" + name + "\' could not be found.");
         }
         return result;
      }
      
      public static function getName(clazz:Class) : String
      {
         return getNameFromFullyQualifiedName(getFullyQualifiedName(clazz));
      }
      
      public static function getNameFromFullyQualifiedName(fullyQualifiedName:String) : String
      {
         var startIndex:int = fullyQualifiedName.indexOf(PACKAGE_CLASS_SEPARATOR);
         if(startIndex == -1)
         {
            return fullyQualifiedName;
         }
         return fullyQualifiedName.substring(startIndex + PACKAGE_CLASS_SEPARATOR.length,fullyQualifiedName.length);
      }
      
      public static function getFullyQualifiedName(clazz:Class, replaceColons:Boolean = false) : String
      {
         var result:String = getQualifiedClassName(clazz);
         if(replaceColons)
         {
            return convertFullyQualifiedName(result);
         }
         return result;
      }
      
      public static function isAssignableFrom(clazz1:Class, clazz2:Class, applicationDomain:ApplicationDomain = null) : Boolean
      {
         return clazz1 === clazz2 || isSubclassOf(clazz2,clazz1,applicationDomain) || isImplementationOf(clazz2,clazz1,applicationDomain);
      }
      
      public static function isPrivateClass(object:*) : Boolean
      {
         var className:String = object is Class?getQualifiedClassName(object):object.toString();
         var index:int = className.indexOf("::");
         var inRootPackage:* = index == -1;
         if(inRootPackage)
         {
            return false;
         }
         var ns:String = className.substr(0,index);
         return ns === "" || ns.indexOf(".as$") > -1;
      }
      
      public static function getProperties(clazz:*, statik:Boolean = false, readable:Boolean = true, writable:Boolean = true, applicationDomain:ApplicationDomain = null) : Object
      {
         var properties:XMLList = null;
         var result:Object = null;
         var node:XML = null;
         var nodeClass:Class = null;
         var xml:XML = getFromObject(clazz,applicationDomain);
         if(!statik)
         {
            xml = xml.factory[0];
         }
         if(readable && writable)
         {
            properties = xml.accessor.(@access == "readwrite") + xml.variable;
         }
         else if(!readable && !writable)
         {
            properties = new XMLList();
         }
         else if(!writable)
         {
            properties = xml.constant + xml.accessor.(@access == "readonly");
         }
         else
         {
            properties = xml.accessor.(@access == "writeonly");
         }
         result = {};
         for each(node in properties)
         {
            try
            {
               nodeClass = ClassUtils.forName(node.@type);
            }
            catch(e:Error)
            {
               nodeClass = Object;
            }
            if(node.@uri && QName(node.@uri).localName != "")
            {
               result[node.@uri + "::" + node.@name] = nodeClass;
            }
            else
            {
               result[node.@name] = nodeClass;
            }
         }
         return result;
      }
      
      public static function isSubclassOf(clazz:Class, parentClass:Class, applicationDomain:ApplicationDomain = null) : Boolean
      {
         var classDescription:XML = getFromObject(clazz,applicationDomain);
         var parentName:String = getQualifiedClassName(parentClass);
         return classDescription.factory.extendsClass.(@type == parentName).length() != 0;
      }
      
      public static function getSuperClass(clazz:Class, applicationDomain:ApplicationDomain = null) : Class
      {
         var result:Class = null;
         var classDescription:XML = getFromObject(clazz,applicationDomain);
         var superClasses:XMLList = classDescription.factory.extendsClass;
         if(superClasses.length() > 0)
         {
            result = ClassUtils.forName(superClasses[0].@type);
         }
         return result;
      }
      
      public static function getSuperClassName(clazz:Class) : String
      {
         var fullyQualifiedName:String = getFullyQualifiedSuperClassName(clazz);
         var index:int = fullyQualifiedName.indexOf(PACKAGE_CLASS_SEPARATOR) + PACKAGE_CLASS_SEPARATOR.length;
         return fullyQualifiedName.substring(index,fullyQualifiedName.length);
      }
      
      public static function getFullyQualifiedSuperClassName(clazz:Class, replaceColons:Boolean = false) : String
      {
         var result:String = getQualifiedSuperclassName(clazz);
         if(replaceColons)
         {
            result = convertFullyQualifiedName(result);
         }
         return result;
      }
      
      public static function isImplementationOf(clazz:Class, interfaze:Class, applicationDomain:ApplicationDomain = null) : Boolean
      {
         var result:Boolean = false;
         var classDescription:XML = null;
         if(clazz == null)
         {
            result = false;
         }
         else
         {
            classDescription = getFromObject(clazz,applicationDomain);
            result = classDescription.factory.implementsInterface.(@type == getQualifiedClassName(interfaze)).length() != 0;
         }
         return result;
      }
      
      public static function isInformalImplementationOf(clazz:Class, interfaze:Class, applicationDomain:ApplicationDomain = null) : Boolean
      {
         var classDescription:XML = null;
         var interfaceDescription:XML = null;
         var interfaceAccessors:XMLList = null;
         var interfaceAccessor:XML = null;
         var interfaceMethods:XMLList = null;
         var interfaceMethod:XML = null;
         var accessorMatchesInClass:XMLList = null;
         var methodMatchesInClass:XMLList = null;
         var interfaceMethodParameters:XMLList = null;
         var classMethodParameters:XMLList = null;
         var interfaceParameter:XML = null;
         var parameterMatchesInClass:XMLList = null;
         var result:Boolean = true;
         if(clazz == null)
         {
            result = false;
         }
         else
         {
            classDescription = getFromObject(clazz,applicationDomain);
            interfaceDescription = getFromObject(interfaze,applicationDomain);
            interfaceAccessors = interfaceDescription.factory.accessor;
            for each(interfaceAccessor in interfaceAccessors)
            {
               accessorMatchesInClass = classDescription.factory.accessor.(@name == interfaceAccessor.@name && @access == interfaceAccessor.@access && @type == interfaceAccessor.@type);
               if(accessorMatchesInClass.length() < 1)
               {
                  result = false;
                  break;
               }
            }
            interfaceMethods = interfaceDescription.factory.method;
            for each(interfaceMethod in interfaceMethods)
            {
               methodMatchesInClass = classDescription.factory.method.(@name == interfaceMethod.@name && @returnType == interfaceMethod.@returnType);
               if(methodMatchesInClass.length() < 1)
               {
                  result = false;
                  break;
               }
               interfaceMethodParameters = interfaceMethod.parameter;
               classMethodParameters = methodMatchesInClass.parameter;
               if(interfaceMethodParameters.length() != classMethodParameters.length())
               {
                  result = false;
               }
               for each(interfaceParameter in interfaceMethodParameters)
               {
                  parameterMatchesInClass = methodMatchesInClass.parameter.(@index == interfaceParameter.@index && @type == interfaceParameter.@type && @optional == interfaceParameter.@optional);
                  if(parameterMatchesInClass.length() < 1)
                  {
                     result = false;
                     break;
                  }
               }
            }
         }
         return result;
      }
      
      public static function isInterface(clazz:Class) : Boolean
      {
         return clazz === Object?false:describeType(clazz).factory.extendsClass.length() == 0;
      }
      
      public static function getImplementedInterfaceNames(clazz:Class) : Array
      {
         var result:Array = getFullyQualifiedImplementedInterfaceNames(clazz);
         for(var i:int = 0; i < result.length; i++)
         {
            result[i] = getNameFromFullyQualifiedName(result[i]);
         }
         return result;
      }
      
      public static function getFullyQualifiedImplementedInterfaceNames(clazz:Class, replaceColons:Boolean = false, applicationDomain:ApplicationDomain = null) : Array
      {
         var numInterfaces:int = 0;
         var i:int = 0;
         var fullyQualifiedInterfaceName:String = null;
         var result:Array = [];
         var classDescription:XML = getFromObject(clazz,applicationDomain);
         var interfacesDescription:XMLList = classDescription.factory.implementsInterface;
         if(interfacesDescription)
         {
            numInterfaces = interfacesDescription.length();
            for(i = 0; i < numInterfaces; i++)
            {
               fullyQualifiedInterfaceName = interfacesDescription[i].@type.toString();
               if(replaceColons)
               {
                  fullyQualifiedInterfaceName = convertFullyQualifiedName(fullyQualifiedInterfaceName);
               }
               result[result.length] = fullyQualifiedInterfaceName;
            }
         }
         return result;
      }
      
      public static function getImplementedInterfaces(clazz:Class, applicationDomain:ApplicationDomain = null) : Array
      {
         applicationDomain = applicationDomain || ApplicationDomain.currentDomain;
         var result:Array = getFullyQualifiedImplementedInterfaceNames(clazz);
         for(var i:int = 0; i < result.length; i++)
         {
            result[i] = ClassUtils.forName(result[i],applicationDomain);
         }
         return result;
      }
      
      public static function newInstance(clazz:Class, args:Array = null) : *
      {
         var result:* = undefined;
         var a:Array = args == null?[]:args;
         switch(a.length)
         {
            case 1:
               result = new clazz(a[0]);
               break;
            case 2:
               result = new clazz(a[0],a[1]);
               break;
            case 3:
               result = new clazz(a[0],a[1],a[2]);
               break;
            case 4:
               result = new clazz(a[0],a[1],a[2],a[3]);
               break;
            case 5:
               result = new clazz(a[0],a[1],a[2],a[3],a[4]);
               break;
            case 6:
               result = new clazz(a[0],a[1],a[2],a[3],a[4],a[5]);
               break;
            case 7:
               result = new clazz(a[0],a[1],a[2],a[3],a[4],a[5],a[6]);
               break;
            case 8:
               result = new clazz(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7]);
               break;
            case 9:
               result = new clazz(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8]);
               break;
            case 10:
               result = new clazz(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9]);
               break;
            default:
               result = new clazz();
         }
         return result;
      }
      
      public static function convertFullyQualifiedName(className:String) : String
      {
         return className.replace(PACKAGE_CLASS_SEPARATOR,".");
      }
      
      public static function clearDescribeTypeCache() : void
      {
         _describeTypeCache = {};
         if(_timer && _timer.running)
         {
            _timer.stop();
         }
      }
      
      public static function getClassParameterFromFullyQualifiedName(fullName:String, applicationDomain:ApplicationDomain = null) : Class
      {
         var startIdx:int = 0;
         var len:int = 0;
         var className:String = null;
         if(StringUtils.startsWith(fullName,AS3VEC_SUFFIX))
         {
            startIdx = fullName.indexOf(LESS_THAN) + 1;
            len = fullName.length - startIdx - 1;
            className = fullName.substr(startIdx,len);
            return forName(className,applicationDomain);
         }
         return null;
      }
      
      private static function timerHandler(e:TimerEvent) : void
      {
         clearDescribeTypeCache();
      }
      
      private static function getFromObject(object:Object, applicationDomain:ApplicationDomain) : XML
      {
         var metadata:XML = null;
         Assert.notNull(object,"The object argument must not be null");
         var className:String = getQualifiedClassName(object);
         if(_describeTypeCache.hasOwnProperty(className))
         {
            metadata = _describeTypeCache[className];
         }
         else
         {
            if(!_timer)
            {
               _timer = new Timer(clearCacheInterval,1);
               _timer.addEventListener(TimerEvent.TIMER,timerHandler);
            }
            if(!(object is Class))
            {
               if(object.hasOwnProperty(CONSTRUCTOR_FIELD_NAME))
               {
                  object = object.constructor;
               }
               else
               {
                  object = forName(className,applicationDomain);
               }
            }
            metadata = describeType(object);
            _describeTypeCache[className] = metadata;
            if(!_timer.running)
            {
               _timer.start();
            }
         }
         return metadata;
      }
   }
}
