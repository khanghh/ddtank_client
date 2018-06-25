package ddt.view{   import com.pickgliss.utils.ClassUtils;   import flash.events.Event;   import flash.events.EventDispatcher;      [Event(name="close",type="flash.events.Event")]   public class UIModuleSmallLoading extends EventDispatcher   {            private static var _instance:UIModuleSmallLoading;            private static const SMALL_LOADING_CLASS:String = "SmallLoading";            private static var _loadingInstance;                   public function UIModuleSmallLoading() { super(); }
            public static function get Instance() : UIModuleSmallLoading { return null; }
            private static function __onCloseClick(event:Event) : void { }
            public function show(blackGound:Boolean = true, autoRemoveChild:Boolean = true) : void { }
            public function hide() : void { }
            public function get isShow() : Boolean { return false; }
            public function set progress(p:int) : void { }
            public function get progress() : int { return 0; }
            public function setLoadingAlpha(value:*) : void { }
   }}