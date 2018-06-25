package gameCommon.view.playerThumbnail{   import com.pickgliss.ui.core.Disposeable;   import ddt.events.LivingEvent;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.filters.BitmapFilter;   import flash.filters.ColorMatrixFilter;   import flash.text.TextField;   import gameCommon.model.Living;   import gameCommon.model.SimpleBoss;      public class NPCThumbnail extends Sprite implements Disposeable   {                   private var _living:Living;            private var _headFigure:HeadFigure;            private var _blood:BloodItem;            private var _name:TextField;            private var _tipContainer:Sprite;            private var lightingFilter:BitmapFilter;            public function NPCThumbnail(living:Living) { super(); }
            public function init() : void { }
            public function initHead() : void { }
            public function initBlood() : void { }
            public function initName() : void { }
            public function initEvents() : void { }
            public function __updateBlood(evt:LivingEvent) : void { }
            public function __die(evt:LivingEvent) : void { }
            private function __shineChange(evt:LivingEvent) : void { }
            protected function overHandler(evt:MouseEvent) : void { }
            protected function outHandler(evt:MouseEvent) : void { }
            public function setUpLintingFilter() : void { }
            public function removeEvents() : void { }
            public function updateView() : void { }
            public function set info(value:Living) : void { }
            public function dispose() : void { }
   }}