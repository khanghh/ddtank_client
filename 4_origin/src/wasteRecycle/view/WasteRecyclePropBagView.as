package wasteRecycle.view
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import wasteRecycle.WasteRecycleController;
   
   public class WasteRecyclePropBagView extends BagListView
   {
       
      
      private var _waitBagUpdate:Array;
      
      public function WasteRecyclePropBagView(bagType:int, columnNum:int = 7, cellNun:int = 49)
      {
         _waitBagUpdate = [];
         super(bagType,columnNum,cellNun);
         WasteRecycleController.instance.addEventListener("complete",__onWaitUpdate);
      }
      
      override protected function createCells() : void
      {
         var i:int = 0;
         var cell:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         for(i = 0; i < _cellNum; )
         {
            cell = new WasteRecycleCell(i,null);
            cell.mouseOverEffBoolean = false;
            addChild(cell);
            cell.bagType = _bagType;
            cell.addEventListener("interactive_click",__clickHandler);
            cell.addEventListener("mouseOver",_cellOverEff);
            cell.addEventListener("mouseOut",_cellOutEff);
            cell.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(cell);
            cell.addEventListener("lockChanged",__cellChanged);
            _cells[cell.place] = cell;
            _cellVec.push(cell);
            i++;
         }
      }
      
      override protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         var frame:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if((evt.currentTarget as BagCell).info != null)
         {
            SoundManager.instance.playButtonSound();
            frame = ComponentFactory.Instance.creatComponentByStylename("wasteRecycel.selectedFrame");
            frame.show(evt.currentTarget as WasteRecycleCell);
         }
      }
      
      override public function setData(bag:BagInfo) : void
      {
         var info:* = null;
         if(_bagdata == bag)
         {
            return;
         }
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("update",__updateGoods);
         }
         _bagdata = bag;
         var _infoArr:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _bagdata.items;
         for(var i in _bagdata.items)
         {
            info = _bagdata.items[i] as InventoryItemInfo;
            if(WasteRecycleController.instance.model.data[info.TemplateID])
            {
               _cells[i].info = info;
               _infoArr.push(_cells[i]);
            }
         }
         _bagdata.addEventListener("update",__updateGoods);
         _cellsSort(_infoArr);
      }
      
      override protected function __updateGoods(evt:BagEvent) : void
      {
         var c:* = null;
         var changes:Dictionary = evt.changedSlots;
         if(WasteRecycleController.instance.isPlay)
         {
            _waitBagUpdate.push(changes);
         }
         else
         {
            var _loc6_:int = 0;
            var _loc5_:* = changes;
            for each(var i in changes)
            {
               c = _bagdata.getItemAt(i.Place);
               if(c && WasteRecycleController.instance.model.data[c.TemplateID])
               {
                  setCellInfo(c.Place,c);
               }
               else
               {
                  setCellInfo(i.Place,null);
               }
               dispatchEvent(new Event("change"));
            }
         }
      }
      
      private function __onWaitUpdate(e:Event) : void
      {
         var data:* = null;
         var c:* = null;
         while(_waitBagUpdate.length)
         {
            data = _waitBagUpdate.shift();
            var _loc6_:int = 0;
            var _loc5_:* = data;
            for each(var i in data)
            {
               c = _bagdata.getItemAt(i.Place);
               if(c && WasteRecycleController.instance.model.data[c.TemplateID])
               {
                  setCellInfo(c.Place,c);
               }
               else
               {
                  setCellInfo(i.Place,null);
               }
               dispatchEvent(new Event("change"));
            }
         }
      }
      
      private function _cellsSort(arr:Array) : void
      {
         var i:int = 0;
         var oldx:Number = NaN;
         var oldy:Number = NaN;
         var n:int = 0;
         var oldCell:* = null;
         if(arr.length <= 0)
         {
            return;
         }
         i = 0;
         while(i < arr.length)
         {
            oldx = arr[i].x;
            oldy = arr[i].y;
            n = _cellVec.indexOf(arr[i]);
            oldCell = _cellVec[i];
            arr[i].x = oldCell.x;
            arr[i].y = oldCell.y;
            oldCell.x = oldx;
            oldCell.y = oldy;
            _cellVec[i] = arr[i];
            _cellVec[n] = oldCell;
            i++;
         }
      }
      
      override public function dispose() : void
      {
         var data:* = null;
         WasteRecycleController.instance.removeEventListener("complete",__onWaitUpdate);
         if(_waitBagUpdate)
         {
            while(_waitBagUpdate.length)
            {
               data = _waitBagUpdate.pop();
               var _loc4_:int = 0;
               var _loc3_:* = data;
               for(var s in data)
               {
                  data[s] = null;
                  delete data[s];
               }
            }
         }
         _waitBagUpdate = null;
         super.dispose();
      }
   }
}
