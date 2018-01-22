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
      
      override protected function showDressBagView(param1:PlayerDressEvent) : void
      {
         super.showDressBagView(param1);
      }
      
      override protected function adjustEvent() : void
      {
      }
      
      override protected function __cellOpen(param1:Event) : void
      {
      }
      
      override protected function __onBagUpdatePROPBAG(param1:BagEvent) : void
      {
      }
      
      override protected function __cellClick(param1:CellEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(!_sellBtn.isActive)
         {
            param1.stopImmediatePropagation();
            _loc2_ = param1.data as BaseCell;
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
               SoundManager.instance.play("008");
               _loc2_.dragStart();
            }
         }
      }
      
      override protected function __cellDoubleClick(param1:CellEvent) : void
      {
      }
      
      override public function dispose() : void
      {
         PlayerDressControl.instance.showBind = true;
         super.dispose();
      }
   }
}
