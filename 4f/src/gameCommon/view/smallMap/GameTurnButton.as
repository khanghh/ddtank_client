package gameCommon.view.smallMap{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObjectContainer;   import flash.display.MovieClip;   import flash.events.Event;   import road7th.utils.MovieClipWrapper;      public class GameTurnButton extends TextButton   {                   private var _turnShine:MovieClipWrapper;            private var _container:DisplayObjectContainer;            public var isFirst:Boolean = true;            public function GameTurnButton(container:DisplayObjectContainer) { super(); }
            override protected function init() : void { }
            public function shine() : void { }
            private function __shineComplete(evt:Event) : void { }
            override public function get width() : Number { return 0; }
            override public function dispose() : void { }
   }}