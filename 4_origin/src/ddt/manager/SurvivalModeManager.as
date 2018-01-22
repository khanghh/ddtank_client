package ddt.manager
{
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.utils.getTimer;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class SurvivalModeManager extends CoreManager
   {
      
      public static var SURVIVAL_OPENVIEW:String = "survivalOpenView";
      
      private static var _instance:SurvivalModeManager;
       
      
      private var _last_creat:uint;
      
      private var _showFlag:Boolean;
      
      private var _hall:HallStateView;
      
      private var _survivalModeIcon:BaseButton;
      
      public function SurvivalModeManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get Instance() : SurvivalModeManager
      {
         if(!_instance)
         {
            _instance = new SurvivalModeManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(320),__onOpenIcon);
      }
      
      protected function __onOpenIcon(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _showFlag = _loc2_.readBoolean();
         if(_showFlag)
         {
            showSurvivalModeIcon();
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("survivalMode.open.text"));
         }
         else
         {
            deleteSurvivalModeIcon();
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("survivalMode.open.text"));
         }
      }
      
      private function showSurvivalModeIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("survival",true);
      }
      
      public function deleteSurvivalModeIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("survival",false);
      }
      
      override protected function start() : void
      {
         SoundManager.instance.play("008");
         if(getTimer() - _last_creat >= 2000)
         {
            _last_creat = getTimer();
            dispatchEvent(new Event(SURVIVAL_OPENVIEW));
         }
      }
      
      public function get survivalModeIcon() : BaseButton
      {
         return _survivalModeIcon;
      }
   }
}
