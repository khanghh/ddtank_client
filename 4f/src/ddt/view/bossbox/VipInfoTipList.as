package ddt.view.bossbox
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   
   public class VipInfoTipList extends Sprite implements Disposeable
   {
       
      
      private var _goodsList:Array;
      
      private var _list:SimpleTileList;
      
      private var _cells:Vector.<BoxVipTipsInfoCell>;
      
      private var _currentCell:BoxVipTipsInfoCell;
      
      public function VipInfoTipList(){super();}
      
      public function get currentCell() : BoxVipTipsInfoCell{return null;}
      
      protected function initList() : void{}
      
      public function showForVipAward(param1:Array) : void{}
      
      private function isCanSelect(param1:int) : Boolean{return false;}
      
      private function __cellClick(param1:CellEvent) : void{}
      
      private function getTemplateInfo(param1:int) : InventoryItemInfo{return null;}
      
      public function dispose() : void{}
   }
}
