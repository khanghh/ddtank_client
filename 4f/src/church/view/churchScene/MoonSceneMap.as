package church.view.churchScene{   import baglocked.BaglockedManager;   import church.model.ChurchRoomModel;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ClassUtils;   import ddt.events.SceneCharacterEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.scenePathSearcher.SceneScene;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;   import road7th.data.DictionaryData;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class MoonSceneMap extends SceneMap   {            public static const YF_OFSET:int = 230;            public static const FIRE_TEMPLETEID:int = 22001;                   private var _model:ChurchRoomModel;            private var saluteContainer:Sprite;            private var saluteMask:MovieClip;            private var _isSaluteFiring:Boolean;            private var saluteQueue:Array;            private var timer:TimerJuggler;            public function MoonSceneMap(model:ChurchRoomModel, scene:SceneScene, data:DictionaryData, bg:Sprite, mesh:Sprite, acticle:Sprite = null, sky:Sprite = null) { super(null,null,null,null,null,null,null); }
            private function get isSaluteFiring() : Boolean { return false; }
            private function set isSaluteFiring(value:Boolean) : void { }
            override public function setCenter(event:SceneCharacterEvent = null) : void { }
            private function initSaulte() : void { }
            override public function setSalute(id:int) : void { }
            private function saluteFireFrameHandler(e:Event) : void { }
            private function clearnSaluteFire() : void { }
            private function playSaluteSound() : void { }
            private function __timer(event:Event) : void { }
            private function stopSaluteSound() : void { }
            override public function dispose() : void { }
   }}