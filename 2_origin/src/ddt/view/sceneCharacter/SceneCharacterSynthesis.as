package ddt.view.sceneCharacter
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class SceneCharacterSynthesis
   {
       
      
      private var _sceneCharacterSet:SceneCharacterSet;
      
      private var _frameBitmap:Vector.<Bitmap>;
      
      private var _callBack:Function;
      
      public function SceneCharacterSynthesis(sceneCharacterSet:SceneCharacterSet, callBack:Function)
      {
         _frameBitmap = new Vector.<Bitmap>();
         super();
         _sceneCharacterSet = sceneCharacterSet;
         _callBack = callBack;
         initialize();
      }
      
      private function initialize() : void
      {
         characterSynthesis();
      }
      
      private function characterSynthesis() : void
      {
         var bmp:* = null;
         var i:int = 0;
         var bmp2:* = null;
         var row:int = 0;
         var cellCount:int = 0;
         var j:int = 0;
         var sourcePoint:* = null;
         var matrix:Matrix = new Matrix();
         var point:Point = new Point(0,0);
         var rectangle:Rectangle = new Rectangle();
         var _loc15_:int = 0;
         var _loc14_:* = _sceneCharacterSet.dataSet;
         for each(var sceneCharacterItem in _sceneCharacterSet.dataSet)
         {
            if(sceneCharacterItem.isRepeat)
            {
               bmp = new BitmapData(sceneCharacterItem.source.width * sceneCharacterItem.repeatNumber,sceneCharacterItem.source.height,true,0);
               for(i = 0; i < sceneCharacterItem.repeatNumber; )
               {
                  matrix.tx = sceneCharacterItem.source.width * i;
                  bmp.draw(sceneCharacterItem.source,matrix);
                  i++;
               }
               sceneCharacterItem.source.dispose();
               sceneCharacterItem.source = null;
               sceneCharacterItem.source = new BitmapData(bmp.width,bmp.height,true,0);
               sceneCharacterItem.source.draw(bmp);
               bmp.dispose();
               bmp = null;
            }
            if(sceneCharacterItem.points && sceneCharacterItem.points.length > 0)
            {
               bmp2 = new BitmapData(sceneCharacterItem.source.width,sceneCharacterItem.source.height,true,0);
               bmp2.draw(sceneCharacterItem.source);
               sceneCharacterItem.source.dispose();
               sceneCharacterItem.source = null;
               sceneCharacterItem.source = new BitmapData(bmp2.width,bmp2.height,true,0);
               rectangle.width = sceneCharacterItem.cellWitdh;
               rectangle.height = sceneCharacterItem.cellHeight;
               for(row = 0; row < sceneCharacterItem.rowNumber; )
               {
                  cellCount = !!sceneCharacterItem.isRepeat?sceneCharacterItem.repeatNumber:int(sceneCharacterItem.rowCellNumber);
                  for(j = 0; j < cellCount; )
                  {
                     sourcePoint = sceneCharacterItem.points[row * cellCount + j];
                     if(sourcePoint)
                     {
                        point.x = sceneCharacterItem.cellWitdh * j + sourcePoint.x;
                        point.y = sceneCharacterItem.cellHeight * row + sourcePoint.y;
                        rectangle.x = sceneCharacterItem.cellWitdh * j;
                        rectangle.y = sceneCharacterItem.cellHeight * row;
                        sceneCharacterItem.source.copyPixels(bmp2,rectangle,point);
                     }
                     else
                     {
                        var _loc13_:* = sceneCharacterItem.cellWitdh * j;
                        rectangle.x = _loc13_;
                        point.x = _loc13_;
                        _loc13_ = sceneCharacterItem.cellHeight * row;
                        rectangle.y = _loc13_;
                        point.y = _loc13_;
                        sceneCharacterItem.source.copyPixels(bmp2,rectangle,point);
                     }
                     j++;
                  }
                  row++;
               }
               bmp2.dispose();
               bmp2 = null;
            }
         }
         var _loc17_:int = 0;
         var _loc16_:* = _sceneCharacterSet.dataSet;
         for each(var sceneCharacterItemGroup in _sceneCharacterSet.dataSet)
         {
            characterGroupDraw(sceneCharacterItemGroup);
         }
         characterDraw();
      }
      
      private function characterGroupDraw(sceneCharacterItem:SceneCharacterItem) : void
      {
         var i:int = 0;
         for(i = 0; i < _sceneCharacterSet.dataSet.length; )
         {
            if(sceneCharacterItem.groupType == _sceneCharacterSet.dataSet[i].groupType && _sceneCharacterSet.dataSet[i].type != sceneCharacterItem.type)
            {
               sceneCharacterItem.source.draw(_sceneCharacterSet.dataSet[i].source);
               sceneCharacterItem.rowNumber = _sceneCharacterSet.dataSet[i].rowNumber > sceneCharacterItem.rowNumber?_sceneCharacterSet.dataSet[i].rowNumber:int(sceneCharacterItem.rowNumber);
               sceneCharacterItem.rowCellNumber = _sceneCharacterSet.dataSet[i].rowCellNumber > sceneCharacterItem.rowCellNumber?_sceneCharacterSet.dataSet[i].rowCellNumber:int(sceneCharacterItem.rowCellNumber);
               _sceneCharacterSet.dataSet.splice(_sceneCharacterSet.dataSet.indexOf(_sceneCharacterSet.dataSet[i]),1);
               i--;
            }
            i++;
         }
      }
      
      private function characterDraw() : void
      {
         var bmp:* = null;
         var row:int = 0;
         var i:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _sceneCharacterSet.dataSet;
         for each(var sceneCharacterItem in _sceneCharacterSet.dataSet)
         {
            for(row = 0; row < sceneCharacterItem.rowNumber; )
            {
               for(i = 0; i < sceneCharacterItem.rowCellNumber; )
               {
                  bmp = new BitmapData(sceneCharacterItem.cellWitdh,sceneCharacterItem.cellHeight,true,0);
                  bmp.copyPixels(sceneCharacterItem.source,new Rectangle(i * sceneCharacterItem.cellWitdh,sceneCharacterItem.cellHeight * row,sceneCharacterItem.cellWitdh,sceneCharacterItem.cellHeight),new Point(0,0));
                  _frameBitmap.push(new Bitmap(bmp));
                  i++;
               }
               row++;
            }
         }
         if(_callBack != null)
         {
            _callBack(_frameBitmap);
         }
      }
      
      public function dispose() : void
      {
         if(_sceneCharacterSet)
         {
            _sceneCharacterSet.dispose();
         }
         _sceneCharacterSet = null;
         while(_frameBitmap && _frameBitmap.length > 0)
         {
            _frameBitmap[0].bitmapData.dispose();
            _frameBitmap[0].bitmapData = null;
            _frameBitmap.shift();
         }
         _frameBitmap = null;
         _callBack = null;
      }
   }
}
