package shop.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   
   public class SetsShopItem extends ShopCartItem
   {
       
      
      private var _checkBox:SelectedCheckButton;
      
      public function SetsShopItem()
      {
         super();
         PositionUtils.setPos(this._cartItemSelectVBox,"ddtshop.SetsShopView.SelectedCheckBoxPos");
         _checkBox = ComponentFactory.Instance.creatComponentByStylename("ddtshop.SetsShopView.SetsShopCheckBox");
         _checkBox.addEventListener("select",__selectedChanged);
         _checkBox.addEventListener("click",__soundPlay);
         addChildAt(_checkBox,getChildIndex(_bg) + 1);
         _closeBtn.visible = false;
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _checkBox.removeEventListener("change",__selectedChanged);
         _checkBox.removeEventListener("click",__soundPlay);
      }
      
      private function __selectedChanged(param1:Event) : void
      {
         dispatchEvent(new Event("select"));
      }
      
      override protected function drawBackground(param1:Boolean = false) : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.SetsShopItemBg");
         addChild(_bg);
      }
      
      override protected function drawCellField() : void
      {
         super.drawCellField();
         PositionUtils.setPos(_cell,"ddtshop.SetsShopCellPoint");
      }
      
      override protected function drawNameField() : void
      {
         _itemName = ComponentFactory.Instance.creatComponentByStylename("ddtshop.SetsShopItemName");
         addChild(_itemName);
      }
      
      public function get selected() : Boolean
      {
         return _checkBox.selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _checkBox.selected = param1;
      }
   }
}
