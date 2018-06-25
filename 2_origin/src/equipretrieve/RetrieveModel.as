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
      
      public function start(_info:SelfInfo) : void
      {
         _CellsInfoArr = [];
         _CellsInfoArr = [null,null,null,null,null];
         _equipmentBag = _info.Bag;
      }
      
      public function get equipmentBag() : BagInfo
      {
         return _equipmentBag;
      }
      
      public function setSaveCells(cell:BaseCell, i:int) : void
      {
         if(_CellsInfoArr[i] == null)
         {
            _CellsInfoArr[i] = {};
         }
         _CellsInfoArr[i].info = cell.info;
         _CellsInfoArr[i].oldx = cell.x;
         _CellsInfoArr[i].oldy = cell.y;
      }
      
      public function setSaveInfo(info:InventoryItemInfo, i:int) : void
      {
         _CellsInfoArr[i].info = info;
      }
      
      public function setSavePlaceType(info:InventoryItemInfo, i:int) : void
      {
         if(info.BagType == 0 || info.BagType == 1)
         {
            _CellsInfoArr[i].Place = info.Place;
            _CellsInfoArr[i].BagType = info.BagType;
         }
      }
      
      public function getSaveCells(i:int) : Object
      {
         if(_CellsInfoArr[i].info)
         {
            _CellsInfoArr[i].info.Count = 1;
         }
         return _CellsInfoArr[i];
      }
      
      public function setresultCell(obj:Object) : void
      {
         if(_resultCell == null)
         {
            _resultCell = {};
         }
         _resultCell.point = obj.point;
         _resultCell.place = int(obj.place);
         _resultCell.bagType = int(obj.bagType);
         _resultCell.cell = obj.cell;
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
