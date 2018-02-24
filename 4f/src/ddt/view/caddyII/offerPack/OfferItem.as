package ddt.view.caddyII.offerPack
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class OfferItem extends Sprite implements IListCell
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _cell:BaseCell;
      
      private var _nameTxt:FilterFrameText;
      
      private var _showBG:Boolean = true;
      
      public function OfferItem(){super();}
      
      private function initView() : void{}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function _over(param1:MouseEvent) : void{}
      
      private function _out(param1:MouseEvent) : void{}
      
      public function set showBG(param1:Boolean) : void{}
      
      public function get showBG() : Boolean{return false;}
      
      public function set info(param1:ItemTemplateInfo) : void{}
      
      public function get info() : ItemTemplateInfo{return null;}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
