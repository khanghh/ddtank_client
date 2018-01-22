package ddt.view.characterStarling
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import com.greensock.TweenMax;
   import com.greensock.events.TweenEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.command.PlayerAction;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.SocketManager;
   import ddt.utils.BitmapUtils;
   import ddt.view.character.GameCharacterLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import road7th.StarlingMain;
   import road7th.utils.StringHelper;
   import starling.display.Image;
   import starling.events.Event;
   import starling.textures.Texture;
   
   public class GameCharacter3D extends BaseCharacter3D implements IGameCharacter
   {
      
      private static const STAND_FRAME_1:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,6,7,7,8,8,9,9,9,9,8,8,7,7,6,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,10,10,10,10,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,10,10,10,10,10];
      
      private static const STAND_FRAME_2:Array = [7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,6,6,7,7,8,8,9,9,9,9,8,8,7,7,6,6,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7];
      
      public static const STAND:PlayerAction = new PlayerAction("stand",[STAND_FRAME_1,STAND_FRAME_2],false,true,false);
      
      private static const LACK_FACE_DOWN:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,10,10,10,10,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,10,10,10,10,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
      
      private static const LACK_FACE_UP:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,10,10,10,10,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,10,10,10,10,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
      
      private static const STAND_LACK_HP_FRAME:Array = [0,0,1,1,2,2,3,3,3,3,3,2,2,1,1,0,0,0,0,0,1,1,2,2,3,3,3,3,3,2,2,1,1,0,0,0,0,0,0,1,1,2,2,3,3,3,3,3,2,2,1,1,0,0,0,0,0,1,1,2,2,3,3,3,3,3,2,2,1,1,0,0,0,0];
      
      private static const STAND_LACK_HP_FRAME_1:Array = [0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1,2,0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1,2];
      
      public static const STAND_LACK_HP:PlayerAction = new PlayerAction("standLackHP",[STAND_LACK_HP_FRAME,STAND_LACK_HP_FRAME_1],false,false,false);
      
      public static const WALK_LACK_HP:PlayerAction = new PlayerAction("walkLackHP",[[1,1,2,2,3,3,4,4,5,5]],false,true,false);
      
      public static const WALK:PlayerAction = new PlayerAction("walk",[[1,1,2,2,3,3,4,4,5,5]],false,true,false);
      
      public static const SHOT:PlayerAction = new PlayerAction("shot",[[22,23,26,27]],true,false,true);
      
      public static const STOPSHOT:PlayerAction = new PlayerAction("stopshot",[[23]],true,false,false);
      
      public static const SHOWGUN:PlayerAction = new PlayerAction("showgun",[[19,20,21,21,21]],true,false,true);
      
      public static const HIDEGUN:PlayerAction = new PlayerAction("hidegun",[[27]],true,false,false);
      
      public static const THROWS:PlayerAction = new PlayerAction("throws",[[31,32,33,34,35]],true,false,true);
      
      public static const STOPTHROWS:PlayerAction = new PlayerAction("stopthrows",[[34]],true,false,false);
      
      public static const SHOWTHROWS:PlayerAction = new PlayerAction("showthrows",[[28,29,30,30,30]],true,false,true);
      
      public static const HIDETHROWS:PlayerAction = new PlayerAction("hidethrows",[[35]],true,false,false);
      
      public static const SHAKE:PlayerAction = new PlayerAction("shake",[[6,6,7,7,8,8,9,9,8,8,7,7,6,6]],false,false,false);
      
      public static const HANDCLIP:PlayerAction = new PlayerAction("handclip",[[13,13,14,14,15,15,14,14,13,13,14,14,15,15,14,14,13,13,14,14,15,15,14,14,13,13,14,14,15,15,14,14,13,13,14,14,15,15,14,14,13,13,14,14,15,15,14,14,13,13]],true,false,false);
      
      public static const HANDCLIP_LACK_HP:PlayerAction = new PlayerAction("handclip",[[13,13,14,14,15,15,14,14,13,13,14,14,15,15,14,14,13,13,14,14,15,15,14,14,13,13,14,14,15,15,14,14,13,13,14,14,15,15,14,14,13,13,14,14,15,15,14,14,13,13]],true,false,false);
      
      public static const SOUL:PlayerAction = new PlayerAction("soul",[[0]],false,true,false);
      
      public static const SOUL_MOVE:PlayerAction = new PlayerAction("soulMove",[[1]],false,true,false);
      
      public static const SOUL_SMILE:PlayerAction = new PlayerAction("soulSmile",[[2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]],false,false,false);
      
      public static const SOUL_CRY:PlayerAction = new PlayerAction("soulCry",[[3]],false,true,false);
      
      public static const CRY:PlayerAction = new PlayerAction("cry",[[16,16,17,17,18,18,16,16,17,17,18,18,16,16,17,17,18,18,16,16,17,17,18,18,16,16,17,17,18,18]],false,false,false);
      
      public static const HIT:PlayerAction = new PlayerAction("hit",[[12,12,24,24,24,24,24,24,24,24,25,25,38,38,38,38,11,11,11,11]],false,false,false);
      
      public static const SPECIAL_EFFECT_FRAMES:Array = [0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1,2,0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1,2];
      
      private static const grayFilter:ColorMatrixFilter = new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0]);
      
      public static const PET_CALL:PlayerAction = new PlayerAction("petCall",[[28,29,29,30,30,31,31,32,32,33,33,34,34,35,35,35,35,35,35,35,35,35,35,35,35,35,35]],false,false,false);
      
      public static const GAME_WING_WAIT:String = "stand";
      
      public static const GAME_WING_MOVE:String = "move";
      
      public static const GAME_WING_CRY:String = "cry";
      
      public static const GAME_WING_CLIP:String = "clip";
      
      public static const GAME_WING_SHOOT:String = "shot";
       
      
      private var _currentAction:PlayerAction;
      
      private var _defaultAction:PlayerAction;
      
      private var _frameStartPoint:Point;
      
      private var _defaultStartPoint:Point;
      
      private var _spBitmapData:Vector.<BitmapData>;
      
      private var _faceupBitmapData:BitmapData;
      
      private var _faceBitmapData:BitmapData;
      
      private var _lackHpFaceBitmapdata:Vector.<BitmapData>;
      
      private var _faceDownBitmapdata:BitmapData;
      
      private var _normalSuit:BitmapData;
      
      private var _lackHpSuit:BitmapData;
      
      private var _soulFace:BitmapData;
      
      private var _defaultFace:Image;
      
      private var _buffEffect:Image;
      
      private var _tempCryFace:BitmapData;
      
      private var _leftWing:BoneMovieStarling;
      
      private var _rightWing:BoneMovieStarling;
      
      private var _ghostMovie:BoneMovieStarling;
      
      private var _ghostShine:BoneMovieStarling;
      
      private var _cryTypes:Array;
      
      private var _cryType:int;
      
      private var _specialType:int = 0;
      
      private var _state:int = 1;
      
      private var _rect:Rectangle;
      
      private var _hasSuitSoul:Boolean = true;
      
      private var _cryBmps:Vector.<Bitmap>;
      
      private var _useLackHpSuit:Boolean = false;
      
      private var _useLackHpTurn:int = -1;
      
      protected var _colors:Array;
      
      private var _isLackHp:Boolean;
      
      private var _hasChangeToLackHp:Boolean;
      
      private var _index:int;
      
      private var _isPlaying:Boolean = false;
      
      private var black:Boolean;
      
      private var blackBm:Image;
      
      private var blackEyes:BoneMovieStarling;
      
      private var _wingState:String = "stand";
      
      private var closeEys:int;
      
      public function GameCharacter3D(param1:PlayerInfo)
      {
         _frameStartPoint = new Point(0,0);
         _cryTypes = [0,16,13,10];
         _index = 90 * Math.random();
         super(param1,true);
         _defaultAction = STAND;
         _currentAction = STAND;
         _defaultFace = StarlingMain.instance.createImage("game_defaultCharacter");
      }
      
      override public function show(param1:Boolean = true, param2:int = 1, param3:Boolean = true) : void
      {
         super.show(param1,param2,param3);
         _useLackHpSuit = false;
         _useLackHpTurn = -1;
         _isLackHp = false;
      }
      
      protected function CreateCryFrace(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         ObjectUtils.disposeObject(_tempCryFace);
         _tempCryFace = null;
         if(_cryBmps)
         {
            _loc4_ = 0;
            while(_loc4_ < _cryBmps.length)
            {
               ObjectUtils.disposeObject(_cryBmps[_loc4_]);
               _cryBmps[_loc4_] = null;
               _loc4_++;
            }
            _cryBmps = null;
         }
         _colors = param1.split("|");
         var _loc2_:Sprite = new Sprite();
         _cryBmps = new Vector.<Bitmap>(3);
         _cryBmps[0] = ComponentFactory.Instance.creatBitmap("asset.game.character.cryFaceAsset");
         _loc2_.addChild(_cryBmps[0]);
         _cryBmps[1] = ComponentFactory.Instance.creatBitmap("asset.game.character.cryChangeColorAsset");
         _loc2_.addChild(_cryBmps[1]);
         _cryBmps[1].visible = false;
         if(_colors.length == _cryBmps.length)
         {
            _loc6_ = 0;
            while(_loc6_ < _colors.length)
            {
               if(!StringHelper.isNullOrEmpty(_colors[_loc6_]) && _colors[_loc6_].toString() != "undefined" && _colors[_loc6_].toString() != "null" && _cryBmps[_loc6_])
               {
                  _cryBmps[_loc6_].visible = true;
                  _cryBmps[_loc6_].transform.colorTransform = BitmapUtils.getColorTransfromByColor(_colors[_loc6_]);
                  _loc5_ = BitmapUtils.getHightlightColorTransfrom(_colors[_loc6_]);
                  _loc3_ = new Bitmap(_cryBmps[_loc6_].bitmapData,"auto",true);
                  if(_loc5_)
                  {
                     _loc3_.transform.colorTransform = _loc5_;
                  }
                  _loc3_.blendMode = "hardlight";
                  _loc2_.addChild(_loc3_);
               }
               else if(_cryBmps[_loc6_])
               {
                  _cryBmps[_loc6_].transform.colorTransform = new ColorTransform();
               }
               _loc6_++;
            }
         }
         _tempCryFace = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         _tempCryFace.draw(_loc2_,null,null,"normal");
         ObjectUtils.disposeAllChildren(_loc2_);
      }
      
      public function set isLackHp(param1:Boolean) : void
      {
         _isLackHp = param1;
      }
      
      public function get State() : int
      {
         return _state;
      }
      
      public function set State(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
      }
      
      override protected function initSizeAndPics() : void
      {
         setCharacterSize(114,95);
         setPicNum(3,13);
         _rect = new Rectangle(0,0,_characterWidth,_characterHeight);
         _defaultStartPoint = new Point(_characterWidth / 3,_characterHeight / 3);
      }
      
      public function get weaponX() : int
      {
         return -62;
      }
      
      public function get weaponY() : int
      {
         return -83;
      }
      
      override protected function initLoader() : void
      {
         _loader = _factory.createLoader(_info,"game");
      }
      
      override public function update() : void
      {
         if(_isPlaying)
         {
            if(_index < _currentAction.frames[0].length)
            {
               if(isDead)
               {
                  _index = Number(_index) + 1;
                  drawFrame(_currentAction.frames[0][Number(_index)],8,true);
               }
               else if(_info.getShowSuits())
               {
                  if(_currentAction == STAND_LACK_HP && LACK_FACE_UP && _isLackHp)
                  {
                     drawFrame(LACK_FACE_UP[_index],7,true);
                     _useLackHpSuit = true;
                     _useLackHpTurn = 1;
                  }
                  else if(_useLackHpSuit)
                  {
                     _index = Number(_index) + 1;
                     drawFrame(_currentAction.frames[0][Number(_index)],7,true);
                  }
                  else
                  {
                     _index = Number(_index) + 1;
                     drawFrame(_currentAction.frames[0][Number(_index)],6,true);
                  }
               }
               else if(_currentAction == STAND_LACK_HP)
               {
                  drawFrame(LACK_FACE_DOWN[_index],1,true);
                  drawFrame(_currentAction.frames[STATES_ENUM[_specialType][0] % 2][_index],2,false);
                  drawFrame(LACK_FACE_UP[_index],4,false);
                  _index = Number(_index) + 1;
                  drawFrame(SPECIAL_EFFECT_FRAMES[Number(_index)],5,false);
               }
               else if(_currentAction == STAND)
               {
                  drawFrame(STAND.frames[0][_index],1,true);
                  drawFrame(STAND.frames[0][_index],3,false);
                  _index = Number(_index) + 1;
                  drawFrame(STAND.frames[1][Number(_index)],4,false);
               }
               else
               {
                  drawFrame(_currentAction.frames[0][_index],1,true);
                  drawFrame(_currentAction.frames[0][_index],3,false);
                  _index = Number(_index) + 1;
                  drawFrame(_currentAction.frames[0][Number(_index)],4,false);
               }
            }
            else if(_currentAction.repeat)
            {
               _index = 0;
               if(_currentAction == STAND && _isLackHp)
               {
                  if(Math.random() < 0.33)
                  {
                     doAction(STAND_LACK_HP);
                  }
               }
            }
            else if(_currentAction.stopAtEnd)
            {
               _isPlaying = false;
            }
            else if(isDead)
            {
               doAction(SOUL);
            }
            else if(_currentAction == CRY)
            {
               if(Math.random() < 0.33)
               {
                  doAction(STAND_LACK_HP);
               }
               else
               {
                  doAction(STAND);
               }
            }
            else if(_isLackHp && _currentAction == STAND)
            {
               if(Math.random() < 0.33)
               {
                  doAction(STAND_LACK_HP);
               }
            }
            else
            {
               doAction(STAND);
            }
         }
      }
      
      private function get STATES_ENUM() : Array
      {
         if(_info.Sex)
         {
            return GameCharacterLoader.MALE_STATES;
         }
         return GameCharacterLoader.FEMALE_STATES;
      }
      
      public function bombed() : void
      {
         if(!info.getShowSuits())
         {
            if(black)
            {
               return;
            }
            black = true;
            if(blackBm)
            {
               blackBm.alpha = 1;
               _container.addChild(blackBm);
            }
            createBombedEffect();
            StarlingObjectUtils.removeObject(_bodyImage);
            switchWingVisible(false);
            setTimeout(changeToNormal,2000);
         }
      }
      
      private function createBombedEffect() : void
      {
         StarlingObjectUtils.disposeObject(blackEyes);
         blackEyes = BoneMovieFactory.instance.creatBoneMovie("bonesGameBombedAsset1");
         blackEyes.x = 73;
         blackEyes.y = 68;
         setTimeout(blackEyes.play,300);
         _container.addChild(blackEyes);
      }
      
      override protected function init() : void
      {
         super.init();
         _body.x = _body.x - 62;
         _body.y = _body.y - 83;
         _container.x = _body.x;
         _container.y = _body.y;
      }
      
      private function drawBlack(param1:BitmapData) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Rectangle = new Rectangle(0,0,param1.width,param1.height);
         var _loc3_:Vector.<uint> = param1.getVector(_loc4_);
         var _loc2_:uint = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_[_loc5_] = _loc3_[_loc5_] >> 24 << 24 | 0 | 0 | 0;
            _loc5_++;
         }
         param1.setVector(_loc4_,_loc3_);
      }
      
      public function changeToNormal() : void
      {
         var _loc1_:TweenMax = TweenMax.to(blackBm,0.25,{"alpha":0});
         _loc1_.addEventListener("complete",setBlack);
         StarlingObjectUtils.disposeObject(blackEyes);
         blackEyes = null;
         if(_bodyImage)
         {
            _container.addChild(_bodyImage);
         }
         if(!isDead)
         {
            switchWingVisible(true);
         }
      }
      
      private function get isDead() : Boolean
      {
         return _currentAction == SOUL || _currentAction == SOUL_CRY || _currentAction == SOUL_MOVE || _currentAction == SOUL_SMILE;
      }
      
      private function setBlack(param1:TweenEvent) : void
      {
         TweenMax(param1.target).removeEventListener("complete",setBlack);
         StarlingObjectUtils.removeObject(blackBm);
         black = false;
      }
      
      private function clearBomded() : void
      {
         black = false;
         StarlingObjectUtils.removeObject(blackEyes);
         StarlingObjectUtils.removeObject(blackBm);
         if(_bodyImage)
         {
            _container.addChild(_bodyImage);
         }
      }
      
      public function get standAction() : PlayerAction
      {
         if(_state == 1 || _info.getShowSuits())
         {
            return STAND;
         }
         return STAND_LACK_HP;
      }
      
      public function get walkAction() : PlayerAction
      {
         if(_state == 1 || _info.getShowSuits())
         {
            return WALK;
         }
         return WALK_LACK_HP;
      }
      
      public function get handClipAction() : PlayerAction
      {
         if(_state == 1 || _info.getShowSuits())
         {
            return HANDCLIP;
         }
         return HANDCLIP_LACK_HP;
      }
      
      public function randomCryType() : void
      {
         _cryType = int(Math.random() * 4);
         if(!_info.getShowSuits())
         {
            if(_lackHpFaceBitmapdata)
            {
               _specialType = int(Math.random() * _lackHpFaceBitmapdata.length);
            }
            else
            {
               _specialType = 0;
            }
         }
      }
      
      override public function doAction(param1:*) : void
      {
         var _loc2_:* = null;
         if(_currentAction.canReplace(param1))
         {
            _currentAction = param1;
            _index = 0;
         }
         if(_currentAction == STAND || _currentAction == STAND_LACK_HP)
         {
            StarlingObjectUtils.disposeObject(_ghostMovie);
            _ghostMovie = null;
            StarlingObjectUtils.disposeObject(_ghostShine);
            _ghostShine = null;
         }
         else if(isDead)
         {
            switchWingVisible(false);
            clearBomded();
            if(_ghostMovie == null)
            {
               _ghostMovie = BoneMovieFactory.instance.creatBoneMovie("bonesGameGhostMovieAsset");
               _ghostMovie.stop();
               _container.addChild(_ghostMovie);
               if(_info.getShowSuits() && !_hasSuitSoul)
               {
                  _ghostMovie.play("default");
               }
               else
               {
                  _loc2_ = !!_info.getShowSuits()?"1":"2";
                  _ghostMovie.play(!!_info.Sex?"man" + _loc2_:"girl" + _loc2_);
                  _ghostMovie.x = 35;
                  _ghostMovie.y = 35;
               }
            }
            if(_ghostShine == null)
            {
               _ghostShine = BoneMovieFactory.instance.creatBoneMovie("bonesGameGhostShineAsset");
               _ghostShine.x = 33;
               _ghostShine.y = 35;
               _container.addChild(_ghostShine);
            }
         }
         else
         {
            StarlingObjectUtils.disposeObject(_ghostMovie);
            _ghostMovie = null;
            StarlingObjectUtils.disposeObject(_ghostShine);
            _ghostShine = null;
         }
         if(_currentAction == STAND || _currentAction == STAND_LACK_HP)
         {
            WingState = "stand";
         }
         else if(_currentAction == WALK || _currentAction == WALK_LACK_HP)
         {
            WingState = "move";
         }
         else if(_currentAction == CRY)
         {
            WingState = "cry";
         }
         else if(_currentAction == HANDCLIP || _currentAction == HANDCLIP_LACK_HP)
         {
            WingState = "clip";
         }
         else if(_currentAction == SHOWGUN || _currentAction == SHOWTHROWS)
         {
            WingState = "shot";
         }
         else
         {
            WingState = "stand";
         }
         _isPlaying = true;
      }
      
      override public function actionPlaying() : Boolean
      {
         return _isPlaying;
      }
      
      override public function get currentAction() : *
      {
         return _currentAction;
      }
      
      override public function setDefaultAction(param1:*) : void
      {
         if(param1 is PlayerAction)
         {
            _currentAction = param1;
         }
      }
      
      override protected function setContent() : void
      {
         var _loc2_:* = null;
         if(_loader != null)
         {
            this.scaleX = -1;
            if(!isDead)
            {
               StarlingObjectUtils.disposeObject(_ghostMovie);
               _ghostMovie = null;
            }
            try
            {
               _loc2_ = _loader.getContent();
            }
            catch(e:Error)
            {
               SocketManager.Instance.out.sendErrorMsg("客户端记录: GameCharacter3D:loader空对象");
               return;
            }
            if(_info.getShowSuits())
            {
               try
               {
                  if(_normalSuit && _normalSuit != _loc2_[6])
                  {
                     _normalSuit.dispose();
                  }
                  _normalSuit = _loc2_[6];
               }
               catch(e:Error)
               {
                  SocketManager.Instance.out.sendErrorMsg("客户端记录: GameCharacter3D:t[6]空对象" + getEquipID(6));
               }
               try
               {
                  if(_lackHpSuit && _lackHpSuit != _loc2_[7])
                  {
                     _lackHpSuit.dispose();
                  }
                  _lackHpSuit = _loc2_[7];
                  _hasSuitSoul = checkHasSuitsSoul(_lackHpSuit);
               }
               catch(e:Error)
               {
                  SocketManager.Instance.out.sendErrorMsg("客户端记录: GameCharacter3D:t[7]空对象" + getEquipID(7));
               }
               StarlingObjectUtils.disposeObject(_ghostMovie);
               _ghostMovie = null;
            }
            else
            {
               try
               {
                  if(_spBitmapData && _spBitmapData != _loc2_[1])
                  {
                     var _loc12_:int = 0;
                     var _loc11_:* = _spBitmapData;
                     for each(var _loc1_ in _spBitmapData)
                     {
                        _loc1_.dispose();
                     }
                  }
                  _spBitmapData = _loc2_[1];
               }
               catch(e:Error)
               {
                  SocketManager.Instance.out.sendErrorMsg("客户端记录: GameCharacter3D:t[1]空对象" + getEquipID(1));
               }
               try
               {
                  if(_faceupBitmapData && _faceupBitmapData != _loc2_[2])
                  {
                     _faceupBitmapData.dispose();
                  }
                  _faceupBitmapData = _loc2_[2];
               }
               catch(e:Error)
               {
                  SocketManager.Instance.out.sendErrorMsg("客户端记录: GameCharacter3D:t[2]空对象" + getEquipID(2));
               }
               try
               {
                  if(_faceBitmapData && _faceBitmapData != _loc2_[3])
                  {
                     _faceBitmapData.dispose();
                  }
                  _faceBitmapData = _loc2_[3];
               }
               catch(e:Error)
               {
                  SocketManager.Instance.out.sendErrorMsg("客户端记录: GameCharacter3D:t[3]空对象" + getEquipID(3));
               }
               try
               {
                  if(_lackHpFaceBitmapdata && _lackHpFaceBitmapdata != _loc2_[4])
                  {
                     var _loc18_:int = 0;
                     var _loc17_:* = _lackHpFaceBitmapdata;
                     for each(var _loc3_ in _lackHpFaceBitmapdata)
                     {
                        _loc3_.dispose();
                     }
                  }
                  _lackHpFaceBitmapdata = _loc2_[4];
               }
               catch(e:Error)
               {
                  SocketManager.Instance.out.sendErrorMsg("客户端记录: GameCharacter3D:t[4]空对象" + getEquipID(4));
               }
               try
               {
                  if(_faceDownBitmapdata && _faceDownBitmapdata != _loc2_[5])
                  {
                     _faceDownBitmapdata.dispose();
                  }
                  _faceDownBitmapdata = _loc2_[5];
               }
               catch(e:Error)
               {
                  SocketManager.Instance.out.sendErrorMsg("客户端记录: GameCharacter3D:t[5]空对象" + getEquipID(5));
               }
            }
            initCharacterWing();
            drawBomd();
            drawSoul();
            try
            {
               CreateCryFrace(_info.Colors.split(",")[5]);
            }
            catch(e:Error)
            {
               SocketManager.Instance.out.sendErrorMsg("客户端记录: GameCharacter3D:info空对象");
            }
            _isPlaying = true;
            update();
         }
      }
      
      public function getEquipID(param1:int) : String
      {
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         try
         {
            _loc4_ = _info.Style.split(",");
            _loc3_ = " type: " + param1;
            switch(int(param1) - 1)
            {
               case 0:
                  _loc3_ = _loc3_ + String(_loc4_[5].split("|")[0]);
                  break;
               case 1:
                  _loc3_ = _loc3_ + (String(_loc4_[1].split("|")[0]) + String(_loc4_[0].split("|")[0]) + String(_loc4_[3].split("|")[0]) + String(_loc4_[4].split("|")[0]) + String(_loc4_[2].split("|")[0]));
                  break;
               case 2:
               case 3:
                  _loc3_ = _loc3_ + String(_loc4_[5].split("|")[0]);
                  break;
               case 4:
                  _loc3_ = _loc3_ + String(_loc4_[6].split("|")[0]);
                  break;
               case 5:
               case 6:
                  _loc3_ = _loc3_ + (String(_loc4_[6].split("|")[0]) + "|" + String(_loc4_[7].split("|")[0]));
            }
         }
         catch(e:Error)
         {
            var _loc6_:String = " 记录取 style失败!";
            return _loc6_;
         }
         return _loc3_;
      }
      
      private function checkHasSuitsSoul(param1:BitmapData) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(!param1)
         {
            return false;
         }
         var _loc4_:Point = new Point(_characterWidth * 11 - _characterWidth / 2,_characterHeight * 3 - _characterHeight / 2);
         _loc3_ = _loc4_.x - 5;
         while(_loc3_ < _loc4_.x + 5)
         {
            _loc2_ = _loc4_.y - 5;
            while(_loc2_ < _loc4_.y + 5)
            {
               if(param1.getPixel(_loc3_,_loc2_) != 0)
               {
                  return true;
               }
               _loc2_++;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function switchWingVisible(param1:Boolean) : void
      {
         if(_leftWing)
         {
            _leftWing.visible = param1;
         }
         if(_rightWing)
         {
            _rightWing.visible = param1;
         }
      }
      
      public function setWingPos(param1:Number, param2:Number) : void
      {
         if(_leftWing)
         {
            _leftWing.x = param1;
            _leftWing.y = param2;
         }
         if(_rightWing)
         {
            _rightWing.x = param1;
            _rightWing.y = param2;
         }
      }
      
      public function setWingScale(param1:Number, param2:Number) : void
      {
         if(_leftWing)
         {
            _leftWing.scaleX = param1;
            _leftWing.scaleY = param2;
         }
         if(_rightWing)
         {
            _rightWing.scaleX = param1;
            _rightWing.scaleY = param2;
         }
      }
      
      public function set WingState(param1:String) : void
      {
         var _loc2_:* = param1;
         if(_leftWing)
         {
            _loc2_ = param1 == "shot"?"shot":"stand";
         }
         if(_wingState == _loc2_)
         {
            return;
         }
         _wingState = _loc2_;
         if(_rightWing)
         {
            _rightWing.play(_wingState);
         }
         if(_leftWing)
         {
            _leftWing.play(_wingState);
         }
      }
      
      private function initCharacterWing() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc1_:int = _info.Style.split(",")[8].split("|")[0];
         if(!_leftWing && !_rightWing && _loc1_ != 15001)
         {
            _loc3_ = "bonesGameWing" + _loc1_ + "left";
            _loc2_ = "bonesGameWing" + _loc1_ + "right";
            if(BoneMovieFactory.instance.model.getBonesStyle(_loc3_) != null)
            {
               _leftWing = BoneMovieFactory.instance.creatBoneMovie(_loc3_,0,"fighting3d");
            }
            _rightWing = BoneMovieFactory.instance.creatBoneMovie(_loc2_,0,"fighting3d");
            if(_leftWing)
            {
               _leftWing.x = -12;
            }
            if(_rightWing)
            {
               _rightWing.x = -12;
            }
            _rightWing.addEventListener("complete",__onLoadWingComplete);
            if(_rightWing.loadComplete)
            {
               _rightWing.removeEventListener("complete",__onLoadWingComplete);
               showCharacterWing();
            }
         }
      }
      
      public function showCharacterWing() : void
      {
         if(_leftWing)
         {
            addChildAt(_leftWing,0);
         }
         if(_rightWing)
         {
            addChildAt(_rightWing,0);
         }
      }
      
      private function __onLoadWingComplete(param1:Event) : void
      {
         _rightWing.removeEventListener("complete",__onLoadWingComplete);
         showCharacterWing();
      }
      
      public function hideWing() : void
      {
         if(_leftWing)
         {
            StarlingObjectUtils.removeObject(_leftWing);
         }
         if(_rightWing)
         {
            StarlingObjectUtils.removeObject(_rightWing);
         }
      }
      
      public function updateBuffEffect(param1:int, param2:Boolean) : void
      {
         if(param1 == 304)
         {
            StarlingObjectUtils.disposeObject(_buffEffect);
            _buffEffect = StarlingMain.instance.createImage("game_toxicosis","game.view.playerToxicosisPos");
         }
         if(param2 && _buffEffect)
         {
            addChild(_buffEffect);
         }
         else
         {
            StarlingObjectUtils.disposeObject(_buffEffect);
            _buffEffect = null;
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         StarlingObjectUtils.disposeObject(_ghostMovie);
         _ghostMovie = null;
         StarlingObjectUtils.disposeObject(_ghostShine);
         _ghostShine = null;
         StarlingObjectUtils.disposeObject(_buffEffect);
         _buffEffect = null;
         ObjectUtils.disposeObject(_spBitmapData);
         _spBitmapData = null;
         ObjectUtils.disposeObject(_faceupBitmapData);
         _faceupBitmapData = null;
         ObjectUtils.disposeObject(_faceBitmapData);
         _faceBitmapData = null;
         ObjectUtils.disposeObject(_lackHpFaceBitmapdata);
         _lackHpFaceBitmapdata = null;
         ObjectUtils.disposeObject(_faceDownBitmapdata);
         _faceDownBitmapdata = null;
         ObjectUtils.disposeObject(_normalSuit);
         _normalSuit = null;
         ObjectUtils.disposeObject(_lackHpSuit);
         _lackHpSuit = null;
         ObjectUtils.disposeObject(_soulFace);
         _soulFace = null;
         ObjectUtils.disposeObject(_tempCryFace);
         _tempCryFace = null;
         if(_cryBmps)
         {
            _loc1_ = 0;
            while(_loc1_ < _cryBmps.length)
            {
               ObjectUtils.disposeObject(_cryBmps[_loc1_]);
               _cryBmps[_loc1_] = null;
               _loc1_++;
            }
         }
         if(_rightWing)
         {
            _rightWing.removeEventListener("complete",__onLoadWingComplete);
         }
         StarlingObjectUtils.disposeObject(_rightWing);
         StarlingObjectUtils.disposeObject(_leftWing);
         StarlingObjectUtils.disposeObject(_defaultFace);
         _leftWing = null;
         _rightWing = null;
         _defaultFace = null;
         StarlingObjectUtils.disposeObject(blackBm,true);
         blackBm = null;
         StarlingObjectUtils.disposeObject(blackEyes);
         blackEyes = null;
         _frameStartPoint = null;
         _cryBmps = null;
         super.dispose();
      }
      
      private function drawSoul() : void
      {
         var _loc8_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = NaN;
         var _loc7_:Point = new Point(0,0);
         if(_info.getShowSuits())
         {
            _soulFace = new BitmapData(_normalSuit.width,_normalSuit.height,true,0);
            _loc8_ = 0;
            while(_loc8_ < 4)
            {
               _loc7_.x = _characterWidth * _loc8_;
               _soulFace.copyPixels(_lackHpSuit,_frames[36],_loc7_,null,null,true);
               _loc8_++;
            }
         }
         else
         {
            _soulFace = new BitmapData(_faceBitmapData.width,_faceBitmapData.height,true,0);
            _loc1_ = 0;
            _loc4_ = new Matrix();
            _loc5_ = new BitmapData(_faceBitmapData.width,_faceBitmapData.height,true,0);
            _loc6_ = 0;
            while(_loc6_ < 4)
            {
               _loc7_.x = _characterWidth * _loc6_;
               switch(int(_loc6_))
               {
                  case 0:
                     _loc1_ = 0;
                     break;
                  case 1:
                     _loc1_ = 10;
                     break;
                  case 2:
                     _loc1_ = 14;
                     break;
                  case 3:
                     _loc1_ = 17;
               }
               _loc7_.x = _characterWidth * _loc6_;
               _soulFace.copyPixels(_faceBitmapData,_frames[_loc1_],_loc7_,null,null,true);
               _loc6_++;
            }
            _loc4_.scale(0.75,0.75);
            var _loc9_:int = 0;
            _loc7_.y = _loc9_;
            _loc7_.x = _loc9_;
            _loc5_.draw(_soulFace,_loc4_,null,null,null,true);
            _loc2_ = new Rectangle(0,0,_characterWidth,_characterHeight);
            _soulFace.fillRect(_soulFace.rect,0);
            _loc3_ = 0;
            while(_loc3_ < 4)
            {
               _loc2_.x = _loc3_ * _characterWidth * 0.75;
               _loc7_.x = _characterWidth * _loc3_ + 7;
               _loc7_.y = 5;
               _soulFace.copyPixels(_faceDownBitmapdata,_frames[36],new Point(_loc3_ * _characterWidth,0),null,null,true);
               _soulFace.copyPixels(_loc5_,_loc2_,_loc7_,null,null,true);
               _soulFace.copyPixels(_faceupBitmapData,_frames[36],new Point(_loc3_ * _characterWidth,0),null,null,true);
               _loc3_++;
            }
            _loc9_ = 0;
            _loc7_.y = _loc9_;
            _loc7_.x = _loc9_;
            _soulFace.applyFilter(_soulFace,_soulFace.rect,_loc7_,grayFilter);
            _loc5_.dispose();
         }
      }
      
      private function drawBomd() : void
      {
         var _loc1_:BitmapData = new BitmapData(_body.width,_body.height,true,0);
         _loc1_.fillRect(new Rectangle(0,0,_loc1_.height,_loc1_.height),0);
         if(_info.getShowSuits())
         {
            _loc1_.copyPixels(_normalSuit,_frames[1],_frameStartPoint,null,null,true);
         }
         else
         {
            _loc1_.copyPixels(_faceDownBitmapdata,_frames[1],_frameStartPoint,null,null,true);
            _loc1_.copyPixels(_faceBitmapData,_frames[1],_frameStartPoint,null,null,true);
            _loc1_.copyPixels(_faceupBitmapData,_frames[1],_frameStartPoint,null,null,true);
         }
         drawBlack(_loc1_);
         StarlingObjectUtils.disposeObject(blackBm,true);
         blackBm = Image.fromBitmap(new Bitmap(_loc1_),false);
      }
      
      override public function drawFrame(param1:int, param2:int = 0, param3:Boolean = true) : void
      {
         var _loc4_:BitmapData = null;
         if(param2 == 1)
         {
            _loc4_ = _faceDownBitmapdata;
         }
         else if(param2 == 2)
         {
            if(_lackHpFaceBitmapdata)
            {
               _loc4_ = _lackHpFaceBitmapdata[_specialType];
            }
         }
         else if(param2 == 3)
         {
            if(_currentAction == CRY && _cryType > 0)
            {
               _loc4_ = _tempCryFace;
            }
            else
            {
               _loc4_ = _faceBitmapData;
            }
         }
         else if(param2 == 4)
         {
            _loc4_ = _faceupBitmapData;
         }
         else if(param2 == 5)
         {
            if(_spBitmapData)
            {
               _loc4_ = _spBitmapData[_specialType];
            }
         }
         else if(param2 == 6)
         {
            _loc4_ = _normalSuit;
         }
         else if(param2 == 7)
         {
            _loc4_ = _lackHpSuit;
         }
         else if(param2 == 8)
         {
            _loc4_ = _soulFace;
         }
         if(_currentAction == SOUL)
         {
            if(closeEys < 4)
            {
               param1 = 1;
            }
            else if(Math.random() < 0.008)
            {
               closeEys = 0;
            }
            closeEys = Number(closeEys) + 1;
         }
         if(_loc4_ != null)
         {
            if(param1 < 0 || param1 >= _frames.length)
            {
               param1 = 0;
            }
            _currentframe = param1;
            if(param3)
            {
               _body.bitmapData.fillRect(_rect,0);
            }
            if(_currentAction == CRY && (param2 == 2 || param2 == 3))
            {
               _body.bitmapData.copyPixels(_loc4_,_frames[param1 - _cryTypes[_cryType]],_frameStartPoint,null,null,true);
            }
            else
            {
               _body.bitmapData.copyPixels(_loc4_,_frames[param1],_frameStartPoint,null,null,true);
            }
            if(_defaultFace.parent)
            {
               _defaultFace.parent.removeChild(_defaultFace);
            }
            _bodyImage.texture.dispose();
            _bodyImage.texture = Texture.fromBitmap(_body,false);
         }
         else
         {
            if(param1 < 0 || param1 >= _frames.length)
            {
               param1 = 0;
            }
            _currentframe = param1;
            StarlingObjectUtils.removeObject(_bodyImage);
            _container.addChild(_defaultFace);
            if(this.parent)
            {
               this.scaleX = this.parent.scaleX;
            }
         }
      }
      
      public function get useLackHpSuit() : Boolean
      {
         return _useLackHpSuit;
      }
      
      public function set useLackHpSuit(param1:Boolean) : void
      {
         _useLackHpSuit = param1;
      }
      
      public function get useLackHpTurn() : int
      {
         return _useLackHpTurn;
      }
      
      public function set useLackHpTurn(param1:int) : void
      {
         _useLackHpTurn = param1;
      }
   }
}
