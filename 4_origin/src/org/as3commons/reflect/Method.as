package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   import org.as3commons.lang.HashArray;
   
   public class Method extends MetadataContainer implements INamespaceOwner
   {
       
      
      protected var applicationDomain:ApplicationDomain;
      
      private var updateFullName:Boolean = true;
      
      protected var declaringTypeName:String;
      
      private var _fullName:String;
      
      private var _isStatic:Boolean;
      
      private var _name:String;
      
      private var _qName:QName;
      
      private var _namespaceURI:String;
      
      protected var _parameters:Array;
      
      private var _returnTypeName:String;
      
      public function Method(declaringType:String, name:String, isStatic:Boolean, parameters:Array, returnType:String, applicationDomain:ApplicationDomain, metadata:HashArray = null)
      {
         super(metadata);
         this.declaringTypeName = declaringType;
         this._name = name;
         this._isStatic = isStatic;
         this._parameters = parameters;
         this._returnTypeName = returnType;
         this.applicationDomain = applicationDomain;
      }
      
      public function get declaringType() : Type
      {
         return Type.forName(this.declaringTypeName,this.applicationDomain);
      }
      
      public function get fullName() : String
      {
         var len:int = 0;
         var i:int = 0;
         var p:BaseParameter = null;
         if(this.updateFullName)
         {
            this._fullName = "public ";
            if(this.isStatic)
            {
               this._fullName = this._fullName + "static ";
            }
            this._fullName = this._fullName + (this.name + "(");
            len = this._parameters.length;
            for(i = 0; i < len; i++)
            {
               p = this._parameters[i];
               this._fullName = this._fullName + p.type.name;
               this._fullName = this._fullName + (i < len - 1?", ":"");
            }
            this._fullName = this._fullName + ("):" + this.returnType.name);
            this.updateFullName = false;
         }
         return this._fullName;
      }
      
      public function get isStatic() : Boolean
      {
         return this._isStatic;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get qName() : QName
      {
         return new QName(this._namespaceURI,this._name);
      }
      
      public function get namespaceURI() : String
      {
         return this._namespaceURI;
      }
      
      public function get parameters() : Array
      {
         var param:BaseParameter = null;
         var result:Array = [];
         var len:int = this._parameters.length;
         for(var i:int = 0; i < len; i++)
         {
            param = this._parameters[i];
            result[result.length] = new Parameter(param,i);
         }
         return result;
      }
      
      public function get returnType() : Type
      {
         return Type.forName(this._returnTypeName,this.applicationDomain);
      }
      
      as3commons_reflect function get returnTypeName() : String
      {
         return this._returnTypeName;
      }
      
      public function invoke(target:*, args:Array) : *
      {
         var invoker:MethodInvoker = new MethodInvoker();
         invoker.target = target;
         invoker.method = this.name;
         invoker.arguments = args;
         return invoker.invoke();
      }
      
      public function toString() : String
      {
         return "[Method(name:\'" + this.name + "\', isStatic:" + this.isStatic + ")]";
      }
      
      as3commons_reflect function setDeclaringType(value:String) : void
      {
         this.declaringTypeName = value;
      }
      
      as3commons_reflect function setFullName(value:String) : void
      {
         this._fullName = value;
         this.updateFullName = false;
      }
      
      as3commons_reflect function setIsStatic(value:Boolean) : void
      {
         this._isStatic = value;
      }
      
      as3commons_reflect function setName(value:String) : void
      {
         this._name = value;
         this.updateFullName = true;
      }
      
      as3commons_reflect function setNamespaceURI(value:String) : void
      {
         this._namespaceURI = value;
      }
      
      as3commons_reflect function setParameters(value:Array) : void
      {
         this._parameters = value;
         this.updateFullName = true;
      }
      
      as3commons_reflect function setReturnType(value:String) : void
      {
         this._returnTypeName = value;
         this.updateFullName = true;
      }
   }
}
