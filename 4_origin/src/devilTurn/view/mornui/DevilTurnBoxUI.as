package devilTurn.view.mornui
{
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class DevilTurnBoxUI extends View
   {
       
      
      public var dateText:Label = null;
      
      public var openBtn:Button = null;
      
      public function DevilTurnBoxUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("DevilTurnBox.xml");
      }
   }
}
