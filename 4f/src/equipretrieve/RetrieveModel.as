package equipretrieve
{
   import bagAndInfo.cell.BaseCell;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.SelfInfo;
   
   public class RetrieveModel
   {
      
      public static const EmailX:int = 776;
      
      public static const EmailY:int = 572;
      
      private static var _instance:RetrieveModel;
       
      
      private var _CellsInfoArr:Array;
      
      private var _resultCell:Object;
      
      public var isFull:Boolean = false;
      
      private var _equipmentBag:BagInfo;
      
      public function RetrieveModel(){super();}
      
      public static function get Instance() : RetrieveModel{return null;}
      
      public function start(param1:SelfInfo) : void{}
      
      public function get equipmentBag() : BagInfo{return null;}
      
      public function setSaveCells(param1:BaseCell, param2:int) : void{}
      
      public function setSaveInfo(param1:InventoryItemInfo, param2:int) : void{}
      
      public function setSavePlaceType(param1:InventoryItemInfo, param2:int) : void{}
      
      public function getSaveCells(param1:int) : Object{return null;}
      
      public function setresultCell(param1:Object) : void{}
      
      public function getresultCell() : Object{return null;}
      
      public function replay() : void{}
   }
}
