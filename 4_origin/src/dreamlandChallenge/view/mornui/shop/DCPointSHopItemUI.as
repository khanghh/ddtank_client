package dreamlandChallenge.view.mornui.shop
{
   import morn.core.components.Box;
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class DCPointSHopItemUI extends View
   {
       
      
      public var box_goodCell:Box = null;
      
      public var lbl_goodName:Label = null;
      
      public var lbl_goodCost:Label = null;
      
      public var lbl_point:Label = null;
      
      public var btn_buy:Button = null;
      
      public function DCPointSHopItemUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("shop/DCPointSHopItem.xml");
      }
   }
}
