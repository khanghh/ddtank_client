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
      
      public static function forInstance(param1:*, param2:ApplicationDomain = null) : Class
      {
         var _loc3_:String = null;
         if(!(param1 is Proxy) && param1.hasOwnProperty(CONSTRUCTOR_FIELD_NAME))
         {
            return param1[CONSTRUCTOR_FIELD_NAME] as Class;
         }
         _loc3_ = getQualifiedClassName(param1);
         return forName(_loc3_,param2);
      }
      
      public static function forName(param1:String, param2:ApplicationDomain = null) : Class
      {
         var result:Class = null;
         var name:String = param1;
         var applicationDomain:ApplicationDomain = param2;
         applicationDomain = applicationDomain || ApplicationDomain.currentDomain;
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
      
      public static function getName(param1:Class) : String
      {
         return getNameFromFullyQualifiedName(getFullyQualifiedName(param1));
      }
      
      public static function getNameFromFullyQualifiedName(param1:String) : String
      {
         var _loc2_:int = param1.indexOf(PACKAGE_CLASS_SEPARATOR);
         if(_loc2_ == -1)
         {
            return param1;
         }
         return param1.substring(_loc2_ + PACKAGE_CLASS_SEPARATOR.length,param1.length);
      }
      
      public static function getFullyQualifiedName(param1:Class, param2:Boolean = false) : String
      {
         var _loc3_:String = getQualifiedClassName(param1);
         if(param2)
         {
            return convertFullyQualifiedName(_loc3_);
         }
         return _loc3_;
      }
      
      public static function isAssignableFrom(param1:Class, param2:Class, param3:ApplicationDomain = null) : Boolean
      {
         return param1 === param2 || isSubclassOf(param2,param1,param3) || isImplementationOf(param2,param1,param3);
      }
      
      public static function isPrivateClass(param1:*) : Boolean
      {
         var _loc2_:String = param1 is Class?getQualifiedClassName(param1):param1.toString();
         var _loc3_:int = _loc2_.indexOf("::");
         var _loc4_:* = _loc3_ == -1;
         if(_loc4_)
         {
            return false;
         }
         var _loc5_:String = _loc2_.substr(0,_loc3_);
         return _loc5_ === "" || _loc5_.indexOf(".as$") > -1;
      }
      
      public static function getProperties(param1:*, param2:Boolean = false, param3:Boolean = true, param4:Boolean = true, param5:ApplicationDomain = null) : Object
      {
         var properties:XMLList = null;
         var result:Object = null;
         var node:XML = null;
         var nodeClass:Class = null;
         var clazz:* = param1;
         var statik:Boolean = param2;
         var readable:Boolean = param3;
         var writable:Boolean = param4;
         var applicationDomain:ApplicationDomain = param5;
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
      
      public static function isSubclassOf(param1:Class, param2:Class, param3:ApplicationDomain = null) : Boolean
      {
         var clazz:Class = param1;
         var parentClass:Class = param2;
         var applicationDomain:ApplicationDomain = param3;
         var classDescription:XML = getFromObject(clazz,applicationDomain);
         var parentName:String = getQualifiedClassName(parentClass);
         return classDescription.factory.extendsClass.(@type == parentName).length() != 0;
      }
      
      public static function getSuperClass(param1:Class, param2:ApplicationDomain = null) : Class
      {
         var _loc3_:Class = null;
         var _loc4_:XML = getFromObject(param1,param2);
         var _loc5_:XMLList = _loc4_.factory.extendsClass;
         if(_loc5_.length() > 0)
         {
            _loc3_ = ClassUtils.forName(_loc5_[0].@type);
         }
         return _loc3_;
      }
      
      public static function getSuperClassName(param1:Class) : String
      {
         var _loc2_:String = getFullyQualifiedSuperClassName(param1);
         var _loc3_:int = _loc2_.indexOf(PACKAGE_CLASS_SEPARATOR) + PACKAGE_CLASS_SEPARATOR.length;
         return _loc2_.substring(_loc3_,_loc2_.length);
      }
      
      public static function getFullyQualifiedSuperClassName(param1:Class, param2:Boolean = false) : String
      {
         var _loc3_:String = getQualifiedSuperclassName(param1);
         if(param2)
         {
            _loc3_ = convertFullyQualifiedName(_loc3_);
         }
         return _loc3_;
      }
      
      public static function isImplementationOf(param1:Class, param2:Class, param3:ApplicationDomain = null) : Boolean
      {
         var result:Boolean = false;
         var classDescription:XML = null;
         var clazz:Class = param1;
         var interfaze:Class = param2;
         var applicationDomain:ApplicationDomain = param3;
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
      
      public static function isInformalImplementationOf(param1:Class, param2:Class, param3:ApplicationDomain = null) : Boolean
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
         var clazz:Class = param1;
         var interfaze:Class = param2;
         var applicationDomain:ApplicationDomain = param3;
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
      
      public static function isInterface(param1:Class) : Boolean
      {
         return param1 === Object?false:describeType(param1).factory.extendsClass.length() == 0;
      }
      
      public static function getImplementedInterfaceNames(param1:Class) : Array
      {
         var _loc2_:Array = getFullyQualifiedImplementedInterfaceNames(param1);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc2_[_loc3_] = getNameFromFullyQualifiedName(_loc2_[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function getFullyQualifiedImplementedInterfaceNames(param1:Class, param2:Boolean = false, param3:ApplicationDomain = null) : Array
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc4_:Array = [];
         var _loc5_:XML = getFromObject(param1,param3);
         var _loc6_:XMLList = _loc5_.factory.implementsInterface;
         if(_loc6_)
         {
            _loc7_ = _loc6_.length();
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc9_ = _loc6_[_loc8_].@type.toString();
               if(param2)
               {
                  _loc9_ = convertFullyQualifiedName(_loc9_);
               }
               _loc4_[_loc4_.length] = _loc9_;
               _loc8_++;
            }
         }
         return _loc4_;
      }
      
      public static function getImplementedInterfaces(param1:Class, param2:ApplicationDomain = null) : Array
      {
         param2 = param2 || ApplicationDomain.currentDomain;
         var _loc3_:Array = getFullyQualifiedImplementedInterfaceNames(param1);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc3_[_loc4_] = ClassUtils.forName(_loc3_[_loc4_],param2);
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function newInstance(param1:Class, param2:Array = null) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:Array = param2 == null?[]:param2;
         switch(_loc4_.length)
         {
            case 1:
               _loc3_ = new param1(_loc4_[0]);
               break;
            case 2:
               _loc3_ = new param1(_loc4_[0],_loc4_[1]);
               break;
            case 3:
               _loc3_ = new param1(_loc4_[0],_loc4_[1],_loc4_[2]);
               break;
            case 4:
               _loc3_ = new param1(_loc4_[0],_loc4_[1],_loc4_[2],_loc4_[3]);
               break;
            case 5:
               _loc3_ = new param1(_loc4_[0],_loc4_[1],_loc4_[2],_loc4_[3],_loc4_[4]);
               break;
            case 6:
               _loc3_ = new param1(_loc4_[0],_loc4_[1],_loc4_[2],_loc4_[3],_loc4_[4],_loc4_[5]);
               break;
            case 7:
               _loc3_ = new param1(_loc4_[0],_loc4_[1],_loc4_[2],_loc4_[3],_loc4_[4],_loc4_[5],_loc4_[6]);
               break;
            case 8:
               _loc3_ = new param1(_loc4_[0],_loc4_[1],_loc4_[2],_loc4_[3],_loc4_[4],_loc4_[5],_loc4_[6],_loc4_[7]);
               break;
            case 9:
               _loc3_ = new param1(_loc4_[0],_loc4_[1],_loc4_[2],_loc4_[3],_loc4_[4],_loc4_[5],_loc4_[6],_loc4_[7],_loc4_[8]);
               break;
            case 10:
               _loc3_ = new param1(_loc4_[0],_loc4_[1],_loc4_[2],_loc4_[3],_loc4_[4],_loc4_[5],_loc4_[6],_loc4_[7],_loc4_[8],_loc4_[9]);
               break;
            default:
               _loc3_ = new param1();
         }
         return _loc3_;
      }
      
      public static function convertFullyQualifiedName(param1:String) : String
      {
         return param1.replace(PACKAGE_CLASS_SEPARATOR,".");
      }
      
      public static function clearDescribeTypeCache() : void
      {
         _describeTypeCache = {};
         if(_timer && _timer.running)
         {
            _timer.stop();
         }
      }
      
      public static function getClassParameterFromFullyQualifiedName(param1:String, param2:ApplicationDomain = null) : Class
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         if(StringUtils.startsWith(param1,AS3VEC_SUFFIX))
         {
            _loc3_ = param1.indexOf(LESS_THAN) + 1;
            _loc4_ = param1.length - _loc3_ - 1;
            _loc5_ = param1.substr(_loc3_,_loc4_);
            return forName(_loc5_,param2);
         }
         return null;
      }
      
      private static function timerHandler(param1:TimerEvent) : void
      {
         clearDescribeTypeCache();
      }
      
      private static function getFromObject(param1:Object, param2:ApplicationDomain) : XML
      {
         var _loc4_:XML = null;
         Assert.notNull(param1,"The object argument must not be null");
         var _loc3_:String = getQualifiedClassName(param1);
         if(_describeTypeCache.hasOwnProperty(_loc3_))
         {
            _loc4_ = _describeTypeCache[_loc3_];
         }
         else
         {
            if(!_timer)
            {
               _timer = new Timer(clearCacheInterval,1);
               _timer.addEventListener(TimerEvent.TIMER,timerHandler);
            }
            if(!(param1 is Class))
            {
               if(param1.hasOwnProperty(CONSTRUCTOR_FIELD_NAME))
               {
                  param1 = param1.constructor;
               }
               else
               {
                  param1 = forName(_loc3_,param2);
               }
            }
            _loc4_ = describeType(param1);
            _describeTypeCache[_loc3_] = _loc4_;
            if(!_timer.running)
            {
               _timer.start();
            }
         }
         return _loc4_;
      }
   }
}
