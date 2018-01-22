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
      
      public function ChatScrollBar(param1:Function)
      {
         super();
         _backFun = param1;
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
      
      private function __mouseDown(param1:MouseEvent) : void
      {
         _isDrag = true;
         stage.addEventListener("mouseUp",__mouseUp);
         stage.addEventListener("mouseMove",__mouseMove);
         _moveBtn.startDrag(false,new Rectangle(0,0,0,_height - _moveBtn.height));
      }
      
      private function __mouseUp(param1:MouseEvent) : void
      {
         _isDrag = false;
         stage.removeEventListener("mouseUp",__mouseUp);
         stage.removeEventListener("mouseMove",__mouseMove);
         _moveBtn.stopDrag();
      }
      
      private function __mouseMove(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(_length > _rowsOfScreen)
         {
            _loc2_ = _length - _rowsOfScreen - int(_moveBtn.y / ((_height - _moveBtn.height) / (_length - _rowsOfScreen)));
            trace(_loc2_,_currentIndex);
            if(_loc2_ != _currentIndex)
            {
               _backFun(_moveBtn.y + _moveBtn.height + 1 >= _height?0:_loc2_);
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
         var _loc1_:Number = NaN;
         if(_length > _rowsOfScreen)
         {
            _loc1_ = _rowsOfScreen / _length * _height;
            drawThumb(_loc1_);
            _moveBtn.y = _height - _moveBtn.height - _currentIndex * (1 / (_length - _rowsOfScreen)) * (_height - _loc1_);
         }
         else
         {
            _moveBtn.graphics.clear();
         }
      }
      
      private function drawThumb(param1:Number) : void
      {
         var _loc5_:Matrix = new Matrix();
         var _loc4_:BitmapData = new BitmapData(12,8);
         var _loc2_:BitmapData = new BitmapData(12,8);
         var _loc3_:BitmapData = new BitmapData(12,8);
         _loc4_.copyPixels(_bitDB,new Rectangle(0,0,12,8),new Point(0,0));
         _loc2_.copyPixels(_bitDB,new Rectangle(0,8,12,8),new Point(0,0));
         _loc3_.copyPixels(_bitDB,new Rectangle(0,_bitDB.height - 8,12,8),new Point(0,0));
         _moveBtn.graphics.clear();
         _moveBtn.graphics.beginBitmapFill(_loc4_,_loc5_,false);
         _moveBtn.graphics.drawRect(0,0,12,8);
         _moveBtn.graphics.beginBitmapFill(_loc2_,_loc5_);
         _moveBtn.graphics.drawRect(0,8,12,param1 - 16);
         _loc5_.ty = param1 - 9;
         _moveBtn.graphics.beginBitmapFill(_loc3_,_loc5_,false);
         _moveBtn.graphics.drawRect(0,param1 - 9,12,8);
         _moveBtn.graphics.endFill();
      }
      
      public function set length(param1:int) : void
      {
         if(_length != param1)
         {
            _length = param1;
            draw();
         }
      }
      
      public function set currentIndex(param1:int) : void
      {
         if(_currentIndex != param1 && !_isDrag)
         {
            _currentIndex = param1 + _rowsOfScreen > _length?_length - _rowsOfScreen:param1;
            draw();
         }
      }
      
      public function set Height(param1:Number) : void
      {
         if(_height != param1)
         {
            _height = param1;
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
