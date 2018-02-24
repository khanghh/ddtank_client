package littleGame
{
   import ddt.interfaces.IProcessObject;
   import ddt.manager.ProcessManager;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import littleGame.events.LittleGameSocketEvent;
   
   public class LittleGamePacketQueue implements IProcessObject
   {
      
      private static var _ins:LittleGamePacketQueue;
       
      
      private var _executable:Array;
      
      public var _waitlist:Array;
      
      private var _lifeTime:int;
      
      private var _onProcess:Boolean = false;
      
      public function LittleGamePacketQueue(){super();}
      
      public static function get Instance() : LittleGamePacketQueue{return null;}
      
      public function addQueue(param1:LittleGameSocketEvent) : void{}
      
      public function startup() : void{}
      
      public function shutdown() : void{}
      
      public function setLifeTime(param1:int) : void{}
      
      public function reset() : void{}
      
      public function dispose() : void{}
      
      public function get onProcess() : Boolean{return false;}
      
      public function set onProcess(param1:Boolean) : void{}
      
      public function get running() : Boolean{return false;}
      
      public function process(param1:Number) : void{}
      
      private function dispatchEvent(param1:Event) : void{}
   }
}
