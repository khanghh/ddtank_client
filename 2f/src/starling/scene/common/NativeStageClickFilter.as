package starling.scene.common{   import com.pickgliss.ui.core.Disposeable;   import flash.display.DisplayObject;   import flash.events.MouseEvent;   import starling.core.Starling;      public class NativeStageClickFilter implements Disposeable   {                   private var _nativeStageClickDisplayObj:DisplayObject;            public function NativeStageClickFilter() { super(); }
            private function onNativeStageClick(evt:MouseEvent) : void { }
            public function isTypeOf(arr:Array) : Boolean { return false; }
            public function get nativeStageClickDisplayObj() : DisplayObject { return null; }
            public function dispose() : void { }
   }}