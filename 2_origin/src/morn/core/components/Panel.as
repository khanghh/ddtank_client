package morn.core.components
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import morn.editor.core.IContent;
   
   public class Panel extends Box implements IContent
   {
       
      
      protected var _content:Box;
      
      protected var _vScrollBar:VScrollBar;
      
      protected var _hScrollBar:HScrollBar;
      
      public function Panel()
      {
         super();
         this.width = this.height = 100;
      }
      
      override protected function createChildren() : void
      {
         super.addChild(this._content = new Box());
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         param1.addEventListener(Event.RESIZE,this.onResize);
         callLater(this.changeScroll);
         return this._content.addChild(param1);
      }
      
      private function onResize(param1:Event) : void
      {
         callLater(this.changeScroll);
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         param1.addEventListener(Event.RESIZE,this.onResize);
         callLater(this.changeScroll);
         return this._content.addChildAt(param1,param2);
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         param1.removeEventListener(Event.RESIZE,this.onResize);
         callLater(this.changeScroll);
         return this._content.removeChild(param1);
      }
      
      override public function removeChildAt(param1:int) : DisplayObject
      {
         this.getChildAt(param1).removeEventListener(Event.RESIZE,this.onResize);
         callLater(this.changeScroll);
         return this._content.removeChildAt(param1);
      }
      
      override public function removeAllChild(param1:DisplayObject = null) : void
      {
         var _loc2_:int = this._content.numChildren - 1;
         while(_loc2_ > -1)
         {
            if(param1 != this._content.getChildAt(_loc2_))
            {
               this._content.removeChildAt(_loc2_);
            }
            _loc2_--;
         }
         callLater(this.changeScroll);
      }
      
      override public function getChildAt(param1:int) : DisplayObject
      {
         return this._content.getChildAt(param1);
      }
      
      override public function getChildByName(param1:String) : DisplayObject
      {
         return this._content.getChildByName(param1);
      }
      
      override public function getChildIndex(param1:DisplayObject) : int
      {
         return this._content.getChildIndex(param1);
      }
      
      override public function get numChildren() : int
      {
         return this._content.numChildren;
      }
      
      private function changeScroll() : void
      {
         var _loc1_:Number = this.contentWidth;
         var _loc2_:Number = this.contentHeight;
         var _loc3_:Boolean = this._vScrollBar && _loc2_ > _height;
         var _loc4_:Boolean = this._hScrollBar && _loc1_ > _width;
         var _loc5_:Number = !!_loc3_?Number(_width - this._vScrollBar.width):Number(_width);
         var _loc6_:Number = !!_loc4_?Number(_height - this._hScrollBar.height):Number(_height);
         this.setContentSize(_loc5_,_loc6_);
         if(this._vScrollBar)
         {
            this._vScrollBar.x = _width - this._vScrollBar.width;
            this._vScrollBar.y = 0;
            this._vScrollBar.height = _height - (!!_loc4_?this._hScrollBar.height:0);
            this._vScrollBar.scrollSize = Math.max(_height * 0.033,1);
            this._vScrollBar.thumbPercent = _loc6_ / _loc2_;
            this._vScrollBar.setScroll(0,_loc2_ - _loc6_,this._vScrollBar.value);
         }
         if(this._hScrollBar)
         {
            this._hScrollBar.x = 0;
            this._hScrollBar.y = _height - this._hScrollBar.height;
            this._hScrollBar.width = _width - (!!_loc3_?this._vScrollBar.width:0);
            this._hScrollBar.scrollSize = Math.max(_width * 0.033,1);
            this._hScrollBar.thumbPercent = _loc5_ / _loc1_;
            this._hScrollBar.setScroll(0,_loc1_ - _loc5_,this._hScrollBar.value);
         }
      }
      
      private function get contentWidth() : Number
      {
         var _loc3_:DisplayObject = null;
         var _loc1_:* = 0;
         var _loc2_:int = this._content.numChildren - 1;
         while(_loc2_ > -1)
         {
            _loc3_ = this._content.getChildAt(_loc2_);
            _loc1_ = Number(Math.max(_loc3_.x + _loc3_.width * _loc3_.scaleX,_loc1_));
            _loc2_--;
         }
         return _loc1_;
      }
      
      private function get contentHeight() : Number
      {
         var _loc3_:DisplayObject = null;
         var _loc1_:* = 0;
         var _loc2_:int = this._content.numChildren - 1;
         while(_loc2_ > -1)
         {
            _loc3_ = this._content.getChildAt(_loc2_);
            _loc1_ = Number(Math.max(_loc3_.y + _loc3_.height * _loc3_.scaleY,_loc1_));
            _loc2_--;
         }
         return _loc1_;
      }
      
      private function setContentSize(param1:Number, param2:Number) : void
      {
         var _loc3_:Graphics = graphics;
         _loc3_.clear();
         _loc3_.beginFill(16776960,0);
         _loc3_.drawRect(0,0,param1,param2);
         _loc3_.endFill();
         this._content.width = param1;
         this._content.height = param2;
         this._content.scrollRect = new Rectangle(0,0,param1,param2);
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         callLater(this.changeScroll);
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         callLater(this.changeScroll);
      }
      
      public function get vScrollBarSkin() : String
      {
         return !!this._vScrollBar?this._vScrollBar.skin:null;
      }
      
      public function set vScrollBarSkin(param1:String) : void
      {
         if(this._vScrollBar == null)
         {
            super.addChild(this._vScrollBar = new VScrollBar());
            this._vScrollBar.addEventListener(Event.CHANGE,this.onScrollBarChange);
            this._vScrollBar.target = this;
            callLater(this.changeScroll);
         }
         this._vScrollBar.skin = param1;
      }
      
      public function get hScrollBarSkin() : String
      {
         return !!this._hScrollBar?this._hScrollBar.skin:null;
      }
      
      public function set hScrollBarSkin(param1:String) : void
      {
         if(this._hScrollBar == null)
         {
            super.addChild(this._hScrollBar = new HScrollBar());
            this._hScrollBar.addEventListener(Event.CHANGE,this.onScrollBarChange);
            this._hScrollBar.mouseWheelEnable = false;
            this._hScrollBar.target = this;
            callLater(this.changeScroll);
         }
         this._hScrollBar.skin = param1;
      }
      
      public function get vScrollBar() : ScrollBar
      {
         return this._vScrollBar;
      }
      
      public function get hScrollBar() : ScrollBar
      {
         return this._hScrollBar;
      }
      
      public function get content() : Sprite
      {
         return this._content;
      }
      
      protected function onScrollBarChange(param1:Event) : void
      {
         var _loc3_:ScrollBar = null;
         var _loc4_:int = 0;
         var _loc2_:Rectangle = this._content.scrollRect;
         if(_loc2_)
         {
            _loc3_ = param1.currentTarget as ScrollBar;
            _loc4_ = Math.round(_loc3_.value);
            if(_loc3_.direction == ScrollBar.VERTICAL)
            {
               _loc2_.y = _loc4_;
            }
            else
            {
               _loc2_.x = _loc4_;
            }
            this._content.scrollRect = _loc2_;
         }
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(this.changeScroll);
      }
      
      public function scrollTo(param1:Number = 0, param2:Number = 0) : void
      {
         this.commitMeasure();
         if(this.vScrollBar)
         {
            this.vScrollBar.value = param2;
         }
         if(this.hScrollBar)
         {
            this.hScrollBar.value = param1;
         }
      }
      
      public function refresh() : void
      {
         this.changeScroll();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._content && this._content.dispose();
         this._vScrollBar && this._vScrollBar.dispose();
         this._hScrollBar && this._hScrollBar.dispose();
         this._content = null;
         this._vScrollBar = null;
         this._hScrollBar = null;
      }
   }
}
