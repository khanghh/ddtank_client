package ddt.view.sceneCharacter
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.Security;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class GirlHeadPicLoader
   {
       
      
      private var _originalURL:String;
      
      private var _loader:Loader;
      
      private var _request:URLRequest;
      
      private var _callBack:Function;
      
      public function GirlHeadPicLoader(){super();}
      
      public function load(param1:String, param2:Function) : void{}
      
      protected function onGirlPicLoaded(param1:Event) : void{}
      
      private function policyFileNeeded(param1:Event) : void{}
      
      protected function onGirlPicError(param1:IOErrorEvent) : void{}
   }
}
