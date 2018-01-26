package org.as3commons.reflect
{
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   import org.as3commons.lang.IEquals;
   
   public class MethodInvoker implements INamespaceOwner, IEquals
   {
      
      private static const CONSTRUCTOR_FIELD_NAME:String = "constructor";
       
      
      private var _target;
      
      private var _method:String = "";
      
      private var _arguments:Array;
      
      private var _namespaceURI:String;
      
      public function MethodInvoker(){super();}
      
      public function get target() : *{return null;}
      
      public function set target(param1:*) : void{}
      
      public function get method() : String{return null;}
      
      public function set method(param1:String) : void{}
      
      public function get arguments() : Array{return null;}
      
      public function set arguments(param1:Array) : void{}
      
      public function get namespaceURI() : String{return null;}
      
      public function set namespaceURI(param1:String) : void{}
      
      public function invoke() : *{return null;}
      
      public function equals(param1:Object) : Boolean{return false;}
   }
}
