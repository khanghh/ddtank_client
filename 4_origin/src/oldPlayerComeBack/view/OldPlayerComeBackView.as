package oldPlayerComeBack.view
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import flash.display.Sprite;
   import oldPlayerComeBack.data.AwardCellCoordinateDic;
   import oldPlayerComeBack.data.AwardItemInfo;
   import oldPlayerComeBack.data.ComeBackAwardItemsInfo;
   
   public class OldPlayerComeBackView extends Sprite
   {
       
      
      private var _map:AwardCellMap;
      
      private var _curInfo:ComeBackAwardItemsInfo;
      
      public function OldPlayerComeBackView()
      {
         super();
         createAwardMap();
      }
      
      public function updateView(info:ComeBackAwardItemsInfo) : void
      {
         _curInfo = info;
         setCurPlace(_curInfo.curPlace);
         createAwardItems();
      }
      
      private function setCurPlace(place:int) : void
      {
         if(_map)
         {
            _map.setStartPos(place);
         }
      }
      
      private function createAwardItems() : void
      {
         var cell:* = null;
         var temInfo:* = null;
         if(_map == null)
         {
            return;
         }
         _map.clearItem();
         var temVec:Vector.<AwardItemInfo> = _curInfo.allAwardItems;
         var _loc6_:int = 0;
         var _loc5_:* = temVec;
         for each(var info in temVec)
         {
            cell = new AwardCellItem(info.place);
            temInfo = ItemManager.fillByID(int(info.templateID));
            temInfo.IsBinds = true;
            cell.info = temInfo;
            cell.count = info.count;
            _map.addItem(info.place,cell);
         }
      }
      
      public function moveToTargetPos(place:int, callFun:Function) : void
      {
         if(_map)
         {
            _map.moveTargetPos(place,callFun);
         }
      }
      
      private function createAwardMap() : void
      {
         var cellsPostion:Array = new AwardCellCoordinateDic().cellsPostion;
         _map = new AwardCellMap(cellsPostion);
         addChild(_map);
      }
      
      public function dispose() : void
      {
         _curInfo = null;
         if(_map)
         {
            ObjectUtils.disposeObject(_map);
         }
         _map = null;
      }
   }
}
