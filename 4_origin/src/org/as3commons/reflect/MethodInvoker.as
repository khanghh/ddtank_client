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
      
      public function MethodInvoker()
      {
         super();
         this._arguments = [];
      }
      
      public function get target() : *
      {
         return this._target;
      }
      
      public function set target(value:*) : void
      {
         this._target = value;
      }
      
      public function get method() : String
      {
         return this._method;
      }
      
      public function set method(value:String) : void
      {
         this._method = value;
      }
      
      public function get arguments() : Array
      {
         return this._arguments;
      }
      
      public function set arguments(value:Array) : void
      {
         this._arguments = value;
      }
      
      public function get namespaceURI() : String
      {
         return this._namespaceURI;
      }
      
      public function set namespaceURI(value:String) : void
      {
         this._namespaceURI = value;
      }
      
      public function invoke() : *
      {
         var result:* = undefined;
         var f:Function = null;
         var qn:QName = null;
         var args:Array = null;
         var cls:Class = null;
         if(this._namespaceURI != null && this._namespaceURI.length > 0)
         {
            qn = new QName(this._namespaceURI,this.method);
            f = this.target[qn];
         }
         else
         {
            f = this.target[this.method];
         }
         if(f != null)
         {
            result = f.apply(this.target,this.arguments);
         }
         else if(this.target is Proxy)
         {
            args = [this.method].concat(this.arguments);
            result = Proxy(this.target).flash_proxy::callProperty.apply(this.target,args);
         }
         else if(Object(this.target).hasOwnProperty(CONSTRUCTOR_FIELD_NAME))
         {
            cls = Object(this.target).constructor as Class;
            if(cls != null)
            {
               if(this._namespaceURI != null && this._namespaceURI.length > 0)
               {
                  qn = new QName(this._namespaceURI,this.method);
                  f = cls[qn];
               }
               else
               {
                  f = cls[this.method];
               }
               result = f.apply(cls,this.arguments);
            }
         }
         return result;
      }
      
      public function equals(other:Object) : Boolean
      {
         var i:int = 0;
         var arg:* = undefined;
         var otherInvoker:MethodInvoker = other as MethodInvoker;
         var result:Boolean = false;
         if(otherInvoker != null)
         {
            result = this._target === otherInvoker.target && this._method == otherInvoker.method && this._namespaceURI == otherInvoker.namespaceURI;
            if(result)
            {
               if(this._arguments.length == otherInvoker.arguments.length)
               {
                  i = 0;
                  for each(arg in this._arguments)
                  {
                     if(arg !== otherInvoker[i++])
                     {
                        return false;
                     }
                  }
               }
            }
         }
         return result;
      }
   }
}
