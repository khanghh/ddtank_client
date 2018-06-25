package devilTurn.view.mornui
{
   import devilTurn.view.DevilTurnBoxConvertItem;
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.View;
   
   public class DevilTurnBoxConvertViewUI extends View
   {
       
      
      public var closeBtn:Button = null;
      
      public var text9:Label = null;
      
      public var beadList:List = null;
      
      public var beadText1:Label = null;
      
      public var beadText2:Label = null;
      
      public var beadText3:Label = null;
      
      public var beadText4:Label = null;
      
      public var beadText5:Label = null;
      
      public function DevilTurnBoxConvertViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["devilTurn.view.DevilTurnBoxConvertItem"] = DevilTurnBoxConvertItem;
         super.createChildren();
         loadUI("DevilTurnBoxConvertView.xml");
      }
   }
}
