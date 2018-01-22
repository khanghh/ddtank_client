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
      
      override protected function __buy(param1:MouseEvent) : void
      {
         var _loc9_:int = 0;
         SoundManager.instance.play("008");
         var _loc3_:Array = [];
         var _loc7_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         var _loc8_:Array = [];
         var _loc6_:Array = [];
         var _loc2_:Array = [];
         _loc9_ = 0;
         while(_loc9_ <= _number.number - 1)
         {
            _loc3_.push(_shopGoodsId);
            _loc7_.push(1);
            _loc4_.push("");
            _loc5_.push(false);
            _loc8_.push("");
            _loc6_.push(-1);
            _loc2_.push(false);
            _loc9_++;
         }
         SocketManager.Instance.out.sendBuyGoods(_loc3_,_loc7_,_loc4_,_loc6_,_loc5_,_loc8_,0,null,_loc2_);
         SocketManager.Instance.out.updateInsectInfo();
         dispose();
      }
      
      override protected function refreshNumText() : void
      {
         var _loc1_:String = String(_number.number * _perPrice);
         var _loc2_:String = LanguageMgr.GetTranslation("tank.gameover.takecard.score");
         totalText.text = _loc1_ + " " + _loc2_;
      }
   }
}
