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
      
      public function Method(param1:String, param2:String, param3:Boolean, param4:Array, param5:String, param6:ApplicationDomain, param7:HashArray = null)
      {
         super(param7);
         this.declaringTypeName = param1;
         this._name = param2;
         this._isStatic = param3;
         this._parameters = param4;
         this._returnTypeName = param5;
         this.applicationDomain = param6;
      }
      
      public function get declaringType() : Type
      {
         return Type.forName(this.declaringTypeName,this.applicationDomain);
      }
      
      public function get fullName() : String
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:BaseParameter = null;
         if(this.updateFullName)
         {
            this._fullName = "public ";
            if(this.isStatic)
            {
               this._fullName = this._fullName + "static ";
            }
            this._fullName = this._fullName + (this.name + "(");
            _loc1_ = this._parameters.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = this._parameters[_loc2_];
               this._fullName = this._fullName + _loc3_.type.name;
               this._fullName = this._fullName + (_loc2_ < _loc1_ - 1?", ":"");
               _loc2_++;
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
         var _loc4_:BaseParameter = null;
         var _loc1_:Array = [];
         var _loc2_:int = this._parameters.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._parameters[_loc3_];
            _loc1_[_loc1_.length] = new Parameter(_loc4_,_loc3_);
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get returnType() : Type
      {
         return Type.forName(this._returnTypeName,this.applicationDomain);
      }
      
      as3commons_reflect function get returnTypeName() : String
      {
         return this._returnTypeName;
      }
      
      public function invoke(param1:*, param2:Array) : *
      {
         var _loc4_:MethodInvoker = new MethodInvoker();
         _loc4_.target = param1;
         _loc4_.method = this.name;
         _loc4_.arguments = param2;
         return _loc4_.invoke();
      }
      
      public function toString() : String
      {
         return "[Method(name:\'" + this.name + "\', isStatic:" + this.isStatic + ")]";
      }
      
      as3commons_reflect function setDeclaringType(param1:String) : void
      {
         this.declaringTypeName = param1;
      }
      
      as3commons_reflect function setFullName(param1:String) : void
      {
         this._fullName = param1;
         this.updateFullName = false;
      }
      
      as3commons_reflect function setIsStatic(param1:Boolean) : void
      {
         this._isStatic = param1;
      }
      
      as3commons_reflect function setName(param1:String) : void
      {
         this._name = param1;
         this.updateFullName = true;
      }
      
      as3commons_reflect function setNamespaceURI(param1:String) : void
      {
         this._namespaceURI = param1;
      }
      
      as3commons_reflect function setParameters(param1:Array) : void
      {
         this._parameters = param1;
         this.updateFullName = true;
      }
      
      as3commons_reflect function setReturnType(param1:String) : void
      {
         this._returnTypeName = param1;
         this.updateFullName = true;
      }
   }
}
