package game.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.QueueLoader;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.loader.LoaderCreate;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.states.BaseStateView;
   import ddt.utils.PositionUtils;
   import ddt.view.character.GameCharacter;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import game.gametrainer.objects.TrainerEquip;
   import game.gametrainer.objects.TrainerWeapon;
   import game.objects.GamePlayer;
   import gameCommon.GameControl;
   import gameCommon.model.Living;
   import road7th.data.DictionaryEvent;
   import road7th.utils.MovieClipWrapper;
   import trainer.TrainStep;
   import trainer.controller.NewHandGuideManager;
   import trainer.controller.NewHandQueue;
   import trainer.data.Step;
   import trainer.view.NewHandContainer;
   
   public class TrainerGameView extends GameView
   {
       
      
      private const eatOffset:int = -10;
      
      private var _player:GamePlayer;
      
      private var _shouldShowTurn:Boolean;
      
      private var _locked:Boolean;
      
      private var _picked:Boolean;
      
      private var _count:int;
      
      private var _dieNum:int;
      
      private var _weapon:TrainerWeapon;
      
      private var _equip:TrainerEquip;
      
      private var bogu:Living;
      
      private var toolForPick:MovieClip;
      
      public function TrainerGameView()
      {
         super();
      }
      
      override public function getType() : String
      {
         if(StartupResourceLoader.firstEnterHall)
         {
            return "trainer2";
         }
         return "trainer1";
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         super.enter(param1,param2);
         ChatManager.Instance.state = 20;
         ChatManager.Instance.view.visible = false;
         ChatManager.Instance.chatDisabled = true;
         setDefaultAngle();
         reset();
         checkUserGuid();
         if(StartupResourceLoader.firstEnterHall)
         {
            if(!SoundManager.instance.audioiiComplete)
            {
               _loc3_ = LoaderCreate.Instance.createAudioIILoader();
               _loc3_.addEventListener("complete",__onAudioIILoadComplete);
               LoadResourceManager.Instance.startLoad(_loc3_);
            }
         }
         else if(!SoundManager.instance.audioAllComplete)
         {
            _loc4_ = new QueueLoader();
            if(!SoundManager.instance.audioComplete)
            {
               _loc4_.addLoader(LoaderCreate.Instance.createAudioILoader());
            }
            if(!SoundManager.instance.audioiiComplete)
            {
               _loc4_.addLoader(LoaderCreate.Instance.createAudioIILoader());
            }
            if(!SoundManager.instance.audioLiteComplete)
            {
               _loc4_.addLoader(LoaderCreate.Instance.createAudioLiteLoader());
            }
            _loc4_.addEventListener("complete",__onAudioLoadComplete);
            _loc4_.start();
         }
      }
      
      private function __onAudioIILoadComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__onAudioLoadComplete);
         if(param1.loader.isSuccess)
         {
            SoundManager.instance.setupAudioResource(["audioii","audiolite"]);
         }
      }
      
      private function __onAudioLoadComplete(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("complete",__onAudioLoadComplete);
         SoundManager.instance.setupAudioResource();
      }
      
      private function reset() : void
      {
         _shouldShowTurn = true;
         _locked = false;
         _picked = false;
         _count = 0;
         _dieNum = 0;
      }
      
      public function showPickWeapon() : void
      {
      }
      
      private function checkUserGuid() : void
      {
         if(NewHandGuideManager.Instance.mapID == 111)
         {
            NewHandQueue.Instance.push(new Step(2,exeMoveUI,preMoveUI));
            NewHandQueue.Instance.push(new Step(3,exeMove,preMove,finMove));
            NewHandQueue.Instance.push(new Step(4,exeSpawn,preSpawn,null,2000));
            NewHandQueue.Instance.push(new Step(5,exeTipOne,preTipOne,finTipOne));
            NewHandQueue.Instance.push(new Step(6,exeEnergyUI,preEnergyUI));
            NewHandQueue.Instance.push(new Step(8,exeBeatLivingRight,preBeatLivingRight,finBeatLivingRight));
            NewHandQueue.Instance.push(new Step(9,exeBeatLivingLeft,preBeatLivingLeft,finBeatLivingLeft,4000));
            NewHandQueue.Instance.push(new Step(10,exePickOne,prePickOne,finPickOne,1500));
         }
         else if(NewHandGuideManager.Instance.mapID == 112)
         {
            NewHandQueue.Instance.push(new Step(20,exeOneGlow,preOneGlow,finOneGlow));
            NewHandQueue.Instance.push(new Step(21,exeAngle,preAngle,finAngle));
            NewHandQueue.Instance.push(new Step(22,exeSmallBogu,preSmallBogu,finSmallBogu));
            NewHandQueue.Instance.push(new Step(23,exeBigBogu,preBigBogu,finBigBogu,4000));
            NewHandQueue.Instance.push(new Step(24,exePickTen,prePickTen,finPickTen,1500));
            NoviceDataManager.instance.saveNoviceData(370,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(NewHandGuideManager.Instance.mapID == 113)
         {
            NewHandQueue.Instance.push(new Step(30,exePickPower,prePickPower,finPickPower,1500));
            NoviceDataManager.instance.saveNoviceData(470,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(NewHandGuideManager.Instance.mapID == 114)
         {
            NewHandQueue.Instance.push(new Step(6,exeEnergyUI,preEnergyUIF));
            setTimeout(finBeatLivingRightF,13000);
            NewHandQueue.Instance.push(new Step(40,exeArrowThree,preArrowThree,finArrowThree));
            NewHandQueue.Instance.push(new Step(41,exeArrowPower,preArrowPower,finArrowPower,4000));
            NewHandQueue.Instance.push(new Step(42,exePickPlane,prePickPlane,finPickPlane,1500));
            NoviceDataManager.instance.saveNoviceData(520,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(NewHandGuideManager.Instance.mapID == 115)
         {
            NewHandQueue.Instance.push(new Step(6,exeEnergyUI,preEnergyUIFF));
            setTimeout(finBeatLivingRightF,16000);
            NewHandQueue.Instance.push(new Step(50,exeBeatJianjiaoBogu,preBeatJianjiaoBogu,finBeatJianjiaoBogu,4000));
            NewHandQueue.Instance.push(new Step(51,exePickTwoTwenty,prePickTwoTwenty,finPickTwoTwenty,1500));
         }
         else if(NewHandGuideManager.Instance.mapID == 116)
         {
            NewHandQueue.Instance.push(new Step(60,exeBeatRobot,preBeatRobot,finBeatRobot,4000));
            NewHandQueue.Instance.push(new Step(61,exePickThreeFourFive,prePickThreeFourFive,finPickThreeFourFive,1500));
         }
         SocketManager.Instance.addEventListener("missionOver",__missionOver);
      }
      
      private function finBeatLivingRightF() : void
      {
         NewHandContainer.Instance.hideMovie("asset.trainer.mcEnergy4");
         NewHandContainer.Instance.hideMovie("asset.trainer.mcEnergy5");
      }
      
      private function preEnergyUIF() : void
      {
         _count = 0;
         NewHandContainer.Instance.showMovie("asset.trainer.mcEnergy4","asset.trainer.mcEnergy4.pos");
         setEnergyVisible(true);
         shouldShowTurn = true;
         skip();
      }
      
      private function preEnergyUIFF() : void
      {
         _count = 0;
         NewHandContainer.Instance.showMovie("asset.trainer.mcEnergy5","asset.trainer.mcEnergy5.pos");
         setEnergyVisible(true);
         shouldShowTurn = true;
         skip();
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         super.leaving(param1);
         NewHandGuideManager.Instance.mapID = 0;
         disposeThis();
      }
      
      private function showAchieve() : void
      {
         var _loc1_:MovieClipWrapper = new MovieClipWrapper(ClassUtils.CreatInstance("game.trainer.achiveAsset"),true,true);
         PositionUtils.setPos(_loc1_.movie,"trainer.posAchieve");
         LayerManager.Instance.addToLayer(_loc1_.movie,2,false);
      }
      
      override protected function __playerChange(param1:CrazyTankSocketEvent) : void
      {
         if(_locked)
         {
            _map.lockFocusAt(PositionUtils.creatPoint("trainer.posLockFocus"));
         }
         if(_shouldShowTurn)
         {
            super.__playerChange(param1);
            _selfMarkBar.enabled = true;
         }
         else
         {
            _selfMarkBar.enabled = false;
         }
         setPropBarClickEnable(true,true);
      }
      
      override protected function __shoot(param1:CrazyTankSocketEvent) : void
      {
         super.__shoot(param1);
         if(_locked)
         {
            _map.releaseFocus();
         }
      }
      
      public function set shouldShowTurn(param1:Boolean) : void
      {
         _shouldShowTurn = param1;
      }
      
      public function skip() : void
      {
         GameInSocketOut.sendGameSkipNext(1);
      }
      
      private function enableSpace(param1:Boolean) : void
      {
         if(param1)
         {
            StageReferance.stage.removeEventListener("keyDown",__keyDownSpace,true);
            StageReferance.stage.removeEventListener("keyDown",__keyDownSpace,false);
         }
         else
         {
            StageReferance.stage.addEventListener("keyDown",__keyDownSpace,true,99);
            StageReferance.stage.addEventListener("keyDown",__keyDownSpace,false,99);
         }
      }
      
      private function enableLeftAndRight(param1:Boolean) : void
      {
         if(param1)
         {
            StageReferance.stage.removeEventListener("keyDown",__keyDownLeftRight,true);
            StageReferance.stage.removeEventListener("keyDown",__keyDownLeftRight,false);
         }
         else
         {
            StageReferance.stage.addEventListener("keyDown",__keyDownLeftRight,true,99);
            StageReferance.stage.addEventListener("keyDown",__keyDownLeftRight,false,99);
         }
      }
      
      private function enableUpAndDown(param1:Boolean) : void
      {
         if(param1)
         {
            StageReferance.stage.removeEventListener("keyDown",__keyDownUpDown,true);
            StageReferance.stage.removeEventListener("keyDown",__keyDownUpDown,false);
         }
         else
         {
            StageReferance.stage.addEventListener("keyDown",__keyDownUpDown,true,99);
            StageReferance.stage.addEventListener("keyDown",__keyDownUpDown,false,99);
         }
      }
      
      private function __keyDownSpace(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 32)
         {
            param1.stopImmediatePropagation();
         }
      }
      
      private function __keyDownLeftRight(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 37 || param1.keyCode == 39 || param1.keyCode == 65 || param1.keyCode == 68)
         {
            param1.stopImmediatePropagation();
         }
      }
      
      private function __keyDownUpDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 38 || param1.keyCode == 40 || param1.keyCode == 87 || param1.keyCode == 83)
         {
            param1.stopImmediatePropagation();
         }
      }
      
      private function preMoveUI() : void
      {
         _selfMarkBar.enabled = false;
         _map.smallMap.allowDrag = false;
         enableSpace(false);
         enableLeftAndRight(false);
         enableUpAndDown(false);
         setBarrierVisible(false);
         setPlayerThumbVisible(false);
         shouldShowTurn = false;
         _player = _players[_gameInfo.selfGamePlayer] as GamePlayer;
         _player.player.isAttacking = true;
         _player.player.maxEnergy = 10000;
         _gameInfo.selfGamePlayer.energy = 10000;
         NewHandContainer.Instance.showMovie("asset.trainer.mcMove");
      }
      
      private function exeMoveUI() : Boolean
      {
         return true;
      }
      
      private function preMove() : void
      {
         _weapon = new TrainerWeapon(100001);
         _weapon.pos = PositionUtils.creatPoint("trainer1.posWeapon");
         _player.map.addPhysical(_weapon);
         enableLeftAndRight(true);
         GameControl.Instance.Current.selfGamePlayer.selfInfo.addEventListener("propertychange",__playerPropChanged,false,-1);
      }
      
      private function exeMove() : Boolean
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_weapon)
         {
            if(_player.pos.x - _weapon.pos.x < 65)
            {
               GameInSocketOut.sendUpdatePlayStep("pickUpWeapon");
               _loc2_ = new MovieClipWrapper(ClassUtils.CreatInstance("asset.game.ghostPcikPropAsset"),true,true);
               _loc2_.addFrameScriptAt(12,headWeaponEffect);
               SoundManager.instance.play("039");
               _loc2_.movie.y = -10;
               _player.addChild(_loc2_.movie);
               _player.doAction(GameCharacter.HANDCLIP);
               _weapon.dispose();
               _weapon = null;
               NewHandContainer.Instance.hideMovie("asset.trainer.leftKeyShineAsset");
               NewHandContainer.Instance.showMovie("asset.trainer.rightKeyShineAsset","trainer.posRightKey");
               _equip = new TrainerEquip(100002);
               _equip.pos = PositionUtils.creatPoint("trainer1.posEquip");
               _player.map.addPhysical(_equip);
            }
         }
         if(_equip)
         {
            if(_player.pos.x - _equip.pos.x > -10)
            {
               GameInSocketOut.sendUpdatePlayStep("pickUpHat");
               _loc1_ = new MovieClipWrapper(ClassUtils.CreatInstance("asset.game.ghostPcikPropAsset"),true,true);
               _loc1_.addFrameScriptAt(12,headEquipEffect);
               SoundManager.instance.play("039");
               _loc1_.movie.y = -10;
               _player.addChild(_loc1_.movie);
               _player.doAction(GameCharacter.HANDCLIP);
               _equip.dispose();
               _equip = null;
               enableLeftAndRight(false);
            }
         }
         if(!_weapon && !_equip)
         {
            _count = Number(_count) + 1;
         }
         return !_weapon && !_equip && _count >= 55;
      }
      
      private function __playerPropChanged(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["WeaponID"])
         {
            setDefaultAngle();
         }
      }
      
      private function setDefaultAngle() : void
      {
         GameControl.Instance.Current.selfGamePlayer.manuallySetGunAngle(35);
      }
      
      private function headWeaponEffect() : void
      {
         headEffect(ComponentFactory.Instance.creatBitmap("asset.trainer.TrainerWeaponIcon"));
      }
      
      private function headEquipEffect() : void
      {
         var _loc1_:String = !!PlayerManager.Instance.Self.Sex?"asset.trainer.TrainerManEquipIcon":"asset.trainer.TrainerWomanEquipIcon";
         headEffect(ComponentFactory.Instance.creatBitmap(_loc1_));
      }
      
      private function headEffect(param1:DisplayObject) : void
      {
         var _loc2_:AutoPropEffect = new AutoPropEffect(param1);
         PositionUtils.setPos(_loc2_,"trainer1.posHeadEffect");
         param1.width = 62;
         param1.height = 62;
         _player.addChild(_loc2_);
      }
      
      private function finMove() : void
      {
         GameControl.Instance.Current.selfGamePlayer.selfInfo.removeEventListener("propertychange",__playerPropChanged,false);
         NewHandContainer.Instance.hideMovie("asset.trainer.rightKeyShineAsset");
         NewHandContainer.Instance.hideMovie("asset.trainer.mcMove");
         showAchieve();
         setPlayerThumbVisible(true);
         SoundManager.instance.play("018");
      }
      
      private function preSpawn() : void
      {
         _count = 0;
         _gameInfo.livings.addEventListener("add",__addBogu);
         GameInSocketOut.sendUpdatePlayStep("createRightBogu");
      }
      
      private function exeSpawn() : Boolean
      {
         if(bogu)
         {
            _count = Number(_count) + 1;
         }
         return bogu && _count >= 50;
      }
      
      private function preTipOne() : void
      {
         _count = 0;
         NewHandContainer.Instance.showMovie("asset.trainer.mcBeatBoguAsset");
      }
      
      private function exeTipOne() : Boolean
      {
         _count = Number(_count) + 1;
         return _count >= 106;
      }
      
      private function finTipOne() : void
      {
         NewHandContainer.Instance.hideMovie("asset.trainer.mcBeatBoguAsset");
      }
      
      private function preEnergyUI() : void
      {
         _count = 0;
         NewHandContainer.Instance.showMovie("asset.trainer.mcEnergy");
         setEnergyVisible(true);
         shouldShowTurn = true;
         skip();
      }
      
      private function exeEnergyUI() : Boolean
      {
         _count = Number(_count) + 1;
         return _count >= 25;
      }
      
      private function preBeatLivingRight() : void
      {
         enableSpace(true);
      }
      
      private function exeBeatLivingRight() : Boolean
      {
         if(bogu && !bogu.isLiving)
         {
            enableLeftAndRight(true);
            return true;
         }
         return false;
      }
      
      private function finBeatLivingRight() : void
      {
         NewHandContainer.Instance.hideMovie("asset.trainer.mcEnergy");
         showAchieve();
         shouldShowTurn = false;
         skip();
         SoundManager.instance.play("018");
         disposeBogu();
      }
      
      private function preBeatLivingLeft() : void
      {
         _count = 0;
         enableSpace(false);
         lockMap();
         _gameInfo.livings.addEventListener("add",__addBogu);
         GameInSocketOut.sendUpdatePlayStep("createLeftBogu");
      }
      
      private function exeBeatLivingLeft() : Boolean
      {
         if(bogu)
         {
            _count = Number(_count) + 1;
         }
         if(_count == 50)
         {
            NewHandContainer.Instance.showMovie("asset.trainer.mcBigEnergyAsset");
         }
         else if(_count == 100)
         {
            shouldShowTurn = true;
            skip();
            enableSpace(true);
         }
         return bogu && !bogu.isLiving;
      }
      
      private function finBeatLivingLeft() : void
      {
         SocketManager.Instance.removeEventListener("missionOver",__missionOver);
         NewHandContainer.Instance.hideMovie("asset.trainer.mcBigEnergyAsset");
         _map.releaseFocus();
      }
      
      private function prePickOne() : void
      {
         showAchieve();
         creatToolForPick("asset.trainer.pickOneAsset");
      }
      
      private function exePickOne() : Boolean
      {
         return _picked;
      }
      
      private function finPickOne() : void
      {
         disposeToolForPick();
         SocketManager.Instance.out.syncWeakStep(2);
         disposeBogu();
      }
      
      private function __addBogu(param1:DictionaryEvent) : void
      {
         bogu = param1.data as Living;
      }
      
      private function disposeBogu() : void
      {
         _gameInfo.livings.removeEventListener("add",__addBogu);
         bogu = null;
      }
      
      private function lockMap() : void
      {
         _map.lockFocusAt(PositionUtils.creatPoint("trainer.posLockFocus"));
         _locked = true;
      }
      
      private function preOneGlow() : void
      {
         _count = 0;
         enableUpAndDown(true);
         NewHandContainer.Instance.showMovie("asset.trainer.getOne");
      }
      
      private function exeOneGlow() : Boolean
      {
         _count = Number(_count) + 1;
         return _count >= 93;
      }
      
      private function finOneGlow() : void
      {
         NewHandContainer.Instance.hideMovie("asset.trainer.getOne");
      }
      
      private function preAngle() : void
      {
         NewHandContainer.Instance.showMovie("asset.trainer.mcAngle");
      }
      
      private function exeAngle() : Boolean
      {
         return true;
      }
      
      private function finAngle() : void
      {
      }
      
      private function preSmallBogu() : void
      {
         _gameInfo.livings.addEventListener("add",__addBogu);
         GameInSocketOut.sendUpdatePlayStep("createsmallbogu");
      }
      
      private function exeSmallBogu() : Boolean
      {
         return bogu && !bogu.isLiving;
      }
      
      private function finSmallBogu() : void
      {
         disposeBogu();
         shouldShowTurn = false;
         skip();
      }
      
      private function preBigBogu() : void
      {
         NoviceDataManager.instance.saveNoviceData(420,PathManager.userName(),PathManager.solveRequestPath());
         _gameInfo.livings.addEventListener("add",__addBogu);
         _gameInfo.selfGamePlayer.addEventListener("attackingChanged",__showArrow);
         GameInSocketOut.sendUpdatePlayStep("createbigbogu");
      }
      
      private function showTurn() : void
      {
         shouldShowTurn = true;
         skip();
      }
      
      private function exeBigBogu() : Boolean
      {
         return bogu && !bogu.isLiving;
      }
      
      private function finBigBogu() : void
      {
         SocketManager.Instance.removeEventListener("missionOver",__missionOver);
         _gameInfo.selfGamePlayer.removeEventListener("attackingChanged",__showArrow);
         NewHandContainer.Instance.hideMovie("asset.trainer.mcAngle");
      }
      
      private function prePickTen() : void
      {
         creatToolForPick("asset.trainer.pickTenAsset");
      }
      
      private function exePickTen() : Boolean
      {
         return _picked;
      }
      
      private function finPickTen() : void
      {
         disposeToolForPick();
         disposeBogu();
         SocketManager.Instance.out.syncWeakStep(5);
      }
      
      private function prePickPower() : void
      {
         _gameInfo.livings.addEventListener("add",__onAddLiving);
      }
      
      private function __onAddLiving(param1:DictionaryEvent) : void
      {
         _gameInfo.livings.removeEventListener("add",__onAddLiving);
         bogu = param1.data as Living;
         bogu.addEventListener("die",__onLivingDie);
      }
      
      private function __onLivingDie(param1:LivingEvent) : void
      {
         TrainStep.send(TrainStep.Step.GET_POW);
         SocketManager.Instance.removeEventListener("missionOver",__missionOver);
         bogu.removeEventListener("die",__onLivingDie);
      }
      
      private function exePickPower() : Boolean
      {
         return _picked;
      }
      
      private function finPickPower() : void
      {
         bogu = null;
         disposeToolForPick();
         SocketManager.Instance.out.syncWeakStep(10);
         SocketManager.Instance.out.syncWeakStep(12);
      }
      
      private function preArrowThree() : void
      {
         _gameInfo.livings.addEventListener("add",__add);
         _gameInfo.selfGamePlayer.addEventListener("attackingChanged",__showThreeArrow);
      }
      
      private function __add(param1:DictionaryEvent) : void
      {
         var _loc2_:Living = param1.data as Living;
         if(_loc2_.typeLiving == 5)
         {
            bogu = _loc2_;
         }
         else
         {
            _loc2_.addEventListener("die",__die);
         }
      }
      
      private function __die(param1:LivingEvent) : void
      {
         (param1.currentTarget as EventDispatcher).removeEventListener("die",__die);
         _dieNum = Number(_dieNum) + 1;
      }
      
      private function exeArrowThree() : Boolean
      {
         return _dieNum >= 5;
      }
      
      private function finArrowThree() : void
      {
         _gameInfo.selfGamePlayer.removeEventListener("attackingChanged",__showThreeArrow);
      }
      
      private function preArrowPower() : void
      {
         _gameInfo.selfGamePlayer.addEventListener("attackingChanged",__showPowerArrow);
         _gameInfo.selfGamePlayer.addEventListener("danderChanged",__showPowerArrow);
      }
      
      private function exeArrowPower() : Boolean
      {
         return bogu && !bogu.isLiving;
      }
      
      private function finArrowPower() : void
      {
         SocketManager.Instance.removeEventListener("missionOver",__missionOver);
         _gameInfo.livings.removeEventListener("add",__add);
         _gameInfo.selfGamePlayer.removeEventListener("attackingChanged",__showPowerArrow);
         _gameInfo.selfGamePlayer.removeEventListener("danderChanged",__showPowerArrow);
      }
      
      private function prePickPlane() : void
      {
         creatToolForPick("asset.trainer.pickPlaneAsset");
      }
      
      private function exePickPlane() : Boolean
      {
         return _picked;
      }
      
      private function finPickPlane() : void
      {
         NoviceDataManager.instance.saveNoviceData(620,PathManager.userName(),PathManager.solveRequestPath());
         TrainStep.send(TrainStep.Step.COLLECT_PLANE);
         bogu = null;
         disposeToolForPick();
         SocketManager.Instance.out.syncWeakStep(11);
      }
      
      private function __showThreeArrow(param1:LivingEvent) : void
      {
         if(_gameInfo.selfGamePlayer.isAttacking)
         {
            NewHandContainer.Instance.showArrow(21,-90,"trainer.posTipThree");
         }
         else
         {
            NewHandContainer.Instance.clearArrowByID(-1);
         }
      }
      
      private function __showPowerArrow(param1:LivingEvent) : void
      {
         if(_gameInfo.selfGamePlayer.isAttacking)
         {
            if(_gameInfo.selfGamePlayer.dander >= 200)
            {
               NewHandContainer.Instance.showArrow(18,-30,"trainer.posTipPower");
            }
         }
         else
         {
            NewHandContainer.Instance.clearArrowByID(-1);
         }
      }
      
      private function __showArrow(param1:LivingEvent) : void
      {
         if(_gameInfo.selfGamePlayer.isAttacking)
         {
            NewHandContainer.Instance.showArrow(20,-90,"trainer.posTipOne");
         }
         else
         {
            NewHandContainer.Instance.clearArrowByID(-1);
         }
      }
      
      private function preBeatJianjiaoBogu() : void
      {
         _gameInfo.livings.addEventListener("add",__addJianjiaoBogu);
      }
      
      private function __addJianjiaoBogu(param1:DictionaryEvent) : void
      {
         var _loc2_:Living = param1.data as Living;
         if(_loc2_.typeLiving == 5)
         {
            _gameInfo.livings.removeEventListener("add",__addJianjiaoBogu);
            bogu = _loc2_;
         }
      }
      
      private function exeBeatJianjiaoBogu() : Boolean
      {
         return bogu && !bogu.isLiving;
      }
      
      private function finBeatJianjiaoBogu() : void
      {
         SocketManager.Instance.removeEventListener("missionOver",__missionOver);
      }
      
      private function prePickTwoTwenty() : void
      {
         creatToolForPick("asset.trainer.pickTwoTwentyAsset");
      }
      
      private function exePickTwoTwenty() : Boolean
      {
         return _picked;
      }
      
      private function finPickTwoTwenty() : void
      {
         TrainStep.send(TrainStep.Step.GET_ADD_HARMTWO);
         NoviceDataManager.instance.saveNoviceData(780,PathManager.userName(),PathManager.solveRequestPath());
         bogu = null;
         disposeToolForPick();
         SocketManager.Instance.out.syncWeakStep(51);
         SocketManager.Instance.out.syncWeakStep(52);
      }
      
      private function preBeatRobot() : void
      {
         _gameInfo.livings.addEventListener("add",__addRobot);
      }
      
      private function __addRobot(param1:DictionaryEvent) : void
      {
         var _loc2_:Living = param1.data as Living;
         if(_loc2_.typeLiving == 5)
         {
            _gameInfo.livings.removeEventListener("add",__addRobot);
            bogu = _loc2_;
         }
      }
      
      private function exeBeatRobot() : Boolean
      {
         return bogu && !bogu.isLiving;
      }
      
      private function finBeatRobot() : void
      {
         SocketManager.Instance.removeEventListener("missionOver",__missionOver);
      }
      
      private function prePickThreeFourFive() : void
      {
         creatToolForPick("asset.trainer.pickThreeFourFiveAsset");
      }
      
      private function exePickThreeFourFive() : Boolean
      {
         return _picked;
      }
      
      private function finPickThreeFourFive() : void
      {
         NoviceDataManager.instance.saveNoviceData(960,PathManager.userName(),PathManager.solveRequestPath());
         bogu = null;
         disposeToolForPick();
         SocketManager.Instance.out.syncWeakStep(55);
         SocketManager.Instance.out.syncWeakStep(56);
         SocketManager.Instance.out.syncWeakStep(57);
      }
      
      private function __missionOver(param1:CrazyTankSocketEvent) : void
      {
         SocketManager.Instance.removeEventListener("missionOver",__missionOver);
         NewHandQueue.Instance.dispose();
         NewHandContainer.Instance.hideMovie("-1");
         NewHandContainer.Instance.clearArrowByID(-1);
      }
      
      private function exeBeatBogu() : Boolean
      {
         return bogu && !bogu.isLiving;
      }
      
      private function creatToolForPick(param1:String) : void
      {
         var _loc2_:Point = _map.localToGlobal(new Point(bogu.pos.x,bogu.pos.y));
         toolForPick = ClassUtils.CreatInstance(param1) as MovieClip;
         toolForPick.buttonMode = true;
         toolForPick.addEventListener("click",__pickTool);
         toolForPick.x = _loc2_.x;
         toolForPick.y = _loc2_.y;
         toolForPick.addEventListener("mouseOver",__overHandler);
         toolForPick.addEventListener("mouseOut",__outHandler);
         LayerManager.Instance.addToLayer(toolForPick,3,false,1);
         SoundManager.instance.play("156");
      }
      
      private function disposeToolForPick() : void
      {
         ObjectUtils.disposeObject(toolForPick);
         toolForPick.removeEventListener("click",__pickTool);
         toolForPick.removeEventListener("mouseOver",__overHandler);
         toolForPick.removeEventListener("mouseOut",__outHandler);
         toolForPick = null;
         _picked = false;
         TweenLite.to(this,2,{"onComplete":toolFlyAway});
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         toolForPick.filters = null;
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         toolForPick.filters = [new GlowFilter(16737792,1,30,30,2)];
      }
      
      private function __pickTool(param1:MouseEvent) : void
      {
         TweenLite.killTweensOf(this);
         toolFlyAway();
      }
      
      private function toolFlyAway() : void
      {
         if(toolForPick != null)
         {
            toolForPick.removeEventListener("click",__pickTool);
         }
         _picked = true;
         SoundManager.instance.play("008");
         SoundManager.instance.play("157");
      }
      
      private function disposeThis() : void
      {
         enableLeftAndRight(true);
         enableUpAndDown(true);
         enableSpace(true);
         _player = null;
         bogu = null;
         if(_weapon)
         {
            _weapon.dispose();
            _weapon = null;
         }
         if(_equip)
         {
            _equip.dispose();
            _equip = null;
         }
      }
   }
}
