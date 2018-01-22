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
      
      public function SceneCharacterSynthesis(param1:SceneCharacterSet, param2:Function)
      {
         _frameBitmap = new Vector.<Bitmap>();
         super();
         _sceneCharacterSet = param1;
         _callBack = param2;
         initialize();
      }
      
      private function initialize() : void
      {
         characterSynthesis();
      }
      
      private function characterSynthesis() : void
      {
         var _loc1_:* = null;
         var _loc12_:int = 0;
         var _loc4_:* = null;
         var _loc11_:int = 0;
         var _loc10_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:* = null;
         var _loc5_:Matrix = new Matrix();
         var _loc3_:Point = new Point(0,0);
         var _loc2_:Rectangle = new Rectangle();
         var _loc15_:int = 0;
         var _loc14_:* = _sceneCharacterSet.dataSet;
         for each(var _loc6_ in _sceneCharacterSet.dataSet)
         {
            if(_loc6_.isRepeat)
            {
               _loc1_ = new BitmapData(_loc6_.source.width * _loc6_.repeatNumber,_loc6_.source.height,true,0);
               _loc12_ = 0;
               while(_loc12_ < _loc6_.repeatNumber)
               {
                  _loc5_.tx = _loc6_.source.width * _loc12_;
                  _loc1_.draw(_loc6_.source,_loc5_);
                  _loc12_++;
               }
               _loc6_.source.dispose();
               _loc6_.source = null;
               _loc6_.source = new BitmapData(_loc1_.width,_loc1_.height,true,0);
               _loc6_.source.draw(_loc1_);
               _loc1_.dispose();
               _loc1_ = null;
            }
            if(_loc6_.points && _loc6_.points.length > 0)
            {
               _loc4_ = new BitmapData(_loc6_.source.width,_loc6_.source.height,true,0);
               _loc4_.draw(_loc6_.source);
               _loc6_.source.dispose();
               _loc6_.source = null;
               _loc6_.source = new BitmapData(_loc4_.width,_loc4_.height,true,0);
               _loc2_.width = _loc6_.cellWitdh;
               _loc2_.height = _loc6_.cellHeight;
               _loc11_ = 0;
               while(_loc11_ < _loc6_.rowNumber)
               {
                  _loc10_ = !!_loc6_.isRepeat?_loc6_.repeatNumber:int(_loc6_.rowCellNumber);
                  _loc7_ = 0;
                  while(_loc7_ < _loc10_)
                  {
                     _loc9_ = _loc6_.points[_loc11_ * _loc10_ + _loc7_];
                     if(_loc9_)
                     {
                        _loc3_.x = _loc6_.cellWitdh * _loc7_ + _loc9_.x;
                        _loc3_.y = _loc6_.cellHeight * _loc11_ + _loc9_.y;
                        _loc2_.x = _loc6_.cellWitdh * _loc7_;
                        _loc2_.y = _loc6_.cellHeight * _loc11_;
                        _loc6_.source.copyPixels(_loc4_,_loc2_,_loc3_);
                     }
                     else
                     {
                        var _loc13_:* = _loc6_.cellWitdh * _loc7_;
                        _loc2_.x = _loc13_;
                        _loc3_.x = _loc13_;
                        _loc13_ = _loc6_.cellHeight * _loc11_;
                        _loc2_.y = _loc13_;
                        _loc3_.y = _loc13_;
                        _loc6_.source.copyPixels(_loc4_,_loc2_,_loc3_);
                     }
                     _loc7_++;
                  }
                  _loc11_++;
               }
               _loc4_.dispose();
               _loc4_ = null;
            }
         }
         var _loc17_:int = 0;
         var _loc16_:* = _sceneCharacterSet.dataSet;
         for each(var _loc8_ in _sceneCharacterSet.dataSet)
         {
            characterGroupDraw(_loc8_);
         }
         characterDraw();
      }
      
      private function characterGroupDraw(param1:SceneCharacterItem) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _sceneCharacterSet.dataSet.length)
         {
            if(param1.groupType == _sceneCharacterSet.dataSet[_loc2_].groupType && _sceneCharacterSet.dataSet[_loc2_].type != param1.type)
            {
               param1.source.draw(_sceneCharacterSet.dataSet[_loc2_].source);
               param1.rowNumber = _sceneCharacterSet.dataSet[_loc2_].rowNumber > param1.rowNumber?_sceneCharacterSet.dataSet[_loc2_].rowNumber:int(param1.rowNumber);
               param1.rowCellNumber = _sceneCharacterSet.dataSet[_loc2_].rowCellNumber > param1.rowCellNumber?_sceneCharacterSet.dataSet[_loc2_].rowCellNumber:int(param1.rowCellNumber);
               _sceneCharacterSet.dataSet.splice(_sceneCharacterSet.dataSet.indexOf(_sceneCharacterSet.dataSet[_loc2_]),1);
               _loc2_--;
            }
            _loc2_++;
         }
      }
      
      private function characterDraw() : void
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _sceneCharacterSet.dataSet;
         for each(var _loc2_ in _sceneCharacterSet.dataSet)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.rowNumber)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc2_.rowCellNumber)
               {
                  _loc1_ = new BitmapData(_loc2_.cellWitdh,_loc2_.cellHeight,true,0);
                  _loc1_.copyPixels(_loc2_.source,new Rectangle(_loc4_ * _loc2_.cellWitdh,_loc2_.cellHeight * _loc3_,_loc2_.cellWitdh,_loc2_.cellHeight),new Point(0,0));
                  _frameBitmap.push(new Bitmap(_loc1_));
                  _loc4_++;
               }
               _loc3_++;
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
