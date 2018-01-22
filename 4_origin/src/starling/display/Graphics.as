package starling.display
{
   import flash.geom.Matrix;
   import starling.display.graphics.Fill;
   import starling.display.graphics.Graphic;
   import starling.display.graphics.NGon;
   import starling.display.graphics.Plane;
   import starling.display.graphics.RoundedRectangle;
   import starling.display.graphics.Stroke;
   import starling.display.materials.IMaterial;
   import starling.display.shaders.fragment.TextureFragmentShader;
   import starling.display.util.CurveUtil;
   import starling.textures.Texture;
   
   public class Graphics
   {
      
      protected static const BEZIER_ERROR:Number = 0.75;
      
      protected static var s_textureFragmentShader:TextureFragmentShader = new TextureFragmentShader();
       
      
      protected var _container:DisplayObjectContainer;
      
      protected var _penPosX:Number;
      
      protected var _penPosY:Number;
      
      protected var _currentFill:Fill;
      
      protected var _fillStyleSet:Boolean;
      
      protected var _fillColor:uint;
      
      protected var _fillAlpha:Number;
      
      protected var _fillTexture:Texture;
      
      protected var _fillMaterial:IMaterial;
      
      protected var _fillMatrix:Matrix;
      
      protected var _currentStroke:Stroke;
      
      protected var _strokeStyleSet:Boolean;
      
      protected var _strokeThickness:Number;
      
      protected var _strokeColor:uint;
      
      protected var _strokeAlpha:Number;
      
      protected var _strokeTexture:Texture;
      
      protected var _strokeMaterial:IMaterial;
      
      protected var _strokeInterrupted:Boolean;
      
      protected var _precisionHitTest:Boolean = false;
      
      protected var _precisionHitTestDistance:Number = 0;
      
      public function Graphics(param1:DisplayObjectContainer)
      {
         super();
         _container = param1;
      }
      
      public function clear() : void
      {
         var _loc1_:* = null;
         while(_container.numChildren > 0)
         {
            _loc1_ = _container.getChildAt(0);
            _loc1_.dispose();
            _container.removeChildAt(0);
         }
         _penPosX = NaN;
         _penPosY = NaN;
         endStroke();
         endFill();
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         while(_container.numChildren > 0)
         {
            _loc1_ = _container.getChildAt(0);
            _loc1_.dispose();
            _container.removeChildAt(0);
         }
         _penPosX = NaN;
         _penPosY = NaN;
         disposeStroke();
         disposeFill();
      }
      
      public function beginFill(param1:uint, param2:Number = 1.0) : void
      {
         endFill();
         _fillStyleSet = true;
         _fillColor = param1;
         _fillAlpha = param2;
         _fillTexture = null;
         _fillMaterial = null;
         _fillMatrix = null;
      }
      
      public function beginTextureFill(param1:Texture, param2:Matrix = null, param3:uint = 16777215, param4:Number = 1.0) : void
      {
         endFill();
         _fillStyleSet = true;
         _fillColor = param3;
         _fillAlpha = param4;
         _fillTexture = param1;
         _fillMaterial = null;
         _fillMatrix = new Matrix();
         if(param2)
         {
            _fillMatrix = param2.clone();
            _fillMatrix.invert();
         }
         else
         {
            _fillMatrix = new Matrix();
         }
         _fillMatrix.scale(1 / param1.width,1 / param1.height);
      }
      
      public function beginMaterialFill(param1:IMaterial, param2:Matrix = null) : void
      {
         endFill();
         _fillStyleSet = true;
         _fillColor = param1.color;
         _fillAlpha = param1.alpha;
         _fillTexture = null;
         _fillMaterial = param1;
         if(param2)
         {
            _fillMatrix = param2.clone();
            _fillMatrix.invert();
         }
         else
         {
            _fillMatrix = new Matrix();
         }
         if(param1.textures.length > 0)
         {
            _fillMatrix.scale(1 / param1.textures[0].width,1 / param1.textures[0].height);
         }
      }
      
      public function endFill() : void
      {
         _fillStyleSet = false;
         _fillColor = NaN;
         _fillAlpha = NaN;
         _fillTexture = null;
         _fillMaterial = null;
         _fillMatrix = null;
         if(_currentFill && _currentFill.numVertices < 3)
         {
            _currentFill.dispose();
            _container.removeChild(_currentFill);
         }
         _currentFill = null;
      }
      
      protected function disposeFill() : void
      {
         _fillStyleSet = false;
         _fillColor = NaN;
         _fillAlpha = NaN;
         _fillTexture = null;
         _fillMaterial = null;
         _fillMatrix = null;
         if(_currentFill)
         {
            _currentFill.dispose();
            _container.removeChild(_currentFill);
         }
         _currentFill = null;
      }
      
      public function lineStyle(param1:Number = NaN, param2:uint = 0, param3:Number = 1.0) : void
      {
         endStroke();
         _strokeStyleSet = !isNaN(param1) && param1 > 0;
         _strokeThickness = param1;
         _strokeColor = param2;
         _strokeAlpha = param3;
         _strokeTexture = null;
         _strokeMaterial = null;
      }
      
      public function lineTexture(param1:Number = NaN, param2:Texture = null) : void
      {
         endStroke();
         _strokeStyleSet = !isNaN(param1) && param1 > 0 && param2;
         _strokeThickness = param1;
         _strokeColor = 16777215;
         _strokeAlpha = 1;
         _strokeTexture = param2;
         _strokeMaterial = null;
      }
      
      public function lineMaterial(param1:Number = NaN, param2:IMaterial = null) : void
      {
         endStroke();
         _strokeStyleSet = !isNaN(param1) && param1 > 0 && param2;
         _strokeThickness = param1;
         _strokeColor = param2 != null?param2.color:16777215;
         _strokeAlpha = param2 != null?param2.alpha:1;
         _strokeTexture = null;
         _strokeMaterial = param2;
      }
      
      protected function endStroke() : void
      {
         _strokeStyleSet = false;
         _strokeThickness = NaN;
         _strokeColor = NaN;
         _strokeAlpha = NaN;
         _strokeTexture = null;
         _strokeMaterial = null;
         if(_currentStroke && _currentStroke.numVertices < 2)
         {
            _currentStroke.dispose();
         }
         _currentStroke = null;
      }
      
      protected function disposeStroke() : void
      {
         _strokeStyleSet = false;
         _strokeThickness = NaN;
         _strokeColor = NaN;
         _strokeAlpha = NaN;
         _strokeTexture = null;
         _strokeMaterial = null;
         if(_currentStroke)
         {
            _currentStroke.dispose();
         }
         _currentStroke = null;
      }
      
      public function moveTo(param1:Number, param2:Number) : void
      {
         if(_strokeStyleSet && _currentStroke)
         {
            _currentStroke.addDegenerates(param1,param2);
         }
         if(_fillStyleSet)
         {
            if(_currentFill == null)
            {
               createFill();
               _currentFill.addVertex(param1,param2);
            }
            else
            {
               _currentFill.addDegenerates(param1,param2);
            }
         }
         _penPosX = param1;
         _penPosY = param2;
         _strokeInterrupted = true;
      }
      
      public function lineTo(param1:Number, param2:Number) : void
      {
         if(isNaN(_penPosX))
         {
            moveTo(0,0);
         }
         if(_strokeStyleSet)
         {
            if(_currentStroke == null)
            {
               createStroke();
            }
            if(_strokeInterrupted || _currentStroke.numVertices == 0)
            {
               if(_strokeMaterial)
               {
                  _currentStroke.lineTo(_penPosX,_penPosY,_strokeThickness);
               }
               else
               {
                  _currentStroke.lineTo(_penPosX,_penPosY,_strokeThickness,_strokeColor,_strokeAlpha);
               }
               _strokeInterrupted = false;
            }
            if(_strokeMaterial)
            {
               _currentStroke.lineTo(param1,param2,_strokeThickness);
            }
            else
            {
               _currentStroke.lineTo(param1,param2,_strokeThickness,_strokeColor,_strokeAlpha);
            }
         }
         if(_fillStyleSet)
         {
            if(_currentFill == null)
            {
               createFill();
            }
            _currentFill.addVertex(param1,param2);
         }
         _penPosX = param1;
         _penPosY = param2;
      }
      
      public function curveTo(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0.75) : void
      {
         var _loc12_:int = 0;
         var _loc11_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc6_:* = Number(_penPosX);
         var _loc7_:* = Number(_penPosY);
         if(isNaN(_loc6_))
         {
            _loc6_ = 0;
            _loc7_ = 0;
         }
         var _loc9_:Vector.<Number> = CurveUtil.quadraticCurve(_loc6_,_loc7_,param1,param2,param3,param4,param5);
         var _loc8_:int = _loc9_.length;
         _loc12_ = 0;
         while(_loc12_ < _loc8_)
         {
            _loc11_ = _loc9_[_loc12_];
            _loc10_ = _loc9_[_loc12_ + 1];
            if(_loc12_ == 0 && isNaN(_penPosX))
            {
               moveTo(_loc11_,_loc10_);
            }
            else
            {
               lineTo(_loc11_,_loc10_);
            }
            _loc12_ = _loc12_ + 2;
         }
         _penPosX = param3;
         _penPosY = param4;
      }
      
      public function cubicCurveTo(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number = 0.75) : void
      {
         var _loc9_:int = 0;
         var _loc14_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc10_:* = Number(_penPosX);
         var _loc11_:* = Number(_penPosY);
         if(isNaN(_loc10_))
         {
            _loc10_ = 0;
            _loc11_ = 0;
         }
         var _loc12_:Vector.<Number> = CurveUtil.cubicCurve(_loc10_,_loc11_,param1,param2,param3,param4,param5,param6,param7);
         var _loc8_:int = _loc12_.length;
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            _loc14_ = _loc12_[_loc9_];
            _loc13_ = _loc12_[_loc9_ + 1];
            if(_loc9_ == 0 && isNaN(_penPosX))
            {
               moveTo(_loc14_,_loc13_);
            }
            else
            {
               lineTo(_loc14_,_loc13_);
            }
            _loc9_ = _loc9_ + 2;
         }
         _penPosX = param5;
         _penPosY = param6;
      }
      
      public function drawCircle(param1:Number, param2:Number, param3:Number) : void
      {
         drawEllipse(param1,param2,param3 * 2,param3 * 2);
      }
      
      public function drawEllipse(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc19_:* = null;
         var _loc10_:* = null;
         var _loc12_:* = null;
         var _loc21_:Boolean = false;
         var _loc18_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc14_:* = NaN;
         var _loc8_:* = NaN;
         var _loc11_:int = 0;
         var _loc20_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc13_:int = 3.14159265358979 * (param3 * 0.5 + param4 * 0.5) * 0.25;
         _loc13_ = _loc13_ < 6?6:_loc13_;
         if(_fillStyleSet)
         {
            _loc19_ = new NGon(param3 * 0.5,_loc13_);
            _loc19_.x = param1;
            _loc19_.y = param2;
            _loc19_.scaleY = param4 / param3;
            applyFillStyleToGraphic(_loc19_);
            _loc10_ = new Matrix();
            _loc10_.scale(param3,param4);
            if(_fillMatrix)
            {
               _loc10_.concat(_fillMatrix);
            }
            _loc19_.uvMatrix = _loc10_;
            _loc19_.precisionHitTest = _precisionHitTest;
            _loc19_.precisionHitTestDistance = _precisionHitTestDistance;
            _container.addChild(_loc19_);
         }
         if(_strokeStyleSet)
         {
            _loc12_ = _currentFill;
            _currentFill = null;
            _loc21_ = _fillStyleSet;
            _fillStyleSet = false;
            _loc18_ = param3 * 0.5;
            _loc16_ = param4 * 0.5;
            _loc6_ = 3.14159265358979 * 2 / _loc13_;
            _loc9_ = Math.cos(_loc6_);
            _loc7_ = Math.sin(_loc6_);
            _loc14_ = 0;
            _loc8_ = 1;
            _loc11_ = 0;
            while(_loc11_ <= _loc13_)
            {
               _loc20_ = _loc14_ * _loc18_ + param1;
               _loc17_ = -_loc8_ * _loc16_ + param2;
               if(_loc11_ == 0)
               {
                  moveTo(_loc20_,_loc17_);
               }
               else
               {
                  lineTo(_loc20_,_loc17_);
               }
               _loc5_ = _loc7_ * _loc8_ + _loc9_ * _loc14_;
               _loc15_ = _loc9_ * _loc8_ - _loc7_ * _loc14_;
               _loc8_ = _loc15_;
               _loc14_ = _loc5_;
               _loc11_++;
            }
            _currentFill = _loc12_;
            _fillStyleSet = _loc21_;
         }
      }
      
      public function drawRect(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc7_:Boolean = false;
         if(_fillStyleSet)
         {
            _loc5_ = new Plane(param3,param4);
            applyFillStyleToGraphic(_loc5_);
            _loc6_ = new Matrix();
            _loc6_.scale(param3,param4);
            if(_fillMatrix)
            {
               _loc6_.concat(_fillMatrix);
            }
            _loc5_.uvMatrix = _loc6_;
            _loc5_.x = param1;
            _loc5_.y = param2;
            _container.addChild(_loc5_);
         }
         if(_strokeStyleSet)
         {
            _loc8_ = _currentFill;
            _currentFill = null;
            _loc7_ = _fillStyleSet;
            _fillStyleSet = false;
            moveTo(param1,param2);
            lineTo(param1 + param3,param2);
            lineTo(param1 + param3,param2 + param4);
            lineTo(param1,param2 + param4);
            lineTo(param1,param2 - _strokeThickness * 0.5);
            _currentFill = _loc8_;
            _fillStyleSet = _loc7_;
         }
      }
      
      public function drawRoundRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         drawRoundRectComplex(param1,param2,param3,param4,param5,param5,param5,param5);
      }
      
      public function drawRoundRectComplex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void
      {
         var _loc11_:* = null;
         var _loc13_:* = null;
         var _loc15_:Boolean = false;
         var _loc9_:* = undefined;
         var _loc12_:int = 0;
         var _loc10_:* = NaN;
         if(!_fillStyleSet && !_strokeStyleSet)
         {
            return;
         }
         var _loc14_:RoundedRectangle = new RoundedRectangle(param3,param4,param5,param6,param7,param8);
         if(_fillStyleSet)
         {
            applyFillStyleToGraphic(_loc14_);
            _loc11_ = new Matrix();
            _loc11_.scale(param3,param4);
            if(_fillMatrix)
            {
               _loc11_.concat(_fillMatrix);
            }
            _loc14_.uvMatrix = _loc11_;
            _loc14_.x = param1;
            _loc14_.y = param2;
            _container.addChild(_loc14_);
         }
         _currentFill = _loc13_;
         if(_strokeStyleSet)
         {
            _loc13_ = _currentFill;
            _currentFill = null;
            _loc15_ = _fillStyleSet;
            _fillStyleSet = false;
            _loc9_ = _loc14_.getStrokePoints();
            _loc12_ = 0;
            while(_loc12_ < _loc9_.length)
            {
               if(_loc12_ == 0)
               {
                  moveTo(param1 + _loc9_[_loc12_],param2 + _loc9_[_loc12_ + 1]);
               }
               else if(_loc12_ == _loc9_.length - 2)
               {
                  _loc10_ = 0;
                  if(param5 < _strokeThickness)
                  {
                     _loc10_ = Number(param5 * 0.5);
                  }
                  else
                  {
                     _loc10_ = Number(_strokeThickness * 0.5);
                  }
                  lineTo(param1 + _loc9_[_loc12_],param2 + _loc9_[_loc12_ + 1] - _loc10_);
               }
               else
               {
                  lineTo(param1 + _loc9_[_loc12_],param2 + _loc9_[_loc12_ + 1]);
               }
               _loc12_ = _loc12_ + 2;
            }
            _currentFill = _loc13_;
            _fillStyleSet = _loc15_;
         }
      }
      
      public function set precisionHitTest(param1:Boolean) : void
      {
         _precisionHitTest = param1;
         if(_currentFill)
         {
            _currentFill.precisionHitTest = param1;
         }
         if(_currentStroke)
         {
            _currentStroke.precisionHitTest = param1;
         }
      }
      
      public function get precisionHitTest() : Boolean
      {
         return _precisionHitTest;
      }
      
      public function set precisionHitTestDistance(param1:Number) : void
      {
         _precisionHitTestDistance = param1;
         if(_currentFill)
         {
            _currentFill.precisionHitTestDistance = param1;
         }
         if(_currentStroke)
         {
            _currentStroke.precisionHitTestDistance = param1;
         }
      }
      
      public function get precisionHitTestDistance() : Number
      {
         return _precisionHitTestDistance;
      }
      
      protected function getStrokeInstance() : Stroke
      {
         return new Stroke();
      }
      
      protected function getFillInstance() : Fill
      {
         return new Fill();
      }
      
      protected function createStroke() : void
      {
         if(_currentStroke != null)
         {
            throw new Error("Current stroke should be disposed via endStroke() first.");
         }
         _currentStroke = getStrokeInstance();
         _currentStroke.precisionHitTest = _precisionHitTest;
         _currentStroke.precisionHitTestDistance = _precisionHitTestDistance;
         applyStrokeStyleToGraphic(_currentStroke);
         _container.addChild(_currentStroke);
      }
      
      protected function createFill() : void
      {
         if(_currentFill != null)
         {
            throw new Error("Current stroke should be disposed via endFill() first.");
         }
         _currentFill = getFillInstance();
         if(_fillMatrix)
         {
            _currentFill.uvMatrix = _fillMatrix;
         }
         _currentFill.precisionHitTest = _precisionHitTest;
         _currentFill.precisionHitTestDistance = _precisionHitTestDistance;
         applyFillStyleToGraphic(_currentFill);
         _container.addChild(_currentFill);
      }
      
      protected function applyStrokeStyleToGraphic(param1:Graphic) : void
      {
         if(_strokeMaterial)
         {
            param1.material = _strokeMaterial;
         }
         else if(_strokeTexture)
         {
            param1.material.fragmentShader = s_textureFragmentShader;
            param1.material.textures[0] = _strokeTexture;
         }
         param1.material.color = _strokeColor;
         param1.material.alpha = _strokeAlpha;
      }
      
      protected function applyFillStyleToGraphic(param1:Graphic) : void
      {
         if(_fillMaterial)
         {
            param1.material = _fillMaterial;
         }
         else if(_fillTexture)
         {
            param1.material.fragmentShader = s_textureFragmentShader;
            param1.material.textures[0] = _fillTexture;
         }
         if(_fillMatrix)
         {
            param1.uvMatrix = _fillMatrix;
         }
         param1.material.color = _fillColor;
         param1.material.alpha = _fillAlpha;
      }
   }
}
