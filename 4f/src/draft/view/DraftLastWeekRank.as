package draft.view{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.utils.RequestVairableCreater;   import draft.data.DraftListAnalyzer;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.net.URLVariables;      public class DraftLastWeekRank extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _closeBtn:BaseButton;            private var _playerVec:Vector.<DraftPlayer>;            public function DraftLastWeekRank() { super(); }
            private function initData() : void { }
            private function getDraftPlayerInfo(analyzer:DraftListAnalyzer) : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            protected function __onResponse(event:KeyboardEvent) : void { }
            protected function __onCloseClick(event:MouseEvent) : void { }
            private function deletePlayer() : void { }
            public function dispose() : void { }
            private function removeEvent() : void { }
   }}