package draft.view{   import bagAndInfo.BagAndInfoManager;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.DraftManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.RequestVairableCreater;   import draft.DraftControl;   import draft.data.DraftListAnalyzer;   import draft.data.DraftModel;   import flash.display.Bitmap;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.net.URLVariables;   import road7th.comm.PackageIn;      public class DraftView extends Frame implements Disposeable   {                   private var _ticketBg:Bitmap;            private var _mondayBitmap:Bitmap;            private var _freeTicket:FilterFrameText;            private var _competitionBtn:BaseButton;            private var _lastRankBtn:BaseButton;            private var _foreBtn:SimpleBitmapButton;            private var _nextBtn:SimpleBitmapButton;            private var _pageBg:Scale9CornerImage;            private var _pageTxt:FilterFrameText;            private var _currentPage:int = 1;            private var _playerVec:Vector.<DraftPlayer>;            public function DraftView() { super(); }
            private function sendPkg(page:int = 1) : void { }
            private function initView() : void { }
            private function creatPlayer() : void { }
            private function initEvent() : void { }
            protected function __onResponse(event:KeyboardEvent) : void { }
            protected function __onDraftVote(event:PkgEvent) : void { }
            protected function __onLastRankClick(event:MouseEvent) : void { }
            protected function __onForeBtnClick(event:MouseEvent) : void { }
            protected function __onNextBtnClick(event:MouseEvent) : void { }
            private function __onUpdateProperty(event:PlayerPropertyEvent) : void { }
            private function getDraftPlayerData(page:int = 1) : BaseLoader { return null; }
            private function getDraftPlayerInfo(analyzer:DraftListAnalyzer) : void { }
            protected function __onCompetitionClick(event:MouseEvent) : void { }
            override protected function __onCloseClick(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}