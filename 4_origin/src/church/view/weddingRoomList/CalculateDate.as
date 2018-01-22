package church.view.weddingRoomList
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.TimeManager;
   import flash.geom.Point;
   
   public class CalculateDate
   {
       
      
      public function CalculateDate()
      {
         super();
      }
      
      public static function start(param1:Date) : Array
      {
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc4_:Array = [];
         var _loc3_:Point = ComponentFactory.Instance.creatCustomObject("church.view.weddingRoomList.pointout");
         var _loc5_:int = (_loc2_.valueOf() - param1.valueOf()) / 3600000;
         if(PlayerManager.Instance.Self.isFirstDivorce == 0)
         {
            _loc4_[0] = "<font COLOR=\'#FF0000\'>" + LanguageMgr.GetTranslation("church.weddingRoom.frame.firstDivorce.note") + "</font>";
            _loc4_[1] = "<font COLOR=\'#FF0000\'>" + ServerConfigManager.instance.firstDivorcedMoney + "</font>";
         }
         else if(_loc5_ >= 720)
         {
            _loc4_[0] = "<font COLOR=\'#FF0000\'>" + LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.exceedmounth") + "</font>";
            _loc4_[1] = "<font COLOR=\'#FF0000\'>" + ServerConfigManager.instance.firstDivorcedMoney + "</font>";
         }
         else if(_loc5_ >= 24 && _loc5_ < 720)
         {
            _loc4_[0] = "<font COLOR=\'#FF0000\'>" + String(int(_loc5_ / 24)) + LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.day") + "</font>";
            _loc4_[1] = "<font COLOR=\'#FF0000\'>" + PlayerManager.Instance.merryDiscountArr[2] + "</font>";
         }
         else if(_loc5_ < 24)
         {
            _loc4_[0] = LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.notenoughday");
            _loc4_[1] = "<font COLOR=\'#FF0000\'>" + PlayerManager.Instance.merryDiscountArr[2] + "</font>";
         }
         return _loc4_;
      }
      
      public static function needMoney(param1:Date) : int
      {
         var _loc3_:int = 0;
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc4_:int = (_loc2_.valueOf() - param1.valueOf()) / 3600000;
         if(_loc4_ >= 720 || PlayerManager.Instance.Self.isFirstDivorce == 0)
         {
            _loc3_ = ServerConfigManager.instance.firstDivorcedMoney;
         }
         else
         {
            _loc3_ = PlayerManager.Instance.merryDiscountArr[2];
         }
         return _loc3_;
      }
   }
}
