package wantstrong.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.PlayerManager;   import flash.display.Sprite;   import wantstrong.data.WantStrongMenuData;      public class WantStrongContentView extends Sprite implements Disposeable   {                   private var _content:VBox;            private var _detail:WantStrongDetail;            private var _scrollPanel:ScrollPanel;            public function WantStrongContentView() { super(); }
            private function initEvent() : void { }
            private function initUI() : void { }
            public function setData(val:* = null) : void { }
            public function dispose() : void { }
   }}