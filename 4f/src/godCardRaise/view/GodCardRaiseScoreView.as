package godCardRaise.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.TimeManager;   import flash.display.Sprite;   import godCardRaise.GodCardRaiseManager;   import godCardRaise.info.GodCardPointRewardListInfo;   import road7th.utils.DateUtils;      public class GodCardRaiseScoreView extends Sprite implements Disposeable   {                   private var _bg:MutipleImage;            private var _timeTxt:FilterFrameText;            private var _contentTxt:FilterFrameText;            private var _msgTxt:FilterFrameText;            private var _scrollPanel:ScrollPanel;            private var _awards:Sprite;            public function GodCardRaiseScoreView() { super(); }
            private function initView() : void { }
            private function getCurrentTimeStr() : String { return null; }
            private function initEvent() : void { }
            private function addAwards() : void { }
            private function updateAwards() : void { }
            public function updateTime() : void { }
            public function updateView() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}