package wasteRecycle.view
{
   import bagAndInfo.bag.BagView;
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import playerDress.PlayerDressControl;
   import playerDress.event.PlayerDressEvent;
   
   public class WasteRecycleBagView extends BagView
   {
       
      
      public function WasteRecycleBagView()
      {
         super();
      }
      
      override protected function initBackGround() : void
      {
         super.initBackGround();
         ObjectUtils.disposeObject(_beadSelectedBtn);
         _beadSelectedBtn = null;
         ObjectUtils.disposeObject(_dressSelectedBtn);
         _dressSelectedBtn = null;
         ObjectUtils.disposeObject(bagLockBtn);
         bagLockBtn = null;
      }
      
      override protected function initTabButtons() : void
      {
         super.initTabButtons();
         removeChild(_tabBtn3);
         removeChild(_tabBtn4);
      }
      
      override protected function set_breakBtn_enable() : void
      {
         if(_breakBtn)
         {
            _breakBtn.enable = false;
            _breakBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         if(_sellBtn)
         {
            _sellBtn.enable = false;
            _sellBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         if(_keySortBtn)
         {
            _keySortBtn.enable = false;
            _keySortBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         if(_continueBtn)
         {
            _continueBtn.enable = false;
            _continueBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
      }
      
      override protected function initBagList() : void
      {
         _equiplist = new WasteRecycleEquipBagView(0);
         _proplist = new WasteRecyclePropBagView(1);
         _proplist.visible = false;
         var _loc1_:int = 14;
         _proplist.x = _loc1_;
         _equiplist.x = _loc1_;
         _loc1_ = 47;
         _proplist.y = _loc1_;
         _equiplist.y = _loc1_;
         _lists = [_equiplist,_proplist];
         _currentList = _equiplist;
         addChild(_equiplist);
         addChild(_proplist);
      }
      
      override protected function showDressBagView(event:PlayerDressEvent) : void
      {
         super.showDressBagView(event);
      }
      
      override protected function adjustEvent() : void
      {
      }
      
      override protected function __cellOpen(evt:Event) : void
      {
      }
      
      override protected function __onBagUpdatePROPBAG(evt:BagEvent) : void
      {
      }
      
      override protected function __cellClick(evt:CellEvent) : void
      {
         var cell:* = null;
         var info:* = null;
         if(!_sellBtn.isActive)
         {
            evt.stopImmediatePropagation();
            cell = evt.data as BaseCell;
            if(cell)
            {
               info = cell.info as InventoryItemInfo;
            }
            if(info == null)
            {
               return;
            }
            if(!cell.locked)
            {
               SoundManager.instance.play("008");
               cell.dragStart();
            }
         }
      }
      
      override protected function __cellDoubleClick(evt:CellEvent) : void
      {
      }
      
      override public function dispose() : void
      {
         PlayerDressControl.instance.showBind = true;
         super.dispose();
      }
   }
}
