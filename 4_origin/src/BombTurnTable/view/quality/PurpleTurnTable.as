package BombTurnTable.view.quality
{
   public class PurpleTurnTable extends BaseTurnTable
   {
       
      
      public function PurpleTurnTable(param1:int)
      {
         super(param1);
      }
      
      override public function get quality() : int
      {
         return 3;
      }
      
      override protected function get bgBorResource() : String
      {
         return "asset.bombTurnTable.purple";
      }
      
      override protected function get bgResource() : String
      {
         return "asset.bombTurnTable.purpleBg";
      }
      
      override protected function updateLayout() : void
      {
         _lotteryTicket.x = 284;
         _lotteryTicket.y = 489;
         _explanationTxt.x = 284;
         _explanationTxt.y = 512;
      }
   }
}
