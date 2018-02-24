package mx.utils
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   import flash.utils.getQualifiedClassName;
   import mx.core.IPropertyChangeNotifier;
   import mx.events.PropertyChangeEvent;
   import mx.events.PropertyChangeEventKind;
   
   use namespace object_proxy;
   use namespace flash_proxy;
   
   [RemoteClass(alias="flex.messaging.io.ObjectProxy")]
   [Bindable("propertyChange")]
   public dynamic class ObjectProxy extends Proxy implements IExternalizable, IPropertyChangeNotifier
   {
       
      
      protected var dispatcher:EventDispatcher;
      
      protected var notifiers:Object;
      
      protected var proxyClass:Class;
      
      protected var propertyList:Array;
      
      private var _proxyLevel:int;
      
      private var _item:Object;
      
      private var _type:QName;
      
      private var _id:String;
      
      public function ObjectProxy(param1:Object = null, param2:String = null, param3:int = -1){super();}
      
      object_proxy function get object() : Object{return null;}
      
      object_proxy function get type() : QName{return null;}
      
      object_proxy function set type(param1:QName) : void{}
      
      public function get uid() : String{return null;}
      
      public function set uid(param1:String) : void{}
      
      override flash_proxy function getProperty(param1:*) : *{return null;}
      
      override flash_proxy function callProperty(param1:*, ... rest) : *{return null;}
      
      override flash_proxy function deleteProperty(param1:*) : Boolean{return false;}
      
      override flash_proxy function hasProperty(param1:*) : Boolean{return false;}
      
      override flash_proxy function nextName(param1:int) : String{return null;}
      
      override flash_proxy function nextNameIndex(param1:int) : int{return 0;}
      
      override flash_proxy function nextValue(param1:int) : *{return null;}
      
      override flash_proxy function setProperty(param1:*, param2:*) : void{}
      
      object_proxy function getComplexProperty(param1:*, param2:*) : *{return null;}
      
      public function readExternal(param1:IDataInput) : void{}
      
      public function writeExternal(param1:IDataOutput) : void{}
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void{}
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void{}
      
      public function dispatchEvent(param1:Event) : Boolean{return false;}
      
      public function hasEventListener(param1:String) : Boolean{return false;}
      
      public function willTrigger(param1:String) : Boolean{return false;}
      
      public function propertyChangeHandler(param1:PropertyChangeEvent) : void{}
      
      protected function setupPropertyList() : void{}
   }
}
