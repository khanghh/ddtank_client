package dragonBoat.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import dragonBoat.DragonBoatManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class DragonBoatShopFrame extends BaseAlerFrame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _coinText:FilterFrameText;
      
      private var _coinNumBG:Scale9CornerImage;
      
      private var _coinNumText:FilterFrameText;
      
      private var _lable:FilterFrameText;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      private var _preBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _shopCellList:Vector.<DragonBoatShopCell>;
      
      private var _currentPage:int;
      
      private var _totlePage:int;
      
      private var _goodsInfoList:Vector.<ShopItemInfo>;
      
      private var activeId:int;
      
      public function DragonBoatShopFrame(){super();}
      
      private function initView() : void{}
      
      private function refreshShopView() : void{}
      
      private function refreshView(param1:Event = null) : void{}
      
      private function refreshMoneyTxt() : void{}
      
      private function initEvent() : void{}
      
      private function changePageHandler(param1:MouseEvent) : void{}
      
      private function responseHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
