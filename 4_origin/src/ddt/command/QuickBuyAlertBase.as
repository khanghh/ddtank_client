package ddt.command
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class QuickBuyAlertBase extends Frame
   {
       
      
      protected var _bg:Image;
      
      protected var _number:NumberSelecter;
      
      protected var _selectedBtn:SelectedCheckButton;
      
      protected var _selectedBandBtn:SelectedCheckButton;
      
      protected var _totalTipText:FilterFrameText;
      
      protected var totalText:FilterFrameText;
      
      protected var _moneyTxt:FilterFrameText;
      
      protected var _bandMoney:FilterFrameText;
      
      protected var _submitButton:TextButton;
      
      protected var _movieBack:MovieClip;
      
      protected var _sprite:Sprite;
      
      protected var _cell:BagCell;
      
      protected var _perPrice:int;
      
      protected var _isBand:Boolean;
      
      protected var _shopGoodsId:int;
      
      public function QuickBuyAlertBase()
      {
         super();
         initView();
         initEvents();
      }
      
      protected function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtcore.CellBg");
         addToContent(_bg);
         _number = ComponentFactory.Instance.creatCustomObject("ddtcore.numberSelecter");
         addToContent(_number);
         _totalTipText = ComponentFactory.Instance.creatComponentByStylename("ddtcore.TotalTipsText");
         _totalTipText.text = LanguageMgr.GetTranslation("ddt.QuickFrame.TotalTipText");
         addToContent(_totalTipText);
         totalText = ComponentFactory.Instance.creatComponentByStylename("ddtcore.TotalText");
         addToContent(totalText);
         _sprite = new Sprite();
         addToContent(_sprite);
         _movieBack = ComponentFactory.Instance.creat("asset.core.stranDown");
         _movieBack.x = 176;
         _movieBack.y = 116;
         _sprite.addChild(_movieBack);
         _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("vip.core.selectBtn");
         _selectedBtn.enable = true;
         _selectedBtn.selected = false;
         _selectedBtn.x = 83;
         _selectedBtn.y = 101;
         _sprite.addChild(_selectedBtn);
         _isBand = true;
         _selectedBandBtn = ComponentFactory.Instance.creatComponentByStylename("vip.core.selectBtn");
         _selectedBandBtn.enable = false;
         _selectedBandBtn.selected = true;
         _selectedBandBtn.x = 183;
         _selectedBandBtn.y = 101;
         _sprite.addChild(_selectedBandBtn);
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("vip.core.bandMoney");
         _moneyTxt.x = 55;
         _moneyTxt.y = 107;
         _moneyTxt.text = LanguageMgr.GetTranslation("ddt.money");
         _sprite.addChild(_moneyTxt);
         _bandMoney = ComponentFactory.Instance.creatComponentByStylename("vip.core.bandMoney");
         _bandMoney.x = 173;
         _bandMoney.y = 107;
         _bandMoney.text = LanguageMgr.GetTranslation("ddt.bandMoney");
         _sprite.addChild(_bandMoney);
         _cell = new BagCell(0);
         _cell.x = 33;
         _cell.y = 35;
         addToContent(_cell);
         refreshNumText();
         _submitButton = ComponentFactory.Instance.creatComponentByStylename("ddtcore.quickEnter");
         _submitButton.text = LanguageMgr.GetTranslation("store.view.shortcutBuy.buyBtn");
         addToContent(_submitButton);
         _submitButton.y = 141;
      }
      
      protected function initEvents() : void
      {
         addEventListener("response",__frameEventHandler);
         _selectedBtn.addEventListener("click",seletedHander);
         _selectedBandBtn.addEventListener("click",selectedBandHander);
         _number.addEventListener("change",selectHandler);
         _submitButton.addEventListener("click",__buy);
      }
      
      protected function __buy(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CheckMoneyUtils.instance.checkMoney(_isBand,getNeedMoney(),onCheckComplete);
      }
      
      protected function onCheckComplete() : void
      {
         submit(CheckMoneyUtils.instance.isBind);
         dispose();
      }
      
      protected function getNeedMoney() : int
      {
         return _perPrice * _number.number;
      }
      
      protected function submit(isBand:Boolean) : void
      {
         var i:int = 0;
         var items:Array = [];
         var types:Array = [];
         var colors:Array = [];
         var dresses:Array = [];
         var skins:Array = [];
         var places:Array = [];
         var bands:Array = [];
         for(i = 0; i <= _number.number - 1; )
         {
            items.push(_shopGoodsId);
            types.push(1);
            colors.push("");
            dresses.push(false);
            skins.push("");
            places.push(-1);
            bands.push(isBand);
            i++;
         }
         SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,skins,0,null,bands);
      }
      
      protected function selectedBandHander(event:MouseEvent) : void
      {
         if(_selectedBandBtn.selected)
         {
            _isBand = true;
            _selectedBandBtn.enable = false;
            _selectedBtn.selected = false;
            _selectedBtn.enable = true;
         }
         else
         {
            _isBand = false;
         }
         refreshNumText();
      }
      
      protected function seletedHander(event:MouseEvent) : void
      {
         if(_selectedBtn.selected)
         {
            _isBand = false;
            _selectedBandBtn.selected = false;
            _selectedBandBtn.enable = true;
            _selectedBtn.enable = false;
         }
         else
         {
            _isBand = true;
         }
         refreshNumText();
      }
      
      private function selectHandler(e:Event) : void
      {
         refreshNumText();
      }
      
      protected function refreshNumText() : void
      {
         var priceStr:String = String(_number.number * _perPrice);
         var tmp:String = !!_isBand?LanguageMgr.GetTranslation("ddtMoney"):LanguageMgr.GetTranslation("money");
         totalText.text = priceStr + " " + tmp;
      }
      
      public function setData(templateId:int, goodsId:int, perPrice:int) : void
      {
         _perPrice = perPrice;
         _shopGoodsId = goodsId;
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = templateId;
         ItemManager.fill(info);
         info.BindType = 4;
         _cell.info = info;
         _cell.setCountNotVisible();
         _cell.setBgVisible(false);
         refreshNumText();
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function removeEvnets() : void
      {
         removeEventListener("response",__frameEventHandler);
         _selectedBtn.removeEventListener("click",seletedHander);
         _selectedBandBtn.removeEventListener("click",selectedBandHander);
         _number.removeEventListener("change",selectHandler);
         _submitButton.removeEventListener("click",__buy);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvnets();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_selectedBtn);
         _selectedBtn = null;
         ObjectUtils.disposeObject(_selectedBandBtn);
         _selectedBandBtn = null;
         ObjectUtils.disposeObject(_totalTipText);
         _totalTipText = null;
         ObjectUtils.disposeObject(totalText);
         totalText = null;
         ObjectUtils.disposeObject(_moneyTxt);
         _moneyTxt = null;
         ObjectUtils.disposeObject(_bandMoney);
         _bandMoney = null;
         ObjectUtils.disposeObject(_submitButton);
         _submitButton = null;
         ObjectUtils.disposeObject(_movieBack);
         _movieBack = null;
         ObjectUtils.disposeObject(_cell);
         _cell = null;
      }
   }
}
