package BombTurnTable.view.quality
{
   public class WhiteTurnTable extends BaseTurnTable
   {
       
      
      public function WhiteTurnTable(status:int)
      {
         super(status);
      }
      
      override protected function get bgBorResource() : String
      {
         return "asset.bombTurnTable.white";
      }
      
      override protected function get bgResource() : String
      {
         return "asset.bombTurnTable.whiteBg";
      }
      
      override public function get quality() : int
      {
         return 0;
      }
   }
}
