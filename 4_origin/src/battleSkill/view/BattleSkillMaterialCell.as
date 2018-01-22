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
      
      public function BattleSkillMaterialCell(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         _templateID = param1;
         _upNeedCount = param2;
         _havaCount = param3;
         _index = param4;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:InventoryItemInfo = new InventoryItemInfo();
         _loc1_.TemplateID = _templateID;
         _loc1_ = ItemManager.fill(_loc1_);
         _loc1_.BindType = 4;
         _bagCell = new BagCell(_index);
         _bagCell.info = _loc1_;
         _bagCell.PicPos = new Point(9,9);
         _bagCell.setBgVisible(false);
         _bagCell.setContentSize(59,59);
         addChild(_bagCell);
         updateCount();
      }
      
      public function updateCount() : void
      {
         var _loc1_:String = "";
         _loc1_ = _havaCount + "/" + _upNeedCount;
         _bagCell.setCount(_loc1_);
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
