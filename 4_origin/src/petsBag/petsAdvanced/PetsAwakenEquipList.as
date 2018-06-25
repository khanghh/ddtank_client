package petsBag.petsAdvanced
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   
   public class PetsAwakenEquipList extends Sprite implements Disposeable
   {
       
      
      private var _equipPanel:ScrollPanel;
      
      private var _equipList:SimpleTileList;
      
      private var _cellNum:int;
      
      private var _info:BagInfo;
      
      private var _store:BagInfo;
      
      private var _equipArr:Array;
      
      private var _bagType:int;
      
      public function PetsAwakenEquipList(cellNum:int = 18)
      {
         super();
         _cellNum = cellNum;
         initView();
         initEquipCell(_cellNum);
      }
      
      private function initView() : void
      {
         _equipPanel = ComponentFactory.Instance.creatComponentByStylename("petsBag.petsAwaken.equipScrollPanel");
         addChild(_equipPanel);
         _equipList = ComponentFactory.Instance.creat("petsBag.petsAwaken.equipList",[9]);
         _equipPanel.setView(_equipList);
      }
      
      private function initEquipCell(cellNum:int) : void
      {
         var cell:* = null;
         var i:int = 0;
         _equipArr = [];
         for(i = 0; i < cellNum; )
         {
            cell = new PetsAwakenEquipCell(i);
            cell.allowDrag = true;
            cell.isReceiveDrag = true;
            appendEvent(cell);
            _equipList.addChild(cell);
            _equipArr.push(cell);
            i++;
         }
      }
      
      public function set bagType(value:int) : void
      {
         _bagType = value;
      }
      
      public function get bagType() : int
      {
         return _bagType;
      }
      
      public function setInfo(value:BagInfo, storeInfo:BagInfo) : void
      {
         var temCell:* = null;
         var storeCell:* = null;
         _info = value;
         _store = storeInfo;
         clareEquipCache();
         var temIndex:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = _info.items;
         for each(var info in _info.items)
         {
            if(bagType == 5)
            {
               if((info.CategoryID == 50 || info.CategoryID == 51 || info.CategoryID == 52) && info.Quality == 5 && info.getRemainDate() > 0)
               {
                  if(_equipArr[temIndex] == null)
                  {
                     temCell = new PetsAwakenEquipCell(temIndex);
                     temCell.isReceiveDrag = true;
                     temCell.allowDrag = true;
                     _equipArr[temIndex] = temCell;
                     _equipList.addChild(temCell);
                     appendEvent(temCell);
                  }
                  _equipArr[temIndex].info = info;
                  temIndex++;
               }
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = _store.items;
         for each(info in _store.items)
         {
            if(info.Property1 == "132" && info.getRemainDate() > 0)
            {
               if(_equipArr[temIndex] == null)
               {
                  storeCell = new PetsAwakenEquipCell(temIndex);
                  storeCell.allowDrag = true;
                  storeCell.isReceiveDrag = true;
                  _equipArr[temIndex] = storeCell;
                  _equipList.addChild(storeCell);
                  appendEvent(storeCell);
               }
               _equipArr[temIndex].info = info;
               _equipArr[temIndex].itemInfo = info;
               temIndex++;
            }
         }
      }
      
      private function clareEquipCache() : void
      {
         var i:int = 0;
         for(i = 0; i < _equipArr.length; )
         {
            _equipArr[i].info = null;
            _equipArr[i].updateCount();
            i++;
         }
      }
      
      private function appendEvent(cell:BaseCell) : void
      {
         cell.addEventListener("interactive_click",__equipClickHandler);
         cell.addEventListener("interactive_double_click",__equipDoubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(cell);
      }
      
      private function __equipClickHandler(evt:InteractiveEvent) : void
      {
         if(evt.target)
         {
            dispatchEvent(new CellEvent("itemclick",evt.target));
         }
      }
      
      private function __equipDoubleClickHandler(evt:InteractiveEvent) : void
      {
         if(evt.target)
         {
            SoundManager.instance.play("008");
            dispatchEvent(new CellEvent("doubleclick",evt.target));
         }
      }
      
      public function dispose() : void
      {
         if(_equipPanel)
         {
            ObjectUtils.disposeObject(_equipPanel);
         }
         _equipPanel = null;
         var _loc3_:int = 0;
         var _loc2_:* = _equipArr;
         for each(var cell in _equipArr)
         {
            cell.removeEventListener("interactive_click",__equipClickHandler);
            cell.removeEventListener("interactive_double_click",__equipDoubleClickHandler);
            DoubleClickManager.Instance.disableDoubleClick(cell);
         }
         if(_equipList)
         {
            ObjectUtils.disposeAllChildren(_equipList);
            _equipList = null;
         }
         _info = null;
         _store = null;
         _equipArr = null;
      }
   }
}
