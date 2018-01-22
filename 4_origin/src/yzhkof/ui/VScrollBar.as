package yzhkof.ui
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import yzhkof.MyGraphy;
   import yzhkof.ui.mouse.MouseManager;
   
   public class VScrollBar extends ComponentBase
   {
      
      private static const BAR_WIDTH:Number = 10;
       
      
      private var thumb:Sprite;
      
      private var dragRectangle:Rectangle;
      
      private var _maxScrollV:Number = 0;
      
      private var _scrollV:Number = 0;
      
      public function VScrollBar()
      {
         this.thumb = MyGraphy.drawRectangle();
         this.dragRectangle = new Rectangle();
         super();
         this.init();
      }
      
      private function init() : void
      {
         width = BAR_WIDTH;
         this.thumb.width = BAR_WIDTH;
         this.thumb.height = 20;
         this.thumb.buttonMode = true;
         this.thumb.addEventListener(MouseEvent.MOUSE_DOWN,this.__thumbMouseDown);
         this.thumb.addEventListener(MouseManager.STAGE_UP_EVENT,this.__thumbMouseUp);
         this.thumb.addEventListener(MouseManager.MOUSE_DOWN_AND_DRAGING_EVENT,this.__thumbDraging);
         MouseManager.registExtendMouseEvent(this.thumb);
         addChild(this.thumb);
      }
      
      private function __thumbMouseDown(param1:Event) : void
      {
         this.thumb.startDrag(false,this.dragRectangle);
      }
      
      private function __thumbMouseUp(param1:Event) : void
      {
         this.thumb.stopDrag();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function __thumbDraging(param1:Event) : void
      {
         this.updateDataByThumbPosition();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function updateThumbPositionByData() : void
      {
         this.thumb.y = this._scrollV / this._maxScrollV * (height - this.thumb.height);
      }
      
      private function updateDataByThumbPosition() : void
      {
         this._scrollV = this.thumb.y / (height - this.thumb.height) * this._maxScrollV;
      }
      
      override protected function onDraw() : void
      {
         this.drawScrollLine();
         this.dragRectangle.height = height - this.thumb.height;
         this.updateThumbPositionByData();
      }
      
      private function drawScrollLine() : void
      {
         graphics.lineStyle(1);
         graphics.moveTo(BAR_WIDTH / 2,0);
         graphics.lineTo(BAR_WIDTH / 2,height);
      }
      
      public function get maxScrollV() : Number
      {
         return this._maxScrollV;
      }
      
      public function set maxScrollV(param1:Number) : void
      {
         if(this._maxScrollV == param1)
         {
            return;
         }
         this._maxScrollV = param1;
         commitChage("maxScrollV");
      }
      
      public function get scrollV() : Number
      {
         return this._scrollV;
      }
      
      public function set scrollV(param1:Number) : void
      {
         if(this._scrollV == param1)
         {
            return;
         }
         if(this._scrollV > this._maxScrollV)
         {
            this._scrollV = this._maxScrollV;
         }
         else if(this._scrollV < 0)
         {
            this._scrollV = 0;
         }
         else
         {
            this._scrollV = param1;
         }
         dispatchEvent(new Event(Event.CHANGE));
         commitChage("scrollV");
      }
   }
}
