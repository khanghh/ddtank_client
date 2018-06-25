package ddt.view.character
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class RoomCharacter extends BaseCharacter
   {
      
      public static const STANDBY:String = "standBy";
      
      public static const CLOSE_EYES:String = "close_Eyes";
      
      public static const WANDERING:String = "wandering";
      
      public static const DAZED:String = "dazed";
      
      public static const SMILE:String = "smile";
      
      public static const SELF_SATISFIED:String = "selfSatisfied";
      
      public static const RUT:String = "rut";
      
      public static const WHISTLE:String = "whistle";
      
      public static const MUG:String = "mug";
      
      private static const RANDOM_EXPRESSION:Array = ["close_Eyes","wandering","dazed","smile","whistle"];
      
      public static const HAPPY:String = "happy";
      
      public static const LUAGH:String = "luagh";
      
      public static const NAUGHTY:String = "naughty";
      
      public static const SAD:String = "sad";
      
      public static const SARROWFUL:String = "sarrowful";
      
      public static const LOOK_AWRY:String = "look_awry";
      
      public static const ANGRY:String = "angry";
      
      public static const SULK:String = "sulk";
      
      public static const COLD:String = "cold";
      
      public static const DIZZY:String = "dizzy";
      
      public static const SUPRISE:String = "suprise";
      
      public static const SICK:String = "sick";
      
      public static const SLEEPING:String = "sleeping";
      
      public static const OH_MY_GOD:String = "oh_My_God";
      
      public static const LOVE:String = "love";
      
      private static var _keyWords:Dictionary;
       
      
      private var _faceUpBmd:BitmapData;
      
      private var _faceBmd:BitmapData;
      
      private var _hairBmd:BitmapData;
      
      private var _hairCurrentFrame:int;
      
      private var _armBmd:BitmapData;
      
      private var _armCurrentFrame:int;
      
      private var _suitBmd:BitmapData;
      
      private var _light1:MovieClip;
      
      private var _light2:MovieClip;
      
      private var _light01:BaseLightLayer;
      
      private var _light02:SinpleLightLayer;
      
      private var _wing:MovieClip;
      
      private var _currentAction:RoomPlayerAction;
      
      private var _showGun:Boolean;
      
      private var _recordNimbus:int = -1;
      
      private var _playAnimation:Boolean = true;
      
      private var _faceFrames:Array;
      
      private var _rect:Rectangle;
      
      private var _faceRect:Rectangle;
      
      private var _test:int = 0;
      
      public function RoomCharacter(info:PlayerInfo, showGun:Boolean = false)
      {
         _faceRect = new Rectangle(40,0,250,232);
         _currentAction = RoomPlayerAction.creatAction("standBy",info.getShowSuits());
         _showGun = showGun;
         super(info,true);
      }
      
      public static function getActionByWord(word:String) : String
      {
         var _loc4_:int = 0;
         var _loc3_:* = KEY_WORDS;
         for(var key in KEY_WORDS)
         {
            if(_keyWords[key].indexOf(word) > -1)
            {
               return key;
            }
         }
         return "standBy";
      }
      
      private static function get KEY_WORDS() : Dictionary
      {
         if(_keyWords == null)
         {
            _keyWords = new Dictionary();
            _keyWords["happy"] = LanguageMgr.GetTranslation("room.roomPlayerActionKey.HAPPY").split("|");
            _keyWords["luagh"] = LanguageMgr.GetTranslation("room.roomPlayerActionKey.LUAGH").split("|");
            _keyWords["naughty"] = LanguageMgr.GetTranslation("room.roomPlayerActionKey.NAUGHTY").split("|");
            _keyWords["sad"] = LanguageMgr.GetTranslation("room.roomPlayerActionKey.SAD").split("|");
            _keyWords["sarrowful"] = LanguageMgr.GetTranslation("room.roomPlayerActionKey.SARROWFUL").split("|");
            _keyWords["look_awry"] = LanguageMgr.GetTranslation("room.roomPlayerActionKey.LOOK_AWRY").split("|");
            _keyWords["angry"] = LanguageMgr.GetTranslation("room.roomPlayerActionKey.ANGRY").split("|");
            _keyWords["sulk"] = LanguageMgr.GetTranslation("room.roomPlayerActionKey.SULK").split("|");
            _keyWords["cold"] = LanguageMgr.GetTranslation("room.roomPlayerActionKey.COLD").split("|");
            _keyWords["dizzy"] = LanguageMgr.GetTranslation("room.roomPlayerActionKey.DIZZY").split("|");
            _keyWords["suprise"] = LanguageMgr.GetTranslation("room.roomPlayerActionKey.SUPRISE").split("|");
            _keyWords["sick"] = LanguageMgr.GetTranslation("room.roomPlayerActionKey.SICK").split("|");
            _keyWords["sleeping"] = LanguageMgr.GetTranslation("room.roomPlayerActionKey.SLEEPING").split("|");
            _keyWords["oh_My_God"] = LanguageMgr.GetTranslation("room.roomPlayerActionKey.OH_MY_GOD").split("|");
            _keyWords["love"] = LanguageMgr.GetTranslation("room.roomPlayerActionKey.LOVE").split("|");
         }
         return _keyWords;
      }
      
      override public function set showGun(value:Boolean) : void
      {
         _showGun = value;
      }
      
      override protected function initLoader() : void
      {
         _loader = _factory.createLoader(_info,"room");
         RoomCharaterLoader(_loader).showWeapon = _showGun;
      }
      
      override protected function setContent() : void
      {
         var _recordStyle:* = null;
         if(_loader != null)
         {
            if(_suitBmd && _suitBmd != _loader.getContent()[0])
            {
               _suitBmd.dispose();
            }
            _suitBmd = _loader.getContent()[0];
            if(_faceBmd && _faceBmd != _loader.getContent()[2])
            {
               _faceBmd.dispose();
            }
            _faceBmd = _loader.getContent()[2];
            if(_hairBmd && _hairBmd != _loader.getContent()[4])
            {
               _hairBmd.dispose();
            }
            _hairBmd = _loader.getContent()[4];
            if(_hairBmd && _hairBmd.width > characterWidth)
            {
               resetPicNum(1,_hairBmd.width / characterWidth);
            }
            if(_armBmd && _armBmd != _loader.getContent()[5])
            {
               _armBmd.dispose();
            }
            _armBmd = _loader.getContent()[5];
            if(_armBmd && _armBmd.width > characterWidth)
            {
               resetPicNum(1,_armBmd.width / characterWidth);
            }
            if(_faceUpBmd && _faceUpBmd != _loader.getContent()[1])
            {
               _faceUpBmd.dispose();
            }
            _faceUpBmd = _loader.getContent()[1];
            if(_wing && _wing.parent)
            {
               _wing.parent.removeChild(_wing);
            }
            _wing = _loader.getContent()[3];
            if(_wing && !_playAnimation)
            {
               stopMovieClip(_wing);
            }
         }
         _body.width = 120;
         _body.height = 165;
         _body.cacheAsBitmap = true;
         if(_info.getSuitsType() == 1)
         {
            _body.y = -13;
            _recordStyle = _info.Style.split(",");
            if(ItemManager.Instance.getTemplateById(int(_recordStyle[8].split("|")[0])).Property1 != "1")
            {
               if(_wing)
               {
                  _wing.y = -40;
               }
            }
         }
         else
         {
            _body.y = 0;
            if(_wing)
            {
               _wing.y = 0;
            }
         }
         sortIndex();
      }
      
      public function setBodySize(value:Number = 0.7) : void
      {
         var _loc2_:* = value;
         _body.scaleY = _loc2_;
         _body.scaleX = _loc2_;
      }
      
      private function sortIndex() : void
      {
         if(_light1 != null)
         {
            _container.addChild(_light1);
         }
         if(_wing != null && !_info.wingHide)
         {
            _container.addChild(_wing);
         }
         if(_body != null)
         {
            _container.addChild(_body);
         }
         if(_light2 != null)
         {
            _container.addChild(_light2);
         }
      }
      
      override protected function initSizeAndPics() : void
      {
         setCharacterSize(250,342);
         setPicNum(1,6);
         _rect = new Rectangle(0,0,_characterWidth,_characterHeight);
      }
      
      protected function resetPicNum(lines:int, perline:int) : void
      {
         setPicNum(lines,perline);
         createFrames();
      }
      
      override public function update() : void
      {
         if(!_currentAction.repeat && _currentAction.isEnd)
         {
            randomAction();
         }
         drawFrame(_currentAction.next());
         bodyOffset();
      }
      
      private function randomAction() : void
      {
         var seed:Number = Math.random();
         if(seed < 0.5)
         {
            _currentAction = RoomPlayerAction.creatAction("close_Eyes",_info.getShowSuits());
         }
         else
         {
            _currentAction = RoomPlayerAction.creatAction("wandering",_info.getShowSuits());
         }
      }
      
      override protected function __loadComplete(loader:ICharacterLoader) : void
      {
         super.__loadComplete(loader);
         updateLight();
      }
      
      private function updateLight() : void
      {
         if(_info == null)
         {
            return;
         }
         if(_recordNimbus != _info.Nimbus)
         {
            _recordNimbus = _info.Nimbus;
            if(_info.getHaveLight())
            {
               if(_light02)
               {
                  _light02.dispose();
               }
               _light02 = new SinpleLightLayer(_info.Nimbus);
               _light02.load(callBack02);
            }
            else
            {
               if(_light02)
               {
                  _light02.dispose();
               }
               if(_light2 && _light2.parent)
               {
                  _light2.parent.removeChild(_light2);
               }
               _light2 = null;
            }
            if(_info.getHaveCircle())
            {
               if(_light01)
               {
                  _light01.dispose();
               }
               if(_light1 && _light1.parent)
               {
                  _light1.parent.removeChild(_light1);
               }
               _light1 = null;
               _light01 = new BaseLightLayer(_info.Nimbus);
               _light01.load(callBack01);
            }
            else
            {
               if(_light01)
               {
                  _light01.dispose();
               }
               if(_light1 && _light1.parent)
               {
                  _light1.parent.removeChild(_light1);
               }
               _light1 = null;
            }
         }
      }
      
      private function callBack01($load:BaseLightLayer) : void
      {
         if(_light1 && _light1.parent)
         {
            _light1.parent.removeChild(_light1);
         }
         _light1 = $load.getContent() as MovieClip;
         if(_light1 != null)
         {
            _container.addChildAt(_light1,0);
            _light1.x = 47;
            _light1.y = 65;
         }
         restoreAnimationState();
         sortIndex();
      }
      
      private function callBack02($load:SinpleLightLayer) : void
      {
         if(_light2 && _light2.parent)
         {
            _light2.parent.removeChild(_light2);
         }
         _light2 = $load.getContent() as MovieClip;
         if(_light2 != null)
         {
            _container.addChild(_light2);
            _light2.x = 45;
            _light2.y = 126;
         }
         restoreAnimationState();
         sortIndex();
      }
      
      public function stopAnimation() : void
      {
         _playAnimation = false;
         stopAllMoiveClip();
      }
      
      public function playAnimation() : void
      {
         _playAnimation = true;
         playAllMoiveClip();
      }
      
      private function stopAllMoiveClip() : void
      {
         stopMovieClip(_light1);
         stopMovieClip(_light2);
         stopMovieClip(_wing);
      }
      
      private function playAllMoiveClip() : void
      {
         playMovieClip(_light1);
         playMovieClip(_light2);
         playMovieClip(_wing);
      }
      
      private function restoreAnimationState() : void
      {
         if(_playAnimation)
         {
            playAllMoiveClip();
         }
         else
         {
            stopAllMoiveClip();
         }
      }
      
      private function stopMovieClip(mc:MovieClip) : void
      {
         var i:int = 0;
         if(mc)
         {
            mc.gotoAndStop(1);
            if(mc.numChildren > 0)
            {
               for(i = 0; i < mc.numChildren; )
               {
                  stopMovieClip(mc.getChildAt(i) as MovieClip);
                  i++;
               }
            }
         }
      }
      
      private function playMovieClip(mc:MovieClip) : void
      {
         var i:int = 0;
         if(mc)
         {
            mc.gotoAndPlay(1);
            if(mc.numChildren > 0)
            {
               for(i = 0; i < mc.numChildren; )
               {
                  playMovieClip(mc.getChildAt(i) as MovieClip);
                  i++;
               }
            }
         }
      }
      
      override public function doAction(actionType:*) : void
      {
         if(actionType == "")
         {
            return;
         }
         _currentAction = RoomPlayerAction.creatAction(actionType,_info.getShowSuits());
      }
      
      override protected function createFrames() : void
      {
         var j:int = 0;
         var i:int = 0;
         var m:* = null;
         super.createFrames();
         _faceFrames = [];
         for(j = 0; j < _picLines; )
         {
            for(i = 0; i < _picsPerLine; )
            {
               m = new Rectangle(i * 250,j * 232,250,232);
               _faceFrames.push(m);
               i++;
            }
            j++;
         }
      }
      
      override public function drawFrame(frame:int, type:int = 0, clearOld:Boolean = true) : void
      {
         var hairMaxFrame:int = 0;
         var armMaxFrame:int = 0;
         _body.bitmapData.fillRect(_rect,0);
         if(_info.getShowSuits() && _suitBmd)
         {
            _body.bitmapData.copyPixels(_suitBmd,_frames[frame],new Point(0,0),null,null,true);
         }
         else if(_faceBmd != null && _faceUpBmd != null)
         {
            _body.bitmapData.copyPixels(_faceBmd,_frames[frame],new Point(0,0),null,null,true);
            if(_hairBmd)
            {
               hairMaxFrame = _hairBmd.width / characterWidth - 1;
               if(_hairCurrentFrame >= hairMaxFrame * 3)
               {
                  _hairCurrentFrame = 0;
               }
               else
               {
                  _hairCurrentFrame = Number(_hairCurrentFrame) + 1;
               }
               _body.bitmapData.copyPixels(_hairBmd,_frames[int(_hairCurrentFrame / 3)],new Point(0,0),null,null,true);
            }
            _body.bitmapData.copyPixels(_faceUpBmd,_frames[0],new Point(0,0),null,null,true);
         }
         if(_armBmd != null)
         {
            armMaxFrame = _armBmd.width / characterWidth - 1;
            if(_armCurrentFrame >= armMaxFrame * 3)
            {
               _armCurrentFrame = 0;
            }
            else
            {
               _armCurrentFrame = Number(_armCurrentFrame) + 1;
            }
            _body.bitmapData.copyPixels(_armBmd,_frames[int(_armCurrentFrame / 3)],new Point(0,0),null,null,true);
         }
      }
      
      public function bodyOffset() : void
      {
         var __style:String = _info.Style;
         var suitID:int = __style.split(",")[7].split("|")[0];
         if(!(int(suitID) - 13730))
         {
            _body.x = -12;
            _wing && _loc3_;
         }
         else
         {
            _body.x = 0;
            _wing && _loc3_;
         }
      }
      
      public function bodyReset() : void
      {
         _body.x = 0;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_faceUpBmd)
         {
            _faceUpBmd.dispose();
         }
         _faceUpBmd = null;
         if(_faceBmd)
         {
            _faceBmd.dispose();
         }
         _faceBmd = null;
         if(_hairBmd)
         {
            _hairBmd.dispose();
         }
         _hairBmd = null;
         if(_suitBmd)
         {
            _suitBmd.dispose();
         }
         _suitBmd = null;
         if(_light1)
         {
            ObjectUtils.disposeObject(_light1);
         }
         _light1 = null;
         if(_light2)
         {
            ObjectUtils.disposeObject(_light2);
         }
         _light2 = null;
         if(_light01)
         {
            ObjectUtils.disposeObject(_light01);
         }
         _light01 = null;
         if(_light02)
         {
            ObjectUtils.disposeObject(_light02);
         }
         _light02 = null;
         if(_wing)
         {
            ObjectUtils.disposeObject(_wing);
         }
         _wing = null;
         if(_armBmd)
         {
            _armBmd.dispose();
         }
         _armBmd = null;
         _currentAction = null;
         _keyWords = null;
         _hairCurrentFrame = 0;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
