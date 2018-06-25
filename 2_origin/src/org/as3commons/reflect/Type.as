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
      
      public function Type(applicationDomain:ApplicationDomain)
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
         this._applicationDomain = applicationDomain;
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
      
      public static function forInstance(instance:*, applicationDomain:ApplicationDomain = null) : Type
      {
         var result:Type = null;
         applicationDomain = applicationDomain || currentApplicationDomain;
         var clazz:Class = ClassUtils.forInstance(instance,applicationDomain);
         if(clazz != null)
         {
            result = Type.forClass(clazz,applicationDomain);
         }
         return result;
      }
      
      public static function forName(name:String, applicationDomain:ApplicationDomain = null) : Type
      {
         var result:Type = null;
         var applicationDomain:ApplicationDomain = applicationDomain || currentApplicationDomain;
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
      
      public static function forClass(clazz:Class, applicationDomain:ApplicationDomain = null) : Type
      {
         var result:Type = null;
         applicationDomain = applicationDomain || currentApplicationDomain;
         var fullyQualifiedClassName:String = ClassUtils.getFullyQualifiedName(clazz);
         if(getTypeProvider().getTypeCache().contains(fullyQualifiedClassName,applicationDomain))
         {
            result = getTypeProvider().getTypeCache().get(fullyQualifiedClassName,applicationDomain);
         }
         else
         {
            result = getTypeProvider().getType(clazz,applicationDomain);
         }
         return result;
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
      
      public function set applicationDomain(value:ApplicationDomain) : void
      {
         this._applicationDomain = value;
      }
      
      public function get alias() : String
      {
         return this._alias;
      }
      
      public function set alias(value:String) : void
      {
         this._alias = value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(value:String) : void
      {
         this._name = value;
      }
      
      public function get fullName() : String
      {
         return this._fullName;
      }
      
      public function set fullName(value:String) : void
      {
         this._fullName = value;
      }
      
      public function get clazz() : Class
      {
         return this._class;
      }
      
      public function set clazz(value:Class) : void
      {
         this._class = value;
      }
      
      public function get isDynamic() : Boolean
      {
         return this._isDynamic;
      }
      
      public function set isDynamic(value:Boolean) : void
      {
         this._isDynamic = value;
      }
      
      public function get isFinal() : Boolean
      {
         return this._isFinal;
      }
      
      public function set isFinal(value:Boolean) : void
      {
         this._isFinal = value;
      }
      
      public function get isStatic() : Boolean
      {
         return this._isStatic;
      }
      
      public function set isStatic(value:Boolean) : void
      {
         this._isStatic = value;
      }
      
      public function get isInterface() : Boolean
      {
         return this._isInterface;
      }
      
      public function set isInterface(value:Boolean) : void
      {
         this._isInterface = value;
      }
      
      public function get parameters() : Array
      {
         return this._parameters;
      }
      
      public function get interfaces() : Array
      {
         return this._interfaces;
      }
      
      public function set interfaces(value:Array) : void
      {
         this._interfaces = value;
      }
      
      public function get constructor() : Constructor
      {
         return this._constructor;
      }
      
      public function set constructor(constructor:Constructor) : void
      {
         this._constructor = constructor;
      }
      
      public function get accessors() : Array
      {
         return this._accessors;
      }
      
      public function set accessors(value:Array) : void
      {
         this._accessors = value;
         this._fields = null;
      }
      
      public function get methods() : Array
      {
         return this._methods != null?this._methods.getArray():[];
      }
      
      public function set methods(value:Array) : void
      {
         this._methods = new HashArray(MEMBER_PROPERTY_NAME,false,value);
      }
      
      public function get staticConstants() : Array
      {
         return this._staticConstants;
      }
      
      public function set staticConstants(value:Array) : void
      {
         this._staticConstants = value;
         this._fields = null;
      }
      
      public function get constants() : Array
      {
         return this._constants;
      }
      
      public function set constants(value:Array) : void
      {
         this._constants = value;
         this._fields = null;
      }
      
      public function get staticVariables() : Array
      {
         return this._staticVariables;
      }
      
      public function set staticVariables(value:Array) : void
      {
         this._staticVariables = value;
         this._fields = null;
      }
      
      public function get extendsClasses() : Array
      {
         return this._extendsClasses;
      }
      
      public function set extendsClasses(value:Array) : void
      {
         this._extendsClasses = value;
      }
      
      public function get variables() : Array
      {
         return this._variables;
      }
      
      public function set variables(value:Array) : void
      {
         this._variables = value;
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
      
      public function getMethod(name:String, ns:String = null) : Method
      {
         var mthds:Array = null;
         var method:Method = null;
         if(ns == null)
         {
            return this._methods.get(name);
         }
         mthds = this._methods.getArray();
         for each(method in mthds)
         {
            if(method.name == name && method.namespaceURI == ns)
            {
               return method;
            }
         }
         return null;
      }
      
      public function getField(name:String, ns:String = null) : Field
      {
         var flds:Array = null;
         var field:Field = null;
         if(this._fields == null)
         {
            this.createFieldsHashArray();
         }
         if(ns == null || ns.length == 0)
         {
            return this._fields.get(name);
         }
         flds = this._fields.getArray();
         for each(field in flds)
         {
            if(field.name == name && field.namespaceURI == ns)
            {
               return field;
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
      
      public function getMetadataContainers(name:String) : Array
      {
         if(this._metadataLookup != null)
         {
            name = name.toLowerCase();
            name = name != "constructor"?name:"_constructor";
            return this._metadataLookup[name] as Array;
         }
         return null;
      }
      
      private function addToMetadataLookup(containerList:Array) : void
      {
         var container:MetadataContainer = null;
         var metadatas:Array = null;
         var m:Metadata = null;
         var name:String = null;
         var arr:Array = null;
         for each(container in containerList)
         {
            metadatas = container.metadata;
            for each(m in metadatas)
            {
               if(m != null)
               {
                  name = m.name != "constructor"?m.name:"_constructor";
                  arr = this._metadataLookup[name] = this._metadataLookup[name] || [];
                  arr[arr.length] = container;
               }
            }
         }
      }
      
      as3commons_reflect function setParameters(value:Array) : void
      {
         this._parameters = value;
      }
   }
}
