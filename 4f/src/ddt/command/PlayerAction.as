package ddt.command{   public class PlayerAction   {                   public var type:String;            public var stopAtEnd:Boolean;            public var frames:Array;            public var repeat:Boolean;            public var replaceSame:Boolean;            public function PlayerAction(type:String, frames:Array, replaceSame:Boolean, repeat:Boolean, stopAtEnd:Boolean) { super(); }
            public function canReplace(action:PlayerAction) : Boolean { return false; }
            public function toString() : String { return null; }
   }}