package road7th{   import com.demonsters.debugger.MonsterDebugger;   import com.pickgliss.ui.ComponentFactory;   import flash.display.BitmapData;   import flash.geom.Point;   import flash.geom.Rectangle;   import starling.core.Starling;   import starling.display.Image;   import starling.display.Sprite;   import starling.events.ResizeEvent;   import starling.scene.Scene;   import starling.textures.Texture;      public class StarlingMain extends Sprite   {            private static var _instance:StarlingMain;                   public var currentScene:Scene;            public function StarlingMain() { super(); }
            public static function get instance() : StarlingMain { return null; }
            private function initAsset() : void { }
            public function onStarlingCreate() : void { }
            private function onStageResize(evt:ResizeEvent) : void { }
            public function leaveCurrentScene() : void { }
            public function enterScene(scene:Scene) : void { }
            public function createImage(styleName:String = "default", posObject:* = null) : Image { return null; }
   }}