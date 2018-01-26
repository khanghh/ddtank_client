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
      
      public function BeadItem(){super();}
      
      public function hideBg() : void{}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function _over(param1:MouseEvent) : void{}
      
      private function _out(param1:MouseEvent) : void{}
      
      public function set info(param1:ItemTemplateInfo) : void{}
      
      public function set autoSelect(param1:Boolean) : void{}
      
      public function set selected(param1:Boolean) : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function set count(param1:int) : void{}
      
      public function get count() : int{return 0;}
      
      public function dispose() : void{}
   }
}
