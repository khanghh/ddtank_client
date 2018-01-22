package petsBag.petsAdvanced
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.SocketManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PetsAwakenEquipCell extends BaseCell
   {
      
      public static const DATA_CHANGE:String = "dataChange";
       
      
      private var _drag:Sprite;
      
      private var _place:int = 0;
      
      private var _isReceiveDrag:Boolean = false;
      
      private var _isSendToHideBag:Boolean = false;
      
      private var _itemInfo:InventoryItemInfo;
      
      private var _type:int = 3;
      
      protected var _tbxCount:FilterFrameText;
      
      public function PetsAwakenEquipCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true)
      {
         _drag = new Sprite();
         _place = param1;
         param4 = param4 == null?ComponentFactory.Instance.creatCustomObject("petsBag.skillItemBG"):param4;
         super(param4,param2,param3,param5);
         _tbxCount = ComponentFactory.Instance.creatComponentByStylename("BagCellCountText");
         _tbxCount.mouseEnabled = false;
         addChild(_tbxCount);
         drawDrag();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      private function drawDrag() : void
      {
         _drag.graphics.beginFill(0,0);
         _drag.graphics.drawRect(0,0,60,60);
         _drag.graphics.endFill();
         addChild(_drag);
      }
      
      public function setCount(param1:*) : void
      {
         if(_tbxCount)
         {
            _tbxCount.text = String(param1);
            _tbxCount.visible = true;
            _tbxCount.x = _contentWidth - _tbxCount.width;
            _tbxCount.y = _contentHeight - _tbxCount.height;
            addChild(_tbxCount);
         }
      }
      
      public function setBgVisible(param1:Boolean) : void
      {
         _bg.visible = param1;
      }
      
      public function getCount() : int
      {
         return int(_tbxCount.text);
      }
      
      public function setCountPos(param1:int, param2:int) : void
      {
         if(_tbxCount)
         {
            _tbxCount.x = param1;
            _tbxCount.y = param2;
         }
      }
      
      public function refreshTbxPos() : void
      {
         _tbxCount.x = _pic.x + _contentWidth - _tbxCount.width - 4;
         _tbxCount.y = _pic.y + _contentHeight - _tbxCount.height - 2;
      }
      
      public function setCountNotVisible() : void
      {
         if(_tbxCount)
         {
            _tbxCount.visible = false;
         }
      }
      
      public function updateCount() : void
      {
         if(_tbxCount)
         {
            if(_info && itemInfo && itemInfo.MaxCount > 1)
            {
               _tbxCount.text = String(itemInfo.Count);
               _tbxCount.visible = true;
               addChild(_tbxCount);
            }
            else
            {
               _tbxCount.visible = false;
            }
         }
      }
      
      public function set bgVisible(param1:Boolean) : void
      {
         _bg.visible = param1;
      }
      
      public function set isReceiveDrag(param1:Boolean) : void
      {
         _isReceiveDrag = param1;
      }
      
      public function get isReceiveDrag() : Boolean
      {
         return _isReceiveDrag;
      }
      
      public function set isSendToHideBag(param1:Boolean) : void
      {
         _isSendToHideBag = param1;
      }
      
      public function get isSendToHideBag() : Boolean
      {
         return _isSendToHideBag;
      }
      
      override public function dragStart() : void
      {
         if(_info && !locked && stage && _allowDrag)
         {
            DragManager.startDrag(this,_info,createDragImg(),stage.mouseX,stage.mouseY,"move");
         }
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
      }
      
      public function get itemInfo() : InventoryItemInfo
      {
         return _itemInfo;
      }
      
      public function set itemInfo(param1:InventoryItemInfo) : void
      {
         _itemInfo = param1;
         if(isSendToHideBag && param1)
         {
            if(param1.CategoryID == 50 || param1.CategoryID == 51 || param1.CategoryID == 52)
            {
               SocketManager.Instance.out.sendMoveGoods(param1.BagType,param1.Place,12,1,1);
            }
            else
            {
               SocketManager.Instance.out.sendMoveGoods(param1.BagType,param1.Place,12,0,_itemInfo.Count,true);
            }
         }
         updateCount();
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc2_:* = null;
         if(this.info)
         {
            return;
         }
         param1.action = "none";
         if(isReceiveDrag)
         {
            if(param1.data is InventoryItemInfo)
            {
               _loc2_ = param1.data as InventoryItemInfo;
               switch(int(type) - 1)
               {
                  case 0:
                     if(_loc2_.Property1 == "132")
                     {
                        return;
                     }
                     break;
                  case 1:
                     if(_loc2_.CategoryID == 50 || _loc2_.CategoryID == 51 || _loc2_.CategoryID == 52)
                     {
                        return;
                     }
                     break;
                  case 2:
               }
               if(_loc2_ && param1.action != "split")
               {
                  this.info = _loc2_;
                  itemInfo = _loc2_;
                  DragManager.acceptDrag(this);
               }
            }
         }
         super.dragDrop(param1);
      }
      
      override public function dragStop(param1:DragEffect) : void
      {
         if(param1.target == null)
         {
            return;
         }
         super.dragStop(param1);
         itemInfo = null;
         info = null;
         dispatchEvent(new Event("dataChange"));
      }
      
      override public function dispose() : void
      {
         if(_tbxCount)
         {
            ObjectUtils.disposeObject(_tbxCount);
         }
         _tbxCount = null;
         if(_drag)
         {
            ObjectUtils.disposeObject(_drag);
         }
         _drag = null;
         super.dispose();
         _itemInfo = null;
      }
   }
}
