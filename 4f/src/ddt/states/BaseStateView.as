package ddt.states{   import com.greensock.TweenLite;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.loader.StartupResourceLoader;   import ddt.manager.QQtipsManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.TimerEvent;   import flash.utils.Timer;   import pet.sprite.PetSpriteManager;   import trainer.view.NewHandContainer;      public class BaseStateView extends Sprite   {                   private var _prepared:Boolean;            private var _container:Sprite;            private var _timer:Timer;            private var _size:int = 60;            private var _completed:int = 0;            private var _shapes:Vector.<DisplayObject>;            private var _oldStageWidth:int;            private var index:int;            public function BaseStateView() { super(); }
            public function get prepared() : Boolean { return false; }
            public function check(type:String) : Boolean { return false; }
            public function prepare() : void { }
            public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function playEnterMovie() : void { }
            private function createShapes() : void { }
            private function rebackInitState() : void { }
            private function __tick(evt:TimerEvent) : void { }
            private function shapeTweenComplete() : void { }
            public function addedToStage() : void { }
            public function leaving(next:BaseStateView) : void { }
            public function removedFromStage() : void { }
            public function getView() : DisplayObject { return null; }
            public function getType() : String { return null; }
            public function getBackType() : String { return null; }
            public function goBack() : Boolean { return false; }
            public function fadingComplete() : void { }
            public function dispose() : void { }
            public function refresh() : void { }
   }}