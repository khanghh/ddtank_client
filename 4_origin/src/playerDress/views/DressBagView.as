package playerDress.views
{
   import bagAndInfo.bag.ContinueGoodsBtn;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.cmd.CmdCheckBagLockedPSWNeeds;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.ConfirmAlertData;
   import ddt.utils.HelperBuyAlert;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import playerDress.PlayerDressControl;
   
   public class DressBagView extends Sprite implements Disposeable
   {
      
      public static const CELLS_NUM:int = 49;
      
      private static var _sortdreesBagData:ConfirmAlertData = new ConfirmAlertData();
       
      
      private var _assortBox:ComboBox;
      
      private var _searchInput:TextInput;
      
      private var _searchBtn:SimpleBitmapButton;
      
      private var _baglist:DressBagListView;
      
      private var _bottomBg:Bitmap;
      
      private var _maleBtn:SelectedButton;
      
      private var _femaleBtn:SelectedButton;
      
      private var _sortBtn:SimpleBitmapButton;
      
      private var _renewalBtn:ContinueGoodsBtn;
      
      private var _leftBtn:SimpleBitmapButton;
      
      private var _rightBtn:SimpleBitmapButton;
      
      private var _pageBG:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      private var _currentSort:int;
      
      private var _sortArr:Array;
      
      private var _sortTypeArr:Array;
      
      private var _info:SelfInfo;
      
      private var _currentPage:int;
      
      public function DressBagView()
      {
         _sortArr = [];
         _sortTypeArr = [0,5,1,3,13,2,4,6,15,-1];
         super();
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         _currentSort = 0;
         _currentPage = 1;
         _info = PlayerManager.Instance.Self;
         _sortArr.push(LanguageMgr.GetTranslation("playerDress.sort0"));
         _sortArr.push(LanguageMgr.GetTranslation("playerDress.sort1"));
         _sortArr.push(LanguageMgr.GetTranslation("playerDress.sort2"));
         _sortArr.push(LanguageMgr.GetTranslation("playerDress.sort3"));
         _sortArr.push(LanguageMgr.GetTranslation("playerDress.sort4"));
         _sortArr.push(LanguageMgr.GetTranslation("playerDress.sort5"));
         _sortArr.push(LanguageMgr.GetTranslation("playerDress.sort6"));
         _sortArr.push(LanguageMgr.GetTranslation("playerDress.sort7"));
         _sortArr.push(LanguageMgr.GetTranslation("playerDress.sort8"));
      }
      
      private function initView() : void
      {
         _assortBox = ComponentFactory.Instance.creatComponentByStylename("playerDress.assortCombo");
         _assortBox.selctedPropName = "text";
         _assortBox.textField.text = _sortArr[_currentSort];
         addChild(_assortBox);
         _searchInput = ComponentFactory.Instance.creatComponentByStylename("playerDress.searchInput");
         _searchInput.text = LanguageMgr.GetTranslation("shop.view.ShopRankingView.shopSearchText");
         addChild(_searchInput);
         _searchBtn = ComponentFactory.Instance.creatComponentByStylename("playerDress.searchBtn");
         addChild(_searchBtn);
         _baglist = new DressBagListView(0,7,49);
         PositionUtils.setPos(_baglist,"playerDress.baglistPos");
         addChild(_baglist);
         _bottomBg = ComponentFactory.Instance.creat("playerDress.bottomBg");
         addChild(_bottomBg);
         _maleBtn = ComponentFactory.Instance.creatComponentByStylename("playerDress.maleBtn");
         addChild(_maleBtn);
         _femaleBtn = ComponentFactory.Instance.creatComponentByStylename("playerDress.femaleBtn");
         addChild(_femaleBtn);
         _sortBtn = ComponentFactory.Instance.creatComponentByStylename("playerDress.sortBtn");
         addChild(_sortBtn);
         _renewalBtn = ComponentFactory.Instance.creatComponentByStylename("bagContinueButton1");
         PositionUtils.setPos(_renewalBtn,"playerDress.renewalBtnPos");
         _renewalBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.bagContinue");
         addChild(_renewalBtn);
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("playerDress.leftBtn");
         addChild(_leftBtn);
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("playerDress.rightBtn");
         addChild(_rightBtn);
         _pageBG = ComponentFactory.Instance.creatComponentByStylename("playerDress.pageBG");
         addChild(_pageBG);
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("playerDress.pageTxt");
         addChild(_pageTxt);
         _pageTxt.text = "2/3";
         var _loc1_:Boolean = PlayerManager.Instance.Self.Sex;
         _maleBtn.selected = _loc1_;
         _maleBtn.mouseEnabled = !_loc1_;
         _femaleBtn.selected = !_loc1_;
         _femaleBtn.mouseEnabled = _loc1_;
         updateComboBox(_sortArr[_currentSort]);
         _baglist.setData(_info.Bag);
         updateBagList();
      }
      
      private function initEvent() : void
      {
         _baglist.addEventListener("itemclick",__cellClick);
         _baglist.addEventListener("doubleclick",__cellDoubleClick);
         _assortBox.listPanel.list.addEventListener("listItemClick",__onListClick);
         _searchBtn.addEventListener("click",__searchBtnClick);
         _maleBtn.addEventListener("click",__maleBtnClick);
         _femaleBtn.addEventListener("click",__femaleBtnClick);
         _leftBtn.addEventListener("click",__leftBtnClick);
         _rightBtn.addEventListener("click",__rightBtnClick);
         _sortBtn.addEventListener("click",__sortBtnClick);
         _renewalBtn.addEventListener("click",__renewalBtnClick);
         _searchInput.addEventListener("focusIn",__searchInputFocusIn);
         _searchInput.addEventListener("focusOut",__searchInputFocusOut);
      }
      
      protected function __cellClick(param1:CellEvent) : void
      {
         dispatchEvent(new CellEvent("itemclick",param1.data,false,false,param1.ctrlKey));
      }
      
      protected function __renewalBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      protected function __sortBtnClick(param1:MouseEvent) : void
      {
         event = param1;
         onClickSortEquipBag = function():void
         {
            _baglist.foldItems();
         };
         SoundManager.instance.play("008");
         if(new CmdCheckBagLockedPSWNeeds().excute(1))
         {
            return;
         }
         if(_sortdreesBagData.notShowAlertAgain)
         {
            _baglist.foldItems();
            return;
         }
         var msg:String = LanguageMgr.GetTranslation("playerDress.sortTips");
         HelperBuyAlert.getInstance().alert(msg,_sortdreesBagData,"SimpleAlertWithNotShowAgain",null,onClickSortEquipBag,null,0);
      }
      
      protected function __onResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onResponse);
         _loc2_.dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            _baglist.foldItems();
         }
      }
      
      protected function __cellDoubleClick(param1:CellEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:PlayerDressView = PlayerDressControl.instance.dressView;
         if(_loc2_)
         {
            _loc4_ = param1.data as BagCell;
            _loc3_ = _loc4_.info as InventoryItemInfo;
            PlayerDressControl.instance.putOnDress(_loc3_);
         }
         else
         {
            dispatchEvent(new CellEvent("doubleclick",param1.data));
         }
      }
      
      protected function __searchBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_searchInput.text == LanguageMgr.GetTranslation("shop.view.ShopRankingView.shopSearchText") || _searchInput.text.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.ShopRankingView.PleaseEnterTheKeywords"));
            return;
         }
         _currentSort = 9;
         _assortBox.textField.text = LanguageMgr.GetTranslation("playerDress.sort9");
         updateComboBox();
         updateBagList();
      }
      
      protected function __maleBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _maleBtn.mouseEnabled = false;
         _femaleBtn.mouseEnabled = true;
         _femaleBtn.selected = false;
         updateBagList();
      }
      
      protected function __femaleBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _femaleBtn.mouseEnabled = false;
         _maleBtn.mouseEnabled = true;
         _maleBtn.selected = false;
         updateBagList();
      }
      
      protected function __rightBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _currentPage = Number(_currentPage) + 1;
         if(_currentPage > pageSum())
         {
            _currentPage = 1;
         }
         updatePage();
         _baglist.fillPage(_currentPage);
      }
      
      protected function __leftBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _currentPage = Number(_currentPage) - 1;
         if(_currentPage < 1)
         {
            _currentPage = pageSum();
         }
         updatePage();
         _baglist.fillPage(_currentPage);
      }
      
      protected function __onListClick(param1:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         _currentSort = _sortArr.indexOf(param1.cellValue);
         _searchInput.text = "";
         updateComboBox(param1.cellValue);
         updateBagList();
      }
      
      public function updateBagList() : void
      {
         _baglist.setSortType(_sortTypeArr[_currentSort],_maleBtn.selected,_searchInput.text);
      }
      
      public function set currentPage(param1:int) : void
      {
         _currentPage = param1;
      }
      
      public function updatePage() : void
      {
         _pageTxt.text = _currentPage + "/" + pageSum();
      }
      
      private function pageSum() : int
      {
         var _loc1_:int = _baglist.displayItemsLength();
         return _loc1_ == 0?1:Number(Math.ceil(_loc1_ / 49));
      }
      
      private function updateComboBox(param1:* = null) : void
      {
         var _loc2_:VectorListModel = _assortBox.listPanel.vectorListModel;
         _loc2_.clear();
         _loc2_.appendAll(_sortArr);
         _loc2_.remove(param1);
      }
      
      protected function __searchInputFocusIn(param1:FocusEvent) : void
      {
         if(_searchInput.text == LanguageMgr.GetTranslation("shop.view.ShopRankingView.shopSearchText"))
         {
            _searchInput.text = "";
         }
      }
      
      protected function __searchInputFocusOut(param1:FocusEvent) : void
      {
         if(_searchInput.text.length == 0)
         {
            _searchInput.text = LanguageMgr.GetTranslation("shop.view.ShopRankingView.shopSearchText");
         }
      }
      
      public function enableSortBtn(param1:Boolean) : void
      {
         _sortBtn.enable = param1;
      }
      
      private function removeEvent() : void
      {
         _baglist.removeEventListener("doubleclick",__cellDoubleClick);
         _assortBox.listPanel.list.removeEventListener("listItemClick",__onListClick);
         _searchBtn.removeEventListener("click",__searchBtnClick);
         _maleBtn.removeEventListener("click",__maleBtnClick);
         _femaleBtn.removeEventListener("click",__femaleBtnClick);
         _leftBtn.removeEventListener("click",__leftBtnClick);
         _rightBtn.removeEventListener("click",__rightBtnClick);
         _sortBtn.removeEventListener("click",__sortBtnClick);
         _renewalBtn.removeEventListener("click",__renewalBtnClick);
         _baglist.removeEventListener("itemclick",__cellClick);
         _searchInput.removeEventListener("focusIn",__searchInputFocusIn);
         _searchInput.removeEventListener("focusOut",__searchInputFocusOut);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_assortBox);
         _assortBox = null;
         ObjectUtils.disposeObject(_searchInput);
         _searchInput = null;
         ObjectUtils.disposeObject(_searchBtn);
         _searchBtn = null;
         ObjectUtils.disposeObject(_baglist);
         _baglist = null;
         ObjectUtils.disposeObject(_maleBtn);
         _maleBtn = null;
         ObjectUtils.disposeObject(_femaleBtn);
         _femaleBtn = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_sortBtn);
         _sortBtn = null;
         ObjectUtils.disposeObject(_renewalBtn);
         _renewalBtn = null;
         ObjectUtils.disposeObject(_leftBtn);
         _leftBtn = null;
         ObjectUtils.disposeObject(_rightBtn);
         _rightBtn = null;
         ObjectUtils.disposeObject(_pageBG);
         _pageBG = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
      }
      
      public function get baglist() : DressBagListView
      {
         return _baglist;
      }
   }
}
