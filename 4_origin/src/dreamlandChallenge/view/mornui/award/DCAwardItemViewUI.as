package dreamlandChallenge.view.mornui.award
{
   import morn.core.components.Clip;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class DCAwardItemViewUI extends View
   {
       
      
      public var clip_bg:Clip = null;
      
      public var lbl_type:Label = null;
      
      public function DCAwardItemViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("award/DCAwardItemView.xml");
      }
   }
}
