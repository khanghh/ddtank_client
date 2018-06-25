package org.aswing{   import flash.utils.Dictionary;      public class KeyMap   {                   private var map:Dictionary;            public function KeyMap() { super(); }
            public static function getCodec(key:KeyType) : String { return null; }
            public static function getCodecWithKeySequence(keySequence:Array) : String { return null; }
            public function registerKeyAction(key:KeyType, action:Function) : void { }
            public function unregisterKeyAction(key:KeyType, action:Function) : void { }
            public function getKeyAction(key:KeyType) : Function { return null; }
            private function getKeyActionWithCodec(codec:String) : Function { return null; }
            public function fireKeyAction(keySequence:Array) : Boolean { return false; }
            public function containsKey(key:KeyType) : Boolean { return false; }
   }}import org.aswing.KeyType;class KeyAction{          private var key:KeyType;      private var action:Function;      function KeyAction(key:KeyType, action:Function) { super(); }
}