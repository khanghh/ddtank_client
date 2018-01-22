package com.demonsters.debugger
{
   import flash.display.DisplayObject;
   
   public class MonsterDebugger
   {
      
      private static var _enabled:Boolean = true;
      
      private static var _initialized:Boolean = false;
      
      static const VERSION:Number = 3.02;
      
      public static var logger:Function;
       
      
      public function MonsterDebugger()
      {
         super();
      }
      
      public static function initialize(param1:Object, param2:String = "127.0.0.1") : void
      {
         if(!_initialized)
         {
            _initialized = true;
            MonsterDebuggerCore.base = param1;
            MonsterDebuggerCore.initialize();
            MonsterDebuggerConnection.initialize();
            MonsterDebuggerConnection.address = param2;
            MonsterDebuggerConnection.connect();
         }
      }
      
      public static function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public static function set enabled(param1:Boolean) : void
      {
         _enabled = param1;
      }
      
      public static function trace(param1:*, param2:*, param3:String = "", param4:String = "", param5:uint = 0, param6:int = 5) : void
      {
         if(_initialized && _enabled)
         {
            MonsterDebuggerCore.trace(param1,param2,param3,param4,param5,param6);
         }
      }
      
      public static function log(... rest) : void
      {
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc2_:* = 0;
         if(_initialized && _enabled)
         {
            if(rest.length == 0)
            {
               return;
            }
            _loc5_ = "Log";
            try
            {
               throw new Error();
            }
            catch(e:Error)
            {
               _loc7_ = e.getStackTrace();
               if(_loc7_ != null && _loc7_ != "")
               {
                  _loc7_ = _loc7_.split("\t").join("");
                  _loc6_ = _loc7_.split("\n");
                  if(_loc6_.length > 2)
                  {
                     _loc6_.shift();
                     _loc6_.shift();
                     _loc4_ = _loc6_[0];
                     _loc4_ = _loc4_.substring(3,_loc4_.length);
                     _loc3_ = _loc4_.indexOf("[");
                     _loc2_ = int(_loc4_.indexOf("/"));
                     if(_loc3_ == -1)
                     {
                        _loc3_ = _loc4_.length;
                     }
                     if(_loc2_ == -1)
                     {
                        _loc2_ = _loc3_;
                     }
                     _loc5_ = MonsterDebuggerUtils.parseType(_loc4_.substring(0,_loc2_));
                     if(_loc5_ == "<anonymous>")
                     {
                        _loc5_ = "";
                     }
                     if(_loc5_ == "")
                     {
                        _loc5_ = "Log";
                     }
                  }
               }
            }
            if(rest.length == 1)
            {
               MonsterDebuggerCore.trace(_loc5_,rest[0],"","",0,5);
            }
            else
            {
               MonsterDebuggerCore.trace(_loc5_,rest,"","",0,5);
            }
         }
      }
      
      public static function snapshot(param1:*, param2:DisplayObject, param3:String = "", param4:String = "") : void
      {
         if(_initialized && _enabled)
         {
            MonsterDebuggerCore.snapshot(param1,param2,param3,param4);
         }
      }
      
      public static function breakpoint(param1:*, param2:String = "breakpoint") : void
      {
         if(_initialized && _enabled)
         {
            MonsterDebuggerCore.breakpoint(param1,param2);
         }
      }
      
      public static function inspect(param1:*) : void
      {
         if(_initialized && _enabled)
         {
            MonsterDebuggerCore.inspect(param1);
         }
      }
      
      public static function clear() : void
      {
         if(_initialized && _enabled)
         {
            MonsterDebuggerCore.clear();
         }
      }
   }
}
