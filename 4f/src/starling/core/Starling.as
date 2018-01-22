package starling.core
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.Stage3D;
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import flash.errors.IllegalOperationError;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TouchEvent;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import flash.ui.Multitouch;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import starling.animation.Juggler;
   import starling.display.DisplayObject;
   import starling.display.Stage;
   import starling.events.EventDispatcher;
   import starling.events.ResizeEvent;
   import starling.events.TouchProcessor;
   import starling.utils.SystemUtil;
   import starling.utils.execute;
   
   [Event(name="context3DCreate",type="starling.events.Event")]
   [Event(name="rootCreated",type="starling.events.Event")]
   [Event(name="fatalError",type="starling.events.Event")]
   [Event(name="render",type="starling.events.Event")]
   public class Starling extends EventDispatcher
   {
      
      public static const VERSION:String = "1.7";
      
      private static const PROGRAM_DATA_NAME:String = "Starling.programs";
      
      private static var sCurrent:Starling;
      
      private static var sHandleLostContext:Boolean = true;
      
      private static var sContextData:Dictionary = new Dictionary(true);
      
      private static var sAll:Vector.<Starling> = new Vector.<Starling>(0);
       
      
      private var mStage3D:Stage3D;
      
      private var mStage:starling.display.Stage;
      
      private var mRootClass:Class;
      
      private var mRoot:DisplayObject;
      
      private var mJuggler:Juggler;
      
      private var mSupport:RenderSupport;
      
      private var mTouchProcessor:TouchProcessor;
      
      private var mAntiAliasing:int;
      
      private var mSimulateMultitouch:Boolean;
      
      private var mEnableErrorChecking:Boolean;
      
      private var mLastFrameTimestamp:Number;
      
      private var mLeftMouseDown:Boolean;
      
      private var mStatsDisplay:StatsDisplay;
      
      private var mShareContext:Boolean;
      
      private var mProfile:String;
      
      private var mContext:Context3D;
      
      private var mStarted:Boolean;
      
      private var mRendering:Boolean;
      
      private var mSupportHighResolutions:Boolean;
      
      private var mViewPort:Rectangle;
      
      private var mPreviousViewPort:Rectangle;
      
      private var mClippedViewPort:Rectangle;
      
      private var mNativeStage:flash.display.Stage;
      
      private var mNativeOverlay:Sprite;
      
      private var mNativeStageContentScaleFactor:Number;
      
      public function Starling(param1:Class, param2:flash.display.Stage, param3:Rectangle = null, param4:Stage3D = null, param5:String = "auto", param6:Object = "baselineConstrained"){super();}
      
      public static function get current() : Starling{return null;}
      
      public static function get all() : Vector.<Starling>{return null;}
      
      public static function get context() : Context3D{return null;}
      
      public static function get juggler() : Juggler{return null;}
      
      public static function get contentScaleFactor() : Number{return 0;}
      
      public static function get multitouchEnabled() : Boolean{return false;}
      
      public static function set multitouchEnabled(param1:Boolean) : void{}
      
      public static function get handleLostContext() : Boolean{return false;}
      
      public static function set handleLostContext(param1:Boolean) : void{}
      
      public function dispose() : void{}
      
      private function requestContext3D(param1:Stage3D, param2:String, param3:Object) : void{}
      
      private function initialize() : void{}
      
      private function initializeGraphicsAPI() : void{}
      
      private function initializeRoot() : void{}
      
      public function nextFrame() : void{}
      
      public function advanceTime(param1:Number) : void{}
      
      public function render() : void{}
      
      private function updateViewPort(param1:Boolean = false) : void{}
      
      private function configureBackBuffer(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean = false) : void{}
      
      private function updateNativeOverlay() : void{}
      
      public function stopWithFatalError(param1:String) : void{}
      
      public function makeCurrent() : void{}
      
      public function start() : void{}
      
      public function stop(param1:Boolean = false) : void{}
      
      private function onStage3DError(param1:ErrorEvent) : void{}
      
      private function onContextCreated(param1:Event) : void{}
      
      private function onEnterFrame(param1:Event) : void{}
      
      private function onKey(param1:flash.events.KeyboardEvent) : void{}
      
      private function onResize(param1:Event) : void{}
      
      private function onMouseLeave(param1:Event) : void{}
      
      private function onTouch(param1:Event) : void{}
      
      private function get touchEventTypes() : Array{return null;}
      
      public function registerProgram(param1:String, param2:ByteArray, param3:ByteArray) : Program3D{return null;}
      
      public function registerProgramFromSource(param1:String, param2:String, param3:String) : Program3D{return null;}
      
      public function deleteProgram(param1:String) : void{}
      
      public function getProgram(param1:String) : Program3D{return null;}
      
      public function hasProgram(param1:String) : Boolean{return false;}
      
      private function get programs() : Dictionary{return null;}
      
      public function get isStarted() : Boolean{return false;}
      
      public function get juggler() : Juggler{return null;}
      
      public function get context() : Context3D{return null;}
      
      public function get contextData() : Dictionary{return null;}
      
      public function get backBufferWidth() : int{return 0;}
      
      public function get backBufferHeight() : int{return 0;}
      
      public function get backBufferPixelsPerPoint() : int{return 0;}
      
      public function get simulateMultitouch() : Boolean{return false;}
      
      public function set simulateMultitouch(param1:Boolean) : void{}
      
      public function get enableErrorChecking() : Boolean{return false;}
      
      public function set enableErrorChecking(param1:Boolean) : void{}
      
      public function get antiAliasing() : int{return 0;}
      
      public function set antiAliasing(param1:int) : void{}
      
      public function get viewPort() : Rectangle{return null;}
      
      public function set viewPort(param1:Rectangle) : void{}
      
      public function get contentScaleFactor() : Number{return 0;}
      
      public function get nativeOverlay() : Sprite{return null;}
      
      public function get showStats() : Boolean{return false;}
      
      public function set showStats(param1:Boolean) : void{}
      
      public function showStatsAt(param1:String = "left", param2:String = "top", param3:Number = 1) : void{}
      
      public function get stage() : starling.display.Stage{return null;}
      
      public function get stage3D() : Stage3D{return null;}
      
      public function get nativeStage() : flash.display.Stage{return null;}
      
      public function get root() : DisplayObject{return null;}
      
      public function get rootClass() : Class{return null;}
      
      public function set rootClass(param1:Class) : void{}
      
      public function get shareContext() : Boolean{return false;}
      
      public function set shareContext(param1:Boolean) : void{}
      
      public function get profile() : String{return null;}
      
      public function get supportHighResolutions() : Boolean{return false;}
      
      public function set supportHighResolutions(param1:Boolean) : void{}
      
      public function get touchProcessor() : TouchProcessor{return null;}
      
      public function set touchProcessor(param1:TouchProcessor) : void{}
      
      public function get contextValid() : Boolean{return false;}
   }
}
