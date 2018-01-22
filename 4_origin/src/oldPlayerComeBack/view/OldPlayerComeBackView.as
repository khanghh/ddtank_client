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
      
      public function updateView(param1:ComeBackAwardItemsInfo) : void
      {
         _curInfo = param1;
         setCurPlace(_curInfo.curPlace);
         createAwardItems();
      }
      
      private function setCurPlace(param1:int) : void
      {
         if(_map)
         {
            _map.setStartPos(param1);
         }
      }
      
      private function createAwardItems() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_map == null)
         {
            return;
         }
         _map.clearItem();
         var _loc3_:Vector.<AwardItemInfo> = _curInfo.allAwardItems;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            _loc2_ = new AwardCellItem(_loc4_.place);
            _loc1_ = ItemManager.fillByID(int(_loc4_.templateID));
            _loc1_.IsBinds = true;
            _loc2_.info = _loc1_;
            _loc2_.count = _loc4_.count;
            _map.addItem(_loc4_.place,_loc2_);
         }
      }
      
      public function moveToTargetPos(param1:int, param2:Function) : void
      {
         if(_map)
         {
            _map.moveTargetPos(param1,param2);
         }
      }
      
      private function createAwardMap() : void
      {
         var _loc1_:Array = new AwardCellCoordinateDic().cellsPostion;
         _map = new AwardCellMap(_loc1_);
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
