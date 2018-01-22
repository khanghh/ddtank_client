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
      
      public function GamePlayer3D(param1:Player, param2:ShowCharacter, param3:GameCharacter3D = null, param4:int = 0)
      {
         UsedPetSkill = new DictionaryData();
         labelMapping = new Dictionary();
         _character = param2;
         _body = param3;
         super(param1);
         initBuff();
         GameControl.OBJECT = this;
         _ballpos = new Point(30,-20);
         if(param1.currentPet && GameControl.Instance.Current.roomType != 120 && GameControl.Instance.Current.roomType != 123 && GameControl.Instance.Current.gameMode != 120)
         {
            _petMovie = new GamePetMovie3D(param1.currentPet.petInfo,this);
         }
      }
      
      public function playRingSkill() : void
      {
      }
      
      public function playGuardCoreEffect() : void
      {
      }
      
      public function replacePlayerSource(param1:ShowCharacter, param2:GameCharacter3D) : void
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
      
      public function get facecontainer() : FaceContainer3D
      {
         return _facecontainer;
      }
      
      override protected function initView() : void
      {
         var _loc1_:* = null;
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
            _loc1_ = ItemManager.Instance.getTemplateById(_info.playerInfo.pvpBadgeId);
            if(_loc1_)
            {
               _badgeIcon = StarlingMain.instance.createImage("asset.game.badgeIcon" + _loc1_.TemplateID.toString());
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
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(player.playerInfo.IsShowConsortia && player.playerInfo.ConsortiaID > 0)
         {
            _consortiaName = new TextLabel("GameLiving.ConsortiaName");
            _consortiaName.text = player.playerInfo.ConsortiaName;
            if(player.playerInfo.ConsortiaID != 0)
            {
               _loc3_ = GameControl.Instance.Current;
               _loc2_ = PlayerManager.Instance.Self;
               if(_loc2_.ConsortiaID == 0 || _loc2_.ConsortiaID == player.playerInfo.ConsortiaID && _loc2_.ZoneID == player.playerInfo.ZoneID || _loc3_ && _loc3_.gameMode == 2)
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
            _loc1_ = NewTitleManager.instance.getTitleByName(player.playerInfo.honor);
            if(_loc1_ && _loc1_.Show != "0" && _loc1_.Pic != "0")
            {
               _newTitle = StarlingMain.instance.createImage("image_title_" + _loc1_.Pic);
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
         if(_petMovie)
         {
            _petMovie.addEventListener("PlayEffect",__playPlayerEffect);
         }
      }
      
      protected function __playerDoAction(param1:LivingEvent) : void
      {
         var _loc2_:* = param1.paras[0];
         doAction(_loc2_);
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
         if(_loc2_ && _loc2_.isActiveSkill && _loc2_.Pic != "-1")
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
         else if(param1.paras[0] is CellContent3D)
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
         super.doUseItemAnimation(param1);
         if(_isLiving)
         {
            doAction(_body.handClipAction);
         }
      }
      
      protected function __danderChanged(param1:LivingEvent) : void
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
      
      override protected function __posChanged(param1:LivingEvent) : void
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
      
      protected function __checkCollide(param1:LivingEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(map)
         {
            _loc4_ = getCollideRect();
            _loc4_.offset(pos.x,pos.y);
            _loc3_ = _map.getSceneEffectPhysicalObject(_loc4_,this) as GameSceneEffect3D;
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
               _loc2_ = _map.getSceneEffectPhysicalObjectCircle(_loc4_,this) as GameSceneEffect3D;
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
            _attackPlayerCite.play(_info.team.toString());
            addChild(_attackPlayerCite);
         }
         else
         {
            StarlingObjectUtils.removeObject(_attackPlayerCite);
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
         var _loc4_:* = null;
         var _loc3_:String = param1.paras[1] as String;
         var _loc2_:Function = param1.paras[2] as Function;
         try
         {
            _loc4_ = new BoneMovieWrapper(_loc3_,false,true);
            addChild(_loc4_.asDisplay);
            _loc4_.playAction("stand",_loc2_,param1.paras[3]);
            return;
         }
         catch(error:Error)
         {
            if(_loc2_ != null)
            {
               _loc2_(param1.paras[3]);
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
               _body.WingState = "cry";
            }
         }
         updateBloodStrip();
      }
      
      override protected function __shoot(param1:LivingEvent) : void
      {
         var _loc2_:Array = param1.paras[0];
         player.currentBomb = _loc2_[0].Template.ID;
         if(GameControl.Instance.Current.togetherShoot && !(this is GameLocalPlayer3D))
         {
            act(new PrepareShootAction(this));
            act(new ShootBombAction(this,_loc2_,param1.paras[1],_info.shootInterval));
         }
         else
         {
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
         var _loc2_:int = param1.paras[0];
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
      
      public function set weaponMovie(param1:BoneMovieWrapper) : void
      {
         var _loc2_:* = null;
         if(param1 != _weaponMovie)
         {
            StarlingObjectUtils.disposeObject(_weaponMovie);
            _weaponMovie = param1;
            _currentWeaponMovieAction = "";
            if(_weaponMovie)
            {
               _weaponMovie.addFrameScript("effect",creatWeaponShotAction);
               _weaponMovie.movie.stop();
               _loc2_ = _weaponMovie.asDisplay as BoneMovieStarling;
               _loc2_.visible = false;
               _loc2_.x = _body.weaponX * _body.scaleX;
               _loc2_.y = _body.weaponY * _body.scaleY;
               _loc2_.scaleX = _body.scaleX;
               _loc2_.scaleY = _body.scaleY;
               _player.addChild(_loc2_);
            }
         }
      }
      
      private function creatWeaponShotAction(param1:BoneMovieWrapper, param2:Array = null) : void
      {
         var _loc3_:BoneMovieWrapper = new BoneMovieWrapper("bonesEffect" + param2[0],true,true);
         var _loc4_:BoneMovieStarling = _loc3_.asDisplay as BoneMovieStarling;
         _loc4_.x = int(param2[1]) + param1.asDisplay.x;
         _loc4_.y = int(param2[2]) + param1.asDisplay.y;
         _loc4_.scaleX = param1.asDisplay.scaleX;
         _loc4_.scaleY = param1.asDisplay.scaleY;
         _player.addChild(_loc4_);
      }
      
      private function checkCurrentMovie(param1:Event) : void
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
      
      public function setWeaponMoiveActionSyc(param1:String) : void
      {
         if(_weaponMovie)
         {
            _weaponMovie.playAction(param1);
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
      
      protected function __updateNamePos(param1:Event) : void
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
      
      private function insureActRevive(param1:TimerEvent) : void
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
         var _loc1_:BoneMovieWrapper = new BoneMovieWrapper("bonesGameSkillClearDebuffMc",true,true);
         addChild(_loc1_.asDisplay);
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
      
      public function say(param1:String, param2:int) : void
      {
         _chatballview.setText(param1,param2);
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
            if(_loc2_ >= 49 && _loc2_ <= 74)
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
      
      public function showFace(param1:int) : void
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
      
      public function getPlayerMapPos() : Point
      {
         var _loc1_:Point = new Point(0,0);
         _loc1_ = _body.localToGlobal(_loc1_);
         _loc1_ = _map.globalToLocal(_loc1_);
         return _loc1_;
      }
      
      override public function doAction(param1:*, param2:Function = null, param3:Array = null) : void
      {
         if(param1 is PlayerAction)
         {
            _body.doAction(param1);
         }
      }
      
      override protected function __buffChanged(param1:LivingEvent) : void
      {
         var _loc2_:FightBuffInfo = param1.paras[1] as FightBuffInfo;
         if(_loc2_ && _loc2_.type == 6)
         {
            if(_loc2_.id == 304)
            {
               _body.updateBuffEffect(_loc2_.id,_loc2_.Count > 0);
            }
         }
         super.__buffChanged(param1);
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
      
      override protected function __bombed(param1:LivingEvent) : void
      {
         body.bombed();
      }
      
      override public function setMap(param1:Map3D) : void
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
            _body.doAction(GameCharacter3D.SOUL_SMILE);
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
