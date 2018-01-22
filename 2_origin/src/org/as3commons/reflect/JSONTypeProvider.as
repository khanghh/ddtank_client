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
      
      override public function getType(param1:Class, param2:ApplicationDomain) : Type
      {
         var _loc10_:Type = null;
         var _loc11_:Array = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:Metadata = null;
         var _loc3_:Type = new Type(param2);
         var _loc4_:String = ClassUtils.getFullyQualifiedName(param1);
         typeCache.put(_loc4_,_loc3_,param2);
         var _loc5_:Object = this._describeTypeJSON(param1,DescribeType.GET_INSTANCE_INFO);
         var _loc6_:Object = this._describeTypeJSON(param1,DescribeType.GET_CLASS_INFO);
         _loc3_.fullName = _loc4_;
         _loc3_.name = ClassUtils.getNameFromFullyQualifiedName(_loc4_);
         var _loc7_:Class = ClassUtils.getClassParameterFromFullyQualifiedName(_loc5_.name,param2);
         if(_loc7_ != null)
         {
            _loc3_.parameters[_loc3_.parameters.length] = _loc7_;
         }
         _loc3_.clazz = param1;
         _loc3_.isDynamic = _loc5_.isDynamic;
         _loc3_.isFinal = _loc5_.isFinal;
         _loc3_.isStatic = _loc5_.isStatic;
         _loc3_.alias = ALIAS_NOT_AVAILABLE;
         _loc3_.isInterface = _loc5_.traits.bases.length == 0;
         _loc3_.constructor = this.parseConstructor(_loc3_,_loc5_.traits.constructor,param2);
         _loc3_.accessors = this.parseAccessors(_loc3_,_loc5_.traits.accessors,param2,false).concat(this.parseAccessors(_loc3_,_loc6_.traits.accessors,param2,true));
         _loc3_.methods = this.parseMethods(_loc3_,_loc5_.traits.methods,param2,false).concat(this.parseMethods(_loc3_,_loc6_.traits.methods,param2,true));
         _loc3_.staticConstants = this.parseMembers(_loc3_,Constant,_loc6_.traits.variables,_loc4_,true,true,param2);
         _loc3_.constants = this.parseMembers(_loc3_,Constant,_loc5_.traits.variables,_loc4_,false,true,param2);
         _loc3_.staticVariables = this.parseMembers(_loc3_,Variable,_loc6_.traits.variables,_loc4_,true,false,param2);
         _loc3_.variables = this.parseMembers(_loc3_,Variable,_loc5_.traits.variables,_loc4_,false,false,param2);
         _loc3_.extendsClasses = _loc5_.traits.bases.concat();
         this.parseMetadata(_loc5_.traits.metadata,_loc3_);
         _loc3_.interfaces = this.parseImplementedInterfaces(_loc5_.traits.interfaces);
         var _loc8_:int = _loc3_.interfaces.length;
         var _loc9_:int = 0;
         while(_loc9_ < _loc8_)
         {
            _loc10_ = Type.forName(_loc3_.interfaces[int(_loc9_)],param2);
            if(_loc10_ != null)
            {
               this.concatMetadata(_loc3_,_loc10_.methods,"methods");
               this.concatMetadata(_loc3_,_loc10_.accessors,"accessors");
               _loc11_ = _loc10_.metadata;
               _loc12_ = _loc11_.length;
               _loc13_ = 0;
               while(_loc13_ < _loc12_)
               {
                  _loc14_ = _loc11_[int(_loc13_)];
                  if(!_loc3_.hasExactMetadata(_loc14_))
                  {
                     _loc3_.addMetadata(_loc14_);
                  }
                  _loc13_++;
               }
            }
            _loc9_++;
         }
         _loc3_.createMetadataLookup();
         return _loc3_;
      }
      
      protected function parseConstructor(param1:Type, param2:Array, param3:ApplicationDomain) : Constructor
      {
         var _loc4_:Array = null;
         if(param2 != null && param2.length > 0)
         {
            _loc4_ = this.parseParameters(param2,param3);
            return new Constructor(param1.fullName,param3,_loc4_);
         }
         return new Constructor(param1.fullName,param3);
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
      
      private function parseImplementedInterfaces(param1:Array) : Array
      {
         var _loc3_:String = null;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            _loc2_[_loc2_.length] = ClassUtils.convertFullyQualifiedName(_loc3_);
         }
         return _loc2_;
      }
      
      private function parseMethods(param1:Type, param2:Array, param3:ApplicationDomain, param4:Boolean) : Array
      {
         var _loc6_:Object = null;
         var _loc7_:Array = null;
         var _loc8_:Method = null;
         var _loc5_:Array = [];
         for each(_loc6_ in param2)
         {
            _loc7_ = this.parseParameters(_loc6_.parameters,param3);
            _loc8_ = new Method(_loc6_.declaredBy,_loc6_.name,param4,_loc7_,_loc6_.returnType,param3);
            _loc8_.as3commons_reflect::setNamespaceURI(_loc6_.uri);
            this.parseMetadata(_loc6_.metadata,_loc8_);
            _loc5_[_loc5_.length] = _loc8_;
         }
         return _loc5_;
      }
      
      private function parseParameters(param1:Array, param2:ApplicationDomain) : Array
      {
         var _loc4_:Object = null;
         var _loc5_:BaseParameter = null;
         var _loc3_:Array = [];
         for each(_loc4_ in param1)
         {
            _loc5_ = BaseParameter.newInstance(_loc4_.type,param2,_loc4_.optional);
            _loc3_[_loc3_.length] = _loc5_;
         }
         return _loc3_;
      }
      
      private function parseAccessors(param1:Type, param2:Array, param3:ApplicationDomain, param4:Boolean) : Array
      {
         var _loc6_:Object = null;
         var _loc7_:Accessor = null;
         var _loc5_:Array = [];
         for each(_loc6_ in param2)
         {
            _loc7_ = Accessor.newInstance(_loc6_.name,AccessorAccess.fromString(_loc6_.access),_loc6_.type,_loc6_.declaredBy,param4,param3);
            _loc7_.as3commons_reflect::setNamespaceURI(_loc6_.uri);
            this.parseMetadata(_loc6_.metadata,_loc7_);
            _loc5_[_loc5_.length] = _loc7_;
         }
         return _loc5_;
      }
      
      private function parseMetadata(param1:Array, param2:IMetadataContainer) : void
      {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         for each(_loc3_ in param1)
         {
            _loc4_ = _loc3_.name;
            if(!this.isIgnoredMetadata(_loc4_))
            {
               _loc5_ = [];
               for each(_loc6_ in _loc3_.value)
               {
                  _loc5_[_loc5_.length] = MetadataArgument.newInstance(_loc6_.key,_loc6_.value);
               }
               param2.addMetadata(Metadata.newInstance(_loc4_,_loc5_));
            }
         }
      }
      
      private function isIgnoredMetadata(param1:String) : Boolean
      {
         return this._ignoredMetadata.indexOf(param1) > -1;
      }
      
      private function parseMembers(param1:Type, param2:Class, param3:Array, param4:String, param5:Boolean, param6:Boolean, param7:ApplicationDomain) : Array
      {
         var _loc9_:Object = null;
         var _loc10_:IMember = null;
         var _loc8_:Array = [];
         for each(_loc9_ in param3)
         {
            if(!(param6 && _loc9_.access != AccessorAccess.READ_ONLY.name))
            {
               if(!(!param6 && _loc9_.access == AccessorAccess.READ_ONLY.name))
               {
                  _loc10_ = param2["newInstance"](_loc9_.name,_loc9_.type,param4,param5,param7);
                  if(_loc10_ is INamespaceOwner)
                  {
                     INamespaceOwner(_loc10_).as3commons_reflect::setNamespaceURI(_loc9_.uri);
                  }
                  this.parseMetadata(_loc9_.metadata,_loc10_);
                  _loc8_[_loc8_.length] = _loc10_;
               }
            }
         }
         return _loc8_;
      }
   }
}
