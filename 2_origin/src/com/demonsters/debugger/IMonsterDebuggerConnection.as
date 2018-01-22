package com.demonsters.debugger
{
   interface IMonsterDebuggerConnection
   {
       
      
      function set address(param1:String) : void;
      
      function get connected() : Boolean;
      
      function processQueue() : void;
      
      function send(param1:String, param2:Object, param3:Boolean = false) : void;
      
      function connect() : void;
   }
}
