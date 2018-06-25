package dice.vo
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.CellContentCreator;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class DiceCell extends BaseCell
   {
       
      
      private var _txtCount:FilterFrameText;
      
      private var _count:int;
      
      private var _position:int;
      
      private var _strengthLevel:int;
      
      private var _validate:int;
      
      private var _isBind:Boolean = false;
      
      private var _isDestination:Boolean = false;
      
      private var _vertices:Vector.<Number>;
      
      private var _indices:Vector.<int>;
      
      private var _uvtData:Vector.<Number>;
      
      private var _cellInfo:DiceCellInfo;
      
      private var _mask:DisplayObject;
      
      private var _lightByMask:DisplayObject;
      
      private var _Deform:Shape;
      
      public function DiceCell(bg:DisplayObject, cellInfo:DiceCellInfo, $info:ItemTemplateInfo = null, mask:DisplayObject = null, showLoading:Boolean = true, showTip:Boolean = true)
      {
         super(bg,$info,showLoading,showTip);
         _cellInfo = cellInfo;
         _mask = mask;
         preInitialize();
         initialize();
      }
      
      private function preInitialize() : void
      {
         var ClassRef:Class = getDefinitionByName(getQualifiedClassName(_mask)) as Class;
         _lightByMask = new ClassRef();
         _lightByMask.x = _mask.x;
         _lightByMask.y = _mask.y;
      }
      
      public function get isDestination() : Boolean
      {
         return _isDestination;
      }
      
      public function set isDestination(value:Boolean) : void
      {
         var _x:int = 0;
         var _y:int = 0;
         if(_isDestination != value)
         {
            _isDestination = value;
            if(_isDestination)
            {
               _lightByMask.filters = [new GlowFilter(16777215,1,10,10,2,1,false,true)];
               addChild(_lightByMask);
               _x = x - (width * 1.2 - width >> 1);
               _y = y - (height * 1.2 - height >> 1);
               TweenLite.to(this,0.5,{
                  "x":_x,
                  "y":_y,
                  "scaleX":1.2,
                  "scaleY":1.2
               });
               if(parent)
               {
                  parent.setChildIndex(this,parent.numChildren - 1);
               }
            }
            else
            {
               TweenLite.to(this,0.5,{
                  "x":_cellInfo.Position.x,
                  "y":_cellInfo.Position.y,
                  "scaleX":1,
                  "scaleY":1
               });
               _lightByMask.filters = null;
               removeChild(_lightByMask);
            }
         }
      }
      
      public function get isBind() : Boolean
      {
         return _isBind;
      }
      
      public function set isBind(value:Boolean) : void
      {
         _isBind = value;
      }
      
      public function get validate() : int
      {
         return _validate;
      }
      
      public function set validate(value:int) : void
      {
         _validate = value;
      }
      
      public function get strengthLevel() : int
      {
         return _strengthLevel;
      }
      
      public function set strengthLevel(value:int) : void
      {
         _strengthLevel = value;
      }
      
      public function get position() : int
      {
         return _position;
      }
      
      public function set position(value:int) : void
      {
         _position = value;
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(value:int) : void
      {
         _count = value;
         _txtCount.text = String(_count);
         _txtCount.visible = true;
         if(value == 1)
         {
            _txtCount.visible = false;
         }
      }
      
      private function initialize() : void
      {
         _tipGapH = -15;
         _tipGapV = -15;
         _Deform = new Shape();
         _pic.visible = false;
         _bg.visible = true;
         addChild(_bg);
         addChild(_Deform);
         addChild(_mask);
         _Deform.mask = _mask;
         _indices = new Vector.<int>();
         _indices.push(0,2,1);
         _indices.push(2,1,3);
         _uvtData = new Vector.<Number>();
         _uvtData.push(0,0);
         _uvtData.push(0,1);
         _uvtData.push(1,0);
         _uvtData.push(1,1);
         _vertices = new Vector.<Number>();
         _vertices.push(-2,-2);
         _vertices.push(_cellInfo.vertices1.x,_cellInfo.vertices1.y);
         _vertices.push(_cellInfo.vertices2.x,_cellInfo.vertices2.y);
         _vertices.push(_cellInfo.vertices3.x,_cellInfo.vertices3.y);
         _txtCount = ComponentFactory.Instance.creatComponentByStylename("asset.dice.cellTextCount");
         _txtCount.x = _cellInfo.vertices3.x - _txtCount.width - 17;
         _txtCount.y = _cellInfo.vertices3.y - _txtCount.height - 17;
         x = _cellInfo.Position.x;
         y = _cellInfo.Position.y;
      }
      
      override public function setContentSize(cWidth:Number, cHeight:Number) : void
      {
         _contentWidth = _pic.width;
         _contentHeight = _pic.height;
         PicPos = new Point(-_contentWidth >> 1,-_contentHeight >> 1);
         updateSize(_pic);
      }
      
      override protected function createChildren() : void
      {
         _pic = new CellContentCreator();
      }
      
      override protected function createContentComplete() : void
      {
         super.createContentComplete();
         var bmp:BitmapData = new BitmapData(_pic.width,_pic.height,true,0);
         bmp.draw(_pic,null,null,null,null,true);
         _Deform.graphics.clear();
         _Deform.graphics.beginBitmapFill(bmp);
         _Deform.graphics.drawTriangles(_vertices,_indices,_uvtData);
         addChild(_Deform);
         addChild(_txtCount);
      }
      
      override public function dispose() : void
      {
         _vertices = null;
         _indices = null;
         _uvtData = null;
         if(_Deform)
         {
            if(_Deform.parent)
            {
               _Deform.parent.removeChild(_Deform);
            }
            _Deform = null;
         }
         super.dispose();
      }
   }
}
