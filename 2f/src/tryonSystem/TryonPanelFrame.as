package tryonSystem{   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.vo.AlertInfo;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;      public class TryonPanelFrame extends BaseAlerFrame   {                   private var _control:TryonSystemController;            private var _view:TryonPanelView;            public function TryonPanelFrame() { super(); }
            public function set controller(control:TryonSystemController) : void { }
            public function initView() : void { }
            override public function dispose() : void { }
   }}