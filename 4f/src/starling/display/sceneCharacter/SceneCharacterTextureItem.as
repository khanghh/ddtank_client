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
      
      public function SceneCharacterTextureItem(param1:String, param2:String, param3:int, param4:int, param5:int, param6:Number, param7:Number, param8:int = 0, param9:int = 0){super();}
      
      public function get type() : String{return null;}
      
      public function get sourceName() : String{return null;}
      
      public function set sourceName(param1:String) : void{}
      
      public function get cellWitdh() : Number{return 0;}
      
      public function get cellHeight() : Number{return 0;}
      
      public function get rowNumber() : int{return 0;}
      
      public function set rowNumber(param1:int) : void{}
      
      public function get rowCellNumber() : int{return 0;}
      
      public function set rowCellNumber(param1:int) : void{}
      
      public function get sortOrder() : int{return 0;}
      
      public function get isRepeat() : Boolean{return false;}
      
      public function get amount() : int{return 0;}
      
      public function set parseType(param1:int) : void{}
      
      public function get parseType() : int{return 0;}
   }
}
