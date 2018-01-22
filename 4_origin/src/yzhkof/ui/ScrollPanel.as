package yzhkof.ui
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import yzhkof.ui.event.ComponentEvent;
   
   public class ScrollPanel extends ComponentContainer
   {
       
      
      private var vScrollBar:VScrollBar;
      
      private var viewRectangle:Rectangle;
      
      private var contentContainer:Sprite;
      
      private var rectContaner:Sprite;
      
      private var _source:DisplayObject;
      
      private var _maxScrollV:Number = 0;
      
      private var _scrollV:Number = 0;
      
      public function ScrollPanel()
      {
         this.vScrollBar = new VScrollBar();
         this.viewRectangle = new Rectangle();
         this.contentContainer = new Sprite();
         this.rectContaner = new Sprite();
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.rectContaner.addChild(this.contentContainer);
         addChild(this.rectContaner);
         addChild(this.vScrollBar);
         this.vScrollBar.addEventListener(Event.CHANGE,this.__scrollChange);
         this.vScrollBar.addEventListener(ComponentEvent.DRAW_COMPLETE,this.__scrollBarUpdate);
      }
      
      private function __scrollChange(param1:Event) : void
      {
         this.viewRectangle.y = this._scrollV = this.vScrollBar.scrollV;
         this.rectContaner.scrollRect = this.viewRectangle;
      }
      
      private function __scrollBarUpdate(param1:Event) : void
      {
         commitChage();
      }
      
      private function updateScrollByContent() : void
      {
         var _loc1_:Number = NaN;
         _loc1_ = this._scrollV == 0?0:Number(this._scrollV / this._maxScrollV);
         this._maxScrollV = this.contentContainer.height - height;
         if(this._maxScrollV < 0)
         {
            this._maxScrollV = 0;
         }
         this.vScrollBar.maxScrollV = this._maxScrollV;
         this._scrollV = this._maxScrollV * _loc1_;
         if(this._scrollV > this._maxScrollV)
         {
            this._scrollV = this._maxScrollV;
         }
         this.vScrollBar.scrollV = this._scrollV;
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         this.vScrollBar.height = height;
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         this.vScrollBar.x = width - this.vScrollBar.width;
      }
      
      override protected function onDraw() : void
      {
         this.viewRectangle.width = width - this.vScrollBar.width;
         this.viewRectangle.height = height;
         this.rectContaner.scrollRect = this.viewRectangle;
      }
      
      public function get maxScrollV() : Number
      {
         return this._maxScrollV;
      }
      
      public function get scrollV() : Number
      {
         return this._scrollV;
      }
      
      public function set scrollV(param1:Number) : void
      {
         this._scrollV = param1;
      }
      
      private function __childSizeChange(param1:Event) : void
      {
         this.updateScrollByContent();
      }
      
      public function get source() : DisplayObject
      {
         return this._source;
      }
      
      public function set source(param1:DisplayObject) : void
      {
         if(this._source == param1)
         {
            return;
         }
         if(this._source != null)
         {
            this.contentContainer.removeChildAt(0);
         }
         this._source = param1;
         if(this._source)
         {
            this.contentContainer.addChild(this._source);
         }
         this.updateScrollByContent();
         if(this._source is ComponentBase)
         {
            this._source.addEventListener(ComponentEvent.DRAW_COMPLETE,this.__childSizeChange);
         }
         commitChage(CHILD_CHANGE);
      }
   }
}
