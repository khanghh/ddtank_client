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
      
      public function DressBagView(){super();}
      
      private function initData() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __cellClick(param1:CellEvent) : void{}
      
      protected function __renewalBtnClick(param1:MouseEvent) : void{}
      
      protected function __sortBtnClick(param1:MouseEvent) : void{}
      
      protected function __onResponse(param1:FrameEvent) : void{}
      
      protected function __cellDoubleClick(param1:CellEvent) : void{}
      
      protected function __searchBtnClick(param1:MouseEvent) : void{}
      
      protected function __maleBtnClick(param1:MouseEvent) : void{}
      
      protected function __femaleBtnClick(param1:MouseEvent) : void{}
      
      protected function __rightBtnClick(param1:MouseEvent) : void{}
      
      protected function __leftBtnClick(param1:MouseEvent) : void{}
      
      protected function __onListClick(param1:ListItemEvent) : void{}
      
      public function updateBagList() : void{}
      
      public function set currentPage(param1:int) : void{}
      
      public function updatePage() : void{}
      
      private function pageSum() : int{return 0;}
      
      private function updateComboBox(param1:* = null) : void{}
      
      protected function __searchInputFocusIn(param1:FocusEvent) : void{}
      
      protected function __searchInputFocusOut(param1:FocusEvent) : void{}
      
      public function enableSortBtn(param1:Boolean) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
      
      public function get baglist() : DressBagListView{return null;}
   }
}
