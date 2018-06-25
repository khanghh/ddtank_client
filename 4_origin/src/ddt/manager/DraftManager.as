package ddt.manager
{
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class DraftManager extends CoreManager
   {
      
      public static const DRAFT_OPENVIEW:String = "DraftOpenView";
      
      private static var _instance:DraftManager;
       
      
      public var showDraft:Boolean = false;
      
      private var _draftBtn:BaseButton;
      
      private var _showFlag:Boolean;
      
      private var _hall:HallStateView;
      
      public function DraftManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : DraftManager
      {
         if(!_instance)
         {
            _instance = new DraftManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         if(PathManager.girdAttestEnable)
         {
            showDraftIcon();
         }
         else
         {
            deleteDraftIcon();
         }
      }
      
      protected function __onShowIcon(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _showFlag = pkg.readBoolean();
         if(_showFlag)
         {
            showDraftIcon();
         }
         else
         {
            deleteDraftIcon();
         }
      }
      
      private function showDraftIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("draft",true);
      }
      
      protected function __onOpenView(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         show();
      }
      
      override protected function start() : void
      {
         dispatchEvent(new Event("DraftOpenView"));
      }
      
      public function deleteDraftIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("draft",false);
      }
      
      public function get draftBtn() : BaseButton
      {
         return _draftBtn;
      }
   }
}
