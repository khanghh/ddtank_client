package auctionHouse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.TextEvent;
   
   public class BidMoneyView extends Sprite implements Disposeable
   {
       
      
      public const MONEY_KEY_UP:String = "money_key_up";
      
      private var _money:FilterFrameText;
      
      private var _canMoney:Boolean;
      
      private var _canGold:Boolean;
      
      public function BidMoneyView()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get money() : FilterFrameText
      {
         return _money;
      }
      
      private function initView() : void
      {
         var icon:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.BidInputIcon");
         addChild(icon);
         _money = ComponentFactory.Instance.creat("auctionHouse.BidMoney");
         _money.restrict = "0-9";
         addChild(_money);
      }
      
      private function addEvent() : void
      {
         _money.addEventListener("change",__change);
         _money.addEventListener("textInput",__inputTextM);
         _money.addEventListener("keyUp",_moneyUp);
      }
      
      function get canMoney() : Boolean
      {
         return _canMoney;
      }
      
      function get canGold() : Boolean
      {
         return _canGold;
      }
      
      private function removeEvent() : void
      {
         _money.removeEventListener("change",__change);
         _money.removeEventListener("textInput",__inputTextM);
         _money.removeEventListener("keyUp",_moneyUp);
      }
      
      function canMoneyBid(price:int) : void
      {
         _money.mouseEnabled = true;
         _canMoney = true;
         _canGold = false;
         _money.text = price.toString();
         _money.setFocus();
         _money.setSelection(price.toString().length,price.toString().length);
      }
      
      function canGoldBid(price:int) : void
      {
         _money.text = "";
         if(_money.stage)
         {
            _money.stage.focus = null;
         }
         _money.mouseEnabled = false;
         _canGold = true;
         _canMoney = false;
      }
      
      function cannotBid() : void
      {
         _money.mouseEnabled = false;
         _money.text = "";
         if(_money.stage)
         {
            _money.stage.focus = null;
         }
         _canGold = false;
         _canMoney = false;
      }
      
      function getData() : Number
      {
         var result:Number = NaN;
         if(!_canGold)
         {
            if(_canMoney)
            {
               result = _money.text;
            }
         }
         return result;
      }
      
      private function _moneyUp(e:KeyboardEvent) : void
      {
         if(e.keyCode == 13)
         {
            _money.removeEventListener("keyUp",_moneyUp);
            dispatchEvent(new Event("money_key_up"));
         }
      }
      
      private function __change(event:Event) : void
      {
      }
      
      private function __inputTextM(event:TextEvent) : void
      {
         if(Number(_money.text) + Number(event.text) > PlayerManager.Instance.Self.Money || Number(_money.text) + Number(event.text) == 0)
         {
            return;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_money)
         {
            ObjectUtils.disposeObject(_money);
         }
         _money = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
