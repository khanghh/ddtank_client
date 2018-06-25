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
      
      public function SceneCharacterItem(type:String, groupType:String, source:BitmapData, rowNumber:int, rowCellNumber:int, cellWitdh:Number, cellHeight:Number, sortOrder:int = 0, points:Vector.<Point> = null, isRepeat:Boolean = false, repeatNumber:int = 0)
      {
         super();
         _type = type;
         _groupType = groupType;
         _source = source;
         _rowNumber = rowNumber;
         _rowCellNumber = rowCellNumber;
         _cellWitdh = cellWitdh;
         _cellHeight = cellHeight;
         _points = points;
         _sortOrder = sortOrder;
         _isRepeat = isRepeat;
         _repeatNumber = repeatNumber;
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
      
      public function set source(value:BitmapData) : void
      {
         _source = value;
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
