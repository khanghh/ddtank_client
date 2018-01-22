package sanXiao.model
{
   import sanXiao.game.SXCellItem;
   
   public class SXModel
   {
      
      public static const PROP_NONE:int = 0;
      
      public static const PROP_CROSS_BOMB:int = 1;
      
      public static const PROP_SQUARE_BOMB:int = 2;
      
      public static const PROP_CLEAR_COLOR:int = 3;
      
      public static const PROP_CHANGE_COLOR:int = 4;
       
      
      public var ROW_COUNT:Number = 7;
      
      public var COLUMN_COUNT:Number = 7;
      
      public var tweenDuration:Number = 0.5;
      
      public var boomLength:int = 3;
      
      public var typeCount:int = 5;
      
      public var curProp:int = 0;
      
      private var _map:Vector.<Vector.<SXCellData>>;
      
      private var _row:Number = 0;
      
      private var _column:Number = 0;
      
      public function SXModel(){super();}
      
      public function initMap(param1:Number = 7, param2:Number = 7) : void{}
      
      public function createNewMap() : void{}
      
      public function setMap(param1:Array) : void{}
      
      public function getData(param1:int, param2:int) : SXCellData{return null;}
      
      public function map() : Vector.<Vector.<SXCellData>>{return null;}
      
      public function mapInfo() : Array{return null;}
      
      public function mapDataArray() : Vector.<SXCellData>{return null;}
      
      public function cellTypeExchange(param1:Pos, param2:int, param3:Pos, param4:int) : Boolean{return false;}
      
      public function cellPropCrossBomb(param1:Pos) : Vector.<SXCellData>{return null;}
      
      public function cellPropSquareBomb(param1:Pos) : Vector.<SXCellData>{return null;}
      
      public function cellPropClearColor(param1:Pos) : Vector.<SXCellData>{return null;}
      
      public function cellPropChangeColor(param1:Pos) : Vector.<SXCellData>{return null;}
      
      private function checkBoomList(param1:Pos) : Vector.<SXCellData>{return null;}
      
      public function canBoomCellsList(param1:Array) : Vector.<SXCellData>{return null;}
      
      private function spread(param1:Vector.<SXCellData>) : Vector.<SXCellData>{return null;}
      
      public function boomAndFall(param1:Vector.<SXCellData>) : Vector.<SXCellData>{return null;}
      
      public function isDieMap() : Boolean{return false;}
      
      private function isDie(param1:Number, param2:Number) : Boolean{return false;}
   }
}
