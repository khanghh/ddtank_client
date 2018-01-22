package team.view.mornui
{
   import morn.core.components.Button;
   import morn.core.components.Clip;
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.View;
   import morn.core.ex.NumberImageEx;
   import team.view.main.TeamGovernInviteItem;
   
   public class TeamGovernViewUI extends View
   {
       
      
      public var label_name:Label = null;
      
      public var label_grade:Label = null;
      
      public var label_tag:Label = null;
      
      public var ex_time:NumberImageEx = null;
      
      public var clip_division:Clip = null;
      
      public var label_createDate:Label = null;
      
      public var label_count:Label = null;
      
      public var teamText1:Label = null;
      
      public var teamText2:Label = null;
      
      public var list_invite:List = null;
      
      public var list_member:List = null;
      
      public var list_friend:List = null;
      
      public var btn_online:Button = null;
      
      public var label_invite:Label = null;
      
      public var label_current:Label = null;
      
      public function TeamGovernViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["team.view.main.TeamGovernInviteItem"] = TeamGovernInviteItem;
         super.createChildren();
         loadUI("TeamGovernView.xml");
      }
   }
}
