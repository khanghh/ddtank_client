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
      
      public function addWonderfulIcon(param1:HallStateView) : void
      {
         _hallView = param1;
         creatWonderfulIcon();
      }
      
      public function creatWonderfulIcon() : void
      {
         var _loc4_:Boolean = true;
         var _loc2_:Dictionary = WonderfulActivityManager.Instance.exchangeActLeftViewInfoDic;
         var _loc3_:String = LanguageMgr.GetTranslation("wonderfulActivityManager.btnTxt16");
         var _loc6_:int = 0;
         var _loc5_:* = _loc2_;
         for each(var _loc1_ in _loc2_)
         {
            if(_loc1_.label != _loc3_)
            {
               _loc4_ = false;
               break;
            }
         }
         if(_loc4_)
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
