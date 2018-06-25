package ddt.manager{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import flash.display.DisplayObject;   import flash.display.InteractiveObject;   import flash.display.Sprite;   import flash.display.Stage;   import flash.events.Event;   import flash.events.MouseEvent;      public class StageFocusManager   {            public static const GAME_WIDTH:int = 1000;            public static const GAME_HEIGHT:int = 600;            private static var instance:StageFocusManager;                   private var _count:int;            private var _stage:Stage;            private var _view:Sprite;            private var _currentActiveObject:InteractiveObject;            public function StageFocusManager() { super(); }
            public static function getInstance() : StageFocusManager { return null; }
            public function setup($state:Stage) : void { }
            private function updateView() : void { }
            public function removeEvent() : void { }
            public function addEvent() : void { }
            private function __deactivateHandler(evt:Event) : void { }
            private function __activateHandler(evt:Event) : void { }
            private function __enterFrameHandler(evt:Event) : void { }
            private function __onClickHandler(evt:MouseEvent) : void { }
            public function setActiveFocus(activeObject:InteractiveObject) : void { }
            private function fadein() : void { }
            private function stopFade() : void { }
            private function __onFadein(e:Event) : void { }
   }}