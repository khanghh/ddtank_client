package ddt.view.sceneCharacter
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class SceneCharacterItem
   {
       
      
      private var _type:String;
      
      private var _groupType:String;
      
      private var _sortOrder:int;
      
      private var _source:BitmapData;
      
      private var _points:Vector.<Point>;
      
      private var _cellWitdh:Number;
      
      private var _cellHeight:Number;
      
      private var _rowNumber:int;
      
      private var _rowCellNumber:int;
      
      private var _isRepeat:Boolean;
      
      private var _repeatNumber:int;
      
      public function SceneCharacterItem(param1:String, param2:String, param3:BitmapData, param4:int, param5:int, param6:Number, param7:Number, param8:int = 0, param9:Vector.<Point> = null, param10:Boolean = false, param11:int = 0)
      {
         super();
         _type = param1;
         _groupType = param2;
         _source = param3;
         _rowNumber = param4;
         _rowCellNumber = param5;
         _cellWitdh = param6;
         _cellHeight = param7;
         _points = param9;
         _sortOrder = param8;
         _isRepeat = param10;
         _repeatNumber = param11;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get groupType() : String
      {
         return _groupType;
      }
      
      public function get source() : BitmapData
      {
         return _source;
      }
      
      public function set source(param1:BitmapData) : void
      {
         _source = param1;
      }
      
      public function get points() : Vector.<Point>
      {
         return _points;
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
      
      public function get repeatNumber() : int
      {
         return _repeatNumber;
      }
      
      public function dispose() : void
      {
         if(_source)
         {
            _source.dispose();
         }
         _source = null;
         while(_points && _points.length > 0)
         {
            _points.shift();
         }
         _points = null;
      }
   }
}
