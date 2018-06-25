package totem.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerInfo;   import ddt.events.CEvent;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import totem.TotemManager;   import totem.data.TotemChapterTipInfo;      public class TotemItemTabView extends Sprite implements Disposeable   {            public static const CHANGE_CHAPTER:String = "changeChapter";            private static const MAX_ITEM:int = 5;            private static const EFF_OFFSETY:int = 0;            private static const TAB_SPACING:int = 70;            public static const BAG:int = 2;            public static const Search:int = 1;                   private var _chaptersSpri:Sprite;            private var _borEff:Bitmap;            private var _oldPage:int = -1;            private var _chapters:Array;            private var _isSelf:Boolean = false;            private var _playerInfo:PlayerInfo;            private var _fromType:int = -1;            public function TotemItemTabView(playerInfo:PlayerInfo, fromType:*) { super(); }
            protected function initView() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function set curItem(index:int) : void { }
            public function set selectedPage(page:int) : void { }
            public function set curTotemPagePrecess(page:int) : void { }
            private function setBorPos($x:int, $y:int) : void { }
            protected function createChapter(chapterId:int) : void { }
            private function __updateChapterTip(evt:CEvent) : void { }
            public function updateTipsByChapterID(chapterID:int) : void { }
            private function createTipInfo(chapterID:int) : TotemChapterTipInfo { return null; }
            private function getSelfTotemGrade(chapterID:int) : int { return 0; }
            private function getOtherTotemGrade(chapterID:int) : int { return 0; }
            private function __chapterClickHandler(evt:MouseEvent) : void { }
            public function dispose() : void { }
   }}