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
      
      protected function __onPumpkinBuyClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var shopInfo:ShopItemInfo = ShopManager.Instance.getGoodsByTemplateID(1120243,1);
         ShopBuyManager.Instance.buy(shopInfo.GoodsID,1,shopInfo.getItemPrice(1).PriceType);
      }
      
      protected function __onGetCandyNum(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var num:int = pkg.readInt();
         _candyNum.text = num.toString();
      }
      
      protected function __onKeyDown(event:KeyboardEvent) : void
      {
         var focusTarget:DisplayObject = StageReferance.stage.focus as DisplayObject;
         if(DisplayUtils.isTargetOrContain(focusTarget,this))
         {
            if(event.keyCode == 27)
            {
               SoundManager.instance.playButtonSound();
               HalloweenControl.instance.hide();
            }
         }
      }
      
      protected function __onSetExchangeInfo(event:PkgEvent) : void
      {
         var i:int = 0;
         var pkg:PackageIn = event.pkg;
         var idArr:Array = [];
         for(i = 0; i < 5; )
         {
            idArr.push(pkg.readInt());
            i++;
         }
         _exchangeView.info = idArr;
      }
      
      private function setTimeText() : void
      {
         var startDate:Date = DateUtils.getDateByStr(ServerConfigManager.instance.halloweenBeginDate);
         var endDate:Date = DateUtils.getDateByStr(ServerConfigManager.instance.halloweenEndDate);
         _halloweenTime.text = addZero(startDate.fullYear) + "." + addZero(startDate.month + 1) + "." + addZero(startDate.date);
         _halloweenTime.text = _halloweenTime.text + ("-" + addZero(endDate.fullYear) + "." + addZero(endDate.month + 1) + "." + addZero(endDate.date));
      }
      
      private function addZero(value:Number) : String
      {
         var result:* = null;
         if(value < 10)
         {
            result = "0" + value.toString();
         }
         else
         {
            result = value.toString();
         }
         return result;
      }
      
      protected function __onCloseClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         HalloweenControl.instance.hide();
      }
      
      public function show() : void
      {
         PositionUtils.setPos(this,"halloween.viewPos");
         LayerManager.Instance.addToLayer(this,4,false,1);
      }
      
      private function __onMouseClickSetFocus(event:MouseEvent) : void
      {
         StageReferance.stage.focus = event.target as InteractiveObject;
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
         var focusDisplay:DisplayObject = StageReferance.stage.focus as DisplayObject;
         if(focusDisplay && contains(focusDisplay))
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
