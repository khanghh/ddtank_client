package giftSystem.element
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import shop.view.ShopItemCell;
   
   public class GiftCartItem extends Sprite implements Disposeable
   {
       
      
      private var _itemCell:ShopItemCell;
      
      private var _name:FilterFrameText;
      
      private var _info:ShopItemInfo;
      
      private var _chooseNum:ChooseNum;
      
      private var _bg:ScaleBitmapImage;
      
      private var _itemCellBg:ScaleBitmapImage;
      
      private var _lineBg:ScaleBitmapImage;
      
      private var _InputBg:Scale9CornerImage;
      
      public function GiftCartItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtgiftSytem.CartItemBg");
         _itemCellBg = ComponentFactory.Instance.creatComponentByStylename("ddtgiftSytem.CartItemCellBg");
         _name = ComponentFactory.Instance.creatComponentByStylename("GiftCartItem.name");
         _chooseNum = ComponentFactory.Instance.creatCustomObject("chooseNum");
         _lineBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.VerticalLine");
         PositionUtils.setPos(_lineBg,"giftSystem.linePos");
         _InputBg = ComponentFactory.Instance.creatComponentByStylename("ddtgiftSystem.TotalMoneyPanel.InputBg");
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,48,48);
         _loc1_.graphics.endFill();
         _itemCell = CellFactory.instance.createShopItemCell(_loc1_,null,true,true) as ShopItemCell;
         _itemCell.cellSize = 60;
         PositionUtils.setPos(_itemCell,"GiftCartItem.cellPos");
         addChild(_bg);
         addChild(_itemCellBg);
         addChild(_itemCell);
         addChild(_InputBg);
         addChild(_lineBg);
         addChild(_name);
         addChild(_chooseNum);
      }
      
      public function get number() : int
      {
         return _chooseNum.number;
      }
      
      public function set info(param1:ShopItemInfo) : void
      {
         if(_info == param1)
         {
            return;
         }
         _info = param1;
         upView();
      }
      
      private function upView() : void
      {
         _itemCell.info = _info.TemplateInfo;
         _name.text = _info.TemplateInfo.Name;
      }
      
      private function initEvent() : void
      {
         _chooseNum.addEventListener("numberIsChange",__numberChange);
      }
      
      private function __numberChange(param1:Event) : void
      {
         dispatchEvent(new Event("numberIsChange"));
      }
      
      private function removeEvent() : void
      {
         _chooseNum.removeEventListener("numberIsChange",__numberChange);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_itemCellBg)
         {
            ObjectUtils.disposeObject(_itemCellBg);
         }
         _itemCellBg = null;
         if(_itemCell)
         {
            ObjectUtils.disposeObject(_itemCell);
         }
         _itemCell = null;
         if(_InputBg)
         {
            ObjectUtils.disposeObject(_InputBg);
         }
         _InputBg = null;
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_chooseNum)
         {
            ObjectUtils.disposeObject(_chooseNum);
         }
         _chooseNum = null;
         if(_lineBg)
         {
            ObjectUtils.disposeObject(_lineBg);
         }
         _lineBg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
