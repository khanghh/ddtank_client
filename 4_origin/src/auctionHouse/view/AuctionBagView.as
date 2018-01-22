package auctionHouse.view
{
   import bagAndInfo.bag.BagView;
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import playerDress.PlayerDressControl;
   import playerDress.event.PlayerDressEvent;
   
   public class AuctionBagView extends BagView
   {
       
      
      public function AuctionBagView()
      {
         super();
         PlayerDressControl.instance.showBind = false;
      }
      
      override protected function initBackGround() : void
      {
         super.initBackGround();
         ObjectUtils.disposeObject(_equipSelectedBtn);
         _equipSelectedBtn = null;
         _equipSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("bagView.equipTabBtn2");
         _equipSelectedBtn.mouseEnabled = false;
         _equipSelectedBtn.mouseChildren = false;
         _equipSelectedBtn.selected = true;
         addChild(_equipSelectedBtn);
         ObjectUtils.disposeObject(_propSelectedBtn);
         _propSelectedBtn = null;
         _propSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("bagView.propTabBtn2");
         _propSelectedBtn.mouseEnabled = false;
         _propSelectedBtn.mouseChildren = false;
         addChild(_propSelectedBtn);
         ObjectUtils.disposeObject(_beadSelectedBtn);
         _beadSelectedBtn = null;
         _beadSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("bagView.beadTabBtn2");
         _beadSelectedBtn.mouseEnabled = false;
         _beadSelectedBtn.mouseChildren = false;
         addChild(_beadSelectedBtn);
         ObjectUtils.disposeObject(_dressSelectedBtn);
         _dressSelectedBtn = null;
         _dressSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("bagView.dressTabBtn2");
         _dressSelectedBtn.mouseEnabled = false;
         _dressSelectedBtn.mouseChildren = false;
         addChild(_dressSelectedBtn);
         bagLockBtn.visible = false;
      }
      
      override protected function initTabButtons() : void
      {
         super.initTabButtons();
         removeChild(_tabBtn1);
         _tabBtn1 = new Sprite();
         _tabBtn1.graphics.beginFill(255,1);
         _tabBtn1.graphics.drawRoundRect(349,42,50,97,15,15);
         _tabBtn1.graphics.endFill();
         _tabBtn1.alpha = 0;
         _tabBtn1.buttonMode = true;
         addChild(_tabBtn1);
         removeChild(_tabBtn2);
         _tabBtn2 = new Sprite();
         _tabBtn2.graphics.beginFill(255,1);
         _tabBtn2.graphics.drawRoundRect(350,147,50,97,15,15);
         _tabBtn2.graphics.endFill();
         _tabBtn2.alpha = 0;
         _tabBtn2.buttonMode = true;
         addChild(_tabBtn2);
         removeChild(_tabBtn3);
         _tabBtn3 = new Sprite();
         _tabBtn3.graphics.beginFill(255,1);
         _tabBtn3.graphics.drawRoundRect(351,254,50,97,15,15);
         _tabBtn3.graphics.endFill();
         _tabBtn3.alpha = 0;
         _tabBtn3.buttonMode = true;
         addChild(_tabBtn3);
         removeChild(_tabBtn4);
         _tabBtn4 = new Sprite();
         _tabBtn4.graphics.beginFill(255,1);
         _tabBtn4.graphics.drawRoundRect(351,359,50,97,15,15);
         _tabBtn4.graphics.endFill();
         _tabBtn4.alpha = 0;
         _tabBtn4.buttonMode = true;
         addChild(_tabBtn4);
      }
      
      override protected function initBagList() : void
      {
         _equiplist = new AuctionBagEquipListView(0);
         _proplist = new AuctionBagListView(1);
         _beadList = new AuctionBeadListView(21,32,80);
         _beadList2 = new AuctionBeadListView(21,81,129);
         _beadList3 = new AuctionBeadListView(21,130,178);
         var _loc1_:* = 14;
         _beadList3.x = _loc1_;
         _loc1_ = _loc1_;
         _beadList2.x = _loc1_;
         _loc1_ = _loc1_;
         _beadList.x = _loc1_;
         _loc1_ = _loc1_;
         _proplist.x = _loc1_;
         _equiplist.x = _loc1_;
         _loc1_ = 47;
         _beadList3.y = _loc1_;
         _loc1_ = _loc1_;
         _beadList2.y = _loc1_;
         _loc1_ = _loc1_;
         _beadList.y = _loc1_;
         _loc1_ = _loc1_;
         _proplist.y = _loc1_;
         _equiplist.y = _loc1_;
         _loc1_ = 330;
         _beadList3.width = _loc1_;
         _loc1_ = _loc1_;
         _beadList2.width = _loc1_;
         _loc1_ = _loc1_;
         _beadList.width = _loc1_;
         _loc1_ = _loc1_;
         _proplist.width = _loc1_;
         _equiplist.width = _loc1_;
         _loc1_ = 320;
         _beadList3.height = _loc1_;
         _loc1_ = _loc1_;
         _beadList2.height = _loc1_;
         _loc1_ = _loc1_;
         _beadList.height = _loc1_;
         _loc1_ = _loc1_;
         _proplist.height = _loc1_;
         _equiplist.height = _loc1_;
         _proplist.visible = false;
         _loc1_ = false;
         _beadList3.visible = _loc1_;
         _loc1_ = _loc1_;
         _beadList2.visible = _loc1_;
         _beadList.visible = _loc1_;
         _lists = [_equiplist,_proplist,_beadList,_beadList2,_beadList3];
         _currentList = _equiplist;
         addChild(_equiplist);
         addChild(_proplist);
         addChild(_beadList);
         addChild(_beadList2);
         addChild(_beadList3);
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
      
      override public function setBagType(param1:int) : void
      {
         super.setBagType(param1);
         if(param1 == 21)
         {
            adjustBeadBagPage(true);
         }
      }
      
      override public function dispose() : void
      {
         PlayerDressControl.instance.showBind = true;
         super.dispose();
      }
   }
}
