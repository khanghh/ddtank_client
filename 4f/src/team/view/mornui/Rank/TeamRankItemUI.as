package team.view.mornui.Rank
{
   import morn.core.components.Clip;
   import morn.core.components.Label;
   import morn.core.components.View;
   import morn.core.ex.NameTextEx;
   
   public class TeamRankItemUI extends View
   {
       
      
      public var image_rankItemBg:Clip = null;
      
      public var label_rank:Label = null;
      
      public var label_integral:Label = null;
      
      public var label_server:Label = null;
      
      public var image_rankIcon:Clip = null;
      
      public var label_name:NameTextEx = null;
      
      public function TeamRankItemUI(){super();}
      
      override protected function createChildren() : void{}
   }
}
