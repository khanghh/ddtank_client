package rescue
{
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import flash.events.Event;
   import hallIcon.HallIconManager;
   import rescue.analyzer.RescueRewardAnalyzer;
   import road7th.comm.PackageIn;
   
   public class RescueManager extends CoreManager
   {
      
      public static const RESCUE_OPENVIEW:String = "rescueOpenView";
      
      private static var _instance:RescueManager;
       
      
      private var _isBegin:Boolean;
      
      public var rewardArr:Array;
      
      public function RescueManager()
      {
         super();
      }
      
      public static function get instance() : RescueManager
      {
         if(!_instance)
         {
            _instance = new RescueManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(277,1),__addRescueBtn);
      }
      
      protected function __addRescueBtn(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc3_.readBoolean();
         _isBegin = _loc2_;
         createRescueBtn(_isBegin);
      }
      
      public function createRescueBtn(param1:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("rescue",param1);
      }
      
      public function setupRewardList(param1:RescueRewardAnalyzer) : void
      {
         rewardArr = param1.list;
      }
      
      public function isSpringShowTop() : Boolean
      {
         var _loc3_:Date = ServerConfigManager.instance.yearMonsterBeginDate();
         var _loc2_:Date = ServerConfigManager.instance.yearMonsterEndDate();
         var _loc1_:Date = TimeManager.Instance.Now();
         return _loc1_.getTime() >= _loc3_.getTime() && _loc1_.getTime() <= _loc2_.getTime();
      }
      
      public function isSpringBegin() : Boolean
      {
         var _loc2_:Date = ServerConfigManager.instance.rescueSpringBegin();
         var _loc1_:Date = TimeManager.Instance.Now();
         return _loc1_.getTime() >= _loc2_.getTime();
      }
      
      override protected function start() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 20)
         {
            dispatchEvent(new Event("rescueOpenView"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("rescue.gradeLimit"));
         }
      }
      
      public function get isBegin() : Boolean
      {
         return _isBegin;
      }
      
      public function set isBegin(param1:Boolean) : void
      {
         _isBegin = param1;
      }
   }
}
