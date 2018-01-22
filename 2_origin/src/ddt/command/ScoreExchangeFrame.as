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
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.dragonBoat.shopBuyFrame.titleTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _loc1_.moveEnable = false;
         _loc1_.autoDispose = false;
         _loc1_.sound = "008";
         info = _loc1_;
         _sprite = new Sprite();
         PositionUtils.setPos(_sprite,"scoreExchangeFrame.contentPos");
         addToContent(_sprite);
         var _loc2_:Image = ComponentFactory.Instance.creatComponentByStylename("ddtcore.CellBg");
         _sprite.addChild(_loc2_);
         _number = ComponentFactory.Instance.creatCustomObject("ddtcore.numberSelecter");
         _sprite.addChild(_number);
         var _loc3_:Sprite = new Sprite();
         _loc3_.addChild(ComponentFactory.Instance.creatBitmap("asset.ddtcore.EquipCellBG"));
         _totalTipText = ComponentFactory.Instance.creatComponentByStylename("ddtcore.TotalTipsText");
         _totalTipText.text = LanguageMgr.GetTranslation("ddt.QuickFrame.TotalTipText");
         _sprite.addChild(_totalTipText);
         totalText = ComponentFactory.Instance.creatComponentByStylename("ddtcore.TotalText");
         _sprite.addChild(totalText);
         _cell = new BaseCell(_loc3_);
         _cell.x = _loc2_.x + 4;
         _cell.y = _loc2_.y + 4;
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
      
      private function _numberEnter(param1:Event) : void
      {
         doBuy();
         dispose();
      }
      
      private function _numberClose(param1:Event) : void
      {
         dispose();
      }
      
      private function responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
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
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc5_:* = null;
         var _loc1_:* = null;
         var _loc8_:int = 0;
         switch(int(type))
         {
            case 0:
               _loc2_ = [];
               _loc6_ = [];
               _loc3_ = [];
               _loc4_ = [];
               _loc7_ = [];
               _loc5_ = [];
               _loc1_ = [];
               _loc8_ = 0;
               while(_loc8_ < _stoneNumber)
               {
                  _loc2_.push(_shopItem.GoodsID);
                  _loc6_.push(1);
                  _loc3_.push("");
                  _loc4_.push(false);
                  _loc7_.push("");
                  _loc5_.push(-1);
                  _loc1_.push(false);
                  _loc8_++;
               }
               SocketManager.Instance.out.sendBuyGoods(_loc2_,_loc6_,_loc3_,_loc5_,_loc4_,_loc7_,0,null,_loc1_);
               break;
            case 1:
            case 2:
               SocketManager.Instance.out.sendDragonBoatExchange(_shopItem.GoodsID,_stoneNumber);
         }
      }
      
      private function selectHandler(param1:Event) : void
      {
         _stoneNumber = _number.number;
         refreshNumText();
      }
      
      public function set shopItem(param1:ShopItemInfo) : void
      {
         _shopItem = param1;
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
