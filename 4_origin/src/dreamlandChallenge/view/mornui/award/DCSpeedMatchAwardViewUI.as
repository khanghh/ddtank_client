package dreamlandChallenge.view.mornui.award
{
   import dreamlandChallenge.view.logicView.award.DCAwardItemView;
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.View;
   import morn.core.ex.TabListEx;
   
   public class DCSpeedMatchAwardViewUI extends View
   {
       
      
      public var text1:Label = null;
      
      public var btn_close:Button = null;
      
      public var speedMatch_list:List = null;
      
      public var tab_award:TabListEx = null;
      
      public function DCSpeedMatchAwardViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["dreamlandChallenge.view.logicView.award.DCAwardItemView"] = DCAwardItemView;
         super.createChildren();
         loadUI("award/DCSpeedMatchAwardView.xml");
      }
   }
}