package ddt.view.character
{
   import com.greensock.TweenMax;
   import com.greensock.events.TweenEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.PlayerAction;
   import ddt.data.EquipType;
   import ddt.data.player.PlayerInfo;
   import ddt.utils.BitmapUtils;
   import ddt.view.characterStarling.IGameCharacter;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setTimeout;
   import road7th.utils.StringHelper;
   
   public class GameCharacter extends BaseCharacter implements IGameCharacter
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
      
      public static const GAME_WING_WAIT:int = 1;
      
      public static const GAME_WING_MOVE:int = 2;
      
      public static const GAME_WING_CRY:int = 3;
      
      public static const GAME_WING_CLIP:int = 4;
      
      public static const GAME_WING_SHOOT:int = 5;
       
      
      private var _currentAction:PlayerAction;
      
      private var _defaultAction:PlayerAction;
      
      private var _wing:MovieClip;
      
      private var _ghostMovie:MovieClip;
      
      private var _ghostShine:MovieClip;
      
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
      
      private var _defaultFace:BitmapData;
      
      private var _tempCryFace:BitmapData;
      
      private var _cryTypes:Array;
      
      private var _cryType:int;
      
      private var _specialType:int = 0;
      
      private var _state:int = 1;
      
      private var _rect:Rectangle;
      
      private var _hasSuitSoul:Boolean = true;
      
      private var _cryFrace:Sprite;
      
      private var _cryBmps:Vector.<Bitmap>;
      
      private var _useLackHpSuit:Boolean = false;
      
      private var _useLackHpTurn:int = -1;
      
      private var _dynamicWeapon:MovieClip;
      
      private var _weaponStyleName:String;
      
      protected var _colors:Array;
      
      private var _isLackHp:Boolean;
      
      private var _hasChangeToLackHp:Boolean;
      
      private var _index:int;
      
      private var _isPlaying:Boolean = false;
      
      private var black:Boolean;
      
      private var blackBm:Bitmap;
      
      private var blackEyes:MovieClip;
      
      private var _wingState:int = 0;
      
      private var closeEys:int;
      
      public function GameCharacter(info:PlayerInfo)
      {
         _frameStartPoint = new Point(0,0);
         _cryTypes = [0,16,13,10];
         _index = 90 * Math.random();
         super(info,true);
         _weaponStyleName = "game_weapon_" + info.WeaponID;
         _defaultAction = STAND;
         _currentAction = STAND;
         _body.x = _body.x - 62;
         _body.y = _body.y - 83;
         _defaultFace = ComponentFactory.Instance.creatBitmapData("game.player.gameCharacter");
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
         ObjectUtils.disposeAllChildren(_cryFrace);
         _cryFrace = null;
         _colors = color.split("|");
         _cryFrace = new Sprite();
         _cryBmps = new Vector.<Bitmap>(3);
         _cryBmps[0] = ComponentFactory.Instance.creatBitmap("asset.game.character.cryFaceAsset");
         _cryFrace.addChild(_cryBmps[0]);
         _cryBmps[1] = ComponentFactory.Instance.creatBitmap("asset.game.character.cryChangeColorAsset");
         _cryFrace.addChild(_cryBmps[1]);
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
                  _cryFrace.addChild(lightBitmap);
               }
               else if(_cryBmps[i])
               {
                  _cryBmps[i].transform.colorTransform = new ColorTransform();
               }
               i++;
            }
         }
         _tempCryFace = new BitmapData(_cryFrace.width,_cryFrace.height,true,0);
         _tempCryFace.draw(_cryFrace,null,null,"normal");
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         if(evt.altKey)
         {
            _currentAction = SOUL_SMILE;
         }
         else if(evt.ctrlKey)
         {
            _currentAction = SOUL_MOVE;
         }
         else
         {
            _currentAction = SOUL;
         }
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
         return -_characterWidth / 2 - 5;
      }
      
      public function get weaponY() : int
      {
         return -_characterHeight + 12;
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
            blackBm.alpha = 1;
            addChild(blackBm);
            setTimeout(blackEyes.gotoAndPlay,300,1);
            addChild(blackEyes);
            if(contains(_body))
            {
               removeChild(_body);
            }
            switchWingVisible(false);
            setTimeout(changeToNormal,2000);
         }
      }
      
      override protected function init() : void
      {
         _currentframe = -1;
         initSizeAndPics();
         createFrames();
         _body = new Bitmap(new BitmapData(_characterWidth,_characterHeight,true,0),"auto",true);
         addChild(_body);
         mouseEnabled = false;
         mouseChildren = false;
         _loadCompleted = false;
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
         if(blackEyes.parent)
         {
            removeChild(blackEyes);
         }
         addChild(_body);
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
         if(blackBm && blackBm.parent)
         {
            removeChild(blackBm);
         }
         black = false;
      }
      
      private function clearBomded() : void
      {
         black = false;
         if(blackEyes && blackEyes.parent)
         {
            removeChild(blackEyes);
         }
         if(blackBm && blackBm.parent)
         {
            removeChild(blackBm);
         }
         addChild(_body);
      }
      
      public function get standAction() : PlayerAction
      {
         if(State == 1 || _info.getShowSuits())
         {
            return STAND;
         }
         return STAND_LACK_HP;
      }
      
      public function get walkAction() : PlayerAction
      {
         if(State == 1 || _info.getShowSuits())
         {
            return WALK;
         }
         return WALK_LACK_HP;
      }
      
      public function get handClipAction() : PlayerAction
      {
         if(State == 1 || _info.getShowSuits())
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
         var cStr:* = null;
         if(_currentAction.canReplace(actionType))
         {
            _currentAction = actionType;
            _index = 0;
         }
         if(_currentAction == STAND || _currentAction == STAND_LACK_HP)
         {
            if(_ghostMovie && _ghostMovie.parent)
            {
               _ghostMovie.parent.removeChild(_ghostMovie);
            }
            filters = null;
            if(_ghostShine && _ghostShine.parent)
            {
               _ghostShine.parent.removeChild(_ghostShine);
            }
         }
         else if(isDead)
         {
            switchWingVisible(false);
            clearBomded();
            if(_ghostShine == null)
            {
               _ghostShine = ClassUtils.CreatInstance("asset.game.ghostShineAsset") as MovieClip;
            }
            _ghostShine.x = -28;
            _ghostShine.y = -50;
            if(_info.getShowSuits())
            {
               if(_hasSuitSoul)
               {
                  cStr = !!_info.Sex?"asset.game.ghostManMovieAsset1":"asset.game.ghostGirlMovieAsset1";
                  if(_ghostMovie == null)
                  {
                     _ghostMovie = ClassUtils.CreatInstance(cStr) as MovieClip;
                  }
                  addChildAt(_ghostMovie,0);
                  _ghostMovie.x = -26;
                  _ghostMovie.y = -50;
               }
               else
               {
                  if(_ghostMovie == null)
                  {
                     _ghostMovie = ClassUtils.CreatInstance("asset.game.ghostMovieAsset") as MovieClip;
                  }
                  addChildAt(_ghostMovie,0);
               }
            }
            else
            {
               cStr = !!_info.Sex?"asset.game.ghostManMovieAsset":"asset.game.ghostGirlMovieAsset";
               if(_ghostMovie && _ghostMovie.parent)
               {
                  _ghostMovie.parent.removeChild(_ghostMovie);
                  _ghostMovie = null;
               }
               _ghostMovie = ClassUtils.CreatInstance(cStr) as MovieClip;
               addChild(_ghostMovie);
               _ghostMovie.x = -26;
               _ghostMovie.y = -50;
            }
            filters = [new GlowFilter(7564475,1,6,6,2)];
            addChild(_ghostShine);
         }
         else
         {
            if(_ghostMovie && _ghostMovie.parent)
            {
               _ghostMovie.parent.removeChild(_ghostMovie);
            }
            filters = null;
            if(_ghostShine && _ghostShine.parent)
            {
               _ghostShine.parent.removeChild(_ghostShine);
            }
         }
         if(leftWing && leftWing.totalFrames == 2 && rightWing && rightWing.totalFrames == 2)
         {
            if(_currentAction == STAND || _currentAction == STAND_LACK_HP)
            {
               WingState = 1;
               if(leftWing && leftWing["movie"] && rightWing && rightWing["movie"])
               {
                  leftWing["movie"].gotoAndStop(1);
                  rightWing["movie"].gotoAndStop(1);
               }
            }
            else if(leftWing && leftWing["movie"] && rightWing && rightWing["movie"])
            {
               leftWing["movie"].play();
               rightWing["movie"].play();
            }
         }
         else if(_currentAction == STAND || _currentAction == STAND_LACK_HP)
         {
            WingState = 1;
            if(leftWing && leftWing["movie"] && rightWing && rightWing["movie"])
            {
               leftWing["movie"].gotoAndStop(1);
               rightWing["movie"].gotoAndStop(1);
            }
         }
         else if(_currentAction == WALK || _currentAction == WALK_LACK_HP)
         {
            if(leftWing && leftWing["movie"] && rightWing && rightWing["movie"])
            {
               leftWing["movie"].play();
               rightWing["movie"].play();
            }
         }
         else if(_currentAction == CRY)
         {
            if(leftWing && leftWing["movie"] && rightWing && rightWing["movie"])
            {
               leftWing["movie"].play();
               rightWing["movie"].play();
            }
         }
         else if(_currentAction == HANDCLIP || _currentAction == HANDCLIP_LACK_HP)
         {
            if(leftWing && leftWing["movie"] && rightWing && rightWing["movie"])
            {
               leftWing["movie"].play();
               rightWing["movie"].play();
            }
         }
         else if(_currentAction == SHOWGUN || _currentAction == SHOWTHROWS)
         {
            if(leftWing && leftWing["movie"] && rightWing && rightWing["movie"])
            {
               leftWing["movie"].play();
               rightWing["movie"].play();
            }
         }
         else if(leftWing && leftWing["movie"] && rightWing && rightWing["movie"])
         {
            leftWing["movie"].play();
            rightWing["movie"].play();
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
               if(_ghostMovie)
               {
                  ObjectUtils.disposeObject(_ghostMovie);
               }
               _ghostMovie = null;
            }
            t = _loader.getContent();
            if(_info.getShowSuits())
            {
               if(_normalSuit && _normalSuit != t[6])
               {
                  _normalSuit.dispose();
               }
               _normalSuit = t[6];
               if(_lackHpSuit && _lackHpSuit != t[7])
               {
                  _lackHpSuit.dispose();
               }
               _lackHpSuit = t[7];
               _hasSuitSoul = checkHasSuitsSoul(_lackHpSuit);
               if(_ghostMovie)
               {
                  ObjectUtils.disposeObject(_ghostMovie);
               }
               _ghostMovie = null;
            }
            else
            {
               if(_spBitmapData && _spBitmapData != t[1])
               {
                  var _loc5_:int = 0;
                  var _loc4_:* = _spBitmapData;
                  for each(var bmd in _spBitmapData)
                  {
                     bmd.dispose();
                  }
               }
               _spBitmapData = t[1];
               if(_faceupBitmapData && _faceupBitmapData != t[2])
               {
                  _faceupBitmapData.dispose();
               }
               _faceupBitmapData = t[2];
               if(_faceBitmapData && _faceBitmapData != t[3])
               {
                  _faceBitmapData.dispose();
               }
               _faceBitmapData = t[3];
               if(_lackHpFaceBitmapdata && _lackHpFaceBitmapdata != t[4])
               {
                  var _loc7_:int = 0;
                  var _loc6_:* = _lackHpFaceBitmapdata;
                  for each(var bmd1 in _lackHpFaceBitmapdata)
                  {
                     bmd1.dispose();
                  }
               }
               _lackHpFaceBitmapdata = t[4];
               if(_faceDownBitmapdata && _faceDownBitmapdata != t[5])
               {
                  _faceDownBitmapdata.dispose();
               }
               _faceDownBitmapdata = t[5];
            }
            if(getQualifiedClassName(_wing) != getQualifiedClassName(t[0]))
            {
               removeWing();
               _wing = t[0];
               WingState = 1;
            }
            ObjectUtils.disposeObject(_dynamicWeapon);
            _dynamicWeapon = null;
            if(EquipType.isDynamicWeapon(_info.WeaponID) && getQualifiedClassName(_dynamicWeapon) != getQualifiedClassName(t[8]))
            {
               _dynamicWeapon = t[8];
               _dynamicWeapon.gotoAndPlay("stand");
               addChildAt(_dynamicWeapon,0);
            }
            drawBomd();
            drawSoul();
            CreateCryFrace(_info.Colors.split(",")[5]);
            _isPlaying = true;
            update();
         }
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
      
      private function removeWing() : void
      {
         if(_wing == null)
         {
            return;
         }
         if(rightWing && rightWing.parent)
         {
            rightWing.parent.removeChild(rightWing);
         }
         if(leftWing && leftWing.parent)
         {
            leftWing.parent.removeChild(leftWing);
         }
         _wing = null;
      }
      
      public function get dynamicWeapon() : MovieClip
      {
         return _dynamicWeapon;
      }
      
      public function switchWingVisible(v:Boolean) : void
      {
         if(leftWing && rightWing)
         {
            var _loc2_:* = v;
            leftWing.visible = _loc2_;
            rightWing.visible = _loc2_;
         }
      }
      
      public function setWingPos(xPos:Number, yPos:Number) : void
      {
         if(rightWing && leftWing)
         {
            var _loc3_:* = xPos;
            leftWing.x = _loc3_;
            rightWing.x = _loc3_;
            _loc3_ = yPos;
            leftWing.y = _loc3_;
            rightWing.y = _loc3_;
         }
      }
      
      public function setWingScale(xScale:Number, yScale:Number) : void
      {
         if(rightWing && leftWing)
         {
            var _loc3_:* = xScale;
            rightWing.scaleX = _loc3_;
            leftWing.scaleX = _loc3_;
            _loc3_ = yScale;
            rightWing.scaleY = _loc3_;
            leftWing.scaleY = _loc3_;
         }
      }
      
      public function set WingState($wingState:int) : void
      {
         _wingState = $wingState;
         if(leftWing && leftWing.totalFrames == 2 && rightWing && rightWing.totalFrames == 2)
         {
            if(_wingState == 5)
            {
               _wingState = 2;
            }
            else
            {
               _wingState = 1;
            }
         }
         if(leftWing && rightWing)
         {
            leftWing.gotoAndStop(_wingState);
            rightWing.gotoAndStop(_wingState);
         }
      }
      
      public function get WingState() : int
      {
         return _wingState;
      }
      
      public function get wing() : MovieClip
      {
         return _wing;
      }
      
      public function get leftWing() : MovieClip
      {
         if(_wing)
         {
            return _wing["leftWing"];
         }
         return null;
      }
      
      public function get rightWing() : MovieClip
      {
         if(_wing)
         {
            return _wing["rightWing"];
         }
         return null;
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         removeWing();
         ObjectUtils.disposeObject(_dynamicWeapon);
         _dynamicWeapon = null;
         ObjectUtils.disposeObject(_ghostMovie);
         _ghostMovie = null;
         ObjectUtils.disposeObject(_ghostShine);
         _ghostShine = null;
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
         ObjectUtils.disposeObject(_defaultFace);
         _defaultFace = null;
         if(_cryBmps)
         {
            for(i = 0; i < _cryBmps.length; )
            {
               ObjectUtils.disposeObject(_cryBmps[i]);
               _cryBmps[i] = null;
               i++;
            }
         }
         ObjectUtils.disposeAllChildren(_cryFrace);
         _cryFrace = null;
         ObjectUtils.disposeObject(blackBm);
         blackBm = null;
         ObjectUtils.disposeObject(blackEyes);
         blackEyes = null;
         super.dispose();
         _frameStartPoint = null;
         _cryBmps = null;
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
         blackBm = new Bitmap(blackBmd);
         blackBm.x = _body.x;
         blackBm.y = _body.y;
         if(blackEyes == null)
         {
            blackEyes = ClassUtils.CreatInstance("asset.game.bombedAsset1") as MovieClip;
            blackEyes.x = 8;
            blackEyes.y = -10;
         }
      }
      
      override public function drawFrame(frame:int, type:int = 0, clearOld:Boolean = true) : void
      {
         var bmd:* = null;
         if(type == 1)
         {
            bmd = _faceDownBitmapdata != null?_faceDownBitmapdata:_defaultFace;
         }
         else if(type == 2)
         {
            if(_lackHpFaceBitmapdata)
            {
               bmd = _lackHpFaceBitmapdata[_specialType];
            }
            else
            {
               bmd = _defaultFace;
            }
         }
         else if(type == 3)
         {
            if(_currentAction == CRY && _cryType > 0)
            {
               bmd = _tempCryFace != null?_tempCryFace:_defaultFace;
            }
            else
            {
               bmd = _faceBitmapData != null?_faceBitmapData:_defaultFace;
            }
         }
         else if(type == 4)
         {
            bmd = _faceupBitmapData != null?_faceupBitmapData:_defaultFace;
         }
         else if(type == 5)
         {
            if(_spBitmapData)
            {
               bmd = _spBitmapData[_specialType];
            }
            else
            {
               bmd = _defaultFace;
            }
         }
         else if(type == 6)
         {
            bmd = _normalSuit != null?_normalSuit:_defaultFace;
         }
         else if(type == 7)
         {
            bmd = _lackHpSuit != null?_lackHpSuit:_defaultFace;
         }
         else if(type == 8)
         {
            bmd = _soulFace != null?_soulFace:_defaultFace;
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
         if(bmd != _defaultFace)
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
            this.scaleX = -1;
         }
         else
         {
            if(frame < 0 || frame >= _frames.length)
            {
               frame = 0;
            }
            _currentframe = frame;
            _body.bitmapData.copyPixels(bmd,_frames[frame],_defaultStartPoint,null,null,true);
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
