package BombTurnTable.view.quality
{
   public class GreenTurnTable extends BaseTurnTable
   {
       
      
      public function GreenTurnTable(status:int)
      {
         super(status);
      }
      
      override public function get quality() : int
      {
         return 1;
      }
      
      override protected function get bgBorResource() : String
      {
         return "asset.bombTurnTable.green";
      }
      
      override protected function get bgResource() : String
      {
         return "asset.bombTurnTable.greenBg";
      }
      
      override protected function updateLayout() : void
      {
         _lotteryTicket.x = 282;
         _lotteryTicket.y = 486;
         _explanationTxt.x = 282;
         _explanationTxt.y = 507;
      }
   }
}
