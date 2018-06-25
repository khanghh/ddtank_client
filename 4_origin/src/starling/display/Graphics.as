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
      
      public function Graphics(displayObjectContainer:DisplayObjectContainer)
      {
         super();
         _container = displayObjectContainer;
      }
      
      public function clear() : void
      {
         var child:* = null;
         while(_container.numChildren > 0)
         {
            child = _container.getChildAt(0);
            child.dispose();
            _container.removeChildAt(0);
         }
         _penPosX = NaN;
         _penPosY = NaN;
         endStroke();
         endFill();
      }
      
      public function dispose() : void
      {
         var child:* = null;
         while(_container.numChildren > 0)
         {
            child = _container.getChildAt(0);
            child.dispose();
            _container.removeChildAt(0);
         }
         _penPosX = NaN;
         _penPosY = NaN;
         disposeStroke();
         disposeFill();
      }
      
      public function beginFill(color:uint, alpha:Number = 1.0) : void
      {
         endFill();
         _fillStyleSet = true;
         _fillColor = color;
         _fillAlpha = alpha;
         _fillTexture = null;
         _fillMaterial = null;
         _fillMatrix = null;
      }
      
      public function beginTextureFill(texture:Texture, uvMatrix:Matrix = null, color:uint = 16777215, alpha:Number = 1.0) : void
      {
         endFill();
         _fillStyleSet = true;
         _fillColor = color;
         _fillAlpha = alpha;
         _fillTexture = texture;
         _fillMaterial = null;
         _fillMatrix = new Matrix();
         if(uvMatrix)
         {
            _fillMatrix = uvMatrix.clone();
            _fillMatrix.invert();
         }
         else
         {
            _fillMatrix = new Matrix();
         }
         _fillMatrix.scale(1 / texture.width,1 / texture.height);
      }
      
      public function beginMaterialFill(material:IMaterial, uvMatrix:Matrix = null) : void
      {
         endFill();
         _fillStyleSet = true;
         _fillColor = material.color;
         _fillAlpha = material.alpha;
         _fillTexture = null;
         _fillMaterial = material;
         if(uvMatrix)
         {
            _fillMatrix = uvMatrix.clone();
            _fillMatrix.invert();
         }
         else
         {
            _fillMatrix = new Matrix();
         }
         if(material.textures.length > 0)
         {
            _fillMatrix.scale(1 / material.textures[0].width,1 / material.textures[0].height);
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
      
      public function lineStyle(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0) : void
      {
         endStroke();
         _strokeStyleSet = !isNaN(thickness) && thickness > 0;
         _strokeThickness = thickness;
         _strokeColor = color;
         _strokeAlpha = alpha;
         _strokeTexture = null;
         _strokeMaterial = null;
      }
      
      public function lineTexture(thickness:Number = NaN, texture:Texture = null) : void
      {
         endStroke();
         _strokeStyleSet = !isNaN(thickness) && thickness > 0 && texture;
         _strokeThickness = thickness;
         _strokeColor = 16777215;
         _strokeAlpha = 1;
         _strokeTexture = texture;
         _strokeMaterial = null;
      }
      
      public function lineMaterial(thickness:Number = NaN, material:IMaterial = null) : void
      {
         endStroke();
         _strokeStyleSet = !isNaN(thickness) && thickness > 0 && material;
         _strokeThickness = thickness;
         _strokeColor = material != null?material.color:16777215;
         _strokeAlpha = material != null?material.alpha:1;
         _strokeTexture = null;
         _strokeMaterial = material;
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
      
      public function moveTo(x:Number, y:Number) : void
      {
         if(_strokeStyleSet && _currentStroke)
         {
            _currentStroke.addDegenerates(x,y);
         }
         if(_fillStyleSet)
         {
            if(_currentFill == null)
            {
               createFill();
               _currentFill.addVertex(x,y);
            }
            else
            {
               _currentFill.addDegenerates(x,y);
            }
         }
         _penPosX = x;
         _penPosY = y;
         _strokeInterrupted = true;
      }
      
      public function lineTo(x:Number, y:Number) : void
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
               _currentStroke.lineTo(x,y,_strokeThickness);
            }
            else
            {
               _currentStroke.lineTo(x,y,_strokeThickness,_strokeColor,_strokeAlpha);
            }
         }
         if(_fillStyleSet)
         {
            if(_currentFill == null)
            {
               createFill();
            }
            _currentFill.addVertex(x,y);
         }
         _penPosX = x;
         _penPosY = y;
      }
      
      public function curveTo(cx:Number, cy:Number, a2x:Number, a2y:Number, error:Number = 0.75) : void
      {
         var i:int = 0;
         var x:Number = NaN;
         var y:Number = NaN;
         var startX:* = Number(_penPosX);
         var startY:* = Number(_penPosY);
         if(isNaN(startX))
         {
            startX = 0;
            startY = 0;
         }
         var points:Vector.<Number> = CurveUtil.quadraticCurve(startX,startY,cx,cy,a2x,a2y,error);
         var L:int = points.length;
         for(i = 0; i < L; )
         {
            x = points[i];
            y = points[i + 1];
            if(i == 0 && isNaN(_penPosX))
            {
               moveTo(x,y);
            }
            else
            {
               lineTo(x,y);
            }
            i = i + 2;
         }
         _penPosX = a2x;
         _penPosY = a2y;
      }
      
      public function cubicCurveTo(c1x:Number, c1y:Number, c2x:Number, c2y:Number, a2x:Number, a2y:Number, error:Number = 0.75) : void
      {
         var i:int = 0;
         var x:Number = NaN;
         var y:Number = NaN;
         var startX:* = Number(_penPosX);
         var startY:* = Number(_penPosY);
         if(isNaN(startX))
         {
            startX = 0;
            startY = 0;
         }
         var points:Vector.<Number> = CurveUtil.cubicCurve(startX,startY,c1x,c1y,c2x,c2y,a2x,a2y,error);
         var L:int = points.length;
         for(i = 0; i < L; )
         {
            x = points[i];
            y = points[i + 1];
            if(i == 0 && isNaN(_penPosX))
            {
               moveTo(x,y);
            }
            else
            {
               lineTo(x,y);
            }
            i = i + 2;
         }
         _penPosX = a2x;
         _penPosY = a2y;
      }
      
      public function drawCircle(x:Number, y:Number, radius:Number) : void
      {
         drawEllipse(x,y,radius * 2,radius * 2);
      }
      
      public function drawEllipse(x:Number, y:Number, width:Number, height:Number) : void
      {
         var nGon:* = null;
         var m:* = null;
         var storedFill:* = null;
         var storedFillStyleSet:Boolean = false;
         var halfWidth:Number = NaN;
         var halfHeight:Number = NaN;
         var anglePerSide:Number = NaN;
         var a:Number = NaN;
         var b:Number = NaN;
         var s:* = NaN;
         var c:* = NaN;
         var i:int = 0;
         var sx:Number = NaN;
         var sy:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc15_:Number = NaN;
         var numSides:int = 3.14159265358979 * (width * 0.5 + height * 0.5) * 0.25;
         numSides = numSides < 6?6:numSides;
         if(_fillStyleSet)
         {
            nGon = new NGon(width * 0.5,numSides);
            nGon.x = x;
            nGon.y = y;
            nGon.scaleY = height / width;
            applyFillStyleToGraphic(nGon);
            m = new Matrix();
            m.scale(width,height);
            if(_fillMatrix)
            {
               m.concat(_fillMatrix);
            }
            nGon.uvMatrix = m;
            nGon.precisionHitTest = _precisionHitTest;
            nGon.precisionHitTestDistance = _precisionHitTestDistance;
            _container.addChild(nGon);
         }
         if(_strokeStyleSet)
         {
            storedFill = _currentFill;
            _currentFill = null;
            storedFillStyleSet = _fillStyleSet;
            _fillStyleSet = false;
            halfWidth = width * 0.5;
            halfHeight = height * 0.5;
            anglePerSide = 3.14159265358979 * 2 / numSides;
            a = Math.cos(anglePerSide);
            b = Math.sin(anglePerSide);
            s = 0;
            c = 1;
            for(i = 0; i <= numSides; )
            {
               sx = s * halfWidth + x;
               sy = -c * halfHeight + y;
               if(i == 0)
               {
                  moveTo(sx,sy);
               }
               else
               {
                  lineTo(sx,sy);
               }
               _loc5_ = b * c + a * s;
               _loc15_ = a * c - b * s;
               c = _loc15_;
               s = _loc5_;
               i++;
            }
            _currentFill = storedFill;
            _fillStyleSet = storedFillStyleSet;
         }
      }
      
      public function drawRect(x:Number, y:Number, width:Number, height:Number) : void
      {
         var plane:* = null;
         var m:* = null;
         var storedFill:* = null;
         var storedFillStyleSet:Boolean = false;
         if(_fillStyleSet)
         {
            plane = new Plane(width,height);
            applyFillStyleToGraphic(plane);
            m = new Matrix();
            m.scale(width,height);
            if(_fillMatrix)
            {
               m.concat(_fillMatrix);
            }
            plane.uvMatrix = m;
            plane.x = x;
            plane.y = y;
            _container.addChild(plane);
         }
         if(_strokeStyleSet)
         {
            storedFill = _currentFill;
            _currentFill = null;
            storedFillStyleSet = _fillStyleSet;
            _fillStyleSet = false;
            moveTo(x,y);
            lineTo(x + width,y);
            lineTo(x + width,y + height);
            lineTo(x,y + height);
            lineTo(x,y - _strokeThickness * 0.5);
            _currentFill = storedFill;
            _fillStyleSet = storedFillStyleSet;
         }
      }
      
      public function drawRoundRect(x:Number, y:Number, width:Number, height:Number, radius:Number) : void
      {
         drawRoundRectComplex(x,y,width,height,radius,radius,radius,radius);
      }
      
      public function drawRoundRectComplex(x:Number, y:Number, width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number) : void
      {
         var m:* = null;
         var storedFill:* = null;
         var storedFillStyleSet:Boolean = false;
         var strokePoints:* = undefined;
         var i:int = 0;
         var lastYPointOffset:* = NaN;
         if(!_fillStyleSet && !_strokeStyleSet)
         {
            return;
         }
         var roundedRect:RoundedRectangle = new RoundedRectangle(width,height,topLeftRadius,topRightRadius,bottomLeftRadius,bottomRightRadius);
         if(_fillStyleSet)
         {
            applyFillStyleToGraphic(roundedRect);
            m = new Matrix();
            m.scale(width,height);
            if(_fillMatrix)
            {
               m.concat(_fillMatrix);
            }
            roundedRect.uvMatrix = m;
            roundedRect.x = x;
            roundedRect.y = y;
            _container.addChild(roundedRect);
         }
         _currentFill = storedFill;
         if(_strokeStyleSet)
         {
            storedFill = _currentFill;
            _currentFill = null;
            storedFillStyleSet = _fillStyleSet;
            _fillStyleSet = false;
            strokePoints = roundedRect.getStrokePoints();
            for(i = 0; i < strokePoints.length; )
            {
               if(i == 0)
               {
                  moveTo(x + strokePoints[i],y + strokePoints[i + 1]);
               }
               else if(i == strokePoints.length - 2)
               {
                  lastYPointOffset = 0;
                  if(topLeftRadius < _strokeThickness)
                  {
                     lastYPointOffset = Number(topLeftRadius * 0.5);
                  }
                  else
                  {
                     lastYPointOffset = Number(_strokeThickness * 0.5);
                  }
                  lineTo(x + strokePoints[i],y + strokePoints[i + 1] - lastYPointOffset);
               }
               else
               {
                  lineTo(x + strokePoints[i],y + strokePoints[i + 1]);
               }
               i = i + 2;
            }
            _currentFill = storedFill;
            _fillStyleSet = storedFillStyleSet;
         }
      }
      
      public function set precisionHitTest(value:Boolean) : void
      {
         _precisionHitTest = value;
         if(_currentFill)
         {
            _currentFill.precisionHitTest = value;
         }
         if(_currentStroke)
         {
            _currentStroke.precisionHitTest = value;
         }
      }
      
      public function get precisionHitTest() : Boolean
      {
         return _precisionHitTest;
      }
      
      public function set precisionHitTestDistance(value:Number) : void
      {
         _precisionHitTestDistance = value;
         if(_currentFill)
         {
            _currentFill.precisionHitTestDistance = value;
         }
         if(_currentStroke)
         {
            _currentStroke.precisionHitTestDistance = value;
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
      
      protected function applyStrokeStyleToGraphic(graphic:Graphic) : void
      {
         if(_strokeMaterial)
         {
            graphic.material = _strokeMaterial;
         }
         else if(_strokeTexture)
         {
            graphic.material.fragmentShader = s_textureFragmentShader;
            graphic.material.textures[0] = _strokeTexture;
         }
         graphic.material.color = _strokeColor;
         graphic.material.alpha = _strokeAlpha;
      }
      
      protected function applyFillStyleToGraphic(graphic:Graphic) : void
      {
         if(_fillMaterial)
         {
            graphic.material = _fillMaterial;
         }
         else if(_fillTexture)
         {
            graphic.material.fragmentShader = s_textureFragmentShader;
            graphic.material.textures[0] = _fillTexture;
         }
         if(_fillMatrix)
         {
            graphic.uvMatrix = _fillMatrix;
         }
         graphic.material.color = _fillColor;
         graphic.material.alpha = _fillAlpha;
      }
   }
}
