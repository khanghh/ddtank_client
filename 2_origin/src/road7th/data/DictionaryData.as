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
      
      public function DictionaryData(param1:Boolean = false)
      {
         super(param1);
         _dispatcher = new EventDispatcher(this);
         _array = [];
      }
      
      public function get length() : int
      {
         return _array.length;
      }
      
      public function get list() : Array
      {
         return _array;
      }
      
      public function filter(param1:String, param2:Object) : Array
      {
         _fName = param1;
         _value = param2;
         return _array.filter(filterCallBack);
      }
      
      private function filterCallBack(param1:*, param2:int, param3:Array) : Boolean
      {
         return param1[_fName] == _value;
      }
      
      public function add(param1:*, param2:Object) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         if(this[param1] == null)
         {
            this[param1] = param2;
            _array.push(param2);
            dispatchEvent(new DictionaryEvent("add",param2));
         }
         else
         {
            _loc3_ = this[param1];
            this[param1] = param2;
            _loc4_ = _array.indexOf(_loc3_);
            if(_loc4_ > -1)
            {
               _array.splice(_loc4_,1);
            }
            _array.push(param2);
            dispatchEvent(new DictionaryEvent("update",param2));
         }
      }
      
      public function hasKey(param1:*) : Boolean
      {
         return this[param1] != null;
      }
      
      public function remove(param1:*) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = this[param1];
         if(_loc3_ != null)
         {
            this[param1] = null;
            delete this[param1];
            _loc2_ = _array.indexOf(_loc3_);
            if(_loc2_ > -1)
            {
               _array.splice(_loc2_,1);
            }
            dispatchEvent(new DictionaryEvent("remove",_loc3_));
         }
      }
      
      public function setData(param1:DictionaryData) : void
      {
         cleardata();
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for(var _loc2_ in param1)
         {
            this[_loc2_] = param1[_loc2_];
            _array.push(param1[_loc2_]);
         }
      }
      
      public function clear() : void
      {
         cleardata();
         dispatchEvent(new DictionaryEvent("clear"));
      }
      
      public function slice(param1:int = 0, param2:int = 166777215) : Array
      {
         return _array.slice(param1,param2);
      }
      
      public function concat(param1:Array) : Array
      {
         return _array.concat(param1);
      }
      
      private function cleardata() : void
      {
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = this;
         for(var _loc3_ in this)
         {
            _loc2_.push(_loc3_);
         }
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(var _loc1_ in _loc2_)
         {
            this[_loc1_] = null;
            delete this[_loc1_];
         }
         _array = [];
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return _dispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return _dispatcher.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return _dispatcher.willTrigger(param1);
      }
   }
}
