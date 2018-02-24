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
      
      public function ChatScrollBar(param1:Function){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __mouseDown(param1:MouseEvent) : void{}
      
      private function __mouseUp(param1:MouseEvent) : void{}
      
      private function __mouseMove(param1:MouseEvent) : void{}
      
      private function drawBackground() : void{}
      
      private function draw() : void{}
      
      private function drawThumb(param1:Number) : void{}
      
      public function set length(param1:int) : void{}
      
      public function set currentIndex(param1:int) : void{}
      
      public function set Height(param1:Number) : void{}
      
      public function dispose() : void{}
   }
}
