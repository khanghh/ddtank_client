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
      
      public function MoveSprite(param1:ItemTemplateInfo)
      {
         super();
         _src = param1;
         initView();
      }
      
      private function initView() : void
      {
         _moveSprite = CaddyModel.instance.moveSprite;
         addChild(_moveSprite);
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("caddy.selectCellSize");
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,75,75);
         _loc1_.graphics.endFill();
         _moveCell = ComponentFactory.Instance.creatCustomObject("caddy.moveCell",[_loc1_]);
         _moveCell.x = _moveCell.width / 2 * -1;
         _moveCell.y = _moveCell.height / 2 * -1;
         _moveSprite.addChild(_moveCell);
         _beginPoint = new Point(_moveSprite.x,_moveSprite.y);
         _moveSprite.visible = false;
      }
      
      public function setInfo(param1:InventoryItemInfo) : void
      {
         _selectedGoodsInfo = param1;
         _moveCell.info = param1;
      }
      
      public function startMove() : void
      {
         dispatchEvent(new Event("questCellPoint"));
      }
      
      public function setMovePoint(param1:Point) : void
      {
         var _loc2_:Point = globalToLocal(param1);
         _moveSprite.visible = true;
         if(_selectedGoodsInfo && _selectedGoodsInfo.TemplateID == 11550)
         {
            TweenMax.to(_moveSprite,0.3,{
               "scaleX":2,
               "scaleY":2,
               "repeat":1,
               "yoyo":true
            });
            TweenMax.to(_moveSprite,0.3,{
               "delay":0.5,
               "x":_loc2_.x + _moveCell.width / 2 + 7,
               "y":_loc2_.y + _moveCell.height / 2 + 15,
               "scaleX":0.5,
               "scaleY":0.5,
               "onComplete":_moveOk
            });
         }
         else if(_src && _src.TemplateID == 112101)
         {
            TweenMax.to(_moveSprite,0.3,{
               "x":_loc2_.x + _moveCell.width / 2 + 7,
               "y":_loc2_.y + _moveCell.height / 2 + 15,
               "onComplete":_moveOk
            });
         }
         else
         {
            TweenMax.to(_moveSprite,0.3,{
               "scaleX":2,
               "scaleY":2,
               "repeat":1,
               "yoyo":true
            });
            TweenMax.to(_moveSprite,0.15,{
               "delay":0.7,
               "x":_loc2_.x + _moveCell.width / 2 + 7,
               "y":_loc2_.y + _moveCell.height / 2 + 15,
               "onComplete":_moveOk
            });
         }
      }
      
      private function _moveOk() : void
      {
         var _loc1_:CaddyEvent = new CaddyEvent("move_complete");
         _loc1_.info = _selectedGoodsInfo;
         dispatchEvent(_loc1_);
         if(_moveSprite)
         {
            _moveSprite.visible = false;
            _moveSprite.x = _beginPoint.x;
            _moveSprite.y = _beginPoint.y;
         }
      }
      
      public function dispose() : void
      {
         if(_moveCell)
         {
            ObjectUtils.disposeObject(_moveCell);
         }
         _moveCell = null;
         if(_moveSprite)
         {
            ObjectUtils.disposeObject(_moveSprite);
         }
         _moveSprite = null;
         _selectedGoodsInfo = null;
         _beginPoint = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
