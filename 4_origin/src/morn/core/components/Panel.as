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
         height = 100;
         width = 100;
      }
      
      override protected function createChildren() : void
      {
         _content = new Box();
         super.addChild(new Box());
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         child.addEventListener("resize",onResize);
         callLater(changeScroll);
         return _content.addChild(child);
      }
      
      private function onResize(e:Event) : void
      {
         callLater(changeScroll);
      }
      
      override public function addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         child.addEventListener("resize",onResize);
         callLater(changeScroll);
         return _content.addChildAt(child,index);
      }
      
      override public function removeChild(child:DisplayObject) : DisplayObject
      {
         child.removeEventListener("resize",onResize);
         callLater(changeScroll);
         return _content.removeChild(child);
      }
      
      override public function removeChildAt(index:int) : DisplayObject
      {
         getChildAt(index).removeEventListener("resize",onResize);
         callLater(changeScroll);
         return _content.removeChildAt(index);
      }
      
      override public function removeAllChild(except:DisplayObject = null) : void
      {
         var i:int = 0;
         for(i = _content.numChildren - 1; i > -1; )
         {
            if(except != _content.getChildAt(i))
            {
               _content.removeChildAt(i);
            }
            i--;
         }
         callLater(changeScroll);
      }
      
      override public function getChildAt(index:int) : DisplayObject
      {
         return _content.getChildAt(index);
      }
      
      override public function getChildByName(name:String) : DisplayObject
      {
         return _content.getChildByName(name);
      }
      
      override public function getChildIndex(child:DisplayObject) : int
      {
         return _content.getChildIndex(child);
      }
      
      override public function get numChildren() : int
      {
         return _content.numChildren;
      }
      
      private function changeScroll() : void
      {
         var contentW:Number = contentWidth;
         var contentH:Number = contentHeight;
         var vShow:Boolean = _vScrollBar && contentH > _height;
         var hShow:Boolean = _hScrollBar && contentW > _width;
         var showWidth:Number = !!vShow?_width - _vScrollBar.width:Number(_width);
         var showHeight:Number = !!hShow?_height - _hScrollBar.height:Number(_height);
         setContentSize(showWidth,showHeight);
         if(_vScrollBar)
         {
            _vScrollBar.x = _width - _vScrollBar.width;
            _vScrollBar.y = 0;
            _vScrollBar.height = _height - (!!hShow?_hScrollBar.height:0);
            _vScrollBar.scrollSize = Math.max(_height * 0.033,1);
            _vScrollBar.thumbPercent = showHeight / contentH;
            _vScrollBar.setScroll(0,contentH - showHeight,_vScrollBar.value);
         }
         if(_hScrollBar)
         {
            _hScrollBar.x = 0;
            _hScrollBar.y = _height - _hScrollBar.height;
            _hScrollBar.width = _width - (!!vShow?_vScrollBar.width:0);
            _hScrollBar.scrollSize = Math.max(_width * 0.033,1);
            _hScrollBar.thumbPercent = showWidth / contentW;
            _hScrollBar.setScroll(0,contentW - showWidth,_hScrollBar.value);
         }
      }
      
      private function get contentWidth() : Number
      {
         var i:int = 0;
         var comp:* = null;
         var max:* = 0;
         for(i = _content.numChildren - 1; i > -1; )
         {
            comp = _content.getChildAt(i);
            max = Number(Math.max(comp.x + comp.width * comp.scaleX,max));
            i--;
         }
         return max;
      }
      
      private function get contentHeight() : Number
      {
         var i:int = 0;
         var comp:* = null;
         var max:* = 0;
         for(i = _content.numChildren - 1; i > -1; )
         {
            comp = _content.getChildAt(i);
            max = Number(Math.max(comp.y + comp.height * comp.scaleY,max));
            i--;
         }
         return max;
      }
      
      private function setContentSize(width:Number, height:Number) : void
      {
         var g:Graphics = graphics;
         g.clear();
         g.beginFill(16776960,0);
         g.drawRect(0,0,width,height);
         g.endFill();
         _content.width = width;
         _content.height = height;
         _content.scrollRect = new Rectangle(0,0,width,height);
      }
      
      override public function set width(value:Number) : void
      {
         .super.width = value;
         callLater(changeScroll);
      }
      
      override public function set height(value:Number) : void
      {
         .super.height = value;
         callLater(changeScroll);
      }
      
      public function get vScrollBarSkin() : String
      {
         return !!_vScrollBar?_vScrollBar.skin:null;
      }
      
      public function set vScrollBarSkin(value:String) : void
      {
         if(_vScrollBar == null)
         {
            _vScrollBar = new VScrollBar();
            super.addChild(new VScrollBar());
            _vScrollBar.addEventListener("change",onScrollBarChange);
            _vScrollBar.target = this;
            callLater(changeScroll);
         }
         _vScrollBar.skin = value;
      }
      
      public function get hScrollBarSkin() : String
      {
         return !!_hScrollBar?_hScrollBar.skin:null;
      }
      
      public function set hScrollBarSkin(value:String) : void
      {
         if(_hScrollBar == null)
         {
            _hScrollBar = new HScrollBar();
            super.addChild(new HScrollBar());
            _hScrollBar.addEventListener("change",onScrollBarChange);
            _hScrollBar.mouseWheelEnable = false;
            _hScrollBar.target = this;
            callLater(changeScroll);
         }
         _hScrollBar.skin = value;
      }
      
      public function get vScrollBar() : ScrollBar
      {
         return _vScrollBar;
      }
      
      public function get hScrollBar() : ScrollBar
      {
         return _hScrollBar;
      }
      
      public function get content() : Sprite
      {
         return _content;
      }
      
      protected function onScrollBarChange(e:Event) : void
      {
         var scroll:* = null;
         var start:int = 0;
         var rect:Rectangle = _content.scrollRect;
         if(rect)
         {
            scroll = e.currentTarget as ScrollBar;
            start = Math.round(scroll.value);
            if(scroll.direction == "vertical")
            {
               var _loc5_:* = start;
               rect.y = _loc5_;
               §§push(_loc5_);
            }
            else
            {
               _loc5_ = start;
               rect.x = _loc5_;
               §§push(Number(_loc5_));
            }
            §§pop();
            _content.scrollRect = rect;
         }
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(changeScroll);
      }
      
      public function scrollTo(x:Number = 0, y:Number = 0) : void
      {
         commitMeasure();
         if(vScrollBar)
         {
            vScrollBar.value = y;
         }
         if(hScrollBar)
         {
            hScrollBar.value = x;
         }
      }
      
      public function refresh() : void
      {
         changeScroll();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _content && _content.dispose();
         _vScrollBar && _vScrollBar.dispose();
         _hScrollBar && _hScrollBar.dispose();
         _content = null;
         _vScrollBar = null;
         _hScrollBar = null;
      }
   }
}
