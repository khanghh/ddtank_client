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
      
      public function RetrieveModel()
      {
         super();
      }
      
      public static function get Instance() : RetrieveModel
      {
         if(_instance == null)
         {
            _instance = new RetrieveModel();
         }
         return _instance;
      }
      
      public function start(param1:SelfInfo) : void
      {
         _CellsInfoArr = [];
         _CellsInfoArr = [null,null,null,null,null];
         _equipmentBag = param1.Bag;
      }
      
      public function get equipmentBag() : BagInfo
      {
         return _equipmentBag;
      }
      
      public function setSaveCells(param1:BaseCell, param2:int) : void
      {
         if(_CellsInfoArr[param2] == null)
         {
            _CellsInfoArr[param2] = {};
         }
         _CellsInfoArr[param2].info = param1.info;
         _CellsInfoArr[param2].oldx = param1.x;
         _CellsInfoArr[param2].oldy = param1.y;
      }
      
      public function setSaveInfo(param1:InventoryItemInfo, param2:int) : void
      {
         _CellsInfoArr[param2].info = param1;
      }
      
      public function setSavePlaceType(param1:InventoryItemInfo, param2:int) : void
      {
         if(param1.BagType == 0 || param1.BagType == 1)
         {
            _CellsInfoArr[param2].Place = param1.Place;
            _CellsInfoArr[param2].BagType = param1.BagType;
         }
      }
      
      public function getSaveCells(param1:int) : Object
      {
         if(_CellsInfoArr[param1].info)
         {
            _CellsInfoArr[param1].info.Count = 1;
         }
         return _CellsInfoArr[param1];
      }
      
      public function setresultCell(param1:Object) : void
      {
         if(_resultCell == null)
         {
            _resultCell = {};
         }
         _resultCell.point = param1.point;
         _resultCell.place = int(param1.place);
         _resultCell.bagType = int(param1.bagType);
         _resultCell.cell = param1.cell;
      }
      
      public function getresultCell() : Object
      {
         return _resultCell;
      }
      
      public function replay() : void
      {
         _CellsInfoArr = [];
         _resultCell = {};
      }
   }
}
