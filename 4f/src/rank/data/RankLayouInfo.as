package rank.data{   import flash.geom.Point;      public class RankLayouInfo   {                   public var TitleHLinePoint:Vector.<Point>;            public var InfoTextWidth:Array;            public var TitleTextPoint:Vector.<Point>;            public var TitleTextString:Array;            public function RankLayouInfo() { super(); }
            public function set infoTextWidth(value:String) : void { }
            public function set titleHLinePt(value:String) : void { }
            public function set titleTextPt(value:String) : void { }
            private function parseValue(value:String) : Vector.<Point> { return null; }
   }}