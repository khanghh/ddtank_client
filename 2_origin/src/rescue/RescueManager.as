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
      
      protected function __addRescueBtn(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var flag:Boolean = pkg.readBoolean();
         _isBegin = flag;
         createRescueBtn(_isBegin);
      }
      
      public function createRescueBtn(flag:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("rescue",flag);
      }
      
      public function setupRewardList(analyzer:RescueRewardAnalyzer) : void
      {
         rewardArr = analyzer.list;
      }
      
      public function isSpringShowTop() : Boolean
      {
         var beginDate:Date = ServerConfigManager.instance.yearMonsterBeginDate();
         var endDate:Date = ServerConfigManager.instance.yearMonsterEndDate();
         var now:Date = TimeManager.Instance.Now();
         return now.getTime() >= beginDate.getTime() && now.getTime() <= endDate.getTime();
      }
      
      public function isSpringBegin() : Boolean
      {
         var beginDate:Date = ServerConfigManager.instance.rescueSpringBegin();
         var now:Date = TimeManager.Instance.Now();
         return now.getTime() >= beginDate.getTime();
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
      
      public function set isBegin(value:Boolean) : void
      {
         _isBegin = value;
      }
   }
}
