package BombTurnTable.view.quality{   public class PurpleTurnTable extends BaseTurnTable   {                   public function PurpleTurnTable(status:int) { super(null); }
            override public function get quality() : int { return 0; }
            override protected function get bgBorResource() : String { return null; }
            override protected function get bgResource() : String { return null; }
            override protected function updateLayout() : void { }
   }}