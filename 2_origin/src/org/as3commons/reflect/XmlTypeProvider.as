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
      
      private function concatMetadata(param1:Type, param2:Array, param3:String) : void
      {
         var container:IMetadataContainer = null;
         var type:Type = param1;
         var metadataContainers:Array = param2;
         var propertyName:String = param3;
         for each(container in metadataContainers)
         {
            type[propertyName].some(function(param1:MetadataContainer, param2:int, param3:Array):Boolean
            {
               var _loc4_:Array = null;
               var _loc5_:int = 0;
               var _loc6_:int = 0;
               if(Object(param1).name == Object(container).name)
               {
                  _loc4_ = container.metadata;
                  _loc5_ = _loc4_.length;
                  _loc6_ = 0;
                  while(_loc6_ < _loc5_)
                  {
                     if(!param1.hasExactMetadata(_loc4_[_loc6_]))
                     {
                        param1.addMetadata(_loc4_[_loc6_]);
                     }
                     _loc6_++;
                  }
                  return true;
               }
               return false;
            });
         }
      }
      
      override public function getType(param1:Class, param2:ApplicationDomain) : Type
      {
         var _loc9_:Type = null;
         var _loc10_:Array = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Metadata = null;
         var _loc3_:Type = new Type(param2);
         var _loc4_:String = ClassUtils.getFullyQualifiedName(param1);
         typeCache.put(_loc4_,_loc3_,param2);
         var _loc5_:XML = ReflectionUtils.getTypeDescription(param1);
         _loc3_.fullName = _loc4_;
         _loc3_.name = ClassUtils.getNameFromFullyQualifiedName(_loc4_);
         var _loc6_:Class = ClassUtils.getClassParameterFromFullyQualifiedName(_loc5_.@name,param2);
         if(_loc6_ != null)
         {
            _loc3_.parameters[_loc3_.parameters.length] = _loc6_;
         }
         _loc3_.clazz = param1;
         _loc3_.isDynamic = _loc5_.@isDynamic.toString() == TRUE_VALUE;
         _loc3_.isFinal = _loc5_.@isFinal.toString() == TRUE_VALUE;
         _loc3_.isStatic = _loc5_.@isStatic.toString() == TRUE_VALUE;
         _loc3_.alias = _loc5_.@alias;
         _loc3_.isInterface = param1 === Object?false:_loc5_.factory.extendsClass.length() == 0;
         _loc3_.constructor = this.parseConstructor(_loc3_,_loc5_.factory.constructor,param2);
         _loc3_.accessors = this.parseAccessors(_loc3_,_loc5_,param2);
         _loc3_.methods = this.parseMethods(_loc3_,_loc5_,param2);
         _loc3_.staticConstants = this.parseMembers(Constant,_loc5_.constant,_loc4_,true,param2);
         _loc3_.constants = this.parseMembers(Constant,_loc5_.factory.constant,_loc4_,false,param2);
         _loc3_.staticVariables = this.parseMembers(Variable,_loc5_.variable,_loc4_,true,param2);
         _loc3_.variables = this.parseMembers(Variable,_loc5_.factory.variable,_loc4_,false,param2);
         _loc3_.extendsClasses = this.parseExtendsClasses(_loc5_.factory.extendsClass,_loc3_.applicationDomain);
         this.parseMetadata(_loc5_.factory[0].metadata,_loc3_);
         _loc3_.interfaces = this.parseImplementedInterfaces(_loc5_.factory.implementsInterface);
         var _loc7_:int = _loc3_.interfaces.length;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc9_ = Type.forName(_loc3_.interfaces[int(_loc8_)],param2);
            if(_loc9_ != null)
            {
               this.concatMetadata(_loc3_,_loc9_.methods,METHODS_NAME);
               this.concatMetadata(_loc3_,_loc9_.accessors,ACCESSORS_NAME);
               _loc10_ = _loc9_.metadata;
               _loc11_ = _loc10_.length;
               _loc12_ = 0;
               while(_loc12_ < _loc11_)
               {
                  _loc13_ = _loc10_[int(_loc12_)];
                  if(!_loc3_.hasExactMetadata(_loc13_))
                  {
                     _loc3_.addMetadata(_loc13_);
                  }
                  _loc12_++;
               }
            }
            _loc8_++;
         }
         _loc3_.createMetadataLookup();
         return _loc3_;
      }
      
      private function parseConstructor(param1:Type, param2:XMLList, param3:ApplicationDomain) : Constructor
      {
         var _loc4_:Array = null;
         if(param2.length() > 0)
         {
            _loc4_ = this.parseParameters(param2[0].parameter,param3);
            return new Constructor(param1.fullName,param3,_loc4_);
         }
         return new Constructor(param1.fullName,param3);
      }
      
      private function parseMethods(param1:Type, param2:XML, param3:ApplicationDomain) : Array
      {
         var _loc4_:Array = this.parseMethodsByModifier(param1,param2.method,true,param3);
         var _loc5_:Array = this.parseMethodsByModifier(param1,param2.factory.method,false,param3);
         return _loc4_.concat(_loc5_);
      }
      
      private function parseAccessors(param1:Type, param2:XML, param3:ApplicationDomain) : Array
      {
         var _loc4_:Array = this.parseAccessorsByModifier(param1,param2.accessor,true,param3);
         var _loc5_:Array = this.parseAccessorsByModifier(param1,param2.factory.accessor,false,param3);
         return _loc4_.concat(_loc5_);
      }
      
      private function parseMembers(param1:Class, param2:XMLList, param3:String, param4:Boolean, param5:ApplicationDomain) : Array
      {
         var _loc7_:XML = null;
         var _loc8_:IMember = null;
         var _loc6_:Array = [];
         for each(_loc7_ in param2)
         {
            _loc8_ = param1["newInstance"](_loc7_.@name,_loc7_.@type.toString(),param3,param4,param5);
            if(_loc8_ is INamespaceOwner)
            {
               INamespaceOwner(_loc8_).as3commons_reflect::setNamespaceURI(_loc7_.@uri.toString());
            }
            this.parseMetadata(_loc7_.metadata,_loc8_);
            _loc6_[_loc6_.length] = _loc8_;
         }
         return _loc6_;
      }
      
      private function parseImplementedInterfaces(param1:XMLList) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc2_:Array = [];
         if(param1)
         {
            _loc3_ = param1.length();
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = param1[_loc4_].@type.toString();
               _loc5_ = ClassUtils.convertFullyQualifiedName(_loc5_);
               _loc2_[_loc2_.length] = _loc5_;
               _loc4_++;
            }
         }
         return _loc2_;
      }
      
      private function parseExtendsClasses(param1:XMLList, param2:ApplicationDomain) : Array
      {
         var _loc4_:XML = null;
         var _loc3_:Array = [];
         for each(_loc4_ in param1)
         {
            _loc3_[_loc3_.length] = _loc4_.@type.toString();
         }
         return _loc3_;
      }
      
      private function parseMethodsByModifier(param1:Type, param2:XMLList, param3:Boolean, param4:ApplicationDomain) : Array
      {
         var _loc6_:XML = null;
         var _loc7_:Array = null;
         var _loc8_:Method = null;
         var _loc5_:Array = [];
         for each(_loc6_ in param2)
         {
            _loc7_ = this.parseParameters(_loc6_.parameter,param4);
            _loc8_ = new Method(param1.fullName,_loc6_.@name,param3,_loc7_,_loc6_.@returnType,param4);
            _loc8_.as3commons_reflect::setNamespaceURI(_loc6_.@uri);
            this.parseMetadata(_loc6_.metadata,_loc8_);
            _loc5_[_loc5_.length] = _loc8_;
         }
         return _loc5_;
      }
      
      private function parseParameters(param1:XMLList, param2:ApplicationDomain) : Array
      {
         var _loc4_:XML = null;
         var _loc5_:BaseParameter = null;
         var _loc3_:Array = [];
         for each(_loc4_ in param1)
         {
            _loc5_ = BaseParameter.newInstance(_loc4_.@type,param2,_loc4_.@optional == TRUE_VALUE?true:false);
            _loc3_[_loc3_.length] = _loc5_;
         }
         return _loc3_;
      }
      
      private function parseAccessorsByModifier(param1:Type, param2:XMLList, param3:Boolean, param4:ApplicationDomain) : Array
      {
         var _loc6_:XML = null;
         var _loc7_:Accessor = null;
         var _loc5_:Array = [];
         for each(_loc6_ in param2)
         {
            _loc7_ = Accessor.newInstance(_loc6_.@name,AccessorAccess.fromString(_loc6_.@access),_loc6_.@type.toString(),_loc6_.@declaredBy.toString(),param3,param4);
            if(StringUtils.hasText(_loc6_.@uri))
            {
               _loc7_.as3commons_reflect::setNamespaceURI(_loc6_.@uri.toString());
            }
            this.parseMetadata(_loc6_.metadata,_loc7_);
            _loc5_[_loc5_.length] = _loc7_;
         }
         return _loc5_;
      }
      
      private function parseMetadata(param1:XMLList, param2:IMetadataContainer) : void
      {
         var _loc3_:XML = null;
         var _loc4_:Array = null;
         var _loc5_:XML = null;
         for each(_loc3_ in param1)
         {
            _loc4_ = [];
            for each(_loc5_ in _loc3_.arg)
            {
               _loc4_[_loc4_.length] = MetadataArgument.newInstance(_loc5_.@key,_loc5_.@value);
            }
            param2.addMetadata(Metadata.newInstance(_loc3_.@name,_loc4_));
         }
      }
   }
}
