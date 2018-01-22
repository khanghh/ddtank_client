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
      
      public function PetsAwakenEquipList(param1:int = 18)
      {
         super();
         _cellNum = param1;
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
      
      private function initEquipCell(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         _equipArr = [];
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = new PetsAwakenEquipCell(_loc3_);
            _loc2_.allowDrag = true;
            _loc2_.isReceiveDrag = true;
            appendEvent(_loc2_);
            _equipList.addChild(_loc2_);
            _equipArr.push(_loc2_);
            _loc3_++;
         }
      }
      
      public function set bagType(param1:int) : void
      {
         _bagType = param1;
      }
      
      public function get bagType() : int
      {
         return _bagType;
      }
      
      public function setInfo(param1:BagInfo, param2:BagInfo) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         _info = param1;
         _store = param2;
         clareEquipCache();
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = _info.items;
         for each(var _loc6_ in _info.items)
         {
            if(bagType == 5)
            {
               if((_loc6_.CategoryID == 50 || _loc6_.CategoryID == 51 || _loc6_.CategoryID == 52) && _loc6_.Quality == 5 && _loc6_.getRemainDate() > 0)
               {
                  if(_equipArr[_loc5_] == null)
                  {
                     _loc4_ = new PetsAwakenEquipCell(_loc5_);
                     _loc4_.isReceiveDrag = true;
                     _loc4_.allowDrag = true;
                     _equipArr[_loc5_] = _loc4_;
                     _equipList.addChild(_loc4_);
                     appendEvent(_loc4_);
                  }
                  _equipArr[_loc5_].info = _loc6_;
                  _loc5_++;
               }
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = _store.items;
         for each(_loc6_ in _store.items)
         {
            if(_loc6_.Property1 == "132" && _loc6_.getRemainDate() > 0)
            {
               if(_equipArr[_loc5_] == null)
               {
                  _loc3_ = new PetsAwakenEquipCell(_loc5_);
                  _loc3_.allowDrag = true;
                  _loc3_.isReceiveDrag = true;
                  _equipArr[_loc5_] = _loc3_;
                  _equipList.addChild(_loc3_);
                  appendEvent(_loc3_);
               }
               _equipArr[_loc5_].info = _loc6_;
               _equipArr[_loc5_].itemInfo = _loc6_;
               _loc5_++;
            }
         }
      }
      
      private function clareEquipCache() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _equipArr.length)
         {
            _equipArr[_loc1_].info = null;
            _equipArr[_loc1_].updateCount();
            _loc1_++;
         }
      }
      
      private function appendEvent(param1:BaseCell) : void
      {
         param1.addEventListener("interactive_click",__equipClickHandler);
         param1.addEventListener("interactive_double_click",__equipDoubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(param1);
      }
      
      private function __equipClickHandler(param1:InteractiveEvent) : void
      {
         if(param1.target)
         {
            dispatchEvent(new CellEvent("itemclick",param1.target));
         }
      }
      
      private function __equipDoubleClickHandler(param1:InteractiveEvent) : void
      {
         if(param1.target)
         {
            SoundManager.instance.play("008");
            dispatchEvent(new CellEvent("doubleclick",param1.target));
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
         for each(var _loc1_ in _equipArr)
         {
            _loc1_.removeEventListener("interactive_click",__equipClickHandler);
            _loc1_.removeEventListener("interactive_double_click",__equipDoubleClickHandler);
            DoubleClickManager.Instance.disableDoubleClick(_loc1_);
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
