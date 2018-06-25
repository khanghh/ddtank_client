package org.aswing{   import flash.display.Stage;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.KeyboardEvent;   import org.aswing.util.ASWingVector;      [Event(name="keyDown",type="flash.events.KeyboardEvent")]   [Event(name="keyUp",type="flash.events.KeyboardEvent")]   public class KeyboardManager extends EventDispatcher   {            private static var instance:KeyboardManager;                   private var keymaps:ASWingVector;            private var keySequence:ASWingVector;            private var selfKeyMap:KeyMap;            private var inited:Boolean;            private var keyJustActed:Boolean;            private var _isStopDispatching:Boolean;            private var mnemonicModifier:Array;            public function KeyboardManager() { super(); }
            public static function getInstance() : KeyboardManager { return null; }
            public static function isDown(keyCode:uint) : Boolean { return false; }
            public function customDispatchEvent(event:Event) : Boolean { return false; }
            public function init(stage:Stage) : void { }
            override public function dispatchEvent(event:Event) : Boolean { return false; }
            public function registerKeyMap(keyMap:KeyMap) : void { }
            public function unregisterKeyMap(keyMap:KeyMap) : void { }
            public function registerKeyAction(key:KeyType, action:Function) : void { }
            public function unregisterKeyAction(key:KeyType, action:Function) : void { }
            public function isKeyDown(keyCode:uint) : Boolean { return false; }
            public function setMnemonicModifier(keyCodes:Array) : void { }
            public function isMnemonicModifierDown() : Boolean { return false; }
            public function isKeyJustActed() : Boolean { return false; }
            private function __onKeyDown(e:KeyboardEvent) : void { }
            private function __onKeyUp(e:KeyboardEvent) : void { }
            private function __deactived(e:Event) : void { }
            public function reset() : void { }
            public function get isStopDispatching() : Boolean { return false; }
            public function set isStopDispatching(value:Boolean) : void { }
   }}