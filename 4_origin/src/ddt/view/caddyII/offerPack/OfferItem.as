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
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("offer.itemCellSize");
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(16777215,0);
         _loc2_.graphics.drawRect(0,0,_loc1_.x,_loc1_.y);
         _loc2_.graphics.endFill();
         _cell = ComponentFactory.Instance.creatCustomObject("offer.itemCell",[_loc2_,null,false]);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("offer.itemNameTxt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("offer.comboxItembgB");
         addChild(_bg);
         addChild(_cell);
         addChild(_nameTxt);
         buttonMode = true;
         _bg.visible = false;
      }
      
      override public function set width(param1:Number) : void
      {
         .super.width = param1;
         if(_bg)
         {
            _bg.width = param1;
         }
      }
      
      override public function set height(param1:Number) : void
      {
         .super.height = param1;
         if(_bg)
         {
            _bg.height = param1;
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
      
      private function _over(param1:MouseEvent) : void
      {
         if(_showBG)
         {
            _bg.visible = true;
         }
      }
      
      private function _out(param1:MouseEvent) : void
      {
         if(_showBG)
         {
            _bg.visible = false;
         }
      }
      
      public function set showBG(param1:Boolean) : void
      {
         _showBG = param1;
      }
      
      public function get showBG() : Boolean
      {
         return _showBG;
      }
      
      public function set info(param1:ItemTemplateInfo) : void
      {
         _cell.info = param1;
         _nameTxt.text = _cell.info.Name;
      }
      
      public function get info() : ItemTemplateInfo
      {
         return _cell.info;
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _cell.info;
      }
      
      public function setCellValue(param1:*) : void
      {
         info = param1;
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
