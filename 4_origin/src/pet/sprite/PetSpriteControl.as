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
      
      private function __dataHandler(event:CEvent) : void
      {
         checkData();
      }
      
      private function checkData() : void
      {
         var pkgs:Array = PetSpriteManager.Instance.pkgs;
         if(pkgs.length <= 0)
         {
            return;
         }
         var event:CEvent = pkgs.shift();
         var _loc3_:* = event.type;
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
                        hidePetSprite(event.data[0],event.data[1]);
                     }
                  }
                  else
                  {
                     showPetSprite(event.data[0],event.data[1]);
                  }
               }
               else
               {
                  switchPetSprite(event.data[0]);
               }
            }
            else
            {
               say(event.data[0],event.data[1],event.data[2],event.data[3]);
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
      
      protected function __onCurrentPetChanged(event:Event) : void
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
      
      private function switchPetSprite(val:Boolean) : void
      {
         if(val && _petSprite.petSpriteLand && canShowPetSprite())
         {
            _petSprite.petSpriteLand.gotoAndPlay(1);
         }
         else if(_petSprite && _petSprite.petSpriteLand)
         {
            _petSprite.petNotMove();
         }
         _petModel.petSwitcher = val;
         if(!PetSpriteManager.Instance.canInitPetSprite())
         {
            return;
         }
         if(val)
         {
            say("");
         }
         else
         {
            hidePetSprite(false,false);
            _queue.length = 0;
         }
      }
      
      private function showPetSprite(immediately:Boolean = false, showAlways:Boolean = false) : void
      {
         if(!canShowPetSprite() || !_petModel.currentPet || !_petSprite || !_petModel.currentPet.assetReady || _isShown)
         {
            if(!_petModel.currentPet)
            {
               PetSpriteManager.Instance.dispatchEvent(new Event("close"));
            }
            return;
         }
         if(!_petModel.petSwitcher && !showAlways)
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
         if(!immediately)
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
      
      private function hidePetSprite(immediately:Boolean = false, canShowNext:Boolean = true) : void
      {
         if(!_petSprite)
         {
            return;
         }
         if(canShowNext && showNextMessage())
         {
            return;
         }
         _loopTimer.stop();
         _petSprite.hideMessageText();
         if(immediately)
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
         var action:String = Helpers.randomPick(ACTION);
         if(action == "walkB")
         {
            say(LanguageMgr.GetTranslation("ddt.pets.pose1"),true,1,action);
            _petSprite.petMove();
         }
         else if(action == "walkA")
         {
            say(LanguageMgr.GetTranslation("ddt.pets.pose2"),true,1,action);
            _petSprite.petMove();
         }
         else if(action == "bsetC")
         {
            _petSprite.petNotMove();
            say("",false,-1,action);
         }
         else
         {
            _petSprite.petNotMove();
            say(LanguageMgr.GetTranslation("ddt.pets.pose3"),true,1,action);
         }
      }
      
      private function enableChatViewPetSwitcher(val:Boolean) : void
      {
         ChatManager.Instance.output.enablePetSpriteSwitcher(val);
      }
      
      private function __messageLoop(evt:Event) : void
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
      
      protected function __onCheckTimer(event:Event) : void
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
         var currentStateType:String = StateManager.currentStateType;
         if(currentStateType == "main" || currentStateType == "roomlist" || currentStateType == "dungeon" || currentStateType == "matchRoom" || currentStateType == "dungeonRoom")
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
         var msg:PetMessage = _queue.pop();
         if(_isShown)
         {
            _petSprite.playAnimation(msg.action);
         }
         else
         {
            showPetSprite(false,msg.isAlwaysShow);
         }
         if(msg.type == 1)
         {
            _petSprite.say(msg.msg);
         }
         else if(msg.type == -1)
         {
            _petSprite.hideMessageText();
         }
         return true;
      }
      
      public function say(message:String, showAlways:Boolean = false, type:int = -1, action:String = "born3") : void
      {
         if(_isShown || !canShowPetSprite())
         {
            if(_petModel.petSwitcher || showAlways)
            {
               _queue.push(new PetMessage(type,action,message,showAlways));
            }
         }
         else
         {
            if(action == "hunger")
            {
               showPetSprite(true,true);
               _petSprite.playAnimation("hunger");
            }
            else
            {
               showPetSprite(type == 1,showAlways);
            }
            if(type == 1)
            {
               _petSprite.say(message);
            }
         }
      }
      
      public function hasMessageInQueue() : Boolean
      {
         return _queue.length > 0;
      }
      
      private function checkMessageQueue() : void
      {
         var msg:* = null;
         if(_isShown || !canShowPetSprite())
         {
            return;
         }
         while(hasMessageInQueue())
         {
            msg = _queue[0];
            if(!msg.isAlwaysShow && !_petModel.petSwitcher)
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
   
   function PetMessage(t:int, ac:String, m:String, always:Boolean)
   {
      super();
      type = t;
      action = ac;
      msg = m;
      isAlwaysShow = always;
   }
}
