package team.view.mornui
{
   import morn.core.components.Button;
   import morn.core.components.Clip;
   import morn.core.components.FrameClip;
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.ProgressBar;
   import morn.core.components.View;
   import morn.core.ex.NumberImageEx;
   
   public class TeamInfoViewUI extends View
   {
       
      
      public var teamText1:Label = null;
      
      public var teamText2:Label = null;
      
      public var teamText3:Label = null;
      
      public var teamText4:Label = null;
      
      public var btn_exit:Button = null;
      
      public var btn_chat:Button = null;
      
      public var label_rate:Label = null;
      
      public var btn_fight:Button = null;
      
      public var list_member:List = null;
      
      public var clip_divisionBig:Clip = null;
      
      public var clip_divisionTitle:Clip = null;
      
      public var label_score:Label = null;
      
      public var label_name:Label = null;
      
      public var label_tag:Label = null;
      
      public var label_grade:Label = null;
      
      public var ex_member:NumberImageEx = null;
      
      public var clip_division:Clip = null;
      
      public var progress_grade:ProgressBar = null;
      
      public var label_createDate:Label = null;
      
      public var btn_helpTips:Button = null;
      
      public var clip_divisionEffect:FrameClip = null;
      
      public var btn_CaptainTransfer:Button = null;
      
      public function TeamInfoViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("TeamInfoView.xml");
      }
   }
}
