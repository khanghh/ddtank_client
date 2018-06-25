package campbattle.view.rank{   import campbattle.CampBattleControl;   import campbattle.event.MapEvent;   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class ScoreRankView extends Sprite implements Disposeable   {                   private var _backBtn:MovieClip;            private var _rankSprite:Sprite;            private var _rankListBg:MovieClip;            private var _rankBtn:SimpleBitmapButton;            private var _itemList:Vector.<CampRankItem>;            private var _isOut:Boolean;            private var _capList:Array;            public function ScoreRankView() { super(); }
            private function initView() : void { }
            private function addRankItem() : void { }
            private function initEvent() : void { }
            private function __onUpdateScore(event:MapEvent) : void { }
            private function upDateRankList(arr:Array) : void { }
            private function __onRankBtnClick(event:MouseEvent) : void { }
            private function __onClickHander(e:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}