package church.view.churchScene{   import church.ChurchManager;   import church.model.ChurchRoomModel;   import church.player.ChurchPlayer;   import church.view.churchFire.ChurchFireEffectPlayer;   import church.vo.FatherBallConfigVO;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.SceneCharacterEvent;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.BitmapUtils;   import ddt.view.sceneCharacter.SceneCharacterDirection;   import ddt.view.scenePathSearcher.SceneScene;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.geom.Point;   import road7th.data.DictionaryData;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class WeddingSceneMap extends SceneMap   {            public static const MOVE_SPEED:Number = 0.055;            public static const MOVE_SPEEDII:Number = 0.15;                   private var _model:ChurchRoomModel;            private var father_read:MovieClip;            private var father_com:MovieClip;            private var bride:ChurchPlayer;            private var groom:ChurchPlayer;            private var guestPos:Array;            private var _fatherPaopaoBg:ScaleFrameImage;            private var _fatherPaopao:ScaleFrameImage;            private var _fatherPaopaoConfig:Array;            private var frame:uint = 1;            private var _brideName:FilterFrameText;            private var _groomName:FilterFrameText;            private var kissMovie:MovieClip;            private var fireTimer:TimerJuggler;            public function WeddingSceneMap(model:ChurchRoomModel, scene:SceneScene, data:DictionaryData, bg:Sprite, mesh:Sprite, acticle:Sprite = null, sky:Sprite = null) { super(null,null,null,null,null,null,null); }
            private function initFather() : void { }
            public function fireImdily(pt:Point, type:uint, playSound:Boolean = false) : void { }
            public function playWeddingMovie() : void { }
            public function stopWeddingMovie() : void { }
            private function __arrive(event:SceneCharacterEvent) : void { }
            public function rangeGuest() : void { }
            private function getGuestPos() : void { }
            private function spliceLine(line:DisplayObject, count:uint, right:Boolean, top:Boolean) : Array { return null; }
            private function playDialogue() : void { }
            private function playerFatherPaopaoFrame() : void { }
            private function readyForKiss() : void { }
            private function ajustPosition() : void { }
            private function hideDialogue() : void { }
            private function playKissMovie() : void { }
            private function stopKissMovie() : void { }
            public function playFireMovie() : void { }
            private function __fireTimer(event:Event) : void { }
            private function getFirePosition() : Point { return null; }
            private function __fireTimerComplete(event:TimerEvent) : void { }
            private function stopFireMovie() : void { }
            override protected function __click(event:MouseEvent) : void { }
            override public function dispose() : void { }
   }}