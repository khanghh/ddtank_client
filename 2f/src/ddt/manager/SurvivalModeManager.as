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
      
      public function SurvivalModeManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : SurvivalModeManager{return null;}
      
      public function setup() : void{}
      
      protected function __onOpenIcon(param1:PkgEvent) : void{}
      
      private function showSurvivalModeIcon() : void{}
      
      public function deleteSurvivalModeIcon() : void{}
      
      override protected function start() : void{}
      
      public function get survivalModeIcon() : BaseButton{return null;}
   }
}
