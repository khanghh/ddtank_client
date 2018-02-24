package shop.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   
   public class SetsShopItem extends ShopCartItem
   {
       
      
      private var _checkBox:SelectedCheckButton;
      
      public function SetsShopItem(){super();}
      
      override protected function removeEvent() : void{}
      
      private function __selectedChanged(param1:Event) : void{}
      
      override protected function drawBackground(param1:Boolean = false) : void{}
      
      override protected function drawCellField() : void{}
      
      override protected function drawNameField() : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
   }
}
