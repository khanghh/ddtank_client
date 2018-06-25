package yzhkof.ui
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class TileContainer extends ComponentContainer
   {
       
      
      private var _paddingH:Number = 10;
      
      private var _paddingV:Number = 10;
      
      private var _columnCount:uint = 2.147483647E9;
      
      private var _rowCount:uint = 2.147483647E9;
      
      private var _autoVSize:Boolean = true;
      
      private var _scrollY:int = 0;
      
      private var _scrollX:int = 0;
      
      public var childBoundsSize:Boolean;
      
      private var layoutMap:Dictionary;
      
      public function TileContainer(childBoundsSize:Boolean = true)
      {
         this.layoutMap = new Dictionary(true);
         super();
         this.childBoundsSize = childBoundsSize;
         this.init();
      }
      
      private function init() : void
      {
         width = 400;
      }
      
      public function removeAllChildren() : void
      {
         var i:int = 0;
         var length:int = numChildren;
         for(i = 0; i < length; i++)
         {
            removeChildAt(0);
         }
      }
      
      override protected function onDraw() : void
      {
         var i:int = 0;
         var current_dobj:DisplayObject = null;
         var t_obj:DisplayObject = null;
         var layout:Object = null;
         var position:Point = new Point();
         var t_column:uint = 0;
         var t_row:uint = 0;
         for(i = 0; i < numChildren; i++)
         {
            t_obj = getChildAt(i);
            layout = this.getItemLayout(t_obj);
            current_dobj = t_obj;
            current_dobj.x = position.x;
            current_dobj.y = position.y;
            position.x = position.x + (layout.width + layout.paddingH);
            t_column++;
            if(i + 1 < numChildren)
            {
               if(this.getItemLayout(getChildAt(i + 1)).width + layout.paddingH + position.x > width || t_column >= this._columnCount)
               {
                  position.y = position.y + (layout.height + layout.paddingV);
                  position.x = 0;
                  t_column = 0;
                  t_row++;
               }
            }
         }
      }
      
      public function get columnCount() : uint
      {
         return this._columnCount;
      }
      
      public function set columnCount(value:uint) : void
      {
         this._columnCount = value;
      }
      
      public function get rowCount() : uint
      {
         return this._rowCount;
      }
      
      public function set rowCount(value:uint) : void
      {
         this._rowCount = value;
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         throw new Error("use appendItem method!");
      }
      
      override public function removeChild(child:DisplayObject) : DisplayObject
      {
         throw new Error("use removeItem method!");
      }
      
      public function removeItem(child:DisplayObject) : void
      {
         super.removeChild(child);
         delete this.layoutMap[child];
      }
      
      public function appendItem(child:DisplayObject, itemLayout:Object = null) : void
      {
         if(itemLayout)
         {
            this.layoutMap[child] = itemLayout;
         }
         else
         {
            this.layoutMap[child] = new Object();
         }
         super.addChild(child);
      }
      
      private function getItemLayout(child:DisplayObject) : Object
      {
         var bound_child:Rectangle = null;
         var re_lo:Object = new Object();
         var lo:Object = this.layoutMap[child];
         if(this.childBoundsSize)
         {
            bound_child = child.getBounds(this);
            re_lo.width = lo.width || bound_child.width;
            re_lo.height = lo.height || bound_child.height;
         }
         else
         {
            re_lo.width = lo.width || child.width;
            re_lo.height = lo.height || child.height;
         }
         re_lo.paddingV = lo.paddingV || this.paddingV;
         re_lo.paddingH = lo.paddingH || this.paddingH;
         return re_lo;
      }
      
      override public function get height() : Number
      {
         if(this.autoVSize)
         {
            return contentHeight;
         }
         return super.height;
      }
      
      public function get paddingH() : Number
      {
         return this._paddingH;
      }
      
      public function set paddingH(value:Number) : void
      {
         this._paddingH = value;
      }
      
      public function get paddingV() : Number
      {
         return this._paddingV;
      }
      
      public function set paddingV(value:Number) : void
      {
         this._paddingV = value;
      }
      
      public function get autoVSize() : Boolean
      {
         return this._autoVSize;
      }
      
      public function set autoVSize(value:Boolean) : void
      {
         if(this._autoVSize == value)
         {
            return;
         }
         this._autoVSize = value;
         commitChage("autoVSize");
      }
   }
}
