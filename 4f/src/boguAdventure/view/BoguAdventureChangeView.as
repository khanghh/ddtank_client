package boguAdventure.view{   import bagAndInfo.cell.CellContentCreator;   import boguAdventure.BoguAdventureControl;   import boguAdventure.player.BoguAdventurePlayer;   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.SceneCharacterEvent;   import ddt.manager.ItemManager;   import ddt.manager.SoundManager;   import ddt.view.sceneCharacter.SceneCharacterDirection;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;   import flash.utils.Dictionary;      public class BoguAdventureChangeView extends Sprite implements Disposeable   {            public static const MINE:String = "mine";            public static const SIGN:String = "sign";                   private var _bogu:BoguAdventurePlayer;            private var _control:BoguAdventureControl;            private var _list:Dictionary;            private var _move:Boolean;            private var _explodeAction:MovieClip;            private var _awardAction:MovieClip;            private var _mineNum:ScaleFrameImage;            private var _awardImgae:CellContentCreator;            private var _boguDie:Bitmap;            public function BoguAdventureChangeView(control:BoguAdventureControl) { super(); }
            private function init() : void { }
            public function boguWalk(path:Array) : void { }
            public function placeGoods(type:String, index:int, indexPos:Point) : void { }
            public function celarGoods(index:int) : void { }
            public function playExplodAciton() : void { }
            public function playAwardAction(templateId:int) : void { }
            public function playWarnAction(value:int, pos:Point) : void { }
            public function update() : void { }
            public function resetBogu(pos:Point) : void { }
            public function clearChangeView() : void { }
            private function __onPlayExplodAcitonComplete(e:Event) : void { }
            private function clearExplodeAction() : void { }
            private function onCreateAwardImageComplete() : void { }
            private function __onPlayAwardAcitonComplete(e:Event) : void { }
            private function clearAwardAction() : void { }
            public function clearWarnAction() : void { }
            public function boguState(value:Boolean) : void { }
            private function __onStopMove(e:SceneCharacterEvent) : void { }
            private function createBogu() : void { }
            private function createBoguComplete(bogu:BoguAdventurePlayer, isLoadSucceed:Boolean, index:int = 0) : void { }
            private function changeShowLevel(index:int) : void { }
            private function swapShowLevel(index1:int, index2:int) : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}