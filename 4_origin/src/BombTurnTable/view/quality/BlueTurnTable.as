package BombTurnTable.view.quality
{
   public class BlueTurnTable extends BaseTurnTable
   {
       
      
      public function BlueTurnTable(param1:int)
      {
         super(param1);
      }
      
      override public function get quality() : int
      {
         return 2;
      }
      
      override protected function get bgResource() : String
      {
         return "asset.bombTurnTable.blueBg";
      }
      
      override protected function get bgBorResource() : String
      {
         return "asset.bombTurnTable.blue";
      }
      
      override protected function updateLayout() : void
      {
         _lotteryTicket.x = 284;
         _lotteryTicket.y = 487;
         _explanationTxt.x = 284;
         _explanationTxt.y = 510;
      }
   }
}
