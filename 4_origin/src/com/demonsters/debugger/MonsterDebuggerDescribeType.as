package com.demonsters.debugger
{
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   class MonsterDebuggerDescribeType
   {
      
      private static var cache:Object = {};
       
      
      function MonsterDebuggerDescribeType()
      {
         super();
      }
      
      static function get(param1:*) : XML
      {
         var _loc3_:String = getQualifiedClassName(param1);
         if(_loc3_ in cache)
         {
            return cache[_loc3_];
         }
         var _loc2_:XML = describeType(param1);
         cache[_loc3_] = _loc2_;
         return _loc2_;
      }
   }
}
