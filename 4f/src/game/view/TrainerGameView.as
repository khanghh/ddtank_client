package game.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.QueueLoader;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.loader.LoaderCreate;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.states.BaseStateView;
   import ddt.utils.PositionUtils;
   import ddt.view.character.GameCharacter;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import game.gametrainer.objects.TrainerEquip;
   import game.gametrainer.objects.TrainerWeapon;
   import game.objects.GamePlayer;
   import gameCommon.GameControl;
   import gameCommon.model.Living;
   import road7th.data.DictionaryEvent;
   import road7th.utils.MovieClipWrapper;
   import trainer.TrainStep;
   import trainer.controller.NewHandGuideManager;
   import trainer.controller.NewHandQueue;
   import trainer.data.Step;
   import trainer.view.NewHandContainer;
   
   public class TrainerGameView extends GameView
   {
       
      
      private const eatOffset:int = -10;
      
      private var _player:GamePlayer;
      
      private var _shouldShowTurn:Boolean;
      
      private var _locked:Boolean;
      
      private var _picked:Boolean;
      
      private var _count:int;
      
      private var _dieNum:int;
      
      private var _weapon:TrainerWeapon;
      
      private var _equip:TrainerEquip;
      
      private var bogu:Living;
      
      private var toolForPick:MovieClip;
      
      public function TrainerGameView(){super();}
      
      override public function getType() : String{return null;}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      private function __onAudioIILoadComplete(param1:LoaderEvent) : void{}
      
      private function __onAudioLoadComplete(param1:Event) : void{}
      
      private function reset() : void{}
      
      public function showPickWeapon() : void{}
      
      private function checkUserGuid() : void{}
      
      private function finBeatLivingRightF() : void{}
      
      private function preEnergyUIF() : void{}
      
      private function preEnergyUIFF() : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      private function showAchieve() : void{}
      
      override protected function __playerChange(param1:CrazyTankSocketEvent) : void{}
      
      override protected function __shoot(param1:CrazyTankSocketEvent) : void{}
      
      public function set shouldShowTurn(param1:Boolean) : void{}
      
      public function skip() : void{}
      
      private function enableSpace(param1:Boolean) : void{}
      
      private function enableLeftAndRight(param1:Boolean) : void{}
      
      private function enableUpAndDown(param1:Boolean) : void{}
      
      private function __keyDownSpace(param1:KeyboardEvent) : void{}
      
      private function __keyDownLeftRight(param1:KeyboardEvent) : void{}
      
      private function __keyDownUpDown(param1:KeyboardEvent) : void{}
      
      private function preMoveUI() : void{}
      
      private function exeMoveUI() : Boolean{return false;}
      
      private function preMove() : void{}
      
      private function exeMove() : Boolean{return false;}
      
      private function __playerPropChanged(param1:PlayerPropertyEvent) : void{}
      
      private function setDefaultAngle() : void{}
      
      private function headWeaponEffect() : void{}
      
      private function headEquipEffect() : void{}
      
      private function headEffect(param1:DisplayObject) : void{}
      
      private function finMove() : void{}
      
      private function preSpawn() : void{}
      
      private function exeSpawn() : Boolean{return false;}
      
      private function preTipOne() : void{}
      
      private function exeTipOne() : Boolean{return false;}
      
      private function finTipOne() : void{}
      
      private function preEnergyUI() : void{}
      
      private function exeEnergyUI() : Boolean{return false;}
      
      private function preBeatLivingRight() : void{}
      
      private function exeBeatLivingRight() : Boolean{return false;}
      
      private function finBeatLivingRight() : void{}
      
      private function preBeatLivingLeft() : void{}
      
      private function exeBeatLivingLeft() : Boolean{return false;}
      
      private function finBeatLivingLeft() : void{}
      
      private function prePickOne() : void{}
      
      private function exePickOne() : Boolean{return false;}
      
      private function finPickOne() : void{}
      
      private function __addBogu(param1:DictionaryEvent) : void{}
      
      private function disposeBogu() : void{}
      
      private function lockMap() : void{}
      
      private function preOneGlow() : void{}
      
      private function exeOneGlow() : Boolean{return false;}
      
      private function finOneGlow() : void{}
      
      private function preAngle() : void{}
      
      private function exeAngle() : Boolean{return false;}
      
      private function finAngle() : void{}
      
      private function preSmallBogu() : void{}
      
      private function exeSmallBogu() : Boolean{return false;}
      
      private function finSmallBogu() : void{}
      
      private function preBigBogu() : void{}
      
      private function showTurn() : void{}
      
      private function exeBigBogu() : Boolean{return false;}
      
      private function finBigBogu() : void{}
      
      private function prePickTen() : void{}
      
      private function exePickTen() : Boolean{return false;}
      
      private function finPickTen() : void{}
      
      private function prePickPower() : void{}
      
      private function __onAddLiving(param1:DictionaryEvent) : void{}
      
      private function __onLivingDie(param1:LivingEvent) : void{}
      
      private function exePickPower() : Boolean{return false;}
      
      private function finPickPower() : void{}
      
      private function preArrowThree() : void{}
      
      private function __add(param1:DictionaryEvent) : void{}
      
      private function __die(param1:LivingEvent) : void{}
      
      private function exeArrowThree() : Boolean{return false;}
      
      private function finArrowThree() : void{}
      
      private function preArrowPower() : void{}
      
      private function exeArrowPower() : Boolean{return false;}
      
      private function finArrowPower() : void{}
      
      private function prePickPlane() : void{}
      
      private function exePickPlane() : Boolean{return false;}
      
      private function finPickPlane() : void{}
      
      private function __showThreeArrow(param1:LivingEvent) : void{}
      
      private function __showPowerArrow(param1:LivingEvent) : void{}
      
      private function __showArrow(param1:LivingEvent) : void{}
      
      private function preBeatJianjiaoBogu() : void{}
      
      private function __addJianjiaoBogu(param1:DictionaryEvent) : void{}
      
      private function exeBeatJianjiaoBogu() : Boolean{return false;}
      
      private function finBeatJianjiaoBogu() : void{}
      
      private function prePickTwoTwenty() : void{}
      
      private function exePickTwoTwenty() : Boolean{return false;}
      
      private function finPickTwoTwenty() : void{}
      
      private function preBeatRobot() : void{}
      
      private function __addRobot(param1:DictionaryEvent) : void{}
      
      private function exeBeatRobot() : Boolean{return false;}
      
      private function finBeatRobot() : void{}
      
      private function prePickThreeFourFive() : void{}
      
      private function exePickThreeFourFive() : Boolean{return false;}
      
      private function finPickThreeFourFive() : void{}
      
      private function __missionOver(param1:CrazyTankSocketEvent) : void{}
      
      private function exeBeatBogu() : Boolean{return false;}
      
      private function creatToolForPick(param1:String) : void{}
      
      private function disposeToolForPick() : void{}
      
      private function __outHandler(param1:MouseEvent) : void{}
      
      private function __overHandler(param1:MouseEvent) : void{}
      
      private function __pickTool(param1:MouseEvent) : void{}
      
      private function toolFlyAway() : void{}
      
      private function disposeThis() : void{}
   }
}
