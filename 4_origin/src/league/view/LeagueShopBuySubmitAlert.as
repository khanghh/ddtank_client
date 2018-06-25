package league.view
{
   import ddt.command.QuickBuyAlertBase;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class LeagueShopBuySubmitAlert extends QuickBuyAlertBase
   {
       
      
      private var _buyNum:int;
      
      private var _goodsId:int;
      
      public function LeagueShopBuySubmitAlert()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         var _loc1_:* = false;
         _sprite.visible = _loc1_;
         _loc1_ = _loc1_;
         _sprite.mouseChildren = _loc1_;
         _sprite.mouseEnabled = _loc1_;
         _totalTipText.text = LanguageMgr.GetTranslation("leagueShopView.todayBuyText");
         totalText.x = 217;
         _submitButton.y = 141;
      }
      
      override protected function refreshNumText() : void
      {
         var priceStr:String = String(_number.number * _perPrice);
         totalText.text = priceStr + "\n\n" + _buyNum;
      }
      
      override public function setData(templateId:int, goodsId:int, perPrice:int) : void
      {
         _goodsId = goodsId;
         super.setData(templateId,_goodsId,perPrice);
      }
      
      public function setBuyNum(value:int) : void
      {
         _buyNum = value;
         refreshNumText();
         _number.maximum = _buyNum;
      }
      
      override protected function __buy(event:MouseEvent) : void
      {
         var i:int = 0;
         SoundManager.instance.playButtonSound();
         var items:Array = [];
         var types:Array = [];
         var colors:Array = [];
         var places:Array = [];
         var dresses:Array = [];
         var goodsTypes:Array = [];
         var skin:Array = [];
         for(i = 0; i < _number.number; )
         {
            items.push(_goodsId);
            types.push(1);
            colors.push("");
            places.push("");
            dresses.push("");
            goodsTypes.push(1);
            skin.push("");
            i++;
         }
         SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,skin,0,goodsTypes);
         dispose();
      }
   }
}
