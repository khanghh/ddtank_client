package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   import org.as3commons.lang.ClassNotFoundError;
   import org.as3commons.lang.ClassUtils;
   import org.as3commons.lang.HashArray;
   
   public class Type extends MetadataContainer
   {
      
      public static const UNTYPED:Type = new Type(currentApplicationDomain);
      
      public static const VOID:Type = new Type(currentApplicationDomain);
      
      public static const PRIVATE:Type = new Type(currentApplicationDomain);
      
      private static const MEMBER_PROPERTY_NAME:String = "name";
      
      public static const VOID_NAME:String = "void";
      
      private static const UNTYPED_NAME:String = "*";
      
      private static const PRIVATE_NAME:String = "private";
      
      public static var typeProviderKind:TypeProviderKind = TypeProviderKind.JSON;
      
      private static var typeProvider:ITypeProvider;
      
      private static var _currentApplicationDomain:ApplicationDomain;
      
      {
         UNTYPED.fullName = UNTYPED_NAME;
         UNTYPED.name = UNTYPED_NAME;
         VOID.fullName = VOID_NAME;
         VOID.name = VOID_NAME;
         PRIVATE.fullName = PRIVATE_NAME;
         PRIVATE.name = PRIVATE_NAME;
      }
      
      private var _applicationDomain:ApplicationDomain;
      
      private var _alias:String;
      
      private var _name:String;
      
      private var _fullName:String;
      
      private var _class:Class;
      
      private var _isDynamic:Boolean;
      
      private var _isFinal:Boolean;
      
      private var _isStatic:Boolean;
      
      private var _isInterface:Boolean;
      
      private var _parameters:Array;
      
      private var _interfaces:Array;
      
      private var _constructor:Constructor;
      
      private var _accessors:Array;
      
      private var _methods:HashArray;
      
      private var _staticConstants:Array;
      
      private var _constants:Array;
      
      private var _staticVariables:Array;
      
      private var _extendsClasses:Array;
      
      private var _variables:Array;
      
      private var _fields:HashArray;
      
      private var _metadataLookup:Object;
      
      public function Type(param1:ApplicationDomain)
      {
         super();
         this._accessors = [];
         this._staticConstants = [];
         this._constants = [];
         this._staticVariables = [];
         this._variables = [];
         this._extendsClasses = [];
         this._interfaces = [];
         this._parameters = [];
         this._applicationDomain = param1;
      }
      
      public static function reset() : void
      {
         if(typeProvider != null)
         {
            typeProvider.clearCache();
         }
         typeProvider = null;
      }
      
      public static function get currentApplicationDomain() : ApplicationDomain
      {
         return _currentApplicationDomain = _currentApplicationDomain || ApplicationDomain.currentDomain;
      }
      
      public static function forInstance(param1:*, param2:ApplicationDomain = null) : Type
      {
         var _loc3_:Type = null;
         param2 = param2 || currentApplicationDomain;
         var _loc4_:Class = ClassUtils.forInstance(param1,param2);
         if(_loc4_ != null)
         {
            _loc3_ = Type.forClass(_loc4_,param2);
         }
         return _loc3_;
      }
      
      public static function forName(param1:String, param2:ApplicationDomain = null) : Type
      {
         var result:Type = null;
         var name:String = param1;
         var applicationDomain:ApplicationDomain = param2;
         applicationDomain = applicationDomain || currentApplicationDomain;
         switch(name)
         {
            case VOID_NAME:
               result = Type.VOID;
               break;
            case UNTYPED_NAME:
               result = Type.UNTYPED;
               break;
            default:
               if(getTypeProvider().getTypeCache().contains(name,applicationDomain))
               {
                  result = getTypeProvider().getTypeCache().get(name,applicationDomain);
               }
               else
               {
                  try
                  {
                     result = Type.forClass(ClassUtils.forName(name,applicationDomain),applicationDomain);
                  }
                  catch(e:ClassNotFoundError)
                  {
                     trace("Type.forName error: " + e.message + " The class \'" + name + "\' is probably an internal class or it may not have been compiled.");
                  }
               }
         }
         return result;
      }
      
      public static function forClass(param1:Class, param2:ApplicationDomain = null) : Type
      {
         var _loc3_:Type = null;
         param2 = param2 || currentApplicationDomain;
         var _loc4_:String = ClassUtils.getFullyQualifiedName(param1);
         if(getTypeProvider().getTypeCache().contains(_loc4_,param2))
         {
            _loc3_ = getTypeProvider().getTypeCache().get(_loc4_,param2);
         }
         else
         {
            _loc3_ = getTypeProvider().getType(param1,param2);
         }
         return _loc3_;
      }
      
      public static function getTypeProvider() : ITypeProvider
      {
         if(typeProvider == null)
         {
            if(typeProviderKind === TypeProviderKind.JSON)
            {
               try
               {
                  typeProvider = new JSONTypeProvider();
               }
               catch(e:*)
               {
               }
            }
            if(typeProvider == null)
            {
               typeProvider = new XmlTypeProvider();
            }
         }
         return typeProvider;
      }
      
      public function get applicationDomain() : ApplicationDomain
      {
         return this._applicationDomain;
      }
      
      public function set applicationDomain(param1:ApplicationDomain) : void
      {
         this._applicationDomain = param1;
      }
      
      public function get alias() : String
      {
         return this._alias;
      }
      
      public function set alias(param1:String) : void
      {
         this._alias = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get fullName() : String
      {
         return this._fullName;
      }
      
      public function set fullName(param1:String) : void
      {
         this._fullName = param1;
      }
      
      public function get clazz() : Class
      {
         return this._class;
      }
      
      public function set clazz(param1:Class) : void
      {
         this._class = param1;
      }
      
      public function get isDynamic() : Boolean
      {
         return this._isDynamic;
      }
      
      public function set isDynamic(param1:Boolean) : void
      {
         this._isDynamic = param1;
      }
      
      public function get isFinal() : Boolean
      {
         return this._isFinal;
      }
      
      public function set isFinal(param1:Boolean) : void
      {
         this._isFinal = param1;
      }
      
      public function get isStatic() : Boolean
      {
         return this._isStatic;
      }
      
      public function set isStatic(param1:Boolean) : void
      {
         this._isStatic = param1;
      }
      
      public function get isInterface() : Boolean
      {
         return this._isInterface;
      }
      
      public function set isInterface(param1:Boolean) : void
      {
         this._isInterface = param1;
      }
      
      public function get parameters() : Array
      {
         return this._parameters;
      }
      
      public function get interfaces() : Array
      {
         return this._interfaces;
      }
      
      public function set interfaces(param1:Array) : void
      {
         this._interfaces = param1;
      }
      
      public function get constructor() : Constructor
      {
         return this._constructor;
      }
      
      public function set constructor(param1:Constructor) : void
      {
         this._constructor = param1;
      }
      
      public function get accessors() : Array
      {
         return this._accessors;
      }
      
      public function set accessors(param1:Array) : void
      {
         this._accessors = param1;
         this._fields = null;
      }
      
      public function get methods() : Array
      {
         return this._methods != null?this._methods.getArray():[];
      }
      
      public function set methods(param1:Array) : void
      {
         this._methods = new HashArray(MEMBER_PROPERTY_NAME,false,param1);
      }
      
      public function get staticConstants() : Array
      {
         return this._staticConstants;
      }
      
      public function set staticConstants(param1:Array) : void
      {
         this._staticConstants = param1;
         this._fields = null;
      }
      
      public function get constants() : Array
      {
         return this._constants;
      }
      
      public function set constants(param1:Array) : void
      {
         this._constants = param1;
         this._fields = null;
      }
      
      public function get staticVariables() : Array
      {
         return this._staticVariables;
      }
      
      public function set staticVariables(param1:Array) : void
      {
         this._staticVariables = param1;
         this._fields = null;
      }
      
      public function get extendsClasses() : Array
      {
         return this._extendsClasses;
      }
      
      public function set extendsClasses(param1:Array) : void
      {
         this._extendsClasses = param1;
      }
      
      public function get variables() : Array
      {
         return this._variables;
      }
      
      public function set variables(param1:Array) : void
      {
         this._variables = param1;
         this._fields = null;
      }
      
      public function get fields() : Array
      {
         if(this._fields == null)
         {
            this.createFieldsHashArray();
         }
         return this._fields.getArray();
      }
      
      private function createFieldsHashArray() : void
      {
         this._fields = new HashArray(MEMBER_PROPERTY_NAME,false,this.accessors.concat(this.staticConstants).concat(this.constants).concat(this.staticVariables).concat(this.variables));
      }
      
      public function get properties() : Array
      {
         return this.accessors.concat(this.variables);
      }
      
      public function getMethod(param1:String, param2:String = null) : Method
      {
         var _loc3_:Array = null;
         var _loc4_:Method = null;
         if(param2 == null)
         {
            return this._methods.get(param1);
         }
         _loc3_ = this._methods.getArray();
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.name == param1 && _loc4_.namespaceURI == param2)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function getField(param1:String, param2:String = null) : Field
      {
         var _loc3_:Array = null;
         var _loc4_:Field = null;
         if(this._fields == null)
         {
            this.createFieldsHashArray();
         }
         if(param2 == null || param2.length == 0)
         {
            return this._fields.get(param1);
         }
         _loc3_ = this._fields.getArray();
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.name == param1 && _loc4_.namespaceURI == param2)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function createMetadataLookup() : void
      {
         this._metadataLookup = {};
         this.addToMetadataLookup([this]);
         this.addToMetadataLookup(this._methods.getArray());
         if(this._fields == null)
         {
            this.createFieldsHashArray();
         }
         this.addToMetadataLookup(this._fields.getArray());
      }
      
      public function getMetadataContainers(param1:String) : Array
      {
         if(this._metadataLookup != null)
         {
            param1 = param1.toLowerCase();
            param1 = param1 != "constructor"?param1:"_constructor";
            return this._metadataLookup[param1] as Array;
         }
         return null;
      }
      
      private function addToMetadataLookup(param1:Array) : void
      {
         var _loc2_:MetadataContainer = null;
         var _loc3_:Array = null;
         var _loc4_:Metadata = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = _loc2_.metadata;
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_ != null)
               {
                  _loc5_ = _loc4_.name != "constructor"?_loc4_.name:"_constructor";
                  _loc6_ = this._metadataLookup[_loc5_] = this._metadataLookup[_loc5_] || [];
                  _loc6_[_loc6_.length] = _loc2_;
               }
            }
         }
      }
      
      as3commons_reflect function setParameters(param1:Array) : void
      {
         this._parameters = param1;
      }
   }
}
