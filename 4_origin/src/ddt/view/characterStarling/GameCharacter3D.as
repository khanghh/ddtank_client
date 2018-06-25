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
      
      public function GameCharacter3D(info:PlayerInfo)
      {
         _frameStartPoint = new Point(0,0);
         _cryTypes = [0,16,13,10];
         _index = 90 * Math.random();
         super(info,true);
         _defaultAction = STAND;
         _currentAction = STAND;
         _defaultFace = StarlingMain.instance.createImage("game_defaultCharacter");
      }
      
      override public function show(clearLoader:Boolean = true, dir:int = 1, small:Boolean = true) : void
      {
         super.show(clearLoader,dir,small);
         _useLackHpSuit = false;
         _useLackHpTurn = -1;
         _isLackHp = false;
      }
      
      protected function CreateCryFrace(color:String) : void
      {
         var j:int = 0;
         var i:int = 0;
         var lightTransfrom:* = null;
         var lightBitmap:* = null;
         ObjectUtils.disposeObject(_tempCryFace);
         _tempCryFace = null;
         if(_cryBmps)
         {
            for(j = 0; j < _cryBmps.length; )
            {
               ObjectUtils.disposeObject(_cryBmps[j]);
               _cryBmps[j] = null;
               j++;
            }
            _cryBmps = null;
         }
         _colors = color.split("|");
         var cryFrace:Sprite = new Sprite();
         _cryBmps = new Vector.<Bitmap>(3);
         _cryBmps[0] = ComponentFactory.Instance.creatBitmap("asset.game.character.cryFaceAsset");
         cryFrace.addChild(_cryBmps[0]);
         _cryBmps[1] = ComponentFactory.Instance.creatBitmap("asset.game.character.cryChangeColorAsset");
         cryFrace.addChild(_cryBmps[1]);
         _cryBmps[1].visible = false;
         if(_colors.length == _cryBmps.length)
         {
            for(i = 0; i < _colors.length; )
            {
               if(!StringHelper.isNullOrEmpty(_colors[i]) && _colors[i].toString() != "undefined" && _colors[i].toString() != "null" && _cryBmps[i])
               {
                  _cryBmps[i].visible = true;
                  _cryBmps[i].transform.colorTransform = BitmapUtils.getColorTransfromByColor(_colors[i]);
                  lightTransfrom = BitmapUtils.getHightlightColorTransfrom(_colors[i]);
                  lightBitmap = new Bitmap(_cryBmps[i].bitmapData,"auto",true);
                  if(lightTransfrom)
                  {
                     lightBitmap.transform.colorTransform = lightTransfrom;
                  }
                  lightBitmap.blendMode = "hardlight";
                  cryFrace.addChild(lightBitmap);
               }
               else if(_cryBmps[i])
               {
                  _cryBmps[i].transform.colorTransform = new ColorTransform();
               }
               i++;
            }
         }
         _tempCryFace = new BitmapData(cryFrace.width,cryFrace.height,true,0);
         _tempCryFace.draw(cryFrace,null,null,"normal");
         ObjectUtils.disposeAllChildren(cryFrace);
      }
      
      public function set isLackHp(value:Boolean) : void
      {
         _isLackHp = value;
      }
      
      public function get State() : int
      {
         return _state;
      }
      
      public function set State(value:int) : void
      {
         if(_state == value)
         {
            return;
         }
         _state = value;
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
      
      private function drawBlack(bmd:BitmapData) : void
      {
         var i:int = 0;
         var rect:Rectangle = new Rectangle(0,0,bmd.width,bmd.height);
         var pixels:Vector.<uint> = bmd.getVector(rect);
         var len:uint = pixels.length;
         for(i = 0; i < len; )
         {
            pixels[i] = pixels[i] >> 24 << 24 | 0 | 0 | 0;
            i++;
         }
         bmd.setVector(rect,pixels);
      }
      
      public function changeToNormal() : void
      {
         var t:TweenMax = TweenMax.to(blackBm,0.25,{"alpha":0});
         t.addEventListener("complete",setBlack);
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
      
      private function setBlack(event:TweenEvent) : void
      {
         TweenMax(event.target).removeEventListener("complete",setBlack);
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
      
      override public function doAction(actionType:*) : void
      {
         var playSuits:* = null;
         if(_currentAction.canReplace(actionType))
         {
            _currentAction = actionType;
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
                  playSuits = !!_info.getShowSuits()?"1":"2";
                  _ghostMovie.play(!!_info.Sex?"man" + playSuits:"girl" + playSuits);
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
      
      override public function setDefaultAction(actionType:*) : void
      {
         if(actionType is PlayerAction)
         {
            _currentAction = actionType;
         }
      }
      
      override protected function setContent() : void
      {
         var t:* = null;
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
               t = _loader.getContent();
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
                  if(_normalSuit && _normalSuit != t[6])
                  {
                     _normalSuit.dispose();
                  }
                  _normalSuit = t[6];
               }
               catch(e:Error)
               {
                  SocketManager.Instance.out.sendErrorMsg("客户端记录: GameCharacter3D:t[6]空对象" + getEquipID(6));
               }
               try
               {
                  if(_lackHpSuit && _lackHpSuit != t[7])
                  {
                     _lackHpSuit.dispose();
                  }
                  _lackHpSuit = t[7];
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
                  if(_spBitmapData && _spBitmapData != t[1])
                  {
                     var _loc12_:int = 0;
                     var _loc11_:* = _spBitmapData;
                     for each(var bmd in _spBitmapData)
                     {
                        bmd.dispose();
                     }
                  }
                  _spBitmapData = t[1];
               }
               catch(e:Error)
               {
                  SocketManager.Instance.out.sendErrorMsg("客户端记录: GameCharacter3D:t[1]空对象" + getEquipID(1));
               }
               try
               {
                  if(_faceupBitmapData && _faceupBitmapData != t[2])
                  {
                     _faceupBitmapData.dispose();
                  }
                  _faceupBitmapData = t[2];
               }
               catch(e:Error)
               {
                  SocketManager.Instance.out.sendErrorMsg("客户端记录: GameCharacter3D:t[2]空对象" + getEquipID(2));
               }
               try
               {
                  if(_faceBitmapData && _faceBitmapData != t[3])
                  {
                     _faceBitmapData.dispose();
                  }
                  _faceBitmapData = t[3];
               }
               catch(e:Error)
               {
                  SocketManager.Instance.out.sendErrorMsg("客户端记录: GameCharacter3D:t[3]空对象" + getEquipID(3));
               }
               try
               {
                  if(_lackHpFaceBitmapdata && _lackHpFaceBitmapdata != t[4])
                  {
                     var _loc18_:int = 0;
                     var _loc17_:* = _lackHpFaceBitmapdata;
                     for each(var bmd1 in _lackHpFaceBitmapdata)
                     {
                        bmd1.dispose();
                     }
                  }
                  _lackHpFaceBitmapdata = t[4];
               }
               catch(e:Error)
               {
                  SocketManager.Instance.out.sendErrorMsg("客户端记录: GameCharacter3D:t[4]空对象" + getEquipID(4));
               }
               try
               {
                  if(_faceDownBitmapdata && _faceDownBitmapdata != t[5])
                  {
                     _faceDownBitmapdata.dispose();
                  }
                  _faceDownBitmapdata = t[5];
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
      
      public function getEquipID(type:int) : String
      {
         var id:int = 0;
         var _recordStyle:* = null;
         var str:* = null;
         try
         {
            _recordStyle = _info.Style.split(",");
            str = " type: " + type;
            switch(int(type) - 1)
            {
               case 0:
                  str = str + String(_recordStyle[5].split("|")[0]);
                  break;
               case 1:
                  str = str + (String(_recordStyle[1].split("|")[0]) + String(_recordStyle[0].split("|")[0]) + String(_recordStyle[3].split("|")[0]) + String(_recordStyle[4].split("|")[0]) + String(_recordStyle[2].split("|")[0]));
                  break;
               case 2:
               case 3:
                  str = str + String(_recordStyle[5].split("|")[0]);
                  break;
               case 4:
                  str = str + String(_recordStyle[6].split("|")[0]);
                  break;
               case 5:
               case 6:
                  str = str + (String(_recordStyle[6].split("|")[0]) + "|" + String(_recordStyle[7].split("|")[0]));
            }
         }
         catch(e:Error)
         {
            var _loc6_:String = " 记录取 style失败!";
            return _loc6_;
         }
         return str;
      }
      
      private function checkHasSuitsSoul(suit:BitmapData) : Boolean
      {
         var m:int = 0;
         var n:int = 0;
         if(!suit)
         {
            return false;
         }
         var pos:Point = new Point(_characterWidth * 11 - _characterWidth / 2,_characterHeight * 3 - _characterHeight / 2);
         for(m = pos.x - 5; m < pos.x + 5; )
         {
            for(n = pos.y - 5; n < pos.y + 5; )
            {
               if(suit.getPixel(m,n) != 0)
               {
                  return true;
               }
               n++;
            }
            m++;
         }
         return false;
      }
      
      public function switchWingVisible(v:Boolean) : void
      {
         if(_leftWing)
         {
            _leftWing.visible = v;
         }
         if(_rightWing)
         {
            _rightWing.visible = v;
         }
      }
      
      public function setWingPos(xPos:Number, yPos:Number) : void
      {
         if(_leftWing)
         {
            _leftWing.x = xPos;
            _leftWing.y = yPos;
         }
         if(_rightWing)
         {
            _rightWing.x = xPos;
            _rightWing.y = yPos;
         }
      }
      
      public function setWingScale(xScale:Number, yScale:Number) : void
      {
         if(_leftWing)
         {
            _leftWing.scaleX = xScale;
            _leftWing.scaleY = yScale;
         }
         if(_rightWing)
         {
            _rightWing.scaleX = xScale;
            _rightWing.scaleY = yScale;
         }
      }
      
      public function set WingState($wingState:String) : void
      {
         var realState:* = $wingState;
         if(_leftWing)
         {
            realState = $wingState == "shot"?"shot":"stand";
         }
         if(_wingState == realState)
         {
            return;
         }
         _wingState = realState;
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
         var leftName:* = null;
         var rightName:* = null;
         var id:int = _info.Style.split(",")[8].split("|")[0];
         if(!_leftWing && !_rightWing && id != 15001)
         {
            leftName = "bonesGameWing" + id + "left";
            rightName = "bonesGameWing" + id + "right";
            if(BoneMovieFactory.instance.model.getBonesStyle(leftName) != null)
            {
               _leftWing = BoneMovieFactory.instance.creatBoneMovie(leftName,0,"fighting3d");
            }
            _rightWing = BoneMovieFactory.instance.creatBoneMovie(rightName,0,"fighting3d");
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
      
      private function __onLoadWingComplete(e:Event) : void
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
      
      public function updateBuffEffect(buffId:int, show:Boolean) : void
      {
         if(buffId == 304)
         {
            StarlingObjectUtils.disposeObject(_buffEffect);
            _buffEffect = StarlingMain.instance.createImage("game_toxicosis","game.view.playerToxicosisPos");
         }
         if(show && _buffEffect)
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
         var i:int = 0;
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
            for(i = 0; i < _cryBmps.length; )
            {
               ObjectUtils.disposeObject(_cryBmps[i]);
               _cryBmps[i] = null;
               i++;
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
         var i:int = 0;
         var frame:int = 0;
         var tempMatrix:* = null;
         var tempBitmapData:* = null;
         var j:int = 0;
         var tempRect:* = null;
         var n:* = NaN;
         var tempPoint:Point = new Point(0,0);
         if(_info.getShowSuits())
         {
            _soulFace = new BitmapData(_normalSuit.width,_normalSuit.height,true,0);
            for(i = 0; i < 4; )
            {
               tempPoint.x = _characterWidth * i;
               _soulFace.copyPixels(_lackHpSuit,_frames[36],tempPoint,null,null,true);
               i++;
            }
         }
         else
         {
            _soulFace = new BitmapData(_faceBitmapData.width,_faceBitmapData.height,true,0);
            frame = 0;
            tempMatrix = new Matrix();
            tempBitmapData = new BitmapData(_faceBitmapData.width,_faceBitmapData.height,true,0);
            for(j = 0; j < 4; )
            {
               tempPoint.x = _characterWidth * j;
               switch(int(j))
               {
                  case 0:
                     frame = 0;
                     break;
                  case 1:
                     frame = 10;
                     break;
                  case 2:
                     frame = 14;
                     break;
                  case 3:
                     frame = 17;
               }
               tempPoint.x = _characterWidth * j;
               _soulFace.copyPixels(_faceBitmapData,_frames[frame],tempPoint,null,null,true);
               j++;
            }
            tempMatrix.scale(0.75,0.75);
            var _loc9_:int = 0;
            tempPoint.y = _loc9_;
            tempPoint.x = _loc9_;
            tempBitmapData.draw(_soulFace,tempMatrix,null,null,null,true);
            tempRect = new Rectangle(0,0,_characterWidth,_characterHeight);
            _soulFace.fillRect(_soulFace.rect,0);
            for(n = 0; n < 4; )
            {
               tempRect.x = n * _characterWidth * 0.75;
               tempPoint.x = _characterWidth * n + 7;
               tempPoint.y = 5;
               _soulFace.copyPixels(_faceDownBitmapdata,_frames[36],new Point(n * _characterWidth,0),null,null,true);
               _soulFace.copyPixels(tempBitmapData,tempRect,tempPoint,null,null,true);
               _soulFace.copyPixels(_faceupBitmapData,_frames[36],new Point(n * _characterWidth,0),null,null,true);
               n++;
            }
            _loc9_ = 0;
            tempPoint.y = _loc9_;
            tempPoint.x = _loc9_;
            _soulFace.applyFilter(_soulFace,_soulFace.rect,tempPoint,grayFilter);
            tempBitmapData.dispose();
         }
      }
      
      private function drawBomd() : void
      {
         var blackBmd:BitmapData = new BitmapData(_body.width,_body.height,true,0);
         blackBmd.fillRect(new Rectangle(0,0,blackBmd.height,blackBmd.height),0);
         if(_info.getShowSuits())
         {
            blackBmd.copyPixels(_normalSuit,_frames[1],_frameStartPoint,null,null,true);
         }
         else
         {
            blackBmd.copyPixels(_faceDownBitmapdata,_frames[1],_frameStartPoint,null,null,true);
            blackBmd.copyPixels(_faceBitmapData,_frames[1],_frameStartPoint,null,null,true);
            blackBmd.copyPixels(_faceupBitmapData,_frames[1],_frameStartPoint,null,null,true);
         }
         drawBlack(blackBmd);
         StarlingObjectUtils.disposeObject(blackBm,true);
         blackBm = Image.fromBitmap(new Bitmap(blackBmd),false);
      }
      
      override public function drawFrame(frame:int, type:int = 0, clearOld:Boolean = true) : void
      {
         var bmd:BitmapData = null;
         if(type == 1)
         {
            bmd = _faceDownBitmapdata;
         }
         else if(type == 2)
         {
            if(_lackHpFaceBitmapdata)
            {
               bmd = _lackHpFaceBitmapdata[_specialType];
            }
         }
         else if(type == 3)
         {
            if(_currentAction == CRY && _cryType > 0)
            {
               bmd = _tempCryFace;
            }
            else
            {
               bmd = _faceBitmapData;
            }
         }
         else if(type == 4)
         {
            bmd = _faceupBitmapData;
         }
         else if(type == 5)
         {
            if(_spBitmapData)
            {
               bmd = _spBitmapData[_specialType];
            }
         }
         else if(type == 6)
         {
            bmd = _normalSuit;
         }
         else if(type == 7)
         {
            bmd = _lackHpSuit;
         }
         else if(type == 8)
         {
            bmd = _soulFace;
         }
         if(_currentAction == SOUL)
         {
            if(closeEys < 4)
            {
               frame = 1;
            }
            else if(Math.random() < 0.008)
            {
               closeEys = 0;
            }
            closeEys = Number(closeEys) + 1;
         }
         if(bmd != null)
         {
            if(frame < 0 || frame >= _frames.length)
            {
               frame = 0;
            }
            _currentframe = frame;
            if(clearOld)
            {
               _body.bitmapData.fillRect(_rect,0);
            }
            if(_currentAction == CRY && (type == 2 || type == 3))
            {
               _body.bitmapData.copyPixels(bmd,_frames[frame - _cryTypes[_cryType]],_frameStartPoint,null,null,true);
            }
            else
            {
               _body.bitmapData.copyPixels(bmd,_frames[frame],_frameStartPoint,null,null,true);
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
            if(frame < 0 || frame >= _frames.length)
            {
               frame = 0;
            }
            _currentframe = frame;
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
      
      public function set useLackHpSuit(value:Boolean) : void
      {
         _useLackHpSuit = value;
      }
      
      public function get useLackHpTurn() : int
      {
         return _useLackHpTurn;
      }
      
      public function set useLackHpTurn(value:int) : void
      {
         _useLackHpTurn = value;
      }
   }
}
