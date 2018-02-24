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
      
      public function OldPlayerComeBackView(){super();}
      
      public function updateView(param1:ComeBackAwardItemsInfo) : void{}
      
      private function setCurPlace(param1:int) : void{}
      
      private function createAwardItems() : void{}
      
      public function moveToTargetPos(param1:int, param2:Function) : void{}
      
      private function createAwardMap() : void{}
      
      public function dispose() : void{}
   }
}
