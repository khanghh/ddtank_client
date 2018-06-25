package dice.vo{   import flash.geom.Point;      public class DiceCellInfo   {                   private var _position:Point;            private var _vertices1:Point;            private var _vertices2:Point;            private var _vertices3:Point;            private var _centerPosition:Point;            public function DiceCellInfo() { super(); }
            public function get CellCenterPosition() : Point { return null; }
            public function set centerPosition(value:String) : void { }
            public function get Position() : Point { return null; }
            public function set position(value:String) : void { }
            public function set verticesString(value:String) : void { }
            public function get vertices1() : Point { return null; }
            public function get vertices2() : Point { return null; }
            public function get vertices3() : Point { return null; }
            public function dispose() : void { }
   }}