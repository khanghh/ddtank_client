package petIsland.view
{
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.greensock.easing.Elastic;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.sceneCharacter.SceneCharacterLoaderHead;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import petIsland.PetIslandManager;
   import petIsland.event.PetIslandEvent;
   
   public class PetIslandView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _returnBtn:PetIslandReturnBar;
      
      private var _mask:Shape;
      
      private var _contain:Sprite;
      
      private var numberArr:Array;
      
      private var pList:Array;
      
      private var points:int = 0;
      
      private var nowPoints:int = 0;
      
      private var flyFlash:MovieClip;
      
      private var _buyBtn:BaseButton;
      
      private var _buySkillTwoBtn:BaseButton;
      
      private var _helpBtn:BaseButton;
      
      private var _playerMathContain:Sprite;
      
      private var _npcMathContain:Sprite;
      
      private var _roundMc:Sprite;
      
      private var _beginBtn:BaseButton;
      
      private var _playerScore:Bitmap;
      
      private var _npcScore:Bitmap;
      
      private var _begin:Bitmap;
      
      private var _continue:Bitmap;
      
      private var _roundTxt:FilterFrameText;
      
      private var _playerBloodTxt:FilterFrameText;
      
      private var _npcBloodTxt:FilterFrameText;
      
      private var _bloodContain:Sprite;
      
      private var _info:FilterFrameText;
      
      private var _currentStep:int;
      
      private var _playerBlood:Bitmap;
      
      private var playerMask:Sprite;
      
      private var _npcBlood:Bitmap;
      
      private var npcMask:Sprite;
      
      private var prizeView:PetIslandPrizeView;
      
      private var bloodFlash:MovieClip;
      
      private var success:MovieClip;
      
      private var fail:MovieClip;
      
      private var beginFlash:MovieClip;
      
      private var npcHead:MovieClip;
      
      private var playerHead:Sprite;
      
      private var blackBg:Sprite;
      
      private var stopPlayBlackBg:Sprite;
      
      private var _headLoader:SceneCharacterLoaderHead;
      
      private var _headBitmap:Bitmap;
      
      private var _skillTimesTxt:FilterFrameText;
      
      private var _skillTimesTxt1:FilterFrameText;
      
      private var _redBall:Bitmap;
      
      private var _redBallTwo:Bitmap;
      
      private var tweenFlag:Boolean = true;
      
      private var _helpframe:Frame;
      
      private var _bgHelp:Scale9CornerImage;
      
      private var _content:MovieClip;
      
      private var _btnOk:TextButton;
      
      private var gameOver:Boolean = false;
      
      private var alert:BaseAlerFrame;
      
      private var alart1:BaseAlerFrame;
      
      private var useSkillType:int;
      
      private var canClickNum:int = 0;
      
      private var canClick:Boolean = true;
      
      private var isMove:Boolean = false;
      
      private var saveDestroyArr:Array;
      
      private var useSkillScore:int = 0;
      
      public function PetIslandView(){super();}
      
      private function loadHead() : void{}
      
      private function headLoaderCallBack(param1:SceneCharacterLoaderHead, param2:Boolean = true) : void{}
      
      private function initData() : void{}
      
      private function setBegin() : void{}
      
      private function setSaveLifeCount() : void{}
      
      private function setStep() : void{}
      
      private function setPlayerScore() : void{}
      
      private function setNpcScore() : void{}
      
      private function initView() : void{}
      
      private function stepChangeHandler(param1:PetIslandEvent) : void{}
      
      private function refresh(param1:PetIslandEvent = null) : void{}
      
      private function initEvent() : void{}
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void{}
      
      private function __helpFrameRespose(param1:FrameEvent) : void{}
      
      private function __closeHelpFrame(param1:MouseEvent) : void{}
      
      private function completeHandler(param1:Event) : void{}
      
      private function __useSkillChange(param1:PetIslandEvent) : void{}
      
      private function __useSkillTwoChange(param1:PetIslandEvent) : void{}
      
      private function __saveLifeCountChange(param1:PetIslandEvent) : void{}
      
      private function __currentLevelChange(param1:PetIslandEvent) : void{}
      
      private function doSuccess() : void{}
      
      private function __opentypeChange(param1:PetIslandEvent) : void{}
      
      private function __playerBloodChange(param1:PetIslandEvent) : void{}
      
      private function __npcBloodChange(param1:PetIslandEvent) : void{}
      
      private function __rewardRecordChange(param1:PetIslandEvent) : void{}
      
      private function __stepChange(param1:PetIslandEvent) : void{}
      
      private function __currentRoundChange(param1:PetIslandEvent) : void{}
      
      private function __beginBtnClickHandler(param1:MouseEvent) : void{}
      
      private function __onRecoverResponse(param1:FrameEvent) : void{}
      
      private function __onRecoverResponse1(param1:FrameEvent) : void{}
      
      private function __buySkillTwoBtnClickHandler(param1:MouseEvent) : void{}
      
      private function __buyBtnClickHandler(param1:MouseEvent) : void{}
      
      private function _npcScoreChange(param1:PetIslandEvent) : void{}
      
      private function _playerScoreChange(param1:PetIslandEvent) : void{}
      
      private function __petClickHandler(param1:PetIslandEvent) : void{}
      
      private function clearShine() : void{}
      
      private function __onReturn(param1:PetIslandEvent) : void{}
      
      private function checkOneTypeAll() : void{}
      
      private function crossDestroy(param1:int = 3, param2:int = 3) : void{}
      
      private function checkAndDestroy() : void{}
      
      private function flyFlashCom() : void{}
      
      private function __destroyHandler(param1:PetIslandEvent) : void{}
      
      private function tweenComplete(param1:FilterFrameText) : void{}
      
      private function dropBlock() : void{}
      
      private function swap(param1:Array, param2:Array) : void{}
      
      private function checkRoundShine(param1:int, param2:int) : Array{return null;}
      
      private function randomInt(param1:int) : int{return 0;}
      
      private function checkArr(param1:int, param2:int, param3:Array) : Boolean{return false;}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
