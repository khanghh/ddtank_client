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
      
      public function GamePlayer(player:Player, character:ShowCharacter, movie:GameCharacter = null, templeId:int = 0)
      {
         UsedPetSkill = new DictionaryData();
         labelMapping = new Dictionary();
         _character = character;
         _body = movie;
         super(player);
         initBuff();
         _ballpos = new Point(30,-20);
         if(player.currentPet)
         {
            _petMovie = new GamePetMovie(player.currentPet.petInfo,this);
            _petMovie.addEventListener("PlayEffect",__playPlayerEffect);
         }
      }
      
      public function playRingSkill() : void
      {
         var id:int = player.loveBuffLevel;
         if(id > 0 && !SharedManager.Instance.friendshipEffect)
         {
            _ringSkill = ComponentFactory.Instance.creat("asset.game.skill.effect.effect0" + id);
            PositionUtils.setPos(_ringSkill,"game.view.ringSkillPos");
            addChild(_ringSkill);
         }
      }
      
      public function playGuardCoreEffect() : void
      {
         var guardCoreInfo:* = null;
         if(_info.playerInfo.Grade >= GuardCoreManager.instance.guardCoreMinLevel && !SharedManager.Instance.guardEffect)
         {
            guardCoreInfo = GuardCoreManager.instance.getGuardCoreInfoByID(_info.playerInfo.guardCoreID);
            if(guardCoreInfo)
            {
               _guardCoreEffect = ComponentFactory.Instance.creat("asset.game.guardCore.effect" + guardCoreInfo.Type);
               PositionUtils.setPos(_guardCoreEffect,"game.view.guardCoreEffectPos");
               addChild(_guardCoreEffect);
            }
         }
      }
      
      public function replacePlayerSource(character:ShowCharacter, movie:GameCharacter) : void
      {
         _character = character;
         _body = movie;
      }
      
      protected function __playPlayerEffect(event:Event) : void
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
      
      public function set facecontainer(value:FaceContainer) : void
      {
         _facecontainer = value;
      }
      
      override protected function initView() : void
      {
         var tmpItemInfo:* = null;
         var titleModel:* = null;
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
            tmpItemInfo = ItemManager.Instance.getTemplateById(_info.playerInfo.pvpBadgeId);
            if(tmpItemInfo)
            {
               _badgeIcon = ComponentFactory.Instance.creatBitmap("asset.game.badgeIcon" + tmpItemInfo.TemplateID.toString());
               if(tmpItemInfo.TemplateID == 50501 || tmpItemInfo.TemplateID == 50502 || tmpItemInfo.TemplateID == 50503 || tmpItemInfo.TemplateID == 50504 || tmpItemInfo.TemplateID == 50505)
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
            titleModel = NewTitleManager.instance.getTitleByName(player.playerInfo.honor);
            if(titleModel && titleModel.Show != "0" && titleModel.Pic != "0")
            {
               _newTitle = DDTAssetManager.instance.nativeAsset.getBitmap("image_title_" + titleModel.Pic);
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
         var gameInfo:* = null;
         var self:* = null;
         if(player.playerInfo.ConsortiaName)
         {
            _consortiaName = ComponentFactory.Instance.creatComponentByStylename("GameLiving.ConsortiaName");
            _consortiaName.text = player.playerInfo.ConsortiaName;
            if(player.playerInfo.ConsortiaID != 0)
            {
               gameInfo = GameControl.Instance.Current;
               self = PlayerManager.Instance.Self;
               if(self.ConsortiaID == 0 || self.ConsortiaID == player.playerInfo.ConsortiaID && self.ZoneID == player.playerInfo.ZoneID || gameInfo && gameInfo.gameMode == 2)
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
      
      public function playPetMovieDebug(actName:String, pt:Point = null) : void
      {
         var p:Point = pt || _info.pos;
         _petMovie.show(pt.x,pt.y);
         _petMovie.direction = info.direction;
         _petMovie.doAction(actName);
      }
      
      private function initBuff() : void
      {
         var i:int = 0;
         var buff:* = null;
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
            i = 0;
            while(i < _info.turnBuffs.length)
            {
               buff = _info.turnBuffs[i];
               buff.execute(this.info);
               i++;
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
      
      protected function __playerDoAction(event:LivingEvent) : void
      {
         var actionType:* = event.paras[0];
         doAction(actionType);
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
      
      protected function __boxPickHandler(e:LivingEvent) : void
      {
         if(PlayerManager.Instance.Self.FightBag.itemNumber > 3)
         {
            ChatManager.Instance.sysChatRed(LanguageMgr.GetTranslation("tank.game.gameplayer.proplist.full"));
         }
      }
      
      override protected function __applySkill(event:LivingEvent) : void
      {
         var paras:Array = event.paras;
         var skill:int = paras[0];
         switch(int(skill) - 6)
         {
            case 0:
               applyResolveHurt(paras[1]);
               break;
            case 1:
               applyRevert(paras[1]);
         }
      }
      
      private function applyRevert(pkg:PackageIn) : void
      {
         map.animateSet.addAnimation(new BaseSetCenterAnimation(x,y - 150,1,false,2));
         map.act(new RevertAction(map.spellKill(this),player,pkg));
      }
      
      private function applyResolveHurt(pkg:PackageIn) : void
      {
         map.animateSet.addAnimation(new BaseSetCenterAnimation(x,y - 150,1,false,2));
         map.act(new ResolveHurtAction(map.spellKill(this),player,pkg));
      }
      
      protected function __addState(event:LivingEvent) : void
      {
      }
      
      protected function __useSkillHandler(event:LivingEvent) : void
      {
         var horseSkillVo:HorseSkillVo = HorseManager.instance.getHorseSkillInfoById(event.paras[0]);
         if(horseSkillVo && horseSkillVo.Pic != "-1")
         {
            _propArray.push(horseSkillVo.Pic);
            doUseItemAnimation();
         }
      }
      
      protected function __usingItem(event:LivingEvent) : void
      {
         var prop:* = null;
         if(event.paras[0] is ItemTemplateInfo)
         {
            prop = event.paras[0];
            _propArray.push(prop.Pic);
            doUseItemAnimation(EquipType.hasPropAnimation(event.paras[0]) != null);
         }
         else if(event.paras[0] is DisplayObject)
         {
            _propArray.push(event.paras[0]);
            doUseItemAnimation();
         }
      }
      
      protected function __usingSpecialKill(event:LivingEvent) : void
      {
         _propArray.push("-1");
         doUseItemAnimation();
      }
      
      override protected function doUseItemAnimation(skip:Boolean = false) : void
      {
         var using:MovieClipWrapper = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.game.ghostPcikPropAsset")),true,true);
         using.addFrameScriptAt(12,headPropEffect);
         SoundManager.instance.play("039");
         using.movie.x = 0;
         using.movie.y = -10;
         if(!skip)
         {
            addChild(using.movie);
         }
         if(_isLiving)
         {
            doAction(_body.handClipAction);
            body.WingState = 4;
         }
      }
      
      protected function __danderChanged(event:LivingEvent) : void
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
      
      override protected function __posChanged(event:LivingEvent) : void
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
      
      protected function __checkCollide(event:LivingEvent) : void
      {
         var rect:* = null;
         var phyObj:* = null;
         var phyObj2:* = null;
         if(map)
         {
            rect = getCollideRect();
            rect.offset(pos.x,pos.y);
            phyObj = _map.getSceneEffectPhysicalObject(rect,this) as GameSceneEffect;
            if(phyObj && phyObj.Id == SceneEffectObj.Hide && !phyObj.isDie)
            {
               player.isFog = true;
            }
            else
            {
               player.isFog = false;
            }
            if(player.isSelf)
            {
               phyObj2 = _map.getSceneEffectPhysicalObject(rect,this) as GameSceneEffect;
               if(phyObj2 && phyObj2.Id == SceneEffectObj.RedDead && !phyObj2.isDie)
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
      
      private function __isRedSkullChanged(event:LivingEvent) : void
      {
         var pkg:PackageIn = new PackageIn();
         pkg.writeInt(2);
         pkg.writeBoolean(player.isRedSkull);
         pkg.writeInt(player.playerInfo.ID);
         pkg.position = 0;
         var evt:CrazyTankSocketEvent = new CrazyTankSocketEvent("add_animation",pkg);
         SocketManager.Instance.dispatchEvent(evt);
      }
      
      public function playerMove() : void
      {
      }
      
      override protected function __dirChanged(event:LivingEvent) : void
      {
         super.__dirChanged(event);
         if(!player.isLiving)
         {
            setSoulPos();
         }
      }
      
      override protected function __attackingChanged(event:LivingEvent) : void
      {
         super.__attackingChanged(event);
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
      
      override protected function __hiddenChanged(event:LivingEvent) : void
      {
         super.__hiddenChanged(event);
         if(_info.isHidden)
         {
            if(_chatballview)
            {
               _chatballview.visible = false;
            }
         }
      }
      
      override protected function __say(event:LivingEvent) : void
      {
         var data:* = null;
         var type:int = 0;
         if(!_info.isHidden)
         {
            data = event.paras[0];
            type = 0;
            if(event.paras[1])
            {
               type = event.paras[1];
            }
            if(type != 9)
            {
               type = player.playerInfo.paopaoType;
            }
            say(data,type);
         }
      }
      
      override protected function __playDeadEffect(event:LivingEvent) : void
      {
         event = event;
         var deadEffect:String = event.paras[1] as String;
         var backFun:Function = event.paras[2] as Function;
         try
         {
            var deadEffectMovie:MovieClip = MovieClip(ClassUtils.CreatInstance(deadEffect));
            var warpper:MovieClipWrapper = new MovieClipWrapper(deadEffectMovie,true,true);
            warpper.addEventListener("complete",function(e:Event):void
            {
               e.target.removeEventListener("complete",arguments.callee);
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
      
      override protected function __bloodChanged(event:LivingEvent) : void
      {
         super.__bloodChanged(event);
         if(event.paras[0] != 0)
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
      
      override protected function __shoot(event:LivingEvent) : void
      {
         var bombs:Array = event.paras[0];
         player.currentBomb = bombs[0].Template.ID;
         if(GameControl.Instance.Current.togetherShoot && !(this is GameLocalPlayer))
         {
            if(EquipType.isDynamicWeapon(player.playerInfo.WeaponID))
            {
               act(new WeaponShootAction(this));
            }
            act(new PrepareShootAction(this));
            act(new ShootBombAction(this,bombs,event.paras[1],_info.shootInterval));
         }
         else
         {
            if(EquipType.isDynamicWeapon(player.playerInfo.WeaponID))
            {
               map.act(new WeaponShootAction(this));
            }
            map.act(new PrepareShootAction(this));
            map.act(new ShootBombAction(this,bombs,event.paras[1],_info.shootInterval));
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
      
      override protected function __beat(event:LivingEvent) : void
      {
         act(new PlayerBeatAction(this));
      }
      
      protected function __usePetSkill(event:LivingEvent) : void
      {
         var skill:PetSkillTemplateInfo = PetSkillManager.getSkillByID(event.value);
         if(skill == null)
         {
            throw new Error("找不到技能，技能ID为：" + event.value);
         }
         if(skill.isActiveSkill)
         {
            switch(int(skill.BallType))
            {
               case 0:
                  usePetSkill(skill);
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
                  usePetSkill(skill,skipSelfTurn);
                  break;
               case 3:
                  usePetSkill(skill);
            }
            UsedPetSkill.add(skill.ID,skill);
            SoundManager.instance.play("039");
         }
      }
      
      private function __petBeat(event:LivingEvent) : void
      {
         var actName:String = event.paras[0];
         var pt:Point = event.paras[1];
         var targets:Array = event.paras[2];
         playPetMovie(actName,pt,updateHp,[targets]);
      }
      
      private function playPetMovie(actName:String, pt:Point, callBack:Function = null, args:Array = null) : void
      {
         if(!_petMovie)
         {
            return;
         }
         _petMovie.show(pt.x,pt.y);
         _petMovie.direction = info.direction;
         if(callBack == null)
         {
            _petMovie.doAction(actName,hidePetMovie);
         }
         else
         {
            _petMovie.doAction(actName,callBack,args);
         }
      }
      
      public function hidePetMovie() : void
      {
         if(_petMovie)
         {
            _petMovie.hide();
         }
      }
      
      private function updateHp(targets:Array) : void
      {
         var t:* = null;
         var hp:int = 0;
         var damage:int = 0;
         var dander:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = targets;
         for each(var target in targets)
         {
            t = target.target;
            hp = target.hp;
            damage = target.damage;
            dander = target.dander;
            t.updateBlood(hp,target.type,damage);
            if(t is Player)
            {
               Player(t).dander = dander;
            }
         }
         if(_petMovie)
         {
            _petMovie.hide();
         }
      }
      
      public function usePetSkill(skill:PetSkillTemplateInfo, callback:Function = null) : void
      {
         _currentPetSkill = skill;
         if(_info && _info.isHidden && _info.team != GameControl.Instance.Current.selfGamePlayer.team)
         {
            if(callback != null)
            {
               callback();
            }
         }
         else
         {
            playPetMovie(skill.Action,_info.pos,callback);
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
      
      protected function __playerMoveTo(event:LivingEvent) : void
      {
         playerMoveTo(event.paras);
      }
      
      override public function playerMoveTo(params:Array) : void
      {
         var type:int = params[0];
         switch(int(type))
         {
            case 0:
               act(new PlayerWalkAction(this,params[1],params[2],getAction("walk"),params[5]));
               break;
            case 1:
               act(new PlayerFallingAction(this,params[1],params[3],false,params[5]));
               break;
            case 2:
               act(new GhostMoveAction(this,params[1],params[4]));
               break;
            case 3:
               act(new PlayerFallingAction(this,params[1],params[3],true,params[5]));
               break;
            case 4:
               act(new PlayerWalkAction(this,params[1],params[2],getAction("stand"),params[5]));
         }
      }
      
      override protected function __fall(event:LivingEvent) : void
      {
         act(new PlayerFallingAction(this,event.paras[0],true,false));
      }
      
      override protected function __jump(event:LivingEvent) : void
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
      
      public function set weaponMovie(value:MovieClip) : void
      {
         if(value != _weaponMovie)
         {
            if(_weaponMovie && _weaponMovie.parent)
            {
               _weaponMovie.removeEventListener("enterFrame",checkCurrentMovie);
               _weaponMovie.parent.removeChild(_weaponMovie);
            }
            _weaponMovie = value;
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
      
      private function checkCurrentMovie(e:Event) : void
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
      
      public function setWeaponMoiveActionSyc(action:String) : void
      {
         if(_currentWeaponMovie)
         {
            _currentWeaponMovie.gotoAndPlay(action);
         }
         else
         {
            _currentWeaponMovieAction = action;
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
      
      protected function __updateNamePos(event:Event) : void
      {
         this.y = _tomb.y - 30;
      }
      
      override public function revive() : void
      {
         _isNeedActRevive = true;
         var tmpMc:MovieClip = ComponentFactory.Instance.creat("asset.game.skill.reviveMc");
         var tmpMcW:MovieClipWrapper = new MovieClipWrapper(tmpMc,true,true);
         tmpMcW.addEventListener("complete",reviveCompleteHandler,false,0,true);
         addChild(tmpMcW.movie);
         if(!_reviveTimer)
         {
            _reviveTimer = new Timer(2500);
            _reviveTimer.addEventListener("timer",insureActRevive,false,0,true);
         }
         _reviveTimer.start();
      }
      
      private function reviveCompleteHandler(event:Event) : void
      {
         var tmpMcW:* = null;
         if(event)
         {
            tmpMcW = event.currentTarget as MovieClipWrapper;
            tmpMcW.removeEventListener("complete",reviveCompleteHandler);
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
      
      private function insureActRevive(event:TimerEvent) : void
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
         var tmpMc:MovieClip = ComponentFactory.Instance.creat("asset.game.skill.clearDebuffMc");
         var tmpMcW:MovieClipWrapper = new MovieClipWrapper(tmpMc,true,true);
         addChild(tmpMcW.movie);
      }
      
      override protected function __beginNewTurn(event:LivingEvent) : void
      {
         super.__beginNewTurn(event);
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
      
      private function __getChat(evt:ChatEvent) : void
      {
         if(player.isHidden && player.team != GameControl.Instance.Current.selfGamePlayer.team)
         {
            return;
         }
         var data:ChatData = ChatData(evt.data).clone();
         data.msg = Helpers.deCodeString(data.msg);
         if(data.channel == 2 || data.channel == 3)
         {
            return;
         }
         if(data.zoneID == -1)
         {
            if(data.senderID == player.playerInfo.ID)
            {
               say(data.msg,player.playerInfo.paopaoType);
            }
         }
         else if(data.senderID == player.playerInfo.ID && data.zoneID == player.playerInfo.ZoneID)
         {
            say(data.msg,player.playerInfo.paopaoType);
         }
      }
      
      private function say(msg:String, paopaoType:int) : void
      {
         _chatballview.setText(msg,paopaoType);
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
      
      private function __getFace(evt:ChatEvent) : void
      {
         var id:int = 0;
         var delay:int = 0;
         if(player.isHidden && player.team != GameControl.Instance.Current.selfGamePlayer.team)
         {
            return;
         }
         var data:Object = evt.data;
         if(data["playerid"] == player.playerInfo.ID)
         {
            id = data["faceid"];
            delay = data["delay"];
            if(id >= 49)
            {
               setTimeout(showFace,delay,id);
            }
            else
            {
               showFace(id);
               ChatManager.Instance.dispatchEvent(new ChatEvent("setFacecontainerLoction"));
            }
         }
      }
      
      private function showFace(id:int) : void
      {
         if(_facecontainer == null)
         {
            return;
         }
         _facecontainer.scaleX = 1;
         _facecontainer.setFace(id);
      }
      
      public function shootPoint() : Point
      {
         var p:Point = _ballpos;
         p = _body.localToGlobal(p);
         p = _map.globalToLocal(p);
         return p;
      }
      
      override public function doAction(actionType:*) : void
      {
         if(actionType is PlayerAction)
         {
            _body.doAction(actionType);
         }
      }
      
      override protected function __buffChanged(event:LivingEvent) : void
      {
         super.__buffChanged(event);
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
      
      override protected function __bombed(event:LivingEvent) : void
      {
         body.bombed();
      }
      
      override public function setMap(map:Map) : void
      {
         super.setMap(map);
         if(map)
         {
            __posChanged(null);
         }
      }
      
      override public function setProperty(property:String, value:String) : void
      {
         var gainEXP:Number = NaN;
         var vo:StringObject = new StringObject(value);
         var _loc5_:* = property;
         if("GhostGPUp" === _loc5_)
         {
            gainEXP = vo.getInt();
            _expView.exp = gainEXP;
            _expView.play();
            _body.doAction(GameCharacter.SOUL_SMILE);
         }
         super.setProperty(property,value);
      }
      
      public function set gainEXP(value:int) : void
      {
         _nickName.text = String(value);
      }
      
      override public function setActionMapping(source:String, target:String) : void
      {
         if(source.length <= 0)
         {
            return;
         }
         labelMapping[source] = target;
      }
      
      override public function getAction(type:String) : *
      {
         if(labelMapping[type])
         {
            type = labelMapping[type];
         }
         var _loc2_:* = type;
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
         var mc:MovieClip = ComponentFactory.Instance.creat("asset.game.flagBattle.reviveAction");
         addChild(mc);
         var mcWrapper:MovieClipWrapper = new MovieClipWrapper(mc,true,true);
         __danderChanged(null);
      }
      
      public function clone(lvingId:int = 0) : GamePlayer
      {
         lvingId = lvingId;
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
