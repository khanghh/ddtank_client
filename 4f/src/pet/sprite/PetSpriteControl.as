package pet.sprite{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.DisplayUtils;   import ddt.data.PetExperience;   import ddt.events.CEvent;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import ddt.utils.Helpers;   import ddt.utils.PositionUtils;   import flash.events.Event;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class PetSpriteControl   {            private static const CHECK_TIME:int = 30000;            private static const ACTION:Array = ["walkA","walkB","standA","bsetC"];            private static var _instance:PetSpriteControl;                   private var _checkTimer:TimerJuggler;            private var _loopTimer:TimerJuggler;            private var _loopIntervalTime:int = 5000;            private var _queue:Vector.<PetMessage>;            private var _petSprite:PetSprite;            private var _petModel:PetSpriteModel;            private var _isShown:Boolean = false;            public function PetSpriteControl() { super(); }
            public static function get instance() : PetSpriteControl { return null; }
            public function setup() : void { }
            private function __dataHandler(event:CEvent) : void { }
            private function checkData() : void { }
            private function initHandler() : void { }
            private function init() : void { }
            private function initEvent() : void { }
            protected function __onCurrentPetChanged(event:Event) : void { }
            private function switchPetSprite(val:Boolean) : void { }
            private function showPetSprite(immediately:Boolean = false, showAlways:Boolean = false) : void { }
            private function hidePetSprite(immediately:Boolean = false, canShowNext:Boolean = true) : void { }
            public function generatePetMovie() : void { }
            private function enableChatViewPetSwitcher(val:Boolean) : void { }
            private function __messageLoop(evt:Event) : void { }
            protected function __onCheckTimer(event:Event) : void { }
            public function checkHunger() : void { }
            public function checkGP() : void { }
            private function afterAppear() : void { }
            private function removePetSprite() : void { }
            private function canShowPetSprite() : Boolean { return false; }
            public function showNextMessage() : Boolean { return false; }
            public function say(message:String, showAlways:Boolean = false, type:int = -1, action:String = "born3") : void { }
            public function hasMessageInQueue() : Boolean { return false; }
            private function checkMessageQueue() : void { }
            public function get model() : PetSpriteModel { return null; }
   }}class PetMessage{          public var type:int;      public var action:String;      public var msg:String;      public var isAlwaysShow:Boolean;      function PetMessage(t:int, ac:String, m:String, always:Boolean) { super(); }
}