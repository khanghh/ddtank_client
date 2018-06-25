package dreamlandChallenge.view.mornui
{
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class DCMainViewUI extends View
   {
       
      
      public var text1:Label = null;
      
      public var btn_close:Button = null;
      
      public var btn_challenge:Button = null;
      
      public var lbl_surplusTime:Label = null;
      
      public var btn_dupDesc:Button = null;
      
      public var btn_storyDesc:Button = null;
      
      public var btn_point:Button = null;
      
      public var btn_speedMatch:Button = null;
      
      public var btn_buyCount:Button = null;
      
      public function DCMainViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("DCMainView.xml");
      }
   }
}