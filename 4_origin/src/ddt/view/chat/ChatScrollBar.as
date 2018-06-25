package ddt.view.chat
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ChatScrollBar extends Sprite implements Disposeable
   {
       
      
      private var _currentIndex:int;
      
      private var _rowsOfScreen:int = 16;
      
      private var _length:int;
      
      private var _height:Number;
      
      private var _moveBtn:Sprite;
      
      private var _bitDB:BitmapData;
      
      private var _isDrag:Boolean = false;
      
      private var _backFun:Function;
      
      public function ChatScrollBar(_fun:Function)
      {
         super();
         _backFun = _fun;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bitDB = ComponentFactory.Instance.creatBitmapData("asset.core.scroll.thumbV2");
         _moveBtn = new Sprite();
         _moveBtn.buttonMode = true;
         _moveBtn.filters = [new GlowFilter(6705447,0.9)];
         addChild(_moveBtn);
      }
      
      private function initEvent() : void
      {
         _moveBtn.addEventListener("mouseDown",__mouseDown);
      }
      
      private function removeEvent() : void
      {
         _moveBtn.removeEventListener("mouseDown",__mouseDown);
         if(stage.hasEventListener("mouseUp"))
         {
            stage.removeEventListener("mouseUp",__mouseUp);
         }
         if(stage.hasEventListener("mouseMove"))
         {
            stage.removeEventListener("mouseMove",__mouseMove);
         }
      }
      
      private function __mouseDown(event:MouseEvent) : void
      {
         _isDrag = true;
         stage.addEventListener("mouseUp",__mouseUp);
         stage.addEventListener("mouseMove",__mouseMove);
         _moveBtn.startDrag(false,new Rectangle(0,0,0,_height - _moveBtn.height));
      }
      
      private function __mouseUp(event:MouseEvent) : void
      {
         _isDrag = false;
         stage.removeEventListener("mouseUp",__mouseUp);
         stage.removeEventListener("mouseMove",__mouseMove);
         _moveBtn.stopDrag();
      }
      
      private function __mouseMove(event:MouseEvent) : void
      {
         var pos:int = 0;
         if(_length > _rowsOfScreen)
         {
            pos = _length - _rowsOfScreen - int(_moveBtn.y / ((_height - _moveBtn.height) / (_length - _rowsOfScreen)));
            trace(pos,_currentIndex);
            if(pos != _currentIndex)
            {
               _backFun(_moveBtn.y + _moveBtn.height + 1 >= _height?0:pos);
            }
         }
      }
      
      private function drawBackground() : void
      {
         graphics.clear();
         graphics.beginFill(0,0.5);
         graphics.drawRoundRect(4,1,4,_height,4,4);
         graphics.endFill();
      }
      
      private function draw() : void
      {
         var _h:Number = NaN;
         if(_length > _rowsOfScreen)
         {
            _h = _rowsOfScreen / _length * _height;
            drawThumb(_h);
            _moveBtn.y = _height - _moveBtn.height - _currentIndex * (1 / (_length - _rowsOfScreen)) * (_height - _h);
         }
         else
         {
            _moveBtn.graphics.clear();
         }
      }
      
      private function drawThumb(val:Number) : void
      {
         var _matrix:Matrix = new Matrix();
         var _topBit:BitmapData = new BitmapData(12,8);
         var _midBit:BitmapData = new BitmapData(12,8);
         var _bottomBit:BitmapData = new BitmapData(12,8);
         _topBit.copyPixels(_bitDB,new Rectangle(0,0,12,8),new Point(0,0));
         _midBit.copyPixels(_bitDB,new Rectangle(0,8,12,8),new Point(0,0));
         _bottomBit.copyPixels(_bitDB,new Rectangle(0,_bitDB.height - 8,12,8),new Point(0,0));
         _moveBtn.graphics.clear();
         _moveBtn.graphics.beginBitmapFill(_topBit,_matrix,false);
         _moveBtn.graphics.drawRect(0,0,12,8);
         _moveBtn.graphics.beginBitmapFill(_midBit,_matrix);
         _moveBtn.graphics.drawRect(0,8,12,val - 16);
         _matrix.ty = val - 9;
         _moveBtn.graphics.beginBitmapFill(_bottomBit,_matrix,false);
         _moveBtn.graphics.drawRect(0,val - 9,12,8);
         _moveBtn.graphics.endFill();
      }
      
      public function set length(val:int) : void
      {
         if(_length != val)
         {
            _length = val;
            draw();
         }
      }
      
      public function set currentIndex(val:int) : void
      {
         if(_currentIndex != val && !_isDrag)
         {
            _currentIndex = val + _rowsOfScreen > _length?_length - _rowsOfScreen:val;
            draw();
         }
      }
      
      public function set Height(val:Number) : void
      {
         if(_height != val)
         {
            _height = val;
            drawBackground();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         _moveBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
