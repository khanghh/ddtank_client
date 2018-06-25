package starling.display.sceneCharacter
{
   public class SceneCharacterTextureItem
   {
       
      
      private var _type:String;
      
      private var _sortOrder:int;
      
      private var _sourceName:String;
      
      private var _cellWitdh:Number;
      
      private var _cellHeight:Number;
      
      private var _rowNumber:int;
      
      private var _rowCellNumber:int;
      
      private var _isRepeat:Boolean;
      
      private var _amount:int;
      
      private var _parseType:int;
      
      public function SceneCharacterTextureItem(type:String, sourceName:String, amount:int, rowNumber:int, rowCellNumber:int, cellWitdh:Number, cellHeight:Number, sortOrder:int = 0, parseType:int = 0)
      {
         super();
         _type = type;
         _sourceName = sourceName;
         _amount = amount;
         _rowNumber = rowNumber;
         _rowCellNumber = rowCellNumber;
         _cellWitdh = cellWitdh;
         _cellHeight = cellHeight;
         _sortOrder = sortOrder;
         _parseType = parseType;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get sourceName() : String
      {
         return _sourceName;
      }
      
      public function set sourceName(value:String) : void
      {
         _sourceName = value;
      }
      
      public function get cellWitdh() : Number
      {
         return _cellWitdh;
      }
      
      public function get cellHeight() : Number
      {
         return _cellHeight;
      }
      
      public function get rowNumber() : int
      {
         return _rowNumber;
      }
      
      public function set rowNumber(value:int) : void
      {
         _rowNumber = value;
      }
      
      public function get rowCellNumber() : int
      {
         return _rowCellNumber;
      }
      
      public function set rowCellNumber(value:int) : void
      {
         _rowCellNumber = value;
      }
      
      public function get sortOrder() : int
      {
         return _sortOrder;
      }
      
      public function get isRepeat() : Boolean
      {
         return _isRepeat;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function set parseType(value:int) : void
      {
         _parseType = value;
      }
      
      public function get parseType() : int
      {
         return _parseType;
      }
   }
}
