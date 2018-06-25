package starling.display.sceneCharacter{   public class SceneCharacterTextureItem   {                   private var _type:String;            private var _sortOrder:int;            private var _sourceName:String;            private var _cellWitdh:Number;            private var _cellHeight:Number;            private var _rowNumber:int;            private var _rowCellNumber:int;            private var _isRepeat:Boolean;            private var _amount:int;            private var _parseType:int;            public function SceneCharacterTextureItem(type:String, sourceName:String, amount:int, rowNumber:int, rowCellNumber:int, cellWitdh:Number, cellHeight:Number, sortOrder:int = 0, parseType:int = 0) { super(); }
            public function get type() : String { return null; }
            public function get sourceName() : String { return null; }
            public function set sourceName(value:String) : void { }
            public function get cellWitdh() : Number { return 0; }
            public function get cellHeight() : Number { return 0; }
            public function get rowNumber() : int { return 0; }
            public function set rowNumber(value:int) : void { }
            public function get rowCellNumber() : int { return 0; }
            public function set rowCellNumber(value:int) : void { }
            public function get sortOrder() : int { return 0; }
            public function get isRepeat() : Boolean { return false; }
            public function get amount() : int { return 0; }
            public function set parseType(value:int) : void { }
            public function get parseType() : int { return 0; }
   }}