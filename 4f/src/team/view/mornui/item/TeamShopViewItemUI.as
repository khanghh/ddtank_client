package team.view.mornui.item
{
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class TeamShopViewItemUI extends View
   {
       
      
      public var label_name:Label = null;
      
      public var label_coin:Label = null;
      
      public var label_tip:Label = null;
      
      public var btn_buy:Button = null;
      
      public function TeamShopViewItemUI(){super();}
      
      override protected function createChildren() : void{}
   }
}
