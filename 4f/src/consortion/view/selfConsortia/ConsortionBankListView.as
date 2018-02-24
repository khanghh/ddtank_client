package consortion.view.selfConsortia
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.events.CellEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class ConsortionBankListView extends BagListView
   {
      
      private static var MAX_LINE_NUM:int = 10;
       
      
      private var _bankLevel:int;
      
      public function ConsortionBankListView(param1:int, param2:int = 0){super(null,null);}
      
      override public function updateBankBag(param1:int) : void{}
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      private function __resultHandler(param1:MouseEvent) : void{}
      
      override protected function createCells() : void{}
      
      override public function checkBankCell() : int{return 0;}
      
      override public function dispose() : void{}
   }
}
