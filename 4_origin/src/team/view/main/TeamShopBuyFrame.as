package team.view.main
{
   import ddt.command.QuickBuyAlertBase;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import team.TeamManager;
   
   public class TeamShopBuyFrame extends QuickBuyAlertBase
   {
       
      
      public function TeamShopBuyFrame()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _sprite.visible = false;
         _totalTipText.text = LanguageMgr.GetTranslation("team.shop.buyConsume");
         _submitButton.y = 116;
      }
      
      override protected function __buy(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc3_:int = TeamManager.instance.model.selfActive;
         var _loc2_:int = _number.number * _perPrice;
         if(_loc3_ < _loc2_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("team.shop.notBuy"));
            return;
         }
         SocketManager.Instance.out.sendNewBuyGoods(_shopGoodsId,1,_number.number,"",-1,false,"",0,1,false);
         dispose();
      }
      
      override protected function refreshNumText() : void
      {
         var _loc1_:String = String(_number.number * _perPrice);
         totalText.text = _loc1_ + " " + LanguageMgr.GetTranslation("team.shop.price");
         totalText.x = 192;
      }
   }
}
