package dreamlandChallenge.view.mornui.award
{
   import dreamlandChallenge.view.logicView.award.DCAwardItemView;
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.View;
   
   public class DCPointAwardViewUI extends View
   {
       
      
      public var text1:Label = null;
      
      public var btn_close:Button = null;
      
      public var point_list:List = null;
      
      public var text2:Label = null;
      
      public var lbl_myRanking:Label = null;
      
      public function DCPointAwardViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["dreamlandChallenge.view.logicView.award.DCAwardItemView"] = DCAwardItemView;
         super.createChildren();
         loadUI("award/DCPointAwardView.xml");
      }
   }
}
