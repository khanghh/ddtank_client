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
       
      
      public function SystemUtil(){super();}
      
      public static function initialize() : void{}
      
      private static function onActivate(param1:Object) : void{}
      
      private static function onDeactivate(param1:Object) : void{}
      
      public static function executeWhenApplicationIsActive(param1:Function, ... rest) : void{}
      
      public static function get isApplicationActive() : Boolean{return false;}
      
      public static function get isAIR() : Boolean{return false;}
      
      public static function get isDesktop() : Boolean{return false;}
      
      public static function get platform() : String{return null;}
      
      public static function get version() : String{return null;}
      
      public static function get supportsRelaxedTargetClearRequirement() : Boolean{return false;}
      
      public static function get supportsDepthAndStencil() : Boolean{return false;}
      
      public static function get supportsVideoTexture() : Boolean{return false;}
   }
}
