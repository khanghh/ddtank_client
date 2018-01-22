package yzhkof.loader
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.getQualifiedClassName;
   import yzhkof.util.EventProxy;
   import yzhkof.util.delayCallNextFrame;
   
   [Event(name="io_error",type="flash.events.IOErrorEvent")]
   [Event(name="PROGRESS",type="flash.events.ProgressEvent")]
   [Event(name="complete",type="flash.events.Event")]
   public class CompatibleURLLoader extends EventDispatcher
   {
       
      
      private var text_data:String;
      
      private var _url_loader:URLLoader;
      
      public function CompatibleURLLoader()
      {
         super();
      }
      
      public function get dataFormat() : String
      {
         return this.getURLLoader().dataFormat;
      }
      
      public function set dataFormat(param1:String) : void
      {
         this.getURLLoader().dataFormat = param1;
      }
      
      public function load(param1:Object) : void
      {
         var request:Object = param1;
         if(request is String)
         {
            this.reInit();
            this.text_data = request as String;
            this.dispatchManual();
            return;
         }
         if(request is URLRequest)
         {
            this.loadURL(request);
            return;
         }
         if(request is URLLoader)
         {
            this.url_loader = request as URLLoader;
            return;
         }
         try
         {
            String(request);
         }
         catch(e:Error)
         {
            throw new Error("CompatibleURLLoader错误：" + getQualifiedClassName(request) + "不是支持的类型！");
         }
         this.load(String(request));
      }
      
      public function loadURL(param1:Object) : void
      {
         var url:Object = param1;
         if(url is String)
         {
            this.getURLLoader().load(new URLRequest(String(url)));
            return;
         }
         if(url is URLRequest)
         {
            this.getURLLoader().load(URLRequest(url));
            return;
         }
         try
         {
            String(url);
         }
         catch(e:Error)
         {
            throw new Error("CompatibleURLLoader错误：" + getQualifiedClassName(url) + "不是支持的类型！");
         }
         this.loadURL(String(url));
      }
      
      public function get data() : Object
      {
         var _loc1_:Object = null;
         if(this.url_loader != null)
         {
            _loc1_ = this.url_loader.data;
         }
         else
         {
            _loc1_ = this.text_data;
         }
         return _loc1_;
      }
      
      public function getURLLoader() : URLLoader
      {
         if(this.url_loader == null)
         {
            this.url_loader = new URLLoader();
         }
         return this.url_loader;
      }
      
      private function dispatchManual() : void
      {
         delayCallNextFrame(function():void
         {
            dispatchEvent(new Event(Event.OPEN));
            dispatchEvent(new Event(Event.COMPLETE));
         });
      }
      
      private function set url_loader(param1:URLLoader) : void
      {
         if(this._url_loader != null)
         {
            EventProxy.unProxy(this._url_loader,this,[Event.COMPLETE,Event.OPEN,HTTPStatusEvent.HTTP_STATUS,ProgressEvent.PROGRESS,SecurityErrorEvent.SECURITY_ERROR,IOErrorEvent.IO_ERROR]);
         }
         EventProxy.proxy(param1,this,[Event.COMPLETE,Event.OPEN,HTTPStatusEvent.HTTP_STATUS,ProgressEvent.PROGRESS,SecurityErrorEvent.SECURITY_ERROR,IOErrorEvent.IO_ERROR]);
         this._url_loader = param1;
      }
      
      private function get url_loader() : URLLoader
      {
         return this._url_loader;
      }
      
      private function reInit() : void
      {
         this.text_data = null;
         if(this.url_loader != null)
         {
            this.url_loader.close();
         }
         this._url_loader = null;
      }
   }
}
