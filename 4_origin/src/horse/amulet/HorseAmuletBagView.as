package horse.amulet
{
   import bagAndInfo.bag.BagView;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import horse.HorseAmuletManager;
   import uiUtils.SelectPageUI;
   
   public class HorseAmuletBagView extends BagView
   {
       
      
      private var _listBag:HorseAmuletBagListView;
      
      private var _smashAllBtn:SimpleBitmapButton;
      
      private var _equipBtn:SimpleBitmapButton;
      
      private var _activateBtn:SimpleBitmapButton;
      
      private var _smashBtn:HorseAmuletSmashButton;
      
      private var _lockBtn:HorseAmuletLockButton;
      
      private var _selectPage:SelectPageUI;
      
      public function HorseAmuletBagView()
      {
         super();
      }
      
      override public function setBagType(param1:int) : void
      {
         _bagType = 42;
      }
      
      private function __onClickSmashAll(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc3_:Array = _listBag.getAllEnableSmashPlaceList();
         var _loc4_:Boolean = _loc3_.pop();
         if(_loc3_.length <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.smashFail"));
            return;
         }
         var _loc2_:HorseAmuletSmashAlert = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.smashFrame");
         _loc2_.show(_loc3_,_loc4_);
         _loc2_.addEventListener("response",__onConfirmResponse);
         _listBag.lockCellByPlace(true,_loc3_);
      }
      
      private function __onConfirmResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:HorseAmuletSmashAlert = param1.currentTarget as HorseAmuletSmashAlert;
         _loc2_.removeEventListener("response",__onConfirmResponse);
         _listBag.lockCellByPlace(false,_loc2_.placeList);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            SocketManager.Instance.out.sendAmuletSmash(_loc2_.placeList);
         }
         ObjectUtils.disposeObject(_loc2_);
      }
      
      private function __onClickEquip(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         HorseAmuletManager.instance.viewType = 1;
         _equipBtn.visible = false;
         _activateBtn.visible = true;
      }
      
      private function __onClickActivate(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         HorseAmuletManager.instance.viewType = 2;
         _equipBtn.visible = true;
         _activateBtn.visible = false;
      }
      
      private function __onChangePage(param1:Event) : void
      {
         var _loc2_:int = _selectPage.currentPage;
         _listBag.currentPage = _loc2_;
      }
      
      override protected function __sortBagClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         PlayerManager.Instance.Self.PropBag.sortBag(_bagType,PlayerManager.Instance.Self.horseAmuletBag,20,167,false);
      }
      
      override protected function initMoneyTexts() : void
      {
      }
      
      override protected function initBackGround() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("bagBGAsset4");
         addChild(_bg);
      }
      
      override protected function initTabButtons() : void
      {
         addChild(_buttonContainer);
      }
      
      override protected function initButtons() : void
      {
         _keySortBtn = ComponentFactory.Instance.creatComponentByStylename("bagKeySetButton1");
         _keySortBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.bagSortTxt");
         _buttonContainer.addChild(_keySortBtn);
         PositionUtils.setPos(_keySortBtn,"horseAmulet.bagView.keySortBtnPos");
         _selectPage = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.bagViewSelectUI");
         _selectPage.maxPage = 3;
         _smashAllBtn = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.smashAllBtn");
         _lockBtn = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.lockBtn");
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.equipBtn");
         _activateBtn = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.activateBtn");
         _smashBtn = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.smashBtn");
         _buttonContainer.addChild(_selectPage);
         _buttonContainer.addChild(_smashAllBtn);
         _buttonContainer.addChild(_lockBtn);
         _buttonContainer.addChild(_equipBtn);
         _buttonContainer.addChild(_activateBtn);
         _buttonContainer.addChild(_smashBtn);
         _equipBtn.visible = false;
      }
      
      override protected function set_breakBtn_enable() : void
      {
      }
      
      override protected function __bagArrangeOver(param1:MouseEvent) : void
      {
      }
      
      override protected function __bagArrangeOut(param1:MouseEvent) : void
      {
      }
      
      override protected function initBagList() : void
      {
         _listBag = new HorseAmuletBagListView(42);
         _listBag.setData(PlayerManager.Instance.Self.getBag(42));
         PositionUtils.setPos(_listBag,"horseAmulet.bagListViewPos");
         addChild(_listBag);
      }
      
      override protected function initEvent() : void
      {
         _selectPage.addEventListener("change",__onChangePage);
         _smashAllBtn.addEventListener("click",__onClickSmashAll);
         _equipBtn.addEventListener("click",__onClickEquip);
         _activateBtn.addEventListener("click",__onClickActivate);
         _listBag.addEventListener("itemclick",__cellClick);
         _listBag.addEventListener("change",__listChange);
         super.initEvent();
      }
      
      override protected function removeEvents() : void
      {
         _selectPage.removeEventListener("change",__onChangePage);
         _smashAllBtn.removeEventListener("click",__onClickSmashAll);
         _equipBtn.removeEventListener("click",__onClickEquip);
         _activateBtn.removeEventListener("click",__onClickActivate);
         _listBag.removeEventListener("itemclick",__cellClick);
         _listBag.removeEventListener("change",__listChange);
         super.removeEvents();
      }
      
      override protected function __cellClick(param1:CellEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:HorseAmuletCell = param1.data as HorseAmuletCell;
         if(_loc2_.info)
         {
            _loc2_.dragStart();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_listBag);
         _listBag = null;
      }
   }
}
