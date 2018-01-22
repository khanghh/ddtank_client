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
      
      public function PetSpriteControl()
      {
         _queue = new Vector.<PetMessage>();
         super();
      }
      
      public static function get instance() : PetSpriteControl
      {
         if(!_instance)
         {
            _instance = new PetSpriteControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         PetSpriteManager.Instance.addEventListener("pet_update_data",__dataHandler);
         _petModel = new PetSpriteModel();
         checkData();
      }
      
      private function __dataHandler(param1:CEvent) : void
      {
         checkData();
      }
      
      private function checkData() : void
      {
         var _loc2_:Array = PetSpriteManager.Instance.pkgs;
         if(_loc2_.length <= 0)
         {
            return;
         }
         var _loc1_:CEvent = _loc2_.shift();
         var _loc3_:* = _loc1_.type;
         if("pet_init" !== _loc3_)
         {
            if("pet_say" !== _loc3_)
            {
               if("pet_switchPetSprite" !== _loc3_)
               {
                  if("pet_showPetSprite" !== _loc3_)
                  {
                     if("pet_hidePetSprite" === _loc3_)
                     {
                        hidePetSprite(_loc1_.data[0],_loc1_.data[1]);
                     }
                  }
                  else
                  {
                     showPetSprite(_loc1_.data[0],_loc1_.data[1]);
                  }
               }
               else
               {
                  switchPetSprite(_loc1_.data[0]);
               }
            }
            else
            {
               say(_loc1_.data[0],_loc1_.data[1],_loc1_.data[2],_loc1_.data[3]);
            }
         }
         else
         {
            initHandler();
         }
         checkData();
      }
      
      private function initHandler() : void
      {
         init();
         initEvent();
         _checkTimer = TimerManager.getInstance().addTimerJuggler(30000);
         _checkTimer.addEventListener("timer",__onCheckTimer);
         _checkTimer.start();
         ChatManager.Instance.output.openPetSprite(PlayerManager.Instance.Self.pets.length > 0);
         _petModel.petSwitcher = true;
         enableChatViewPetSwitcher(PlayerManager.Instance.Self.currentPet != null);
         _loopTimer = TimerManager.getInstance().addTimerJuggler(_loopIntervalTime);
         _loopTimer.addEventListener("timer",__messageLoop);
         if(PlayerManager.Instance.Self.pets.length > 0 && !PlayerManager.Instance.Self.currentPet)
         {
            SocketManager.Instance.out.sendPetFightUnFight(PlayerManager.Instance.Self.pets[0].Place);
         }
         else if(PlayerManager.Instance.Self.pets.length > 0 && PlayerManager.Instance.Self.currentPet)
         {
            SocketManager.Instance.out.sendPetFightUnFight(PlayerManager.Instance.Self.currentPet.Place);
         }
      }
      
      private function init() : void
      {
         _petSprite = ComponentFactory.Instance.creatCustomObject("petSprite.PetSprite",[_petModel,this]);
      }
      
      private function initEvent() : void
      {
         _petModel.addEventListener("currentPetChanged",__onCurrentPetChanged);
      }
      
      protected function __onCurrentPetChanged(param1:Event) : void
      {
         _petSprite.updatePet();
         if(_petModel.currentPet)
         {
            generatePetMovie();
         }
         else
         {
            _queue.length = 0;
            hidePetSprite(true,false);
            enableChatViewPetSwitcher(false);
         }
         _petSprite.petNotMove();
         checkHunger();
      }
      
      private function switchPetSprite(param1:Boolean) : void
      {
         if(param1 && _petSprite.petSpriteLand && canShowPetSprite())
         {
            _petSprite.petSpriteLand.gotoAndPlay(1);
         }
         else if(_petSprite && _petSprite.petSpriteLand)
         {
            _petSprite.petNotMove();
         }
         _petModel.petSwitcher = param1;
         if(!PetSpriteManager.Instance.canInitPetSprite())
         {
            return;
         }
         if(param1)
         {
            say("");
         }
         else
         {
            hidePetSprite(false,false);
            _queue.length = 0;
         }
      }
      
      private function showPetSprite(param1:Boolean = false, param2:Boolean = false) : void
      {
         if(!canShowPetSprite() || !_petModel.currentPet || !_petSprite || !_petModel.currentPet.assetReady || _isShown)
         {
            if(!_petModel.currentPet)
            {
               PetSpriteManager.Instance.dispatchEvent(new Event("close"));
            }
            return;
         }
         if(!_petModel.petSwitcher && !param2)
         {
            return;
         }
         if(_petModel.currentPet && _petModel.currentPet.Hunger / 10000 < 0.5)
         {
            SocketManager.Instance.out.sendPetFightUnFight(PlayerManager.Instance.Self.currentPet.Place,false);
            PetSpriteManager.Instance.dispatchEvent(new Event("close"));
            return;
         }
         LayerManager.Instance.addToLayer(_petSprite,4,false,0,false);
         LayerManager.Instance.addToLayer(_petSprite.petSpriteLand,4,false,0,false);
         _petSprite.petSpriteLand.gotoAndPlay(0);
         if(_petModel.currentPet.Level < 50)
         {
            PositionUtils.setPos(_petSprite,"petSprite.PetSprite.pet1Pos");
         }
         else
         {
            PositionUtils.setPos(_petSprite,"petSprite.PetSprite.pet2Pos");
         }
         _isShown = true;
         if(!param1)
         {
            enableChatViewPetSwitcher(false);
            _petSprite.playAnimation("bornB",afterAppear);
         }
         else
         {
            _petSprite.playAnimation("walkA");
            enableChatViewPetSwitcher(true);
            _loopTimer.start();
         }
      }
      
      private function hidePetSprite(param1:Boolean = false, param2:Boolean = true) : void
      {
         if(!_petSprite)
         {
            return;
         }
         if(param2 && showNextMessage())
         {
            return;
         }
         _loopTimer.stop();
         _petSprite.hideMessageText();
         if(param1)
         {
            _petSprite.playAnimation("walkA");
            removePetSprite();
         }
         else
         {
            enableChatViewPetSwitcher(false);
            _petSprite.playAnimation("outC",removePetSprite);
         }
      }
      
      public function generatePetMovie() : void
      {
         if(!_petModel.petSwitcher)
         {
            return;
         }
         var _loc1_:String = Helpers.randomPick(ACTION);
         if(_loc1_ == "walkB")
         {
            say(LanguageMgr.GetTranslation("ddt.pets.pose1"),true,1,_loc1_);
            _petSprite.petMove();
         }
         else if(_loc1_ == "walkA")
         {
            say(LanguageMgr.GetTranslation("ddt.pets.pose2"),true,1,_loc1_);
            _petSprite.petMove();
         }
         else if(_loc1_ == "bsetC")
         {
            _petSprite.petNotMove();
            say("",false,-1,_loc1_);
         }
         else
         {
            _petSprite.petNotMove();
            say(LanguageMgr.GetTranslation("ddt.pets.pose3"),true,1,_loc1_);
         }
      }
      
      private function enableChatViewPetSwitcher(param1:Boolean) : void
      {
         ChatManager.Instance.output.enablePetSpriteSwitcher(param1);
      }
      
      private function __messageLoop(param1:Event) : void
      {
         if(!_petModel.petSwitcher && _isShown)
         {
            hidePetSprite(true,false);
            return;
         }
         if(!hasMessageInQueue())
         {
            generatePetMovie();
         }
         showNextMessage();
      }
      
      protected function __onCheckTimer(param1:Event) : void
      {
         checkMessageQueue();
         checkHunger();
         PetSpriteManager.Instance.checkFarmCropRipe();
      }
      
      public function checkHunger() : void
      {
         if(_petModel.currentPet && _petModel.currentPet.Hunger / 10000 < 0.8)
         {
            say(LanguageMgr.GetTranslation("ddt.pets.hungerMsg"),true,1,"hunger");
            _petSprite.petNotMove();
         }
      }
      
      public function checkGP() : void
      {
      }
      
      private function afterAppear() : void
      {
         _loopTimer.reset();
         _loopTimer.start();
         enableChatViewPetSwitcher(true);
      }
      
      private function removePetSprite() : void
      {
         if(_petSprite.petSpriteLand && !_petModel.petSwitcher)
         {
            _petSprite.petSpriteLand.gotoAndPlay("out");
         }
         else if(_petSprite.petSpriteLand)
         {
            DisplayUtils.removeDisplay(_petSprite.petSpriteLand);
         }
         DisplayUtils.removeDisplay(_petSprite);
         _isShown = false;
         if(_petModel.currentPet != null)
         {
            enableChatViewPetSwitcher(true);
         }
      }
      
      private function canShowPetSprite() : Boolean
      {
         var _loc1_:String = StateManager.currentStateType;
         if(_loc1_ == "main" || _loc1_ == "roomlist" || _loc1_ == "dungeon" || _loc1_ == "matchRoom" || _loc1_ == "dungeonRoom")
         {
            enableChatViewPetSwitcher(_petModel.currentPet != null);
            ChatManager.Instance.output.PetSpriteSwitchVisible(true);
            return true;
         }
         ChatManager.Instance.output.PetSpriteSwitchVisible(false);
         return false;
      }
      
      public function showNextMessage() : Boolean
      {
         if(!_petModel.currentPet || !hasMessageInQueue() || !canShowPetSprite())
         {
            return false;
         }
         var _loc1_:PetMessage = _queue.pop();
         if(_isShown)
         {
            _petSprite.playAnimation(_loc1_.action);
         }
         else
         {
            showPetSprite(false,_loc1_.isAlwaysShow);
         }
         if(_loc1_.type == 1)
         {
            _petSprite.say(_loc1_.msg);
         }
         else if(_loc1_.type == -1)
         {
            _petSprite.hideMessageText();
         }
         return true;
      }
      
      public function say(param1:String, param2:Boolean = false, param3:int = -1, param4:String = "born3") : void
      {
         if(_isShown || !canShowPetSprite())
         {
            if(_petModel.petSwitcher || param2)
            {
               _queue.push(new PetMessage(param3,param4,param1,param2));
            }
         }
         else
         {
            if(param4 == "hunger")
            {
               showPetSprite(true,true);
               _petSprite.playAnimation("hunger");
            }
            else
            {
               showPetSprite(param3 == 1,param2);
            }
            if(param3 == 1)
            {
               _petSprite.say(param1);
            }
         }
      }
      
      public function hasMessageInQueue() : Boolean
      {
         return _queue.length > 0;
      }
      
      private function checkMessageQueue() : void
      {
         var _loc1_:* = null;
         if(_isShown || !canShowPetSprite())
         {
            return;
         }
         while(hasMessageInQueue())
         {
            _loc1_ = _queue[0];
            if(!_loc1_.isAlwaysShow && !_petModel.petSwitcher)
            {
               _queue.pop();
               continue;
            }
            showNextMessage();
            break;
         }
      }
      
      public function get model() : PetSpriteModel
      {
         return _petModel;
      }
   }
}

class PetMessage
{
    
   
   public var type:int;
   
   public var action:String;
   
   public var msg:String;
   
   public var isAlwaysShow:Boolean;
   
   function PetMessage(param1:int, param2:String, param3:String, param4:Boolean)
   {
      super();
      type = param1;
      action = param2;
      msg = param3;
      isAlwaysShow = param4;
   }
}
