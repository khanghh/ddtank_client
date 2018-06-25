package happyLittleGame.bombshellGame.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;   import happyLittleGame.bombshellGame.item.BombRankItemII;   import uiModeManager.bombUI.HappyLittleGameManager;   import uiModeManager.bombUI.model.bomb.BombRankInfo;   import yzhkof.debug.debugTrace;      public class BombGameRandomRank extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _items:Vector.<BombRankItemII>;            private var _pagerightBtn:BaseButton;            private var _pageleftBtn:BaseButton;            private var _pageBg:Scale9CornerImage;            private var _pageTxt:FilterFrameText;            private var _currentarr:Vector.<BombRankInfo>;            private var _totalPageIndex:int = 0;            public function BombGameRandomRank() { super(); }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __pageRClickHandler(evt:MouseEvent) : void { }
            private function __pageLClickHandler(evt:MouseEvent) : void { }
            private function initItem() : void { }
            public function set Infos(infos:Vector.<BombRankInfo>) : void { }
            public function refreshData(rankType:int) : void { }
            public function showDayRankByPage(page:int) : void { }
            public function clearItemInfo() : void { }
            public function dispose() : void { }
   }}