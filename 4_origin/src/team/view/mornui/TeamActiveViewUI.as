package team.view.mornui
{
   import morn.core.components.Button;
   import morn.core.components.Clip;
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.ProgressBar;
   import morn.core.components.View;
   import morn.core.ex.NumberImageEx;
   
   public class TeamActiveViewUI extends View
   {
       
      
      public var ex_active:NumberImageEx = null;
      
      public var label_createDate:Label = null;
      
      public var label_count:Label = null;
      
      public var btn_memberTips:Button = null;
      
      public var list_active:List = null;
      
      public var list_member:List = null;
      
      public var teamText1:Label = null;
      
      public var teamText2:Label = null;
      
      public var btn_activeAlert:Button = null;
      
      public var label_name:Label = null;
      
      public var label_tag:Label = null;
      
      public var label_grade:Label = null;
      
      public var progress_grade:ProgressBar = null;
      
      public var clip_division:Clip = null;
      
      public var label_date:Label = null;
      
      public var btn_donate:Button = null;
      
      public function TeamActiveViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("TeamActiveView.xml");
      }
   }
}
