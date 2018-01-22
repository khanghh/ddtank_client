package com.demonsters.debugger
{
   class MonsterDebuggerConnection
   {
      
      private static var connector:IMonsterDebuggerConnection;
       
      
      function MonsterDebuggerConnection()
      {
         super();
      }
      
      static function initialize() : void
      {
         connector = new MonsterDebuggerConnectionDefault();
      }
      
      static function set address(param1:String) : void
      {
         connector.address = param1;
      }
      
      static function get connected() : Boolean
      {
         return connector.connected;
      }
      
      static function processQueue() : void
      {
         connector.processQueue();
      }
      
      static function send(param1:String, param2:Object, param3:Boolean = false) : void
      {
         connector.send(param1,param2,param3);
      }
      
      static function connect() : void
      {
         connector.connect();
      }
   }
}
