package dreamlandChallenge.view.logicView
{
   import dreamlandChallenge.view.mornui.DCRushAwardViewUI;
   
   public class DCRushAwardView extends DCRushAwardViewUI
   {
       
      
      public function DCRushAwardView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
      }
      
      public function set info(award:*) : void
      {
      }
      
      private function __closeView() : void
      {
         this.visible = false;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
