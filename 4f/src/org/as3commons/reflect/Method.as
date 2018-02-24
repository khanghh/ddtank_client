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
      
      public function Method(param1:String, param2:String, param3:Boolean, param4:Array, param5:String, param6:ApplicationDomain, param7:HashArray = null){super(null);}
      
      public function get declaringType() : Type{return null;}
      
      public function get fullName() : String{return null;}
      
      public function get isStatic() : Boolean{return false;}
      
      public function get name() : String{return null;}
      
      public function get qName() : QName{return null;}
      
      public function get namespaceURI() : String{return null;}
      
      public function get parameters() : Array{return null;}
      
      public function get returnType() : Type{return null;}
      
      as3commons_reflect function get returnTypeName() : String{return null;}
      
      public function invoke(param1:*, param2:Array) : *{return null;}
      
      public function toString() : String{return null;}
      
      as3commons_reflect function setDeclaringType(param1:String) : void{}
      
      as3commons_reflect function setFullName(param1:String) : void{}
      
      as3commons_reflect function setIsStatic(param1:Boolean) : void{}
      
      as3commons_reflect function setName(param1:String) : void{}
      
      as3commons_reflect function setNamespaceURI(param1:String) : void{}
      
      as3commons_reflect function setParameters(param1:Array) : void{}
      
      as3commons_reflect function setReturnType(param1:String) : void{}
   }
}
