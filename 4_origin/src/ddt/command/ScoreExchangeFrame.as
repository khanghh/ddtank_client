package ddt.command
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.Price;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import dragonBoat.DragonBoatManager;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ScoreExchangeFrame extends BaseAlerFrame
   {
       
      
      private var _sprite:Sprite;
      
      private var _number:NumberSelecter;
      
      private var _totalTipText:FilterFrameText;
      
      private var totalText:FilterFrameText;
      
      private var _cell:BaseCell;
      
      private var _shopItem:ShopItemInfo;
      
      private var _stoneNumber:int = 1;
      
      private var _price:int;
      
      private var _totalPrice:int;
      
      public var type:int;
      
      public function ScoreExchangeFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         var _alertInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.dragonBoat.shopBuyFrame.titleTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _alertInfo.moveEnable = false;
         _alertInfo.autoDispose = false;
         _alertInfo.sound = "008";
         info = _alertInfo;
         _sprite = new Sprite();
         PositionUtils.setPos(_sprite,"scoreExchangeFrame.contentPos");
         addToContent(_sprite);
         var bg:Image = ComponentFactory.Instance.creatComponentByStylename("ddtcore.CellBg");
         _sprite.addChild(bg);
         _number = ComponentFactory.Instance.creatCustomObject("ddtcore.numberSelecter");
         _sprite.addChild(_number);
         var cellBG:Sprite = new Sprite();
         cellBG.addChild(ComponentFactory.Instance.creatBitmap("asset.ddtcore.EquipCellBG"));
         _totalTipText = ComponentFactory.Instance.creatComponentByStylename("ddtcore.TotalTipsText");
         _totalTipText.text = LanguageMgr.GetTranslation("ddt.QuickFrame.TotalTipText");
         _sprite.addChild(_totalTipText);
         totalText = ComponentFactory.Instance.creatComponentByStylename("ddtcore.TotalText");
         _sprite.addChild(totalText);
         _cell = new BaseCell(cellBG);
         _cell.x = bg.x + 4;
         _cell.y = bg.y + 4;
         _cell.tipDirctions = "7,0";
         _sprite.addChild(_cell);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",responseHandler,false,0,true);
         _number.addEventListener("change",selectHandler);
         _number.addEventListener("number_close",_numberClose);
         _number.addEventListener("number_enter",_numberEnter);
      }
      
      private function _numberEnter(e:Event) : void
      {
         doBuy();
         dispose();
      }
      
      private function _numberClose(e:Event) : void
      {
         dispose();
      }
      
      private function responseHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               doBuy();
               dispose();
         }
      }
      
      private function doBuy() : void
      {
         var items:* = null;
         var types:* = null;
         var colors:* = null;
         var dresses:* = null;
         var skins:* = null;
         var places:* = null;
         var bands:* = null;
         var i:int = 0;
         switch(int(type))
         {
            case 0:
               items = [];
               types = [];
               colors = [];
               dresses = [];
               skins = [];
               places = [];
               bands = [];
               for(i = 0; i < _stoneNumber; )
               {
                  items.push(_shopItem.GoodsID);
                  types.push(1);
                  colors.push("");
                  dresses.push(false);
                  skins.push("");
                  places.push(-1);
                  bands.push(false);
                  i++;
               }
               SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,skins,0,null,bands);
               break;
            case 1:
            case 2:
               SocketManager.Instance.out.sendDragonBoatExchange(_shopItem.GoodsID,_stoneNumber);
         }
      }
      
      private function selectHandler(e:Event) : void
      {
         _stoneNumber = _number.number;
         refreshNumText();
      }
      
      public function set shopItem(value:ShopItemInfo) : void
      {
         _shopItem = value;
         _cell.info = ItemManager.Instance.getTemplateById(_shopItem.TemplateID);
         switch(int(type))
         {
            case 0:
               _price = _shopItem == null?0:_shopItem.getItemPrice(1).scoreValue;
               _number.maximum = PlayerManager.Instance.Self.Score / _price;
               break;
            case 1:
               _price = _shopItem == null?0:_shopItem.AValue1;
               _number.maximum = DragonBoatManager.instance.useableScore / _price;
               break;
            case 2:
               _price = _shopItem == null?0:_shopItem.getItemPrice(1).fishScoreValue;
               _number.maximum = PlayerManager.Instance.Self.fishScore / _price;
         }
         refreshNumText();
      }
      
      private function refreshNumText() : void
      {
         _totalPrice = _stoneNumber * _price;
         totalText.text = _totalPrice + Price.SCORETOSTRING;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",responseHandler);
         _number.removeEventListener("change",selectHandler);
         _number.removeEventListener("number_close",_numberClose);
         _number.removeEventListener("number_enter",_numberEnter);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(_sprite);
         super.dispose();
         _sprite = null;
         _number = null;
         _totalTipText = null;
         totalText = null;
         _cell = null;
         _shopItem = null;
      }
   }
}
