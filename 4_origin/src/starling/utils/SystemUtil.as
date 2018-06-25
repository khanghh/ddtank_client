package starling.utils
{
   import flash.display3D.Context3D;
   import flash.events.EventDispatcher;
   import flash.system.Capabilities;
   import flash.utils.getDefinitionByName;
   import starling.errors.AbstractClassError;
   
   public class SystemUtil
   {
      
      private static var sInitialized:Boolean = false;
      
      private static var sApplicationActive:Boolean = true;
      
      private static var sWaitingCalls:Array = [];
      
      private static var sPlatform:String;
      
      private static var sVersion:String;
      
      private static var sAIR:Boolean;
      
      private static var sSupportsDepthAndStencil:Boolean = true;
       
      
      public function SystemUtil()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function initialize() : void
      {
         var nativeAppClass:* = null;
         var nativeApp:* = null;
         var appDescriptor:* = null;
         var ns:* = null;
         var ds:* = null;
         if(sInitialized)
         {
            return;
         }
         sInitialized = true;
         sPlatform = Capabilities.version.substr(0,3);
         sVersion = Capabilities.version.substr(4);
         try
         {
            nativeAppClass = getDefinitionByName("flash.desktop::NativeApplication");
            nativeApp = nativeAppClass["nativeApplication"] as EventDispatcher;
            nativeApp.addEventListener("activate",onActivate,false,0,true);
            nativeApp.addEventListener("deactivate",onDeactivate,false,0,true);
            appDescriptor = nativeApp["applicationDescriptor"];
            ns = appDescriptor.namespace();
            ds = appDescriptor.ns::initialWindow.ns::depthAndStencil.toString().toLowerCase();
            sSupportsDepthAndStencil = ds == "true";
            sAIR = true;
            return;
         }
         catch(e:Error)
         {
            sAIR = false;
            return;
         }
      }
      
      private static function onActivate(event:Object) : void
      {
         sApplicationActive = true;
         var _loc4_:int = 0;
         var _loc3_:* = sWaitingCalls;
         for each(var call in sWaitingCalls)
         {
            call[0].apply(null,call[1]);
         }
         sWaitingCalls = [];
      }
      
      private static function onDeactivate(event:Object) : void
      {
         sApplicationActive = false;
      }
      
      public static function executeWhenApplicationIsActive(call:Function, ... args) : void
      {
         initialize();
         if(sApplicationActive)
         {
            call.apply(null,args);
         }
         else
         {
            sWaitingCalls.push([call,args]);
         }
      }
      
      public static function get isApplicationActive() : Boolean
      {
         initialize();
         return sApplicationActive;
      }
      
      public static function get isAIR() : Boolean
      {
         initialize();
         return sAIR;
      }
      
      public static function get isDesktop() : Boolean
      {
         initialize();
         return /(WIN|MAC|LNX)/.exec(sPlatform) != null;
      }
      
      public static function get platform() : String
      {
         initialize();
         return sPlatform;
      }
      
      public static function get version() : String
      {
         initialize();
         return sVersion;
      }
      
      public static function get supportsRelaxedTargetClearRequirement() : Boolean
      {
         return parseInt(/\d+/.exec(sVersion)[0]) >= 15;
      }
      
      public static function get supportsDepthAndStencil() : Boolean
      {
         return sSupportsDepthAndStencil;
      }
      
      public static function get supportsVideoTexture() : Boolean
      {
         return Context3D["supportsVideoTexture"];
      }
   }
}
