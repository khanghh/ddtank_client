package pet.sprite
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.DisplayUtils;
   import ddt.data.PetExperience;
   import ddt.events.CEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class PetSpriteControl
   {
      
      private static const CHECK_TIME:int = 30000;
      
      private static const ACTION:Array = ["walkA","walkB","standA","bsetC"];
      
      private static var _instance:PetSpriteControl;
       
      
      private var _checkTimer:TimerJuggler;
      
      private var _loopTimer:TimerJuggler;
      
      private var _loopIntervalTime:int = 5000;
      
      private var _queue:Vector.<PetMessage>;
      
      private var _petSprite:PetSprite;
      
      private var _petModel:PetSpriteModel;
      
      private var _isShown:Boolean = false;
      
      public function PetSpriteControl(){super();}
      
      public static function get instance() : PetSpriteControl{return null;}
      
      public function setup() : void{}
      
      private function __dataHandler(param1:CEvent) : void{}
      
      private function checkData() : void{}
      
      private function initHandler() : void{}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      protected function __onCurrentPetChanged(param1:Event) : void{}
      
      private function switchPetSprite(param1:Boolean) : void{}
      
      private function showPetSprite(param1:Boolean = false, param2:Boolean = false) : void{}
      
      private function hidePetSprite(param1:Boolean = false, param2:Boolean = true) : void{}
      
      public function generatePetMovie() : void{}
      
      private function enableChatViewPetSwitcher(param1:Boolean) : void{}
      
      private function __messageLoop(param1:Event) : void{}
      
      protected function __onCheckTimer(param1:Event) : void{}
      
      public function checkHunger() : void{}
      
      public function checkGP() : void{}
      
      private function afterAppear() : void{}
      
      private function removePetSprite() : void{}
      
      private function canShowPetSprite() : Boolean{return false;}
      
      public function showNextMessage() : Boolean{return false;}
      
      public function say(param1:String, param2:Boolean = false, param3:int = -1, param4:String = "born3") : void{}
      
      public function hasMessageInQueue() : Boolean{return false;}
      
      private function checkMessageQueue() : void{}
      
      public function get model() : PetSpriteModel{return null;}
   }
}

class PetMessage
{
    
   
   public var type:int;
   
   public var action:String;
   
   public var msg:String;
   
   public var isAlwaysShow:Boolean;
   
   function PetMessage(param1:int, param2:String, param3:String, param4:Boolean){super();}
}
