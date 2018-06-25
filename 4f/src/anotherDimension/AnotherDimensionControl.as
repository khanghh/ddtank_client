package anotherDimension{   import anotherDimension.controller.AnotherDimensionManager;   import anotherDimension.view.AnotherDimensionMainView;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import flash.events.Event;   import flash.events.EventDispatcher;      public class AnotherDimensionControl extends EventDispatcher   {            private static var _instance:AnotherDimensionControl;                   private var _anotherDimensionMainView:AnotherDimensionMainView;            public function AnotherDimensionControl() { super(); }
            public static function get instance() : AnotherDimensionControl { return null; }
            public function setup() : void { }
            private function __showHandler(e:Event) : void { }
            private function __updateResourceDataHandler(e:Event) : void { }
            private function showMainView() : void { }
            public function disposeMainView() : void { }
   }}