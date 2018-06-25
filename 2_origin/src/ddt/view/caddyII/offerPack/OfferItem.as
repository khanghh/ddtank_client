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
      
      public function OfferItem()
      {
         super();
         initView();
         initEvents();
         mouseChildren = false;
      }
      
      private function initView() : void
      {
         var point:Point = ComponentFactory.Instance.creatCustomObject("offer.itemCellSize");
         var shape:Shape = new Shape();
         shape.graphics.beginFill(16777215,0);
         shape.graphics.drawRect(0,0,point.x,point.y);
         shape.graphics.endFill();
         _cell = ComponentFactory.Instance.creatCustomObject("offer.itemCell",[shape,null,false]);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("offer.itemNameTxt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("offer.comboxItembgB");
         addChild(_bg);
         addChild(_cell);
         addChild(_nameTxt);
         buttonMode = true;
         _bg.visible = false;
      }
      
      override public function set width(value:Number) : void
      {
         .super.width = value;
         if(_bg)
         {
            _bg.width = value;
         }
      }
      
      override public function set height(value:Number) : void
      {
         .super.height = value;
         if(_bg)
         {
            _bg.height = value;
         }
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
         if(_showBG)
         {
            _bg.visible = true;
         }
      }
      
      private function _out(e:MouseEvent) : void
      {
         if(_showBG)
         {
            _bg.visible = false;
         }
      }
      
      public function set showBG(value:Boolean) : void
      {
         _showBG = value;
      }
      
      public function get showBG() : Boolean
      {
         return _showBG;
      }
      
      public function set info(value:ItemTemplateInfo) : void
      {
         _cell.info = value;
         _nameTxt.text = _cell.info.Name;
      }
      
      public function get info() : ItemTemplateInfo
      {
         return _cell.info;
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _cell.info;
      }
      
      public function setCellValue(value:*) : void
      {
         info = value;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
         }
         _cell = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
