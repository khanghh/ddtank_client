package battleSkill.view{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.core.Disposeable;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.ItemManager;   import flash.display.Sprite;   import flash.geom.Point;      public class BattleSkillMaterialCell extends Sprite implements Disposeable   {                   private var _templateID:int;            private var _upNeedCount:int;            private var _bagCell:BagCell;            private var _index:int = 0;            private var _havaCount:int;            public function BattleSkillMaterialCell(itemTempID:int, needCount:int, haveCount:int, index:int) { super(); }
            private function initView() : void { }
            public function updateCount() : void { }
            private function addEvent() : void { }
            public function dispose() : void { }
   }}