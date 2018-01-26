package ddt.view.caddyII
{
   import bagAndInfo.cell.BaseCell;
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class MoveSprite extends Sprite implements Disposeable
   {
      
      public static const QUEST_CELL_POINT:String = "questCellPoint";
      
      public static const MOVE_COMPLETE:String = "move_complete";
       
      
      private var _selectedGoodsInfo:InventoryItemInfo;
      
      private var _moveCell:BaseCell;
      
      private var _moveSprite:Sprite;
      
      private var _beginPoint:Point;
      
      private var _src:ItemTemplateInfo;
      
      public function MoveSprite(param1:ItemTemplateInfo){super();}
      
      private function initView() : void{}
      
      public function setInfo(param1:InventoryItemInfo) : void{}
      
      public function startMove() : void{}
      
      public function setMovePoint(param1:Point) : void{}
      
      private function _moveOk() : void{}
      
      public function dispose() : void{}
   }
}
