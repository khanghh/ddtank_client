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
      
      public function GirlHeadPicLoader()
      {
         super();
      }
      
      public function load(url:String, callBack:Function) : void
      {
         _originalURL = url;
         _callBack = callBack;
         _loader = new Loader();
         _request = new URLRequest(_originalURL);
         _loader.contentLoaderInfo.addEventListener("complete",onGirlPicLoaded);
         _loader.contentLoaderInfo.addEventListener("ioError",onGirlPicError);
         _loader.load(_request);
      }
      
      protected function onGirlPicLoaded(e:Event) : void
      {
         _loader.contentLoaderInfo.removeEventListener("complete",onGirlPicLoaded);
         _loader.contentLoaderInfo.removeEventListener("ioError",onGirlPicError);
         if(true)
         {
            trace("e.target.url:\n",e.target.url);
            trace("_originalURL:\n",_originalURL);
            policyFileNeeded(e);
         }
         else
         {
            _callBack && _callBack(_loader.content);
            _loader = null;
            _request = null;
            _callBack = null;
         }
      }
      
      private function policyFileNeeded(e:Event) : void
      {
         e = e;
         Security.loadPolicyFile((e.target.url as String).split("/").slice(0,3).join("/") + "/crossdomain.xml");
         var _waitPolicyFileTimer:uint = setInterval(function():void
         {
            if(e.target.childAllowsParent)
            {
               clearInterval(_waitPolicyFileTimer);
               _waitPolicyFileTimer = 0;
               _callBack && _callBack(e.target.content);
               _loader = null;
               _request = null;
               _callBack = null;
            }
         },50);
      }
      
      protected function onGirlPicError(e:IOErrorEvent) : void
      {
         trace("\n" + _request.url);
         trace(e.text);
         _loader.contentLoaderInfo.removeEventListener("complete",onGirlPicLoaded);
         _loader.contentLoaderInfo.removeEventListener("ioError",onGirlPicError);
         _callBack && _callBack(null);
         _loader = null;
         _request = null;
         _callBack = null;
      }
   }
}
