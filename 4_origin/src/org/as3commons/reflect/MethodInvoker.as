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
      
      public function set target(param1:*) : void
      {
         this._target = param1;
      }
      
      public function get method() : String
      {
         return this._method;
      }
      
      public function set method(param1:String) : void
      {
         this._method = param1;
      }
      
      public function get arguments() : Array
      {
         return this._arguments;
      }
      
      public function set arguments(param1:Array) : void
      {
         this._arguments = param1;
      }
      
      public function get namespaceURI() : String
      {
         return this._namespaceURI;
      }
      
      public function set namespaceURI(param1:String) : void
      {
         this._namespaceURI = param1;
      }
      
      public function invoke() : *
      {
         var _loc2_:* = undefined;
         var _loc3_:Function = null;
         var _loc4_:QName = null;
         var _loc5_:Array = null;
         var _loc6_:Class = null;
         if(this._namespaceURI != null && this._namespaceURI.length > 0)
         {
            _loc4_ = new QName(this._namespaceURI,this.method);
            _loc3_ = this.target[_loc4_];
         }
         else
         {
            _loc3_ = this.target[this.method];
         }
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.apply(this.target,this.arguments);
         }
         else if(this.target is Proxy)
         {
            _loc5_ = [this.method].concat(this.arguments);
            _loc2_ = Proxy(this.target).flash_proxy::callProperty.apply(this.target,_loc5_);
         }
         else if(Object(this.target).hasOwnProperty(CONSTRUCTOR_FIELD_NAME))
         {
            _loc6_ = Object(this.target).constructor as Class;
            if(_loc6_ != null)
            {
               if(this._namespaceURI != null && this._namespaceURI.length > 0)
               {
                  _loc4_ = new QName(this._namespaceURI,this.method);
                  _loc3_ = _loc6_[_loc4_];
               }
               else
               {
                  _loc3_ = _loc6_[this.method];
               }
               _loc2_ = _loc3_.apply(_loc6_,this.arguments);
            }
         }
         return _loc2_;
      }
      
      public function equals(param1:Object) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         var _loc3_:MethodInvoker = param1 as MethodInvoker;
         var _loc4_:Boolean = false;
         if(_loc3_ != null)
         {
            _loc4_ = this._target === _loc3_.target && this._method == _loc3_.method && this._namespaceURI == _loc3_.namespaceURI;
            if(_loc4_)
            {
               if(this._arguments.length == _loc3_.arguments.length)
               {
                  _loc5_ = 0;
                  for each(_loc6_ in this._arguments)
                  {
                     if(_loc6_ !== _loc3_[_loc5_++])
                     {
                        return false;
                     }
                  }
               }
            }
         }
         return _loc4_;
      }
   }
}
