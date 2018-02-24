package game.objects
{
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.PlayerAction;
   import ddt.data.EquipType;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PetSkillManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddt.view.ExpMovie;
   import ddt.view.FaceContainer;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.GameCharacter;
   import ddt.view.character.ICharacter;
   import ddt.view.character.ShowCharacter;
   import ddt.view.chat.ChatData;
   import ddt.view.chat.ChatEvent;
   import ddt.view.chat.chatBall.ChatBallPlayer;
   import ddt.view.common.DailyLeagueLevel;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import game.actions.GhostMoveAction;
   import game.actions.PlayerBeatAction;
   import game.actions.PlayerFallingAction;
   import game.actions.PlayerWalkAction;
   import game.actions.PrepareShootAction;
   import game.actions.SelfSkipAction;
   import game.actions.ShootBombAction;
   import game.actions.SkillActions.ResolveHurtAction;
   import game.actions.SkillActions.RevertAction;
   import game.actions.WeaponShootAction;
   import game.animations.BaseSetCenterAnimation;
   import gameCommon.GameControl;
   import gameCommon.model.FightBuffInfo;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.Player;
   import gameCommon.model.SceneEffectObj;
   import guardCore.GuardCoreManager;
   import guardCore.data.GuardCoreInfo;
   import horse.HorseManager;
   import horse.data.HorseSkillVo;
   import newTitle.NewTitleManager;
   import newTitle.model.NewTitleModel;
   import pet.data.PetSkillTemplateInfo;
   import phy.maps.Map;
   import road7th.DDTAssetManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.StringObject;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   
   public class GamePlayer extends GameTurnedLiving
   {
       
      
      protected var _player:Sprite;
      
      protected var _attackPlayerCite:MovieClip;
      
      private var _levelIcon:LevelIcon;
      
      private var _teamTxt:FilterFrameText;
      
      private var _leagueRank:DailyLeagueLevel;
      
      protected var _consortiaName:FilterFrameText;
      
      private var _facecontainer:FaceContainer;
      
      private var _ballpos:Point;
      
      private var _expView:ExpMovie;
      
      private var _resolveHurtMovie:MovieClipWrapper;
      
      private var _petMovie:GamePetMovie;
      
      private var _currentPetSkill:PetSkillTemplateInfo;
      
      private var _badgeIcon:Bitmap;
      
      private var _newTitle:Bitmap;
      
      private var _ringSkill:MovieClip;
      
      private var _guardCoreEffect:MovieClip;
      
      private var _danderFire:MovieClip;
      
      public var isShootPrepared:Boolean;
      
      public var UsedPetSkill:DictionaryData;
      
      private var _character:ShowCharacter;
      
      private var _body:GameCharacter;
      
      private var _weaponMovie:MovieClip;
      
      private var _currentWeaponMovie:MovieClip;
      
      private var _currentWeaponMovieAction:String = "";
      
      private var _tomb:TombView;
      
      private var _isNeedActRevive:Boolean = false;
      
      private var _reviveTimer:Timer;
      
      private var labelMapping:Dictionary;
      
      public function GamePlayer(param1:Player, param2:ShowCharacter, param3:GameCharacter = null, param4:int = 0)
      {
         UsedPetSkill = new DictionaryData();
         labelMapping = new Dictionary();
         _character = param2;
         _body = param3;
         super(param1);
         initBuff();
         _ballpos = new Point(30,-20);
         if(param1.currentPet)
         {
            _petMovie = new GamePetMovie(param1.currentPet.petInfo,this);
            _petMovie.addEventListener("PlayEffect",__playPlayerEffect);
         }
      }
      
      public function playRingSkill() : void
      {
         var _loc1_:int = player.loveBuffLevel;
         if(_loc1_ > 0 && !SharedManager.Instance.friendshipEffect)
         {
            _ringSkill = ComponentFactory.Instance.creat("asset.game.skill.effect.effect0" + _loc1_);
            PositionUtils.setPos(_ringSkill,"game.view.ringSkillPos");
            addChild(_ringSkill);
         }
      }
      
      public function playGuardCoreEffect() : void
      {
         var _loc1_:* = null;
         if(_info.playerInfo.Grade >= GuardCoreManager.instance.guardCoreMinLevel && !SharedManager.Instance.guardEffect)
         {
            _loc1_ = GuardCoreManager.instance.getGuardCoreInfoByID(_info.playerInfo.guardCoreID);
            if(_loc1_)
            {
               _guardCoreEffect = ComponentFactory.Instance.creat("asset.game.guardCore.effect" + _loc1_.Type);
               PositionUtils.setPos(_guardCoreEffect,"game.view.guardCoreEffectPos");
               addChild(_guardCoreEffect);
            }
         }
      }
      
      public function replacePlayerSource(param1:ShowCharacter, param2:GameCharacter) : void
      {
         _character = param1;
         _body = param2;
      }
      
      protected function __playPlayerEffect(param1:Event) : void
      {
         if(ModuleLoader.hasDefinition(_currentPetSkill.EffectClassLink))
         {
            this.showEffect(_currentPetSkill.EffectClassLink);
         }
      }
      
      public function get facecontainer() : FaceContainer
      {
         return _facecontainer;
      }
      
      public function set facecontainer(param1:FaceContainer) : void
      {
         _facecontainer = param1;
      }
      
      override protected function initView() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         bodyHeight = 55;
         super.initView();
         _player = new Sprite();
         _player.y = -3;
         addChild(_player);
         _nickName.x = -19;
         if(_attestBtn != null)
         {
            _attestBtn.x = _nickName.x + _nickName.width;
         }
         _body.x = 0;
         _body.doAction(getAction("stand"));
         _player.addChild(_body as DisplayObject);
         var _loc3_:* = false;
         _player.mouseEnabled = _loc3_;
         _player.mouseChildren = _loc3_;
         _chatballview = new ChatBallPlayer();
         _attackPlayerCite = ClassUtils.CreatInstance("asset.game.AttackCiteAsset") as MovieClip;
         _attackPlayerCite.y = -75;
         _loc3_ = false;
         _attackPlayerCite.mouseEnabled = _loc3_;
         _attackPlayerCite.mouseChildren = _loc3_;
         if(contains(_attackPlayerCite) && player.isAttacking && !RoomManager.Instance.current.selfRoomPlayer.isViewer)
         {
            _attackPlayerCite.gotoAndStop(_info.team);
            removeChild(_attackPlayerCite);
         }
         _levelIcon = new LevelIcon();
         _levelIcon.setInfo(player.playerInfo.Grade,player.playerInfo.ddtKingGrade,player.playerInfo.Repute,player.playerInfo.WinCount,player.playerInfo.TotalCount,player.playerInfo.FightPower,player.playerInfo.Offer,true);
         _levelIcon.setSize(0);
         _levelIcon.x = -52;
         _levelIcon.y = _bloodStripBg.y - 5;
         addChild(_levelIcon);
         if(PlayerManager.Instance.findPlayer(_character.info.ID).teamID > 0)
         {
            _teamTxt = ComponentFactory.Instance.creatComponentByStylename("TeamSmallIcon");
            _teamTxt.text = "(" + PlayerManager.Instance.findPlayer(_character.info.ID).teamTag + ")";
            addChild(_teamTxt);
         }
         _expView = new ExpMovie();
         addChild(_expView);
         _expView.y = -60;
         _expView.x = -50;
         _loc3_ = 1.5;
         _expView.scaleY = _loc3_;
         _expView.scaleX = _loc3_;
         _facecontainer = new FaceContainer();
         addChild(_facecontainer);
         _facecontainer.y = -100;
         _facecontainer.setNickName(_nickName.text);
         if(_info.playerInfo.pvpBadgeId != 0)
         {
            _loc1_ = ItemManager.Instance.getTemplateById(_info.playerInfo.pvpBadgeId);
            if(_loc1_)
            {
               _badgeIcon = ComponentFactory.Instance.creatBitmap("asset.game.badgeIcon" + _loc1_.TemplateID.toString());
               if(_loc1_.TemplateID == 50501 || _loc1_.TemplateID == 50502 || _loc1_.TemplateID == 50503 || _loc1_.TemplateID == 50504 || _loc1_.TemplateID == 50505)
               {
                  _badgeIcon.x = -40;
                  _badgeIcon.y = -85;
               }
               else
               {
                  _badgeIcon.x = -8;
                  _badgeIcon.y = -73;
               }
               _player.addChild(_badgeIcon);
            }
         }
         if(_body.wing && !_info.playerInfo.wingHide)
         {
            addWing();
         }
         else
         {
            removeWing();
         }
         _propArray = [];
         __dirChanged(null);
         if(player.dander >= 200)
         {
            if(_danderFire == null)
            {
               _danderFire = MovieClip(ClassUtils.CreatInstance("asset.game.danderAsset"));
               _danderFire.x = 3;
               _danderFire.y = _body.y + 5;
               _loc3_ = false;
               _danderFire.mouseEnabled = _loc3_;
               _danderFire.mouseChildren = _loc3_;
            }
            _danderFire.play();
            _player.addChild(_danderFire);
         }
         if(player.playerInfo.honor != "" && (StateManager.currentStateType == "fighting" || StateManager.currentStateType == "dungeonRoom"))
         {
            creatConsortiaName();
         }
         else if(player.playerInfo.honor != "" && (StateManager.currentStateType == "fighting" || StateManager.currentStateType == "dungeonRoom"))
         {
            _loc2_ = NewTitleManager.instance.getTitleByName(player.playerInfo.honor);
            if(_loc2_ && _loc2_.Show != "0" && _loc2_.Pic != "0")
            {
               _newTitle = DDTAssetManager.instance.nativeAsset.getBitmap("image_title_" + _loc2_.Pic);
               if(_newTitle)
               {
                  _newTitle.x = -_newTitle.width / 2;
                  _newTitle.y = _player.y - _player.height - _newTitle.height + 20;
                  addChild(_newTitle);
               }
               _facecontainer && addChild(_facecontainer);
            }
         }
      }
      
      private function creatConsortiaName() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(player.playerInfo.ConsortiaName)
         {
            _consortiaName = ComponentFactory.Instance.creatComponentByStylename("GameLiving.ConsortiaName");
            _consortiaName.text = player.playerInfo.ConsortiaName;
            if(player.playerInfo.ConsortiaID != 0)
            {
               _loc2_ = GameControl.Instance.Current;
               _loc1_ = PlayerManager.Instance.Self;
               if(_loc1_.ConsortiaID == 0 || _loc1_.ConsortiaID == player.playerInfo.ConsortiaID && _loc1_.ZoneID == player.playerInfo.ZoneID || _loc2_ && _loc2_.gameMode == 2)
               {
                  _consortiaName.setFrame(3);
               }
               else
               {
                  _consortiaName.setFrame(2);
               }
            }
            else
            {
               _consortiaName.setFrame(1);
            }
            _consortiaName.x = _nickName.x;
            _consortiaName.y = _nickName.y + _nickName.height / 2 + 5;
            addChild(_consortiaName);
            _facecontainer && addChild(_facecontainer);
         }
      }
      
      public function playPetMovieDebug(param1:String, param2:Point = null) : void
      {
         var _loc3_:Point = param2 || _info.pos;
         _petMovie.show(param2.x,param2.y);
         _petMovie.direction = info.direction;
         _petMovie.doAction(param1);
      }
      
      private function initBuff() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(_info)
         {
            _info.turnBuffs = _info.outTurnBuffs;
            _buffBar.update(_info.turnBuffs);
            if(_info.turnBuffs.length > 0)
            {
               _buffBar.x = 5 - _buffBar.width / 2;
               _buffBar.y = bodyHeight * -1 - 23;
               addChild(_buffBar);
            }
            else if(_buffBar.parent)
            {
               _buffBar.parent.removeChild(_buffBar);
            }
            _loc2_ = 0;
            while(_loc2_ < _info.turnBuffs.length)
            {
               _loc1_ = _info.turnBuffs[_loc2_];
               _loc1_.execute(this.info);
               _loc2_++;
            }
         }
      }
      
      override protected function initListener() : void
      {
         super.initListener();
         player.addEventListener("addState",__addState);
         player.addEventListener("posChanged",__posChanged);
         player.addEventListener("usingItem",__usingItem);
         player.addEventListener("usingSpecialSkill",__usingSpecialKill);
         player.addEventListener("danderChanged",__danderChanged);
         player.addEventListener("playerMoveto",__playerMoveTo);
         player.addEventListener("usePetSkill",__usePetSkill);
         player.addEventListener("petBeat",__petBeat);
         player.addEventListener("horseSkillUse",__useSkillHandler);
         player.addEventListener("playerDoAction",__playerDoAction);
         player.addEventListener("isRedSkullChange",__isRedSkullChanged);
         player.addEventListener("checkCollide",__checkCollide);
         ChatManager.Instance.model.addEventListener("addChat",__getChat);
         ChatManager.Instance.addEventListener("addFace",__getFace);
         _info.addEventListener("boxPick",__boxPickHandler);
      }
      
      protected function __playerDoAction(param1:LivingEvent) : void
      {
         var _loc2_:* = param1.paras[0];
         doAction(_loc2_);
      }
      
      override protected function removeListener() : void
      {
         super.removeListener();
         player.removeEventListener("addState",__addState);
         player.removeEventListener("posChanged",__posChanged);
         player.removeEventListener("usingItem",__usingItem);
         player.removeEventListener("usingSpecialSkill",__usingSpecialKill);
         player.removeEventListener("danderChanged",__danderChanged);
         player.removeEventListener("playerMoveto",__playerMoveTo);
         player.removeEventListener("usePetSkill",__usePetSkill);
         player.removeEventListener("petBeat",__petBeat);
         player.removeEventListener("horseSkillUse",__useSkillHandler);
         player.removeEventListener("playerDoAction",__playerDoAction);
         player.removeEventListener("isRedSkullChange",__isRedSkullChanged);
         player.removeEventListener("checkCollide",__checkCollide);
         if(_weaponMovie)
         {
            _weaponMovie.addEventListener("enterFrame",checkCurrentMovie);
         }
         if(_petMovie)
         {
            _petMovie.removeEventListener("PlayEffect",__playPlayerEffect);
         }
         ChatManager.Instance.model.removeEventListener("addChat",__getChat);
         ChatManager.Instance.removeEventListener("addFace",__getFace);
         _info.removeEventListener("boxPick",__boxPickHandler);
      }
      
      override public function get movie() : Sprite
      {
         return _player;
      }
      
      protected function __boxPickHandler(param1:LivingEvent) : void
      {
         if(PlayerManager.Instance.Self.FightBag.itemNumber > 3)
         {
            ChatManager.Instance.sysChatRed(LanguageMgr.GetTranslation("tank.game.gameplayer.proplist.full"));
         }
      }
      
      override protected function __applySkill(param1:LivingEvent) : void
      {
         var _loc3_:Array = param1.paras;
         var _loc2_:int = _loc3_[0];
         switch(int(_loc2_) - 6)
         {
            case 0:
               applyResolveHurt(_loc3_[1]);
               break;
            case 1:
               applyRevert(_loc3_[1]);
         }
      }
      
      private function applyRevert(param1:PackageIn) : void
      {
         map.animateSet.addAnimation(new BaseSetCenterAnimation(x,y - 150,1,false,2));
         map.act(new RevertAction(map.spellKill(this),player,param1));
      }
      
      private function applyResolveHurt(param1:PackageIn) : void
      {
         map.animateSet.addAnimation(new BaseSetCenterAnimation(x,y - 150,1,false,2));
         map.act(new ResolveHurtAction(map.spellKill(this),player,param1));
      }
      
      protected function __addState(param1:LivingEvent) : void
      {
      }
      
      protected function __useSkillHandler(param1:LivingEvent) : void
      {
         var _loc2_:HorseSkillVo = HorseManager.instance.getHorseSkillInfoById(param1.paras[0]);
         if(_loc2_ && _loc2_.Pic != "-1")
         {
            _propArray.push(_loc2_.Pic);
            doUseItemAnimation();
         }
      }
      
      protected function __usingItem(param1:LivingEvent) : void
      {
         var _loc2_:* = null;
         if(param1.paras[0] is ItemTemplateInfo)
         {
            _loc2_ = param1.paras[0];
            _propArray.push(_loc2_.Pic);
            doUseItemAnimation(EquipType.hasPropAnimation(param1.paras[0]) != null);
         }
         else if(param1.paras[0] is DisplayObject)
         {
            _propArray.push(param1.paras[0]);
            doUseItemAnimation();
         }
      }
      
      protected function __usingSpecialKill(param1:LivingEvent) : void
      {
         _propArray.push("-1");
         doUseItemAnimation();
      }
      
      override protected function doUseItemAnimation(param1:Boolean = false) : void
      {
         var _loc2_:MovieClipWrapper = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.game.ghostPcikPropAsset")),true,true);
         _loc2_.addFrameScriptAt(12,headPropEffect);
         SoundManager.instance.play("039");
         _loc2_.movie.x = 0;
         _loc2_.movie.y = -10;
         if(!param1)
         {
            addChild(_loc2_.movie);
         }
         if(_isLiving)
         {
            doAction(_body.handClipAction);
            body.WingState = 4;
         }
      }
      
      protected function __danderChanged(param1:LivingEvent) : void
      {
         if(player.dander >= 200 && _isLiving)
         {
            if(_danderFire == null)
            {
               _danderFire = MovieClip(ClassUtils.CreatInstance("asset.game.danderAsset"));
               _danderFire.x = 3;
               _danderFire.y = _body.y + 5;
               var _loc2_:Boolean = false;
               _danderFire.mouseEnabled = _loc2_;
               _danderFire.mouseChildren = _loc2_;
            }
            _danderFire.play();
            _player.addChild(_danderFire);
         }
         else if(_danderFire && _danderFire.parent)
         {
            _danderFire.stop();
            _player.removeChild(_danderFire);
         }
      }
      
      override protected function __posChanged(param1:LivingEvent) : void
      {
         pos = player.pos;
         if(_isLiving)
         {
            _player.rotation = calcObjectAngle();
            player.playerAngle = _player.rotation;
         }
         playerMove();
         if(map && map.smallMap)
         {
            map.smallMap.updatePos(smallView,pos);
            map.updateObjectPos(this,pos);
         }
         player.dispatchEvent(new LivingEvent("checkCollide"));
      }
      
      protected function __checkCollide(param1:LivingEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(map)
         {
            _loc4_ = getCollideRect();
            _loc4_.offset(pos.x,pos.y);
            _loc3_ = _map.getSceneEffectPhysicalObject(_loc4_,this) as GameSceneEffect;
            if(_loc3_ && _loc3_.Id == SceneEffectObj.Hide && !_loc3_.isDie)
            {
               player.isFog = true;
            }
            else
            {
               player.isFog = false;
            }
            if(player.isSelf)
            {
               _loc2_ = _map.getSceneEffectPhysicalObject(_loc4_,this) as GameSceneEffect;
               if(_loc2_ && _loc2_.Id == SceneEffectObj.RedDead && !_loc2_.isDie)
               {
                  player.isRedSkull = true;
               }
               else
               {
                  player.isRedSkull = false;
               }
            }
         }
      }
      
      private function __isRedSkullChanged(param1:LivingEvent) : void
      {
         var _loc3_:PackageIn = new PackageIn();
         _loc3_.writeInt(2);
         _loc3_.writeBoolean(player.isRedSkull);
         _loc3_.writeInt(player.playerInfo.ID);
         _loc3_.position = 0;
         var _loc2_:CrazyTankSocketEvent = new CrazyTankSocketEvent("add_animation",_loc3_);
         SocketManager.Instance.dispatchEvent(_loc2_);
      }
      
      public function playerMove() : void
      {
      }
      
      override protected function __dirChanged(param1:LivingEvent) : void
      {
         super.__dirChanged(param1);
         if(!player.isLiving)
         {
            setSoulPos();
         }
      }
      
      override protected function __attackingChanged(param1:LivingEvent) : void
      {
         super.__attackingChanged(param1);
         attackingViewChanged();
      }
      
      protected function attackingViewChanged() : void
      {
         if(player.isAttacking && player.isLiving)
         {
            _attackPlayerCite.gotoAndStop(_info.team);
            addChild(_attackPlayerCite);
         }
         else if(contains(_attackPlayerCite))
         {
            removeChild(_attackPlayerCite);
         }
      }
      
      override protected function __hiddenChanged(param1:LivingEvent) : void
      {
         super.__hiddenChanged(param1);
         if(_info.isHidden)
         {
            if(_chatballview)
            {
               _chatballview.visible = false;
            }
         }
      }
      
      override protected function __say(param1:LivingEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(!_info.isHidden)
         {
            _loc2_ = param1.paras[0];
            _loc3_ = 0;
            if(param1.paras[1])
            {
               _loc3_ = param1.paras[1];
            }
            if(_loc3_ != 9)
            {
               _loc3_ = player.playerInfo.paopaoType;
            }
            say(_loc2_,_loc3_);
         }
      }
      
      override protected function __playDeadEffect(param1:LivingEvent) : void
      {
         event = param1;
         var deadEffect:String = event.paras[1] as String;
         var backFun:Function = event.paras[2] as Function;
         try
         {
            var deadEffectMovie:MovieClip = MovieClip(ClassUtils.CreatInstance(deadEffect));
            var warpper:MovieClipWrapper = new MovieClipWrapper(deadEffectMovie,true,true);
            warpper.addEventListener("complete",function(param1:Event):void
            {
               param1.target.removeEventListener("complete",arguments.callee);
               if(backFun != null)
               {
                  backFun(event.paras[3]);
               }
            });
            warpper.gotoAndPlay(1);
            addChild(warpper.movie);
            return;
         }
         catch(error:Error)
         {
            if(backFun != null)
            {
               backFun(event.paras[3]);
            }
            return;
         }
      }
      
      override protected function __bloodChanged(param1:LivingEvent) : void
      {
         super.__bloodChanged(param1);
         if(param1.paras[0] != 0)
         {
            if(_isLiving)
            {
               if(info.blood / info.maxBlood <= 0.3)
               {
                  _body.useLackHpSuit = true;
               }
               else
               {
                  _body.useLackHpSuit = false;
               }
               _body.doAction(getAction("cry"));
               _body.WingState = 3;
            }
         }
         updateBloodStrip();
      }
      
      override protected function __shoot(param1:LivingEvent) : void
      {
         var _loc2_:Array = param1.paras[0];
         player.currentBomb = _loc2_[0].Template.ID;
         if(GameControl.Instance.Current.togetherShoot && !(this is GameLocalPlayer))
         {
            if(EquipType.isDynamicWeapon(player.playerInfo.WeaponID))
            {
               act(new WeaponShootAction(this));
            }
            act(new PrepareShootAction(this));
            act(new ShootBombAction(this,_loc2_,param1.paras[1],_info.shootInterval));
         }
         else
         {
            if(EquipType.isDynamicWeapon(player.playerInfo.WeaponID))
            {
               map.act(new WeaponShootAction(this));
            }
            map.act(new PrepareShootAction(this));
            map.act(new ShootBombAction(this,_loc2_,param1.paras[1],_info.shootInterval));
         }
      }
      
      protected function shootIntervalDegression() : void
      {
         if(_info.shootInterval == 12)
         {
            _info.shootInterval = 9;
            return;
         }
         if(_info.shootInterval == 9)
         {
            _info.shootInterval = 5;
            return;
         }
      }
      
      override protected function __beat(param1:LivingEvent) : void
      {
         act(new PlayerBeatAction(this));
      }
      
      protected function __usePetSkill(param1:LivingEvent) : void
      {
         var _loc2_:PetSkillTemplateInfo = PetSkillManager.getSkillByID(param1.value);
         if(_loc2_ == null)
         {
            throw new Error("找不到技能，技能ID为：" + param1.value);
         }
         if(_loc2_.isActiveSkill)
         {
            switch(int(_loc2_.BallType))
            {
               case 0:
                  usePetSkill(_loc2_);
                  break;
               case 1:
                  if(GameControl.Instance.Current.selfGamePlayer.team == info.team)
                  {
                     GameControl.Instance.Current.selfGamePlayer.soulPropEnabled = false;
                  }
                  break;
               case 2:
                  if(GameControl.Instance.Current.selfGamePlayer.team == info.team)
                  {
                     GameControl.Instance.Current.selfGamePlayer.soulPropEnabled = false;
                  }
                  usePetSkill(_loc2_,skipSelfTurn);
                  break;
               case 3:
                  usePetSkill(_loc2_);
            }
            UsedPetSkill.add(_loc2_.ID,_loc2_);
            SoundManager.instance.play("039");
         }
      }
      
      private function __petBeat(param1:LivingEvent) : void
      {
         var _loc3_:String = param1.paras[0];
         var _loc2_:Point = param1.paras[1];
         var _loc4_:Array = param1.paras[2];
         playPetMovie(_loc3_,_loc2_,updateHp,[_loc4_]);
      }
      
      private function playPetMovie(param1:String, param2:Point, param3:Function = null, param4:Array = null) : void
      {
         if(!_petMovie)
         {
            return;
         }
         _petMovie.show(param2.x,param2.y);
         _petMovie.direction = info.direction;
         if(param3 == null)
         {
            _petMovie.doAction(param1,hidePetMovie);
         }
         else
         {
            _petMovie.doAction(param1,param3,param4);
         }
      }
      
      public function hidePetMovie() : void
      {
         if(_petMovie)
         {
            _petMovie.hide();
         }
      }
      
      private function updateHp(param1:Array) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for each(var _loc6_ in param1)
         {
            _loc3_ = _loc6_.target;
            _loc2_ = _loc6_.hp;
            _loc5_ = _loc6_.damage;
            _loc4_ = _loc6_.dander;
            _loc3_.updateBlood(_loc2_,_loc6_.type,_loc5_);
            if(_loc3_ is Player)
            {
               Player(_loc3_).dander = _loc4_;
            }
         }
         if(_petMovie)
         {
            _petMovie.hide();
         }
      }
      
      public function usePetSkill(param1:PetSkillTemplateInfo, param2:Function = null) : void
      {
         _currentPetSkill = param1;
         if(_info && _info.isHidden && _info.team != GameControl.Instance.Current.selfGamePlayer.team)
         {
            if(param2 != null)
            {
               param2();
            }
         }
         else
         {
            playPetMovie(param1.Action,_info.pos,param2);
         }
      }
      
      private function skipSelfTurn() : void
      {
         hidePetMovie();
         if(info is LocalPlayer)
         {
            act(new SelfSkipAction(LocalPlayer(info)));
         }
      }
      
      protected function __playerMoveTo(param1:LivingEvent) : void
      {
         playerMoveTo(param1.paras);
      }
      
      override public function playerMoveTo(param1:Array) : void
      {
         var _loc2_:int = param1[0];
         switch(int(_loc2_))
         {
            case 0:
               act(new PlayerWalkAction(this,param1[1],param1[2],getAction("walk"),param1[5]));
               break;
            case 1:
               act(new PlayerFallingAction(this,param1[1],param1[3],false,param1[5]));
               break;
            case 2:
               act(new GhostMoveAction(this,param1[1],param1[4]));
               break;
            case 3:
               act(new PlayerFallingAction(this,param1[1],param1[3],true,param1[5]));
               break;
            case 4:
               act(new PlayerWalkAction(this,param1[1],param1[2],getAction("stand"),param1[5]));
         }
      }
      
      override protected function __fall(param1:LivingEvent) : void
      {
         act(new PlayerFallingAction(this,param1.paras[0],true,false));
      }
      
      override protected function __jump(param1:LivingEvent) : void
      {
      }
      
      private function setSoulPos() : void
      {
         if(_player.scaleX == -1)
         {
            _body.x = -6;
         }
         else
         {
            _body.x = -13;
         }
      }
      
      public function get character() : ShowCharacter
      {
         return _character;
      }
      
      public function get body() : GameCharacter
      {
         return _body;
      }
      
      public function get player() : Player
      {
         return info as Player;
      }
      
      private function addWing() : void
      {
         if(_body.wing == null)
         {
            return;
         }
         _body.setWingPos(_body.weaponX * _body.scaleX,_body.weaponY * _body.scaleY);
         _body.setWingScale(_body.scaleX,_body.scaleY);
         if(_body.leftWing && _body.leftWing.parent != _player)
         {
            _player.addChild(_body.rightWing);
            _player.addChildAt(_body.leftWing,0);
         }
         _body.switchWingVisible(_info.isLiving);
         _body.WingState = 1;
      }
      
      public function checkShowWing() : void
      {
         if(_info)
         {
            if(_body.wing && !_info.playerInfo.wingHide)
            {
               addWing();
            }
            else
            {
               removeWing();
            }
         }
      }
      
      private function removeWing() : void
      {
         if(_body.leftWing && _body.leftWing.parent)
         {
            _body.leftWing.parent.removeChild(_body.leftWing);
         }
         if(_body.rightWing && _body.rightWing.parent)
         {
            _body.rightWing.parent.removeChild(_body.rightWing);
         }
      }
      
      public function get weaponMovie() : MovieClip
      {
         return _weaponMovie;
      }
      
      public function set weaponMovie(param1:MovieClip) : void
      {
         if(param1 != _weaponMovie)
         {
            if(_weaponMovie && _weaponMovie.parent)
            {
               _weaponMovie.removeEventListener("enterFrame",checkCurrentMovie);
               _weaponMovie.parent.removeChild(_weaponMovie);
            }
            _weaponMovie = param1;
            _currentWeaponMovie = null;
            _currentWeaponMovieAction = "";
            if(_weaponMovie)
            {
               _weaponMovie.stop();
               _weaponMovie.addEventListener("enterFrame",checkCurrentMovie);
               _weaponMovie.x = _body.weaponX * _body.scaleX;
               _weaponMovie.y = _body.weaponY * _body.scaleY;
               _weaponMovie.scaleX = _body.scaleX;
               _weaponMovie.scaleY = _body.scaleY;
               _weaponMovie.visible = false;
               _player.addChild(_weaponMovie);
               if(_body.wing && !_info.playerInfo.wingHide)
               {
                  addWing();
               }
               else
               {
                  removeWing();
               }
            }
         }
      }
      
      private function checkCurrentMovie(param1:Event) : void
      {
         if(_weaponMovie == null)
         {
            return;
         }
         _currentWeaponMovie = _weaponMovie.getChildAt(0) as MovieClip;
         if(_currentWeaponMovie && _currentWeaponMovieAction != "")
         {
            _weaponMovie.removeEventListener("enterFrame",checkCurrentMovie);
            setWeaponMoiveActionSyc(_currentWeaponMovieAction);
         }
      }
      
      public function setWeaponMoiveActionSyc(param1:String) : void
      {
         if(_currentWeaponMovie)
         {
            _currentWeaponMovie.gotoAndPlay(param1);
         }
         else
         {
            _currentWeaponMovieAction = param1;
         }
      }
      
      override public function die() : void
      {
         super.die();
         player.isSpecialSkill = false;
         player.skill = -1;
         SoundManager.instance.play("042");
         weaponMovie = null;
         _player.rotation = 0;
         _player.y = 25;
         if(contains(_attackPlayerCite))
         {
            removeChild(_attackPlayerCite);
         }
         if(_newTitle)
         {
            if(contains(_newTitle))
            {
               removeChild(_newTitle);
            }
         }
         var _loc1_:Boolean = false;
         _HPStrip.visible = _loc1_;
         _bloodStripBg.visible = _loc1_;
         _tomb = new TombView();
         _tomb.pos = this.pos;
         if(_map)
         {
            _map.addPhysical(_tomb);
         }
         _tomb.startMoving();
         player.pos = new Point(x,y - 70);
         player.startMoving();
         if(RoomManager.Instance.current && (RoomManager.Instance.current.type == 21 || RoomManager.Instance.current.type == 41 || RoomManager.Instance.current.type == 56))
         {
            _tomb.addEventListener("updatenamepos",__updateNamePos);
            _player.visible = false;
         }
         else
         {
            doAction(GameCharacter.SOUL);
         }
         setSoulPos();
         _nickName.y = _nickName.y + 10;
         if(_attestBtn != null)
         {
            _attestBtn.y = _nickName.y;
         }
         if(_consortiaName)
         {
            _consortiaName.y = _consortiaName.y + 10;
         }
         if(_levelIcon)
         {
            _levelIcon.y = _levelIcon.y + 10;
         }
         if(_teamTxt)
         {
            _teamTxt.y = _teamTxt.y + 10;
         }
         if(_leagueRank)
         {
            _leagueRank.y = _leagueRank.y + 20;
         }
         if(_map)
         {
            _map.setTopPhysical(this);
         }
         if(_danderFire && _danderFire.parent)
         {
            _danderFire.parent.removeChild(_danderFire);
         }
         _danderFire = null;
         if(_petMovie)
         {
            _petMovie.dispose();
            _petMovie = null;
         }
         _isNeedActRevive = false;
      }
      
      protected function __updateNamePos(param1:Event) : void
      {
         this.y = _tomb.y - 30;
      }
      
      override public function revive() : void
      {
         _isNeedActRevive = true;
         var _loc2_:MovieClip = ComponentFactory.Instance.creat("asset.game.skill.reviveMc");
         var _loc1_:MovieClipWrapper = new MovieClipWrapper(_loc2_,true,true);
         _loc1_.addEventListener("complete",reviveCompleteHandler,false,0,true);
         addChild(_loc1_.movie);
         if(!_reviveTimer)
         {
            _reviveTimer = new Timer(2500);
            _reviveTimer.addEventListener("timer",insureActRevive,false,0,true);
         }
         _reviveTimer.start();
      }
      
      private function reviveCompleteHandler(param1:Event) : void
      {
         var _loc2_:* = null;
         if(param1)
         {
            _loc2_ = param1.currentTarget as MovieClipWrapper;
            _loc2_.removeEventListener("complete",reviveCompleteHandler);
         }
         if(!_isNeedActRevive)
         {
            return;
         }
         super.revive();
         if(_tomb)
         {
            _tomb.removeEventListener("updatenamepos",__updateNamePos);
         }
         ObjectUtils.disposeObject(_tomb);
         _tomb = null;
         _player.visible = true;
         doAction(GameCharacter.STAND_LACK_HP);
         if(player.currentPet)
         {
            _petMovie = new GamePetMovie(player.currentPet.petInfo,this);
            _petMovie.addEventListener("PlayEffect",__playPlayerEffect);
         }
         _player.y = -3;
         _nickName.y = _nickName.y - 10;
         if(_attestBtn != null)
         {
            _attestBtn.y = _nickName.y;
         }
         if(_consortiaName)
         {
            _consortiaName.y = _consortiaName.y - 10;
         }
         if(_levelIcon)
         {
            _levelIcon.y = _levelIcon.y - 10;
         }
         if(_teamTxt)
         {
            _teamTxt.y = _teamTxt.y - 10;
         }
         if(_leagueRank)
         {
            _leagueRank.y = _leagueRank.y - 20;
         }
         var _loc3_:Boolean = true;
         _HPStrip.visible = _loc3_;
         _bloodStripBg.visible = _loc3_;
         _isNeedActRevive = false;
      }
      
      private function insureActRevive(param1:TimerEvent) : void
      {
         reviveCompleteHandler(null);
         if(!_isNeedActRevive)
         {
            if(_reviveTimer)
            {
               _reviveTimer.stop();
            }
         }
      }
      
      public function clearDebuff() : void
      {
         var _loc2_:MovieClip = ComponentFactory.Instance.creat("asset.game.skill.clearDebuffMc");
         var _loc1_:MovieClipWrapper = new MovieClipWrapper(_loc2_,true,true);
         addChild(_loc1_.movie);
      }
      
      override protected function __beginNewTurn(param1:LivingEvent) : void
      {
         super.__beginNewTurn(param1);
         UsedPetSkill.clear();
         if(_isLiving)
         {
            _body.useLackHpTurn--;
            if(info.blood / info.maxBlood <= 0.3)
            {
               _body.useLackHpSuit = true;
            }
            else if(_body.useLackHpTurn < 0)
            {
               _body.useLackHpSuit = false;
            }
            else
            {
               _body.useLackHpSuit = true;
            }
            _body.doAction(_body.standAction);
            _body.randomCryType();
         }
         weaponMovie = null;
         player.skill = -1;
         isShootPrepared = false;
         _info.shootInterval = 24;
         if(contains(_attackPlayerCite))
         {
            removeChild(_attackPlayerCite);
         }
      }
      
      private function __getChat(param1:ChatEvent) : void
      {
         if(player.isHidden && player.team != GameControl.Instance.Current.selfGamePlayer.team)
         {
            return;
         }
         var _loc2_:ChatData = ChatData(param1.data).clone();
         _loc2_.msg = Helpers.deCodeString(_loc2_.msg);
         if(_loc2_.channel == 2 || _loc2_.channel == 3)
         {
            return;
         }
         if(_loc2_.zoneID == -1)
         {
            if(_loc2_.senderID == player.playerInfo.ID)
            {
               say(_loc2_.msg,player.playerInfo.paopaoType);
            }
         }
         else if(_loc2_.senderID == player.playerInfo.ID && _loc2_.zoneID == player.playerInfo.ZoneID)
         {
            say(_loc2_.msg,player.playerInfo.paopaoType);
         }
      }
      
      private function say(param1:String, param2:int) : void
      {
         _chatballview.setText(param1,param2);
         addChild(_chatballview);
         fitChatBallPos();
      }
      
      override protected function get popPos() : Point
      {
         if(!_info.isLiving)
         {
            return new Point(18,-20);
         }
         return new Point(18,-40);
      }
      
      override protected function get popDir() : Point
      {
         return null;
      }
      
      private function __getFace(param1:ChatEvent) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(player.isHidden && player.team != GameControl.Instance.Current.selfGamePlayer.team)
         {
            return;
         }
         var _loc3_:Object = param1.data;
         if(_loc3_["playerid"] == player.playerInfo.ID)
         {
            _loc2_ = _loc3_["faceid"];
            _loc4_ = _loc3_["delay"];
            if(_loc2_ >= 49)
            {
               setTimeout(showFace,_loc4_,_loc2_);
            }
            else
            {
               showFace(_loc2_);
               ChatManager.Instance.dispatchEvent(new ChatEvent("setFacecontainerLoction"));
            }
         }
      }
      
      private function showFace(param1:int) : void
      {
         if(_facecontainer == null)
         {
            return;
         }
         _facecontainer.scaleX = 1;
         _facecontainer.setFace(param1);
      }
      
      public function shootPoint() : Point
      {
         var _loc1_:Point = _ballpos;
         _loc1_ = _body.localToGlobal(_loc1_);
         _loc1_ = _map.globalToLocal(_loc1_);
         return _loc1_;
      }
      
      override public function doAction(param1:*) : void
      {
         if(param1 is PlayerAction)
         {
            _body.doAction(param1);
         }
      }
      
      override protected function __buffChanged(param1:LivingEvent) : void
      {
         super.__buffChanged(param1);
      }
      
      override public function dispose() : void
      {
         removeListener();
         super.dispose();
         if(_chatballview)
         {
            _chatballview.dispose();
            _chatballview = null;
         }
         if(_facecontainer)
         {
            _facecontainer.dispose();
            _facecontainer = null;
         }
         if(_teamTxt)
         {
            ObjectUtils.disposeObject(_teamTxt);
            _teamTxt = null;
         }
         if(_petMovie)
         {
            _petMovie.dispose();
         }
         _petMovie = null;
         if(_consortiaName)
         {
            ObjectUtils.disposeObject(_consortiaName);
         }
         _consortiaName = null;
         ObjectUtils.disposeObject(_badgeIcon);
         _badgeIcon = null;
         ObjectUtils.disposeObject(_ringSkill);
         _ringSkill = null;
         ObjectUtils.disposeObject(_guardCoreEffect);
         _guardCoreEffect = null;
         if(_attackPlayerCite)
         {
            if(_attackPlayerCite.parent)
            {
               _attackPlayerCite.parent.removeChild(_attackPlayerCite);
            }
         }
         _attackPlayerCite = null;
         _character = null;
         _body = null;
         if(_weaponMovie)
         {
            _weaponMovie.stop();
            _weaponMovie = null;
         }
         if(_danderFire && _danderFire.parent)
         {
            _danderFire.stop();
            _player.removeChild(_danderFire);
         }
         _danderFire = null;
         if(_levelIcon)
         {
            if(_levelIcon.parent)
            {
               _levelIcon.parent.removeChild(_levelIcon);
            }
            _levelIcon.dispose();
         }
         _levelIcon = null;
         if(_leagueRank)
         {
            ObjectUtils.disposeObject(_leagueRank);
         }
         _leagueRank = null;
         ObjectUtils.disposeObject(_expView);
         _expView = null;
         if(_tomb)
         {
            _tomb.removeEventListener("updatenamepos",__updateNamePos);
         }
         ObjectUtils.disposeObject(_tomb);
         _tomb = null;
         ObjectUtils.disposeObject(_newTitle);
         _newTitle = null;
         if(_reviveTimer)
         {
            _reviveTimer.removeEventListener("timer",insureActRevive);
            _reviveTimer.stop();
         }
         _reviveTimer = null;
      }
      
      override protected function __bombed(param1:LivingEvent) : void
      {
         body.bombed();
      }
      
      override public function setMap(param1:Map) : void
      {
         super.setMap(param1);
         if(param1)
         {
            __posChanged(null);
         }
      }
      
      override public function setProperty(param1:String, param2:String) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:StringObject = new StringObject(param2);
         var _loc5_:* = param1;
         if("GhostGPUp" === _loc5_)
         {
            _loc3_ = _loc4_.getInt();
            _expView.exp = _loc3_;
            _expView.play();
            _body.doAction(GameCharacter.SOUL_SMILE);
         }
         super.setProperty(param1,param2);
      }
      
      public function set gainEXP(param1:int) : void
      {
         _nickName.text = String(param1);
      }
      
      override public function setActionMapping(param1:String, param2:String) : void
      {
         if(param1.length <= 0)
         {
            return;
         }
         labelMapping[param1] = param2;
      }
      
      override public function getAction(param1:String) : *
      {
         if(labelMapping[param1])
         {
            param1 = labelMapping[param1];
         }
         var _loc2_:* = param1;
         if("stand" !== _loc2_)
         {
            if("walk" !== _loc2_)
            {
               if("cry" !== _loc2_)
               {
                  if("soul" !== _loc2_)
                  {
                     return _body.standAction;
                  }
                  return GameCharacter.SOUL;
               }
               return GameCharacter.CRY;
            }
            return _body.walkAction;
         }
         return _body.standAction;
      }
      
      public function playFlagBattleReviveAction() : void
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("asset.game.flagBattle.reviveAction");
         addChild(_loc1_);
         var _loc2_:MovieClipWrapper = new MovieClipWrapper(_loc1_,true,true);
         __danderChanged(null);
      }
      
      public function clone(param1:int = 0) : GamePlayer
      {
         lvingId = param1;
         var tempPlayer:Player = (_info as Player).clone(lvingId);
         var temMovie:ICharacter = tempPlayer.movie as GameCharacter;
         if(temMovie == null)
         {
            temMovie = CharactoryFactory.createCharacter(tempPlayer.playerInfo,"game") as GameCharacter;
            tempPlayer.movie = temMovie as GameCharacter;
         }
         var temChara:ICharacter = tempPlayer.character as ShowCharacter;
         if(temChara == null)
         {
            temChara = CharactoryFactory.createCharacter(info.playerInfo,"show");
            tempPlayer.character = ShowCharacter(character);
         }
         var tempGamePlayer:GamePlayer = new GamePlayer(tempPlayer,tempPlayer.character as ShowCharacter,tempPlayer.movie as GameCharacter);
         (temMovie as GameCharacter).addEventListener("complete",function():*
         {
            var /*UnknownSlot*/:* = function():void
            {
               (temMovie as GameCharacter).removeEventListener("complete",__movieLoaded);
               tempGamePlayer.checkShowWing();
            };
            return function():void
            {
               (temMovie as GameCharacter).removeEventListener("complete",__movieLoaded);
               tempGamePlayer.checkShowWing();
            };
         }());
         temMovie.show();
         ShowCharacter(temChara).show();
         this.__hiddenChanged(null);
         return tempGamePlayer;
      }
   }
}
