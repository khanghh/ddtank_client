package battleSkill.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class BattleSkillMaterialCell extends Sprite implements Disposeable
   {
       
      
      private var _templateID:int;
      
      private var _upNeedCount:int;
      
      private var _bagCell:BagCell;
      
      private var _index:int = 0;
      
      private var _havaCount:int;
      
      public function BattleSkillMaterialCell(itemTempID:int, needCount:int, haveCount:int, index:int)
      {
         super();
         _templateID = itemTempID;
         _upNeedCount = needCount;
         _havaCount = haveCount;
         _index = index;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = _templateID;
         info = ItemManager.fill(info);
         info.BindType = 4;
         _bagCell = new BagCell(_index);
         _bagCell.info = info;
         _bagCell.PicPos = new Point(9,9);
         _bagCell.setBgVisible(false);
         _bagCell.setContentSize(59,59);
         addChild(_bagCell);
         updateCount();
      }
      
      public function updateCount() : void
      {
         var temNum:String = "";
         temNum = _havaCount + "/" + _upNeedCount;
         _bagCell.setCount(temNum);
         _bagCell.refreshTbxPos();
      }
      
      private function addEvent() : void
      {
      }
      
      public function dispose() : void
      {
      }
   }
}
