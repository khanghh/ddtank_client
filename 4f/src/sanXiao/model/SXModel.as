package sanXiao.model{   import sanXiao.game.SXCellItem;      public class SXModel   {            public static const PROP_NONE:int = 0;            public static const PROP_CROSS_BOMB:int = 1;            public static const PROP_SQUARE_BOMB:int = 2;            public static const PROP_CLEAR_COLOR:int = 3;            public static const PROP_CHANGE_COLOR:int = 4;                   public var ROW_COUNT:Number = 7;            public var COLUMN_COUNT:Number = 7;            public var tweenDuration:Number = 0.5;            public var boomLength:int = 3;            public var typeCount:int = 5;            public var curProp:int = 0;            private var _map:Vector.<Vector.<SXCellData>>;            private var _row:Number = 0;            private var _column:Number = 0;            public function SXModel() { super(); }
            public function initMap($row:Number = 7, $column:Number = 7) : void { }
            public function createNewMap() : void { }
            public function setMap(mapInfo:Array) : void { }
            public function getData(r:int, c:int) : SXCellData { return null; }
            public function map() : Vector.<Vector.<SXCellData>> { return null; }
            public function mapInfo() : Array { return null; }
            public function mapDataArray() : Vector.<SXCellData> { return null; }
            public function cellTypeExchange(pos1:Pos, type1:int, pos2:Pos, type2:int) : Boolean { return false; }
            public function cellPropCrossBomb(pos:Pos) : Vector.<SXCellData> { return null; }
            public function cellPropSquareBomb(pos:Pos) : Vector.<SXCellData> { return null; }
            public function cellPropClearColor(pos:Pos) : Vector.<SXCellData> { return null; }
            public function cellPropChangeColor(pos:Pos) : Vector.<SXCellData> { return null; }
            private function checkBoomList(pos:Pos) : Vector.<SXCellData> { return null; }
            public function canBoomCellsList(posArr:Array) : Vector.<SXCellData> { return null; }
            private function spread(boomList:Vector.<SXCellData>) : Vector.<SXCellData> { return null; }
            public function boomAndFall(posArr:Vector.<SXCellData>) : Vector.<SXCellData> { return null; }
            public function isDieMap() : Boolean { return false; }
            private function isDie($x:Number, $y:Number) : Boolean { return false; }
   }}