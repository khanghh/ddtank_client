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
      
      public function SceneCharacterTextureItem(param1:String, param2:String, param3:int, param4:int, param5:int, param6:Number, param7:Number, param8:int = 0, param9:int = 0)
      {
         super();
         _type = param1;
         _sourceName = param2;
         _amount = param3;
         _rowNumber = param4;
         _rowCellNumber = param5;
         _cellWitdh = param6;
         _cellHeight = param7;
         _sortOrder = param8;
         _parseType = param9;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get sourceName() : String
      {
         return _sourceName;
      }
      
      public function set sourceName(param1:String) : void
      {
         _sourceName = param1;
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
      
      public function set rowNumber(param1:int) : void
      {
         _rowNumber = param1;
      }
      
      public function get rowCellNumber() : int
      {
         return _rowCellNumber;
      }
      
      public function set rowCellNumber(param1:int) : void
      {
         _rowCellNumber = param1;
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
      
      public function set parseType(param1:int) : void
      {
         _parseType = param1;
      }
      
      public function get parseType() : int
      {
         return _parseType;
      }
   }
}
