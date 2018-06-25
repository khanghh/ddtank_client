package worldcup.view.mornui
{
   import morn.core.components.Button;
   import morn.core.components.List;
   import morn.core.components.View;
   import worldcup.view.item.TeamItem;
   
   public class BetViewUI extends View
   {
       
      
      public var betAgainBtn:Button = null;
      
      public var betBtn:Button = null;
      
      public var listGroup:List = null;
      
      public function BetViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["worldcup.view.item.TeamItem"] = TeamItem;
         super.createChildren();
         loadUI("BetView.xml");
      }
   }
}
