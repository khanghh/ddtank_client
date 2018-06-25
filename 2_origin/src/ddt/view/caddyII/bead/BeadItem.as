package ddt.view.caddyII.bead
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class BeadItem extends Sprite implements ISelectable, Disposeable
   {
       
      
      private var _bg:Scale9CornerImage;
      
      private var _numberTxt:FilterFrameText;
      
      private var _beadCell:BaseCell;
      
      private var _count:int;
      
      private var _isSelected:Boolean = false;
      
      private var _inputBg:Bitmap;
      
      public function BeadItem()
      {
         super();
         initView();
         initEvents();
      }
      
      public function hideBg() : void
      {
         _inputBg.visible = false;
         _numberTxt.visible = false;
         _bg.visible = false;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("bead.selectBox.sparkBorder");
         _numberTxt = ComponentFactory.Instance.creatComponentByStylename("bead.numberTxt");
         var point:Point = ComponentFactory.Instance.creatCustomObject("bead.cellSize");
         var shape:Shape = new Shape();
         shape.graphics.beginFill(16777215,0);
         shape.graphics.drawRect(0,0,point.x,point.y);
         shape.graphics.endFill();
         _beadCell = ComponentFactory.Instance.creatCustomObject("bead.selectCell",[shape]);
         _inputBg = ComponentFactory.Instance.creatBitmap("asset.numInput.bg");
         addChild(_inputBg);
         addChild(_numberTxt);
         addChild(_beadCell);
         addChild(_bg);
         _bg.visible = false;
      }
      
      private function initEvents() : void
      {
         addEventListener("mouseOver",_over);
         addEventListener("mouseOut",_out);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("mouseOver",_over);
         removeEventListener("mouseOut",_out);
      }
      
      private function _over(e:MouseEvent) : void
      {
      }
      
      private function _out(e:MouseEvent) : void
      {
      }
      
      public function set info(info:ItemTemplateInfo) : void
      {
         _beadCell.info = info;
      }
      
      public function set autoSelect(value:Boolean) : void
      {
      }
      
      public function set selected(value:Boolean) : void
      {
         _bg.visible = value;
         _isSelected = value;
      }
      
      public function get selected() : Boolean
      {
         return _isSelected;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this as DisplayObject;
      }
      
      public function set count(value:int) : void
      {
         _count = value;
         _numberTxt.text = String(_count);
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_numberTxt)
         {
            ObjectUtils.disposeObject(_numberTxt);
         }
         _numberTxt = null;
         if(_beadCell)
         {
            ObjectUtils.disposeObject(_beadCell);
         }
         _beadCell = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
