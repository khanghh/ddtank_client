package hallIcon.view
{
   import BombTurnTable.BombTurnTableManager;
   import BraveDoor.BraveDoorManager;
   import DDPlay.DDPlayManaer;
   import GodSyah.SyahManager;
   import HappyRecharge.HappyRechargeManager;
   import Indiana.IndianaDataManager;
   import accumulativeLogin.AccumulativeManager;
   import angelInvestment.AngelInvestmentManager;
   import baglocked.BaglockedManager;
   import bank.BankManager;
   import campbattle.CampBattleManager;
   import catchInsect.CatchInsectManager;
   import catchbeast.CatchBeastManager;
   import chickActivation.ChickActivationManager;
   import christmas.ChristmasCoreManager;
   import cityBattle.CityBattleManager;
   import cloudBuyLottery.CloudBuyLotteryManager;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import conRecharge.ConRechargeManager;
   import condiscount.CondiscountManager;
   import consortionBattle.ConsortiaBattleManager;
   import dayActivity.DayActivityManager;
   import ddQiYuan.DDQiYuanManager;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.BattleGroudManager;
   import ddt.manager.BossBoxManager;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.DraftManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.PolarRegionManager;
   import ddt.manager.PyramidManager;
   import ddt.manager.RouletteManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.SurvivalModeManager;
   import ddt.view.FoodActivityEnterIcon;
   import ddt.view.bossbox.SmallBoxButton;
   import ddtKingWay.DDTKingWayManager;
   import ddtmatch.manager.DDTMatchManager;
   import devilTurn.DevilTurnManager;
   import entertainmentMode.EntertainmentModeManager;
   import escort.EscortManager;
   import exchangeAct.ExchangeActManager;
   import firstRecharge.FirstRechargeManger;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import flowerGiving.FlowerGivingManager;
   import foodActivity.FoodActivityManager;
   import godCardRaise.GodCardRaiseManager;
   import godOfWealth.GodOfWealthManager;
   import godsRoads.manager.GodsRoadsManager;
   import goldmine.GoldmineManager;
   import groupPurchase.GroupPurchaseManager;
   import growthPackage.GrowthPackageManager;
   import guildMemberWeek.manager.GuildMemberWeekManager;
   import hallIcon.HallIconManager;
   import hallIcon.event.HallIconEvent;
   import hallIcon.info.HallIconInfo;
   import hallIcon.model.ActivityEnterGrapType;
   import horseRace.controller.HorseRaceManager;
   import lanternriddles.LanternRiddlesManager;
   import littleGame.LittleControl;
   import lotteryTicket.LotteryManager;
   import luckStar.manager.LuckStarManager;
   import memoryGame.MemoryGameManager;
   import midAutumnWorshipTheMoon.WorshipTheMoonManager;
   import moneyTree.MoneyTreeManager;
   import mysteriousRoullete.MysteriousManager;
   import newChickenBox.NewChickenBoxManager;
   import newYearRice.NewYearRiceManager;
   import oldPlayerComeBack.OldPlayerComeBackManager;
   import oldPlayerRegress.RegressManager;
   import panicBuying.PanicBuyingManager;
   import quest.TaskManager;
   import rank.RankManager;
   import redEnvelope.RedEnvelopeManager;
   import rescue.RescueManager;
   import ringStation.RingStationManager;
   import roleRecharge.RoleRechargeMgr;
   import roulette.LeftGunRouletteManager;
   import sanXiao.SanXiaoManager;
   import sevenDayTarget.controller.NewSevenDayAndNewPlayerManager;
   import sevenDouble.SevenDoubleManager;
   import sevenday.SevendayManager;
   import shop.manager.ShopSaleManager;
   import signActivity.SignActivityMgr;
   import stock.StockMgr;
   import superWinner.manager.SuperWinnerManager;
   import team.TeamManager;
   import trainer.view.NewHandContainer;
   import treasureHunting.TreasureManager;
   import treasurePuzzle.controller.TreasurePuzzleManager;
   import wantstrong.WantStrongManager;
   import welfareCenter.WelfareCenterManager;
   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;
   import witchBlessing.WitchBlessingManager;
   import wonderfulActivity.WonderfulActivityManager;
   import zodiac.ZodiacManager;
   
   public class HallRightIconView extends Sprite implements Disposeable
   {
       
      
      private var _iconBox:HBox;
      
      private var _boxButton:SmallBoxButton;
      
      private var _wonderFulPlay:HallIconPanel;
      
      private var _everyDayActivityIcon:MovieClip;
      
      private var _activity:HallIconPanel;
      
      private var _wantstrongIcon:MovieClip;
      
      private var _firstRechargeIcon:MovieClip;
      
      private var _rankIcon:MovieClip;
      
      private var _cityBattleIcon:MovieClip;
      
      private var _lastCreatTime:Number;
      
      private var _foodButton:FoodActivityEnterIcon;
      
      private var _showArrowSp:Sprite;
      
      private var _polarIcon:MovieClip;
      
      private var _roleRechargeIcon:MovieClip;
      
      private var _clickTime:int = 0;
      
      public function HallRightIconView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __addIcon(param1:Event) : void{}
      
      private function addChildBox(param1:DisplayObject) : void{}
      
      private function __updateBatchIconViewHandler(param1:HallIconEvent) : void{}
      
      private function __updateIconViewHandler(param1:HallIconEvent) : void{}
      
      private function updateIconView(param1:HallIconInfo) : void{}
      
      private function checkFoodBox() : void{}
      
      private function commonUpdateIconPanelView(param1:HallIconPanel, param2:HallIconInfo, param3:Boolean = false) : void{}
      
      private function updateEveryDayActivityIcon() : void{}
      
      private function __everyDayActivityIconClickHandler(param1:MouseEvent) : void{}
      
      private function updateCityBattleIcon() : void{}
      
      private function removeCityBattleIcon() : void{}
      
      private function __cityBattleIconClickHandler(param1:MouseEvent) : void{}
      
      private function updateRankIcon() : void{}
      
      private function removeRankIcon() : void{}
      
      private function __rankIconClickHandler(param1:MouseEvent) : void{}
      
      private function updateWantstrongIcon() : void{}
      
      private function __wantstrongIconClickHandler(param1:MouseEvent) : void{}
      
      private function updateRoleRechargeIcon() : void{}
      
      private function __roleRechargeClickHandler(param1:MouseEvent) : void{}
      
      private function updatePolarIcon() : void{}
      
      private function __polarIconClickHandler(param1:MouseEvent) : void{}
      
      private function updateFirstRechargeIcon() : void{}
      
      private function __firstRechargeIconClickHandler(param1:MouseEvent) : void{}
      
      private function updateWonderfulPlayIcon() : void{}
      
      private function checkShowBossBox() : void{}
      
      private function __wonderFulPlayClickHandler(param1:MouseEvent) : void{}
      
      public function removeWonderFulPlayChildHandler(param1:String) : void{}
      
      private function sevenDoubleCanEnterHandler(param1:Event) : void{}
      
      private function canEnterHandler(param1:Event) : void{}
      
      private function updateActivityIcon() : void{}
      
      private function __activityClickHandler(param1:MouseEvent) : void{}
      
      public function createHallIconPanelIcon(param1:HallIconInfo) : HallIcon{return null;}
      
      public function getIconByType(param1:int, param2:String) : DisplayObject{return null;}
      
      private function topIndex() : void{}
      
      private function checkNoneActivity(param1:int) : void{}
      
      public function __checkHallIconExperienceOpenHandler(param1:HallIconEvent) : void{}
      
      private function updateRightIconTaskArrow() : void{}
      
      private function checkRightIconTaskClickHandler(param1:int) : void{}
      
      private function removeEvent() : void{}
      
      private function removeWonderfulPlayIcon() : void{}
      
      private function removeEveryDayActivityIcon() : void{}
      
      private function removeWantstrongIcon() : void{}
      
      private function removeRoleRechargeIcon() : void{}
      
      private function removeFirstRechargeIcon() : void{}
      
      private function removeActivityIcon() : void{}
      
      private function removeBossBox() : void{}
      
      private function removeFoodBox() : void{}
      
      private function __removeIcon(param1:Event) : void{}
      
      private function removePolarIcon() : void{}
      
      public function dispose() : void{}
   }
}
