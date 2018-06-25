package mainbutton{   public class MainButton   {                   public var ID:String;            private var _btnMark:int;            private var _btnName:String;            private var _btnServerVisable:int;            private var _btnCompleteVisable:int;            public var IsShow:Boolean;            public function MainButton() { super(); }
            public function get btnCompleteVisable() : int { return 0; }
            public function set btnCompleteVisable(value:int) : void { }
            public function get btnServerVisable() : int { return 0; }
            public function set btnServerVisable(value:int) : void { }
            public function get btnName() : String { return null; }
            public function set btnName(value:String) : void { }
            public function get btnMark() : int { return 0; }
            public function set btnMark(value:int) : void { }
   }}