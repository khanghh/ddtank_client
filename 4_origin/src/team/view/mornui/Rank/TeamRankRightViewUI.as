package team.view.mornui.Rank
{
   import morn.core.components.Button;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class TeamRankRightViewUI extends View
   {
       
      
      public var label_teamLevel:Label = null;
      
      public var label_teamLabel:Label = null;
      
      public var label_teamNumber:Label = null;
      
      public var label_teamWinPer:Label = null;
      
      public var label_teamScreenings:Label = null;
      
      public var label_teamHonor:Label = null;
      
      public var btn_priChat:Button = null;
      
      public var btn_addFriend:Button = null;
      
      public var image_headIcon:Image = null;
      
      public var label_headerName:Label = null;
      
      public function TeamRankRightViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("Rank/TeamRankRightView.xml");
      }
   }
}
