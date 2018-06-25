package totem{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CEvent;   import totem.data.TotemUpGradDataVo;   import totem.view.TotemInfoView;   import totem.view.TotemMainView;      public class TotemControl   {            private static var _instance:TotemControl;                   private var _infoView:TotemInfoView;            private var _totemView:TotemMainView;            public function TotemControl() { super(); }
            public static function get instance() : TotemControl { return null; }
            public function setup() : void { }
            public function getGradeByTotemPage(page:int) : int { return 0; }
            public function getUpGradeInfo(page:int, grade:int) : TotemUpGradDataVo { return null; }
            private function __onInfoView(e:CEvent) : void { }
            private function __onTotemView(e:CEvent) : void { }
   }}