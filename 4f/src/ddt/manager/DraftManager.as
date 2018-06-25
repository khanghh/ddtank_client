package ddt.manager{   import com.pickgliss.ui.controls.BaseButton;   import ddt.CoreManager;   import ddt.events.PkgEvent;   import flash.events.Event;   import flash.events.IEventDispatcher;   import flash.events.MouseEvent;   import hall.HallStateView;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class DraftManager extends CoreManager   {            public static const DRAFT_OPENVIEW:String = "DraftOpenView";            private static var _instance:DraftManager;                   public var showDraft:Boolean = false;            private var _draftBtn:BaseButton;            private var _showFlag:Boolean;            private var _hall:HallStateView;            public function DraftManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : DraftManager { return null; }
            public function setup() : void { }
            protected function __onShowIcon(event:PkgEvent) : void { }
            private function showDraftIcon() : void { }
            protected function __onOpenView(event:MouseEvent) : void { }
            override protected function start() : void { }
            public function deleteDraftIcon() : void { }
            public function get draftBtn() : BaseButton { return null; }
   }}