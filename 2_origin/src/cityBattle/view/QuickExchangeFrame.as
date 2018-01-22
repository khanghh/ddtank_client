package cityBattle.view
{
   import cityBattle.CityBattleManager;
   import cityBattle.data.WelfareInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyAlertBase;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   
   public class QuickExchangeFrame extends QuickBuyAlertBase
   {
       
      
      protected var _exchangeTxt:FilterFrameText;
      
      protected var _restTitleText:FilterFrameText;
      
      protected var _restText:FilterFrameText;
      
      public var type:int;
      
      public function QuickExchangeFrame()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         titleText = LanguageMgr.GetTranslation("ddt.cityBattle.exchangeBtn");
         _totalTipText.text = LanguageMgr.GetTranslation("ddt.cityBattle.costScore");
         _submitButton.text = LanguageMgr.GetTranslation("ddt.cityBattle.exchangeBtn");
         _restTitleText = ComponentFactory.Instance.creatComponentByStylename("ddtcore.TotalTipsText");
         _restTitleText.text = LanguageMgr.GetTranslation("ddt.cityBattle.canBuyNum");
         addToContent(_restTitleText);
         PositionUtils.setPos(_restTitleText,"quickExchange.restTitlePos");
         _restText = ComponentFactory.Instance.creatComponentByStylename("ddtcore.TotalText");
         addToContent(_restText);
         PositionUtils.setPos(_restText,"quickExchange.restPos");
         _sprite.visible = false;
      }
      
      override protected function refreshNumText() : void
      {
         var _loc1_:String = String(_number.number * _perPrice);
         var _loc2_:String = LanguageMgr.GetTranslation("ddt.cityBattle.score");
         totalText.text = _loc1_ + " " + _loc2_;
      }
      
      override public function setData(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         super.setData(param1,param2,param3);
         _loc7_ = 0;
         while(_loc7_ < CityBattleManager.instance.welfareList.length)
         {
            if(CityBattleManager.instance.welfareList[_loc7_].ID == _shopGoodsId)
            {
               _loc4_ = CityBattleManager.instance.welfareList[_loc7_];
            }
            _loc7_++;
         }
         _loc5_ = 0;
         while(_loc5_ < CityBattleManager.instance.myExchangeInfo.length)
         {
            if(CityBattleManager.instance.myExchangeInfo[_loc5_].ID == _shopGoodsId)
            {
               _loc6_ = CityBattleManager.instance.myExchangeInfo[_loc5_];
            }
            _loc5_++;
         }
         _restText.text = String(_loc4_.ExchangeCount - _loc6_.myExchangeCount);
         _number.maximum = _loc4_.ExchangeCount - _loc6_.ExchangeCount;
      }
      
      override protected function __buy(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:int = getNeedMoney();
         if(parseInt(_restText.text) < _number.number)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cityBattle.noEnoughNum"));
            return;
         }
         if(CityBattleManager.instance.myScore < _loc2_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cityBattle.noEnoughScore"));
            return;
         }
         if(type == 3)
         {
            SocketManager.Instance.out.exchangeScore(0,_shopGoodsId,_number.number);
         }
         else
         {
            if(CityBattleManager.instance.now < 8 && CityBattleManager.instance.now > 0)
            {
               SocketManager.Instance.out.exchangeScore(CityBattleManager.instance.now,_shopGoodsId,_number.number);
            }
            SocketManager.Instance.out.exchangeScore(7,_shopGoodsId,_number.number);
         }
         dispose();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_restTitleText);
         _restTitleText = null;
         ObjectUtils.disposeObject(_restText);
         _restText = null;
      }
   }
}
