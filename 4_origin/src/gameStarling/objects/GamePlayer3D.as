package gameStarling.objects
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
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
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.Helpers;
   import ddt.view.character.ShowCharacter;
   import ddt.view.characterStarling.GameCharacter3D;
   import ddt.view.chat.ChatData;
   import ddt.view.chat.ChatEvent;
   import ddt.view.common.DailyLeagueLevel;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import gameCommon.GameControl;
   import gameCommon.model.FightBuffInfo;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.Player;
   import gameCommon.model.SceneEffectObj;
   import gameStarling.actions.GhostMoveAction;
   import gameStarling.actions.PlayerBeatAction;
   import gameStarling.actions.PlayerFallingAction;
   import gameStarling.actions.PlayerWalkAction;
   import gameStarling.actions.PrepareShootAction;
   import gameStarling.actions.SelfSkipAction;
   import gameStarling.actions.ShootBombAction;
   import gameStarling.actions.SkillActions.ResolveHurtAction;
   import gameStarling.actions.SkillActions.RevertAction;
   import gameStarling.animations.BaseSetCenterAnimation;
   import gameStarling.chat.ChatBallPlayer3D;
   import gameStarling.view.ExpMovie3D;
   import gameStarling.view.FaceContainer3D;
   import gameStarling.view.GameView3D;
   import horse.HorseManager;
   import horse.data.HorseSkillVo;
   import newTitle.NewTitleManager;
   import newTitle.model.NewTitleModel;
   import pet.data.PetSkillTemplateInfo;
   import road7th.StarlingMain;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.StringObject;
   import road7th.utils.BoneMovieWrapper;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.display.cell.CellContent3D;
   import starling.events.Event;
   import starlingPhy.maps.Map3D;
   import starlingui.core.text.TextLabel;
   
   public class GamePlayer3D extends GameTurnedLiving3D
   {
       
      
      protected var _player:Sprite;
      
      protected var _attackPlayerCite:BoneMovieStarling;
      
      private var _levelIcon:Image;
      
      private var _leagueRank:DailyLeagueLevel;
      
      protected var _consortiaName:TextLabel;
      
      protected var _teamTxt:TextLabel;
      
      private var _facecontainer:FaceContainer3D;
      
      private var _ballpos:Point;
      
      private var _expView:ExpMovie3D;
      
      private var _resolveHurtMovie:MovieClipWrapper;
      
      private var _petMovie:GamePetMovie3D;
      
      private var _currentPetSkill:PetSkillTemplateInfo;
      
      private var _badgeIcon:Image;
      
      private var _newTitle:Image;
      
      private var _ringSkill:BoneMovieWrapper;
      
      private var _guardCoreEffect:BoneMovieWrapper;
      
      private var _danderFire:BoneMovieStarling;
      
      public var isShootPrepared:Boolean;
      
      public var UsedPetSkill:DictionaryData;
      
      private var _character:ShowCharacter;
      
      private var _body:GameCharacter3D;
      
      private var _weaponMovie:BoneMovieWrapper;
      
      private var _currentWeaponMovieAction:String = "";
      
      private var _tomb:TombView3D;
      
      private var _isNeedActRevive:Boolean = false;
      
      private var _reviveTimer:Timer;
      
      private var labelMapping:Dictionary;
      
      public function GamePlayer3D(player:Player, character:ShowCharacter, movie:GameCharacter3D = null, templeId:int = 0)
      {
         UsedPetSkill = new DictionaryData();
         labelMapping = new Dictionary();
         _character = character;
         _body = movie;
         super(player);
         initBuff();
         GameControl.OBJECT = this;
         _ballpos = new Point(30,-20);
         if(player.currentPet && GameControl.Instance.Current.roomType != 120 && GameControl.Instance.Current.roomType != 123 && GameControl.Instance.Current.gameMode != 120)
         {
            _petMovie = new GamePetMovie3D(player.currentPet.petInfo,this);
         }
      }
      
      public function playRingSkill() : void
      {
      }
      
      public function playGuardCoreEffect() : void
      {
      }
      
      public function replacePlayerSource(character:ShowCharacter, movie:GameCharacter3D) : void
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
      
      public function get facecontainer() : FaceContainer3D
      {
         return _facecontainer;
      }
      
      override protected function initView() : void
      {
         var tmpItemInfo:* = null;
         bodyHeight = 55;
         super.initView();
         _player = new Sprite();
         _player.y = -3;
         addChild(_player);
         _nickName.x = -19;
         if(_girlAttest != null)
         {
            _girlAttest.x = _nickName.x + _nickName.width;
         }
         _body.x = 0;
         _body.doAction(getAction("stand"));
         _player.addChild(_body);
         _player.touchable = false;
         _chatballview = new ChatBallPlayer3D();
         (_chatballview as ChatBallPlayer3D).player = this;
         (_chatballview as ChatBallPlayer3D).setPos(0,-40);
         _attackPlayerCite = BoneMovieFactory.instance.creatBoneMovie("bonesGameAttackCiteAsset");
         _attackPlayerCite.play(_info.team.toString());
         _attackPlayerCite.y = -75;
         _levelIcon = StarlingMain.instance.createImage("level_" + player.playerInfo.Grade);
         var _loc2_:* = 0.75;
         _levelIcon.scaleY = _loc2_;
         _levelIcon.scaleX = _loc2_;
         _levelIcon.x = -52;
         _levelIcon.y = _bloodStripBg.y - 5;
         addChild(_levelIcon);
         if(PlayerManager.Instance.findPlayer(_character.info.ID).teamID > 0)
         {
            _teamTxt = new TextLabel("TeamSmallIcon");
            _teamTxt.y = _teamTxt.y + 3;
            _teamTxt.text = "(" + PlayerManager.Instance.findPlayer(_character.info.ID).teamTag + ")";
            addChild(_teamTxt);
         }
         _expView = new ExpMovie3D();
         addChild(_expView);
         _expView.y = -60;
         _expView.x = -50;
         _loc2_ = 1.5;
         _expView.scaleY = _loc2_;
         _expView.scaleX = _loc2_;
         _facecontainer = new FaceContainer3D();
         _facecontainer.player = this;
         _facecontainer.setPos(0,-100);
         (GameControl.Instance.gameView as GameView3D).mapSprite.addChild(_facecontainer);
         _facecontainer.setNickName(_nickName.text);
         if(_info.playerInfo.pvpBadgeId != 0)
         {
            tmpItemInfo = ItemManager.Instance.getTemplateById(_info.playerInfo.pvpBadgeId);
            if(tmpItemInfo)
            {
               _badgeIcon = StarlingMain.instance.createImage("asset.game.badgeIcon" + tmpItemInfo.TemplateID.toString());
               _badgeIcon.x = -8;
               _badgeIcon.y = -73;
               _player.addChild(_badgeIcon);
            }
         }
         _propArray = [];
         __dirChanged(null);
         __danderChanged(null);
         updatePlayerTitle();
      }
      
      private function updatePlayerTitle() : void
      {
         var gameInfo:* = null;
         var self:* = null;
         var titleModel:* = null;
         if(player.playerInfo.IsShowConsortia && player.playerInfo.ConsortiaID > 0)
         {
            _consortiaName = new TextLabel("GameLiving.ConsortiaName");
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
            _facecontainer && (GameControl.Instance.gameView as GameView3D).mapSprite.addChild(_facecontainer);
         }
         else if(player.playerInfo.honor != "" && (StateManager.currentStateType == "fighting3d" || StateManager.currentStateType == "dungeonRoom"))
         {
            titleModel = NewTitleManager.instance.getTitleByName(player.playerInfo.honor);
            if(titleModel && titleModel.Show != "0" && titleModel.Pic != "0")
            {
               _newTitle = StarlingMain.instance.createImage("image_title_" + titleModel.Pic);
               _newTitle.x = -_newTitle.width / 2;
               _newTitle.y = _player.y - _player.height - _newTitle.height + 20;
               addChild(_newTitle);
            }
         }
      }
      
      private function updateNewTitlePos() : void
      {
         if(_newTitle)
         {
            if(player.isAttacking && player.isLiving)
            {
               _newTitle.y = _player.y - _player.height - _newTitle.height + 20;
            }
            else
            {
               _newTitle.y = _player.y - _player.height - _newTitle.height + 75;
            }
         }
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
         if(_petMovie)
         {
            _petMovie.addEventListener("PlayEffect",__playPlayerEffect);
         }
      }
      
      protected function __playerDoAction(event:LivingEvent) : void
      {
         var actionType:* = event.paras[0];
         doAction(actionType);
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
         if(horseSkillVo && horseSkillVo.isActiveSkill && horseSkillVo.Pic != "-1")
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
         else if(event.paras[0] is CellContent3D)
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
         super.doUseItemAnimation(skip);
         if(_isLiving)
         {
            doAction(_body.handClipAction);
         }
      }
      
      protected function __danderChanged(event:LivingEvent) : void
      {
         StarlingObjectUtils.disposeObject(_danderFire);
         _danderFire = null;
         if(player.dander >= 200 && _isLiving)
         {
            _danderFire = BoneMovieFactory.instance.creatBoneMovie("bonesGameDanderAsset");
            _danderFire.x = 3;
            _danderFire.y = _body.y + 5;
            _danderFire.play();
            _player.addChild(_danderFire);
         }
      }
      
      override protected function __posChanged(event:LivingEvent) : void
      {
         pos = player.pos;
         (_chatballview as ChatBallPlayer3D).setPos(popPos.x,popPos.y);
         _facecontainer.setPos(0,ap - 100);
         if(_isLiving)
         {
            _player.angle = calcObjectAngle();
            player.playerAngle = _player.angle;
         }
         playerMove();
         if(map && map.smallMap)
         {
            map.smallMap.updatePos(smallView,pos);
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
            phyObj = _map.getSceneEffectPhysicalObject(rect,this) as GameSceneEffect3D;
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
               phyObj2 = _map.getSceneEffectPhysicalObjectCircle(rect,this) as GameSceneEffect3D;
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
            _attackPlayerCite.play(_info.team.toString());
            addChild(_attackPlayerCite);
         }
         else
         {
            StarlingObjectUtils.removeObject(_attackPlayerCite);
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
         var warpper:* = null;
         var deadEffect:String = event.paras[1] as String;
         var backFun:Function = event.paras[2] as Function;
         try
         {
            warpper = new BoneMovieWrapper(deadEffect,false,true);
            addChild(warpper.asDisplay);
            warpper.playAction("stand",backFun,event.paras[3]);
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
               _body.WingState = "cry";
            }
         }
         updateBloodStrip();
      }
      
      override protected function __shoot(event:LivingEvent) : void
      {
         var bombs:Array = event.paras[0];
         player.currentBomb = bombs[0].Template.ID;
         if(GameControl.Instance.Current.togetherShoot && !(this is GameLocalPlayer3D))
         {
            act(new PrepareShootAction(this));
            act(new ShootBombAction(this,bombs,event.paras[1],_info.shootInterval));
         }
         else
         {
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
         var type:int = event.paras[0];
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
      
      public function get body() : GameCharacter3D
      {
         return _body;
      }
      
      public function get player() : Player
      {
         return info as Player;
      }
      
      public function get weaponMovie() : BoneMovieWrapper
      {
         return _weaponMovie;
      }
      
      public function set weaponMovie(value:BoneMovieWrapper) : void
      {
         var movie:* = null;
         if(value != _weaponMovie)
         {
            StarlingObjectUtils.disposeObject(_weaponMovie);
            _weaponMovie = value;
            _currentWeaponMovieAction = "";
            if(_weaponMovie)
            {
               _weaponMovie.addFrameScript("effect",creatWeaponShotAction);
               _weaponMovie.movie.stop();
               movie = _weaponMovie.asDisplay as BoneMovieStarling;
               movie.visible = false;
               movie.x = _body.weaponX * _body.scaleX;
               movie.y = _body.weaponY * _body.scaleY;
               movie.scaleX = _body.scaleX;
               movie.scaleY = _body.scaleY;
               _player.addChild(movie);
            }
         }
      }
      
      private function creatWeaponShotAction(boneMovie:BoneMovieWrapper, arge:Array = null) : void
      {
         var effect:BoneMovieWrapper = new BoneMovieWrapper("bonesEffect" + arge[0],true,true);
         var movie:BoneMovieStarling = effect.asDisplay as BoneMovieStarling;
         movie.x = int(arge[1]) + boneMovie.asDisplay.x;
         movie.y = int(arge[2]) + boneMovie.asDisplay.y;
         movie.scaleX = boneMovie.asDisplay.scaleX;
         movie.scaleY = boneMovie.asDisplay.scaleY;
         _player.addChild(movie);
      }
      
      private function checkCurrentMovie(e:Event) : void
      {
         if(_weaponMovie == null)
         {
            return;
         }
         if(_weaponMovie && _currentWeaponMovieAction != "")
         {
            setWeaponMoiveActionSyc(_currentWeaponMovieAction);
         }
      }
      
      public function setWeaponMoiveActionSyc(action:String) : void
      {
         if(_weaponMovie)
         {
            _weaponMovie.playAction(action);
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
         _player.angle = 0;
         _player.y = 25;
         if(contains(_attackPlayerCite))
         {
            removeChild(_attackPlayerCite);
         }
         StarlingObjectUtils.removeObject(_newTitle);
         _tomb = new TombView3D();
         _tomb.pos = this.pos;
         if(_map)
         {
            _map.addPhysical(_tomb);
         }
         _tomb.startMoving();
         player.pos = new Point(x,y - 70);
         player.startMoving();
         if(RoomManager.Instance.current && RoomManager.Instance.current.type == 21)
         {
            _tomb.addEventListener("updatenamepos",__updateNamePos);
            _player.visible = false;
         }
         else
         {
            doAction(GameCharacter3D.SOUL);
         }
         setSoulPos();
         _nickName.y = _nickName.y + 10;
         if(_girlAttest != null)
         {
            _girlAttest.y = _nickName.y;
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
         StarlingObjectUtils.disposeObject(_danderFire);
         _danderFire = null;
         if(_petMovie)
         {
            _petMovie.visible = false;
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
         if(!_reviveTimer)
         {
            _reviveTimer = new Timer(2500);
            _reviveTimer.addEventListener("timer",insureActRevive,false,0,true);
         }
         _reviveTimer.start();
      }
      
      private function reviveCompleteHandler() : void
      {
         if(!_isNeedActRevive)
         {
            return;
         }
         super.revive();
         ObjectUtils.disposeObject(_tomb);
         _tomb = null;
         _player.visible = true;
         doAction(GameCharacter3D.STAND_LACK_HP);
         if(_petMovie)
         {
            _petMovie.visible = true;
         }
         _player.y = -3;
         _nickName.y = _nickName.y - 10;
         if(_girlAttest != null)
         {
            _girlAttest.y = _nickName.y;
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
         _isNeedActRevive = false;
      }
      
      private function insureActRevive(event:TimerEvent) : void
      {
         reviveCompleteHandler();
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
         var tmpMc:BoneMovieWrapper = new BoneMovieWrapper("bonesGameSkillClearDebuffMc",true,true);
         addChild(tmpMc.asDisplay);
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
      
      public function say(msg:String, paopaoType:int) : void
      {
         _chatballview.setText(msg,paopaoType);
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
            if(id >= 49 && id <= 74)
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
      
      public function showFace(id:int) : void
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
      
      public function getPlayerMapPos() : Point
      {
         var p:Point = new Point(0,0);
         p = _body.localToGlobal(p);
         p = _map.globalToLocal(p);
         return p;
      }
      
      override public function doAction(actionType:*, callback:Function = null, args:Array = null) : void
      {
         if(actionType is PlayerAction)
         {
            _body.doAction(actionType);
         }
      }
      
      override protected function __buffChanged(event:LivingEvent) : void
      {
         var buff:FightBuffInfo = event.paras[1] as FightBuffInfo;
         if(buff && buff.type == 6)
         {
            if(buff.id == 304)
            {
               _body.updateBuffEffect(buff.id,buff.Count > 0);
            }
         }
         super.__buffChanged(event);
      }
      
      override public function dispose() : void
      {
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
         ChatManager.Instance.model.removeEventListener("addChat",__getChat);
         ChatManager.Instance.removeEventListener("addFace",__getFace);
         _info.removeEventListener("boxPick",__boxPickHandler);
         if(_petMovie)
         {
            _petMovie.removeEventListener("PlayEffect",__playPlayerEffect);
         }
         ObjectUtils.disposeObject(_chatballview);
         _chatballview = null;
         if(_facecontainer)
         {
            _facecontainer.dispose();
            _facecontainer = null;
         }
         StarlingObjectUtils.disposeObject(_petMovie);
         _petMovie = null;
         StarlingObjectUtils.disposeObject(_consortiaName);
         _consortiaName = null;
         ObjectUtils.disposeObject(_badgeIcon);
         _badgeIcon = null;
         ObjectUtils.disposeObject(_ringSkill);
         _ringSkill = null;
         ObjectUtils.disposeObject(_guardCoreEffect);
         _guardCoreEffect = null;
         StarlingObjectUtils.disposeObject(_attackPlayerCite);
         _attackPlayerCite = null;
         _character = null;
         _body = null;
         StarlingObjectUtils.disposeObject(_weaponMovie);
         _weaponMovie = null;
         StarlingObjectUtils.disposeObject(_danderFire);
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
         if(_teamTxt)
         {
            ObjectUtils.disposeObject(_teamTxt);
            _teamTxt = null;
         }
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
         super.dispose();
      }
      
      override protected function __bombed(event:LivingEvent) : void
      {
         body.bombed();
      }
      
      override public function setMap(map:Map3D) : void
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
            _body.doAction(GameCharacter3D.SOUL_SMILE);
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
                  return GameCharacter3D.SOUL;
               }
               return GameCharacter3D.CRY;
            }
            return _body.walkAction;
         }
         return _body.standAction;
      }
   }
}
