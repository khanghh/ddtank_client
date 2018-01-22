package team.view.mornui
{
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.View;
   import morn.core.ex.PageNavigaterEx;
   import team.view.main.TeamRecordItem;
   
   public class TeamRecordViewUI extends View
   {
       
      
      public var label_winName:Label = null;
      
      public var label_winZone:Label = null;
      
      public var teamText1:Label = null;
      
      public var teamText3:Label = null;
      
      public var teamText2:Label = null;
      
      public var label_winSurvival:Label = null;
      
      public var label_failName:Label = null;
      
      public var label_failZone:Label = null;
      
      public var teamText4:Label = null;
      
      public var teamText6:Label = null;
      
      public var teamText5:Label = null;
      
      public var label_failKill:Label = null;
      
      public var list_tab:List = null;
      
      public var list_win:List = null;
      
      public var list_fail:List = null;
      
      public var label_winKill:Label = null;
      
      public var label_failSurvival:Label = null;
      
      public var page_select:PageNavigaterEx = null;
      
      public function TeamRecordViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["team.view.main.TeamRecordItem"] = TeamRecordItem;
         super.createChildren();
         loadUI("TeamRecordView.xml");
      }
   }
}
