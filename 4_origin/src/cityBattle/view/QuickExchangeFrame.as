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
         var priceStr:String = String(_number.number * _perPrice);
         var tmp:String = LanguageMgr.GetTranslation("ddt.cityBattle.score");
         totalText.text = priceStr + " " + tmp;
      }
      
      override public function setData(templateId:int, goodsId:int, perPrice:int) : void
      {
         var wel:* = null;
         var i:int = 0;
         var my:* = null;
         var j:int = 0;
         super.setData(templateId,goodsId,perPrice);
         for(i = 0; i < CityBattleManager.instance.welfareList.length; )
         {
            if(CityBattleManager.instance.welfareList[i].ID == _shopGoodsId)
            {
               wel = CityBattleManager.instance.welfareList[i];
            }
            i++;
         }
         for(j = 0; j < CityBattleManager.instance.myExchangeInfo.length; )
         {
            if(CityBattleManager.instance.myExchangeInfo[j].ID == _shopGoodsId)
            {
               my = CityBattleManager.instance.myExchangeInfo[j];
            }
            j++;
         }
         _restText.text = String(wel.ExchangeCount - my.myExchangeCount);
         _number.maximum = wel.ExchangeCount - my.ExchangeCount;
      }
      
      override protected function __buy(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var tmpNeedMoney:int = getNeedMoney();
         if(parseInt(_restText.text) < _number.number)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cityBattle.noEnoughNum"));
            return;
         }
         if(CityBattleManager.instance.myScore < tmpNeedMoney)
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
