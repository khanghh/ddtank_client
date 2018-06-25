package boguAdventure.view{   import boguAdventure.BoguAdventureControl;   import boguAdventure.cell.BoguAdventureCell;   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.view.sceneCharacter.SceneCharacterDirection;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.PerspectiveProjection;   import flash.geom.Point;   import flash.geom.Rectangle;      public class BoguAdventureMap extends Sprite implements Disposeable   {            private static const MAP_WIDTH:int = 10;            private static const MAP_HEIGHT:int = 7;                   private var _mapBg:Bitmap;            private var _cellList:Vector.<BoguAdventureCell>;            private var _control:BoguAdventureControl;            public function BoguAdventureMap(control:BoguAdventureControl) { super(); }
            private function init() : void { }
            public function getCellPosIndex(index:int, focusPos:Point) : Point { return null; }
            public function getCellByIndex(index:int) : BoguAdventureCell { return null; }
            public function playFineMineAction(index:int) : void { }
            public function mouseClickClose() : void { }
            public function mouseClickOpen() : void { }
            private function createMapCell() : void { }
            private function __onClickCell(e:MouseEvent) : void { }
            private function boguWalk(index:int) : void { }
            private function __onPlayComplete(e:Event) : void { }
            public function dispose() : void { }
   }}