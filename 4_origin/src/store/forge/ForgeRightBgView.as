package store.forge
{
   import bagAndInfo.bag.RichesButton;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import flash.display.Shape;
   import flash.display.Sprite;
   import store.StoreBagBgWHPoint;
   import store.view.storeBag.StoreBagbgbmp;
   
   public class ForgeRightBgView extends Sprite implements Disposeable
   {
       
      
      private var _bitmapBg:StoreBagbgbmp;
      
      private var bagBg:ScaleFrameImage;
      
      private var _equipmentsColumnBg:Image;
      
      private var _itemsColumnBg:Image;
      
      public var msg_txt:ScaleFrameImage;
      
      private var goldTxt:FilterFrameText;
      
      private var moneyTxt:FilterFrameText;
      
      private var giftTxt:FilterFrameText;
      
      private var _goldButton:RichesButton;
      
      private var _giftButton:RichesButton;
      
      private var _moneyButton:RichesButton;
      
      private var _bgPoint:StoreBagBgWHPoint;
      
      private var _bgShape:Shape;
      
      private var _equipmentTitleText:FilterFrameText;
      
      private var _itemTitleText:FilterFrameText;
      
      private var _equipmentTipText:FilterFrameText;
      
      private var _itemTipText:FilterFrameText;
      
      private var showMoneyBG:MutipleImage;
      
      public function ForgeRightBgView()
      {
         super();
         initView();
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
      }
      
      private function initView() : void
      {
         _bitmapBg = new StoreBagbgbmp();
         addChildAt(_bitmapBg,0);
         bagBg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagViewBg2");
         bagBg.setFrame(1);
         addChild(bagBg);
         _equipmentTitleText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.EquipmentTitleText");
         _equipmentTitleText.htmlText = LanguageMgr.GetTranslation("store.StoreBagView.EquipmentTitleText");
         _itemTitleText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.ItemTitleText");
         _itemTitleText.htmlText = LanguageMgr.GetTranslation("store.StoreBagView.ItemTitleText");
         _equipmentTipText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.EquipmentTipText");
         _itemTipText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.ItemTipText");
         addChild(_equipmentTitleText);
         addChild(_itemTitleText);
         addChild(_equipmentTipText);
         addChild(_itemTipText);
         showMoneyBG = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.MoneyPanelBg");
         addChild(showMoneyBG);
         moneyTxt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.TicketText");
         addChild(moneyTxt);
         _goldButton = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreBagView.GoldButton");
         _goldButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GoldDirections");
         addChild(_goldButton);
         giftTxt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.GiftText");
         addChild(giftTxt);
         _giftButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.bag.GiftButton");
         _giftButton = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreBagView.GiftButton");
         var levelNum:int = 6000;
         var vipNum:int = ServerConfigManager.instance.VIPExtraBindMoneyUpper[PlayerManager.Instance.Self.VIPLevel - 1];
         if(PlayerManager.Instance.Self.IsVIP)
         {
            _giftButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GiftDirections",(levelNum + vipNum).toString());
         }
         else
         {
            _giftButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GiftDirections",levelNum.toString());
         }
         addChild(_giftButton);
         _moneyButton = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreBagView.MoneyButton");
         _moneyButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.MoneyDirections");
         addChild(_moneyButton);
         goldTxt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.GoldText");
         addChild(goldTxt);
         updateMoney();
      }
      
      private function __propertyChange(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["Money"] || evt.changedProperties["Gold"] || evt.changedProperties["Money"] || evt.changedProperties["BandMoney"])
         {
            updateMoney();
         }
      }
      
      public function title1(value:String) : void
      {
         _equipmentTitleText.htmlText = value;
      }
      
      public function title2(value:String) : void
      {
         _itemTitleText.htmlText = value;
      }
      
      public function bgFrame(frame:int) : void
      {
         bagBg.setFrame(frame);
      }
      
      public function equipmentTipText() : FilterFrameText
      {
         return _equipmentTipText;
      }
      
      public function hideMoney() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
         ObjectUtils.disposeObject(goldTxt);
         ObjectUtils.disposeObject(moneyTxt);
         ObjectUtils.disposeObject(giftTxt);
         ObjectUtils.disposeObject(_goldButton);
         ObjectUtils.disposeObject(_giftButton);
         ObjectUtils.disposeObject(_moneyButton);
         ObjectUtils.disposeObject(showMoneyBG);
      }
      
      public function showStoreBagViewText(equipmentTip:String, itemTip:String, isShowItemTip:Boolean = true) : void
      {
         _equipmentTipText.text = LanguageMgr.GetTranslation(equipmentTip);
         if(isShowItemTip)
         {
            _itemTipText.text = LanguageMgr.GetTranslation(itemTip);
         }
         _itemTipText.visible = isShowItemTip;
         _itemTitleText.visible = isShowItemTip;
      }
      
      private function updateMoney() : void
      {
         goldTxt.text = String(PlayerManager.Instance.Self.Gold);
         moneyTxt.text = String(PlayerManager.Instance.Self.Money);
         giftTxt.text = String(PlayerManager.Instance.Self.BandMoney);
      }
      
      public function dispose() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
