package road7th.data
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   [Event(name="add",type="road7th.data.DictionaryEvent")]
   [Event(name="update",type="road7th.data.DictionaryEvent")]
   [Event(name="remove",type="road7th.data.DictionaryEvent")]
   [Event(name="clear",type="road7th.data.DictionaryEvent")]
   public dynamic class DictionaryData extends Dictionary implements IEventDispatcher
   {
       
      
      private var _dispatcher:EventDispatcher;
      
      private var _array:Array;
      
      private var _fName:String;
      
      private var _value:Object;
      
      public function DictionaryData(param1:Boolean = false){super(null);}
      
      public function get length() : int{return 0;}
      
      public function get list() : Array{return null;}
      
      public function filter(param1:String, param2:Object) : Array{return null;}
      
      private function filterCallBack(param1:*, param2:int, param3:Array) : Boolean{return false;}
      
      public function add(param1:*, param2:Object) : void{}
      
      public function hasKey(param1:*) : Boolean{return false;}
      
      public function remove(param1:*) : void{}
      
      public function setData(param1:DictionaryData) : void{}
      
      public function clear() : void{}
      
      public function slice(param1:int = 0, param2:int = 166777215) : Array{return null;}
      
      public function concat(param1:Array) : Array{return null;}
      
      private function cleardata() : void{}
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void{}
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void{}
      
      public function dispatchEvent(param1:Event) : Boolean{return false;}
      
      public function hasEventListener(param1:String) : Boolean{return false;}
      
      public function willTrigger(param1:String) : Boolean{return false;}
   }
}
