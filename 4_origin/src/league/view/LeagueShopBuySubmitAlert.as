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
         var _loc1_:String = String(_number.number * _perPrice);
         totalText.text = _loc1_ + "\n\n" + _buyNum;
      }
      
      override public function setData(param1:int, param2:int, param3:int) : void
      {
         _goodsId = param2;
         super.setData(param1,_goodsId,param3);
      }
      
      public function setBuyNum(param1:int) : void
      {
         _buyNum = param1;
         refreshNumText();
         _number.maximum = _buyNum;
      }
      
      override protected function __buy(param1:MouseEvent) : void
      {
         var _loc9_:int = 0;
         SoundManager.instance.playButtonSound();
         var _loc2_:Array = [];
         var _loc7_:Array = [];
         var _loc4_:Array = [];
         var _loc6_:Array = [];
         var _loc5_:Array = [];
         var _loc3_:Array = [];
         var _loc8_:Array = [];
         _loc9_ = 0;
         while(_loc9_ < _number.number)
         {
            _loc2_.push(_goodsId);
            _loc7_.push(1);
            _loc4_.push("");
            _loc6_.push("");
            _loc5_.push("");
            _loc3_.push(1);
            _loc8_.push("");
            _loc9_++;
         }
         SocketManager.Instance.out.sendBuyGoods(_loc2_,_loc7_,_loc4_,_loc6_,_loc5_,_loc8_,0,_loc3_);
         dispose();
      }
   }
}
