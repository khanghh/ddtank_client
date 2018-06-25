package exchangeAct
{
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import ddt.CoreManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.utils.Dictionary;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import wonderfulActivity.WonderfulActivityManager;
   
   public class ExchangeActManager extends CoreManager
   {
      
      private static var _instance:ExchangeActManager;
       
      
      private var _wonderfulIcon:SimpleBitmapButton;
      
      private var _hallView:HallStateView;
      
      public function ExchangeActManager()
      {
         super();
      }
      
      public static function get Instance() : ExchangeActManager
      {
         if(!_instance)
         {
            _instance = new ExchangeActManager();
         }
         return _instance;
      }
      
      public function addWonderfulIcon(hallView:HallStateView) : void
      {
         _hallView = hallView;
         creatWonderfulIcon();
      }
      
      public function creatWonderfulIcon() : void
      {
         var hasNoExchangeAct:Boolean = true;
         var exchangeDic:Dictionary = WonderfulActivityManager.Instance.exchangeActLeftViewInfoDic;
         var exchangeTitle:String = LanguageMgr.GetTranslation("wonderfulActivityManager.btnTxt16");
         var _loc6_:int = 0;
         var _loc5_:* = exchangeDic;
         for each(var v in exchangeDic)
         {
            if(v.label != exchangeTitle)
            {
               hasNoExchangeAct = false;
               break;
            }
         }
         if(hasNoExchangeAct)
         {
            return;
         }
         if(PlayerManager.Instance.Self.Grade >= 10)
         {
            HallIconManager.instance.updateSwitchHandler("ExchangeAct",true);
         }
      }
      
      public function onWonderfulClick() : void
      {
         if(_hallView)
         {
            WonderfulActivityManager.Instance.isExchangeAct = true;
            _hallView.showWonderfulView();
         }
      }
      
      public function deleteWonderfulIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("ExchangeAct",false);
      }
   }
}
