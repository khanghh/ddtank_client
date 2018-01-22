package uigeneral.mornui
{
   import morn.core.components.Button;
   import morn.core.components.Clip;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class TeamInviteViewUI extends View
   {
       
      
      public var clip_division:Clip = null;
      
      public var label_name:Label = null;
      
      public var teamText7:Label = null;
      
      public var teamText2:Label = null;
      
      public var teamText3:Label = null;
      
      public var teamText4:Label = null;
      
      public var teamText5:Label = null;
      
      public var teamText6:Label = null;
      
      public var label_level:Label = null;
      
      public var label_rank:Label = null;
      
      public var label_tag:Label = null;
      
      public var label_num:Label = null;
      
      public var label_rate:Label = null;
      
      public var label_count:Label = null;
      
      public var btn_esc:Button = null;
      
      public var teamText1:Label = null;
      
      public function TeamInviteViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("TeamInviteView.xml");
      }
   }
}
