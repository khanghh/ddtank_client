package beadSystem.views
{
   import bagAndInfo.cell.BagCell;
   import beadSystem.controls.BeadBagList;
   import beadSystem.controls.BeadLockButton;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BeadBagListView extends Sprite implements Disposeable
   {
       
      
      private var _beadLockBtn:BeadLockButton;
      
      private var _beadBagList:BeadBagList;
      
      public function BeadBagListView()
      {
         super();
         _beadLockBtn = ComponentFactory.Instance.creatCustomObject("beadLockBtn");
         _beadBagList = ComponentFactory.Instance.creatCustomObject("beadBagList");
         _beadBagList.setData(PlayerManager.Instance.Self.BeadBag);
         addChild(_beadBagList);
         addChild(_beadLockBtn);
         _beadLockBtn.addEventListener("click",lockBead,false,0,true);
         _beadBagList.addEventListener("itemclick",__cellClick);
      }
      
      protected function __cellClick(param1:CellEvent) : void
      {
         var _loc3_:* = null;
         param1.stopImmediatePropagation();
         var _loc2_:BagCell = param1.data as BagCell;
         if(_loc2_)
         {
            _loc3_ = _loc2_.info as InventoryItemInfo;
         }
         if(_loc3_ == null)
         {
            return;
         }
         if(!_loc2_.locked)
         {
            _loc2_.dragStart();
         }
      }
      
      public function dispose() : void
      {
         _beadLockBtn.removeEventListener("click",lockBead);
         _beadBagList.removeEventListener("itemclick",__cellClick);
         if(_beadLockBtn)
         {
            ObjectUtils.disposeObject(_beadLockBtn);
         }
         _beadLockBtn = null;
         if(_beadBagList)
         {
            ObjectUtils.disposeObject(_beadBagList);
         }
         _beadBagList = null;
      }
      
      private function lockBead(param1:MouseEvent) : void
      {
         _beadLockBtn.dragStart(param1.stageX,param1.stageY);
      }
   }
}
