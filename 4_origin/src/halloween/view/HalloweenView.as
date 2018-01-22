package halloween.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import halloween.HalloweenControl;
   import road7th.comm.PackageIn;
   import road7th.utils.DateUtils;
   import shop.manager.ShopBuyManager;
   
   public class HalloweenView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _halloweenDes:FilterFrameText;
      
      private var _halloweenTime:FilterFrameText;
      
      private var _exchangeView:HalloweenExchangeView;
      
      private var _pumpkin:BagCell;
      
      private var _pumpkinBuyBtn:SimpleBitmapButton;
      
      private var _candy:Bitmap;
      
      private var _candyNum:FilterFrameText;
      
      private var _listView:HalloweenListView;
      
      public function HalloweenView()
      {
         super();
         initView();
         initEvent();
         sendPkg();
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.getHalloweenExchangeViewInfo();
         SocketManager.Instance.out.getHalloweenCandyNum();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.halloween.bg");
         addChild(_bg);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("halloween.closeBtn");
         addChild(_closeBtn);
         _halloweenDes = ComponentFactory.Instance.creatComponentByStylename("halloween.descriptionText");
         _halloweenDes.text = LanguageMgr.GetTranslation("halloween.view.Description");
         addChild(_halloweenDes);
         _halloweenTime = ComponentFactory.Instance.creatComponentByStylename("halloween.timeText");
         setTimeText();
         addChild(_halloweenTime);
         _exchangeView = new HalloweenExchangeView();
         addChild(_exchangeView);
         _pumpkin = new BagCell(0);
         _pumpkin.setBgVisible(false);
         _pumpkin.info = ItemManager.Instance.getTemplateById(1120243);
         PositionUtils.setPos(_pumpkin,"halloween.pumpkinPos");
         addChild(_pumpkin);
         _pumpkinBuyBtn = ComponentFactory.Instance.creatComponentByStylename("halloween.pumpkinBuyBtn");
         addChild(_pumpkinBuyBtn);
         _candy = ComponentFactory.Instance.creat("asset.halloween.candy");
         PositionUtils.setPos(_candy,"halloween.candyPos1");
         addChild(_candy);
         _candyNum = ComponentFactory.Instance.creatComponentByStylename("halloween.candyNumText");
         addChild(_candyNum);
         _listView = new HalloweenListView();
         PositionUtils.setPos(_listView,"halloween.listViewPos");
         addChild(_listView);
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseDown",__onMouseClickSetFocus);
         StageReferance.stage.addEventListener("keyDown",__onKeyDown);
         _closeBtn.addEventListener("click",__onCloseClick);
         _pumpkinBuyBtn.addEventListener("click",__onPumpkinBuyClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(283,4),__onSetExchangeInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(283,6),__onGetCandyNum);
      }
      
      protected function __onPumpkinBuyClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:ShopItemInfo = ShopManager.Instance.getGoodsByTemplateID(1120243,1);
         ShopBuyManager.Instance.buy(_loc2_.GoodsID,1,_loc2_.getItemPrice(1).PriceType);
      }
      
      protected function __onGetCandyNum(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         _candyNum.text = _loc2_.toString();
      }
      
      protected function __onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:DisplayObject = StageReferance.stage.focus as DisplayObject;
         if(DisplayUtils.isTargetOrContain(_loc2_,this))
         {
            if(param1.keyCode == 27)
            {
               SoundManager.instance.playButtonSound();
               HalloweenControl.instance.hide();
            }
         }
      }
      
      protected function __onSetExchangeInfo(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc2_.push(_loc3_.readInt());
            _loc4_++;
         }
         _exchangeView.info = _loc2_;
      }
      
      private function setTimeText() : void
      {
         var _loc1_:Date = DateUtils.getDateByStr(ServerConfigManager.instance.halloweenBeginDate);
         var _loc2_:Date = DateUtils.getDateByStr(ServerConfigManager.instance.halloweenEndDate);
         _halloweenTime.text = addZero(_loc1_.fullYear) + "." + addZero(_loc1_.month + 1) + "." + addZero(_loc1_.date);
         _halloweenTime.text = _halloweenTime.text + ("-" + addZero(_loc2_.fullYear) + "." + addZero(_loc2_.month + 1) + "." + addZero(_loc2_.date));
      }
      
      private function addZero(param1:Number) : String
      {
         var _loc2_:* = null;
         if(param1 < 10)
         {
            _loc2_ = "0" + param1.toString();
         }
         else
         {
            _loc2_ = param1.toString();
         }
         return _loc2_;
      }
      
      protected function __onCloseClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         HalloweenControl.instance.hide();
      }
      
      public function show() : void
      {
         PositionUtils.setPos(this,"halloween.viewPos");
         LayerManager.Instance.addToLayer(this,4,false,1);
      }
      
      private function __onMouseClickSetFocus(param1:MouseEvent) : void
      {
         StageReferance.stage.focus = param1.target as InteractiveObject;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseDown",__onMouseClickSetFocus);
         StageReferance.stage.removeEventListener("keyDown",__onKeyDown);
         _closeBtn.removeEventListener("click",__onCloseClick);
         _pumpkinBuyBtn.removeEventListener("click",__onPumpkinBuyClick);
         SocketManager.Instance.removeEventListener(PkgEvent.format(283,4),__onSetExchangeInfo);
         SocketManager.Instance.removeEventListener(PkgEvent.format(283,6),__onGetCandyNum);
      }
      
      public function dispose() : void
      {
         removeEvent();
         var _loc1_:DisplayObject = StageReferance.stage.focus as DisplayObject;
         if(_loc1_ && contains(_loc1_))
         {
            StageReferance.stage.focus = null;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         ObjectUtils.disposeObject(_halloweenDes);
         _halloweenDes = null;
         ObjectUtils.disposeObject(_halloweenTime);
         _halloweenTime = null;
         ObjectUtils.disposeObject(_pumpkin);
         _pumpkin = null;
         ObjectUtils.disposeObject(_pumpkinBuyBtn);
         _pumpkinBuyBtn = null;
         ObjectUtils.disposeObject(_candy);
         _candy = null;
         ObjectUtils.disposeObject(_candyNum);
         _candyNum = null;
         ObjectUtils.disposeObject(_listView);
         _listView = null;
         ObjectUtils.disposeObject(_exchangeView);
         _exchangeView = null;
      }
   }
}
