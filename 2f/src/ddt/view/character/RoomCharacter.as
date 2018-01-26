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
      
      public function RoomCharacter(param1:PlayerInfo, param2:Boolean = false){super(null,null);}
      
      public static function getActionByWord(param1:String) : String{return null;}
      
      private static function get KEY_WORDS() : Dictionary{return null;}
      
      override public function set showGun(param1:Boolean) : void{}
      
      override protected function initLoader() : void{}
      
      override protected function setContent() : void{}
      
      public function setBodySize(param1:Number = 0.7) : void{}
      
      private function sortIndex() : void{}
      
      override protected function initSizeAndPics() : void{}
      
      protected function resetPicNum(param1:int, param2:int) : void{}
      
      override public function update() : void{}
      
      private function randomAction() : void{}
      
      override protected function __loadComplete(param1:ICharacterLoader) : void{}
      
      private function updateLight() : void{}
      
      private function callBack01(param1:BaseLightLayer) : void{}
      
      private function callBack02(param1:SinpleLightLayer) : void{}
      
      public function stopAnimation() : void{}
      
      public function playAnimation() : void{}
      
      private function stopAllMoiveClip() : void{}
      
      private function playAllMoiveClip() : void{}
      
      private function restoreAnimationState() : void{}
      
      private function stopMovieClip(param1:MovieClip) : void{}
      
      private function playMovieClip(param1:MovieClip) : void{}
      
      override public function doAction(param1:*) : void{}
      
      override protected function createFrames() : void{}
      
      override public function drawFrame(param1:int, param2:int = 0, param3:Boolean = true) : void{}
      
      public function bodyOffset() : void{}
      
      public function bodyReset() : void{}
      
      override public function dispose() : void{}
   }
}
