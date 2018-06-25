package morn.core.managers{   import flash.display.Sprite;   import flash.events.Event;   import flash.events.FocusEvent;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.filters.GlowFilter;   import flash.system.System;   import flash.text.TextField;   import flash.text.TextFormat;   import morn.core.utils.ObjectUtils;      public class LogManager extends Sprite   {                   private var _msgs:Array;            private var _box:Sprite;            private var _textField:TextField;            private var _filter:TextField;            private var _filters:Array;            private var _canScroll:Boolean = true;            private var _scroll:TextField;            public function LogManager() { super(); }
            private function onAddedToStage(e:Event) : void { }
            private function createLinkButton(text:String) : TextField { return null; }
            private function onCopyClick(e:MouseEvent) : void { }
            private function onScrollClick(e:MouseEvent) : void { }
            private function onClearClick(e:MouseEvent) : void { }
            private function onFilterKeyDown(e:KeyboardEvent) : void { }
            private function onFilterFocusOut(e:FocusEvent) : void { }
            private function onStageKeyDown(e:KeyboardEvent) : void { }
            public function clear() : void { }
            public function info(... args) : void { }
            public function echo(... args) : void { }
            public function debug(... args) : void { }
            public function error(... args) : void { }
            public function warn(... args) : void { }
            public function print(type:String, args:Array, color:uint) : void { }
            public function toggle() : void { }
            private function refresh(newMsg:String) : void { }
            private function isFilter(msg:String) : Boolean { return false; }
   }}