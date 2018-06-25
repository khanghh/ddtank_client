package devilTurn.view.mornui
{
   import devilTurn.view.DevilTurnMallItem;
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.View;
   
   public class DevilTurnMallViewUI extends View
   {
       
      
      public var text6:Label = null;
      
      public var countText:Label = null;
      
      public var awardList:List = null;
      
      public var expireDateText:Label = null;
      
      public function DevilTurnMallViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["devilTurn.view.DevilTurnMallItem"] = DevilTurnMallItem;
         super.createChildren();
         loadUI("DevilTurnMallView.xml");
      }
   }
}
