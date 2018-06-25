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
      
      public function PetsAwakenEquipCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         _drag = new Sprite();
         _place = index;
         bg = bg == null?ComponentFactory.Instance.creatCustomObject("petsBag.skillItemBG"):bg;
         super(bg,info,showLoading,mouseOverEffBoolean);
         _tbxCount = ComponentFactory.Instance.creatComponentByStylename("BagCellCountText");
         _tbxCount.mouseEnabled = false;
         addChild(_tbxCount);
         drawDrag();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(value:int) : void
      {
         _type = value;
      }
      
      private function drawDrag() : void
      {
         _drag.graphics.beginFill(0,0);
         _drag.graphics.drawRect(0,0,60,60);
         _drag.graphics.endFill();
         addChild(_drag);
      }
      
      public function setCount(num:*) : void
      {
         if(_tbxCount)
         {
            _tbxCount.text = String(num);
            _tbxCount.visible = true;
            _tbxCount.x = _contentWidth - _tbxCount.width;
            _tbxCount.y = _contentHeight - _tbxCount.height;
            addChild(_tbxCount);
         }
      }
      
      public function setBgVisible(boo:Boolean) : void
      {
         _bg.visible = boo;
      }
      
      public function getCount() : int
      {
         return int(_tbxCount.text);
      }
      
      public function setCountPos(x:int, y:int) : void
      {
         if(_tbxCount)
         {
            _tbxCount.x = x;
            _tbxCount.y = y;
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
      
      public function set bgVisible(value:Boolean) : void
      {
         _bg.visible = value;
      }
      
      public function set isReceiveDrag(value:Boolean) : void
      {
         _isReceiveDrag = value;
      }
      
      public function get isReceiveDrag() : Boolean
      {
         return _isReceiveDrag;
      }
      
      public function set isSendToHideBag(value:Boolean) : void
      {
         _isSendToHideBag = value;
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
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         .super.info = value;
      }
      
      public function get itemInfo() : InventoryItemInfo
      {
         return _itemInfo;
      }
      
      public function set itemInfo(value:InventoryItemInfo) : void
      {
         _itemInfo = value;
         if(isSendToHideBag && value)
         {
            if(value.CategoryID == 50 || value.CategoryID == 51 || value.CategoryID == 52)
            {
               SocketManager.Instance.out.sendMoveGoods(value.BagType,value.Place,12,1,1);
            }
            else
            {
               SocketManager.Instance.out.sendMoveGoods(value.BagType,value.Place,12,0,_itemInfo.Count,true);
            }
         }
         updateCount();
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var infos:* = null;
         if(this.info)
         {
            return;
         }
         effect.action = "none";
         if(isReceiveDrag)
         {
            if(effect.data is InventoryItemInfo)
            {
               infos = effect.data as InventoryItemInfo;
               switch(int(type) - 1)
               {
                  case 0:
                     if(infos.Property1 == "132")
                     {
                        return;
                     }
                     break;
                  case 1:
                     if(infos.CategoryID == 50 || infos.CategoryID == 51 || infos.CategoryID == 52)
                     {
                        return;
                     }
                     break;
                  case 2:
               }
               if(infos && effect.action != "split")
               {
                  this.info = infos;
                  itemInfo = infos;
                  DragManager.acceptDrag(this);
               }
            }
         }
         super.dragDrop(effect);
      }
      
      override public function dragStop(effect:DragEffect) : void
      {
         if(effect.target == null)
         {
            return;
         }
         super.dragStop(effect);
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
