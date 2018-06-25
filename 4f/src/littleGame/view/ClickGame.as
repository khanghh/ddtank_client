package littleGame.view{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.core.Disposeable;   import flash.display.Graphics;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.text.TextField;   import flash.text.TextFormat;   import flash.utils.getDefinitionByName;   import flash.utils.getTimer;   import littleGame.model.LittleSelf;      public class ClickGame extends Sprite implements Disposeable   {                   private var _clickTextField:TextField;            private var _startTime:int;            private var _clickCount:int = 0;            private var _self:LittleSelf;            private var _asset:MovieClip;            public function ClickGame() { super(); }
            private function configUI() : void { }
            private function addEvent() : void { }
            private function __shutdown(event:Event) : void { }
            private function __startup(event:Event) : void { }
            private function removeEvent() : void { }
            private function __clicked(event:MouseEvent) : void { }
            public function dispose() : void { }
   }}