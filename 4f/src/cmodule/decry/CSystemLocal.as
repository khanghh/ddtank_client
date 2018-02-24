package cmodule.decry
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   
   public class CSystemLocal implements CSystem
   {
       
      
      private const statCache:Object = {};
      
      private var forceSync:Boolean;
      
      private const fds:Array = [];
      
      public function CSystemLocal(param1:Boolean = false){super();}
      
      public function getargv() : Array{return null;}
      
      public function lseek(param1:int, param2:int, param3:int) : int{return 0;}
      
      public function open(param1:int, param2:int, param3:int) : int{return 0;}
      
      public function psize(param1:int) : int{return 0;}
      
      public function read(param1:int, param2:int, param3:int) : int{return 0;}
      
      public function getenv() : Object{return null;}
      
      public function write(param1:int, param2:int, param3:int) : int{return 0;}
      
      public function access(param1:int, param2:int) : int{return 0;}
      
      public function exit(param1:int) : void{}
      
      public function fsize(param1:int) : int{return 0;}
      
      public function tell(param1:int) : int{return 0;}
      
      public function ioctl(param1:int, param2:int, param3:int) : int{return 0;}
      
      public function close(param1:int) : int{return 0;}
      
      private function fetch(param1:String) : Object{return null;}
      
      public function setup(param1:Function) : void{}
   }
}
