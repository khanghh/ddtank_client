package totem.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import totem.data.TotemUpGradDataVo;   import totem.mornUI.TotemUpGradeItemViewUI;      public class TotemUpGradeItemView extends TotemUpGradeItemViewUI   {                   private var _info:TotemUpGradDataVo;            private var _name:FilterFrameText;            private var _grade:FilterFrameText;            private var _hBox:HBox;            public function TotemUpGradeItemView() { super(); }
            override protected function initialize() : void { }
            public function update(info:TotemUpGradDataVo) : void { }
            private function updateView() : void { }
            override public function dispose() : void { }
   }}