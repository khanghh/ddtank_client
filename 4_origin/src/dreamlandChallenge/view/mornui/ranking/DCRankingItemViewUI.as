package dreamlandChallenge.view.mornui.ranking
{
   import morn.core.components.Clip;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.components.View;
   import morn.core.ex.NameTextEx;
   import morn.core.ex.ScaleLeftRightImageEx;
   
   public class DCRankingItemViewUI extends View
   {
       
      
      public var scale_itemBg0:ScaleLeftRightImageEx = null;
      
      public var scale_itemBg1:ScaleLeftRightImageEx = null;
      
      public var scale_itemBg2:ScaleLeftRightImageEx = null;
      
      public var clip_ranking:Clip = null;
      
      public var lbl_ranking:Label = null;
      
      public var ntxt_name:NameTextEx = null;
      
      public var lbl_area:Label = null;
      
      public var img_timeIcon:Image = null;
      
      public var lbl_count:Label = null;
      
      public var lbl_contribute:Label = null;
      
      public function DCRankingItemViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("ranking/DCRankingItemView.xml");
      }
   }
}
