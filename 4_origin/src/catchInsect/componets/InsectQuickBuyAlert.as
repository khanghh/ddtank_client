package catchInsect.componets
{
   import ddt.command.QuickBuyAlertBase;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class InsectQuickBuyAlert extends QuickBuyAlertBase
   {
       
      
      public function InsectQuickBuyAlert()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _sprite.visible = false;
      }
      
      override protected function __buy(event:MouseEvent) : void
      {
         var i:int = 0;
         SoundManager.instance.play("008");
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
            bands.push(false);
            i++;
         }
         SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,skins,0,null,bands);
         SocketManager.Instance.out.updateInsectInfo();
         dispose();
      }
      
      override protected function refreshNumText() : void
      {
         var priceStr:String = String(_number.number * _perPrice);
         var tmp:String = LanguageMgr.GetTranslation("tank.gameover.takecard.score");
         totalText.text = priceStr + " " + tmp;
      }
   }
}
