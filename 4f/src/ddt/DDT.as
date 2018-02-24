package ddt
{
   import AvatarCollection.AvatarCollectionManager;
   import BombTurnTable.BombTurnTableManager;
   import BraveDoor.BraveDoorManager;
   import DDPlay.DDPlayManaer;
   import HappyRecharge.HappyRechargeManager;
   import Indiana.IndianaDataManager;
   import LanternFestival2015.LanternFestivalManager;
   import academy.AcademyManager;
   import accumulativeLogin.AccumulativeManager;
   import anotherDimension.controller.AnotherDimensionManager;
   import bagAndInfo.BagAndInfoManager;
   import bank.BankManager;
   import battleSkill.BattleSkillManager;
   import beadSystem.beadSystemManager;
   import boguAdventure.BoguAdventureManager;
   import calendar.CalendarManager;
   import campbattle.CampBattleManager;
   import cardCollectAward.CardCollectAwardManager;
   import catchInsect.CatchInsectManager;
   import catchbeast.CatchBeastManager;
   import chickActivation.ChickActivationManager;
   import christmas.ChristmasCoreManager;
   import church.ChurchManager;
   import cityBattle.CityBattleManager;
   import cityWide.CityWideManager;
   import cloudBuyLottery.CloudBuyLotteryManager;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.StringUtils;
   import conRecharge.ConRechargeManager;
   import condiscount.CondiscountManager;
   import consortion.guard.ConsortiaGuardControl;
   import consortionBattle.ConsortiaBattleManager;
   import cryptBoss.CryptBossManager;
   import dayActivity.DayActivityManager;
   import ddQiYuan.DDQiYuanManager;
   import ddt.data.AccountInfo;
   import ddt.data.ColorEnum;
   import ddt.data.ConfigParaser;
   import ddt.data.PathInfo;
   import ddt.events.StartupEvent;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.BattleGroudManager;
   import ddt.manager.CSMBoxManager;
   import ddt.manager.ChatManager;
   import ddt.manager.DesktopManager;
   import ddt.manager.DraftManager;
   import ddt.manager.DynamicManager;
   import ddt.manager.EdictumManager;
   import ddt.manager.EffortManager;
   import ddt.manager.EnthrallManager;
   import ddt.manager.ExitPromptManager;
   import ddt.manager.GradeExaltClewManager;
   import ddt.manager.HotSpringManager;
   import ddt.manager.IMManager;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MapManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.PlayerStateManager;
   import ddt.manager.PolarRegionManager;
   import ddt.manager.PyramidManager;
   import ddt.manager.QQtipsManager;
   import ddt.manager.QuestionInfoMannager;
   import ddt.manager.QueueManager;
   import ddt.manager.RandomSuitCardManager;
   import ddt.manager.RouletteManager;
   import ddt.manager.SevenDoubleEscortManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StageFocusManager;
   import ddt.manager.StateManager;
   import ddt.manager.SurvivalModeManager;
   import ddt.manager.SystemPostManager;
   import ddt.manager.TimeManager;
   import ddt.states.StateCreater;
   import ddt.utils.CrytoUtils;
   import ddt.view.ComponentEmbed;
   import ddt.view.chat.ChatBugleView;
   import ddtBuried.BuriedManager;
   import ddtDeed.DeedManager;
   import ddtKingLettersCollect.DdtKingLettersCollectManager;
   import ddtKingWay.DDTKingWayManager;
   import ddtmatch.manager.DDTMatchManager;
   import defendisland.DefendislandManager;
   import demonChiYou.DemonChiYouManager;
   import devilTurn.DevilTurnManager;
   import dice.DiceManager;
   import dragonBoat.DragonBoatManager;
   import drgnBoat.DrgnBoatManager;
   import entertainmentMode.EntertainmentModeManager;
   import escort.EscortManager;
   import farm.FarmModelController;
   import fightLib.FightLibManager;
   import firstRecharge.FirstRechargeManger;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flashP2P.FlashP2PManager;
   import foodActivity.FoodActivityManager;
   import game.GameManager;
   import gemstone.GemstoneManager;
   import godCardRaise.GodCardRaiseManager;
   import godOfWealth.GodOfWealthManager;
   import goldmine.GoldmineManager;
   import gradeBuy.GradeBuyManager;
   import groupPurchase.GroupPurchaseManager;
   import growthPackage.GrowthPackageManager;
   import guildMemberWeek.manager.GuildMemberWeekManager;
   import gypsyShop.ctrl.GypsyShopManager;
   import hallIcon.HallIconManager;
   import halloween.HalloweenManager;
   import horse.HorseManager;
   import horseRace.controller.HorseRaceManager;
   import invite.InviteManager;
   import itemActivityGift.ItemActivityGiftManager;
   import kingBless.KingBlessManager;
   import lanternriddles.LanternRiddlesManager;
   import latentEnergy.LatentEnergyManager;
   import latentEnergy.LatentRemainTimeNotice;
   import league.LeagueManager;
   import levelFund.LevelFundManager;
   import littleGame.LittleControl;
   import littleGame.character.LittleGameCharacter;
   import loginDevice.LoginDeviceManager;
   import lotteryTicket.LotteryManager;
   import luckStar.manager.LuckStarManager;
   import magicHouse.MagicHouseManager;
   import magpieBridge.MagpieBridgeManager;
   import mark.MarkMgr;
   import memoryGame.MemoryGameManager;
   import midAutumnWorshipTheMoon.WorshipTheMoonManager;
   import mines.MinesManager;
   import moneyTree.MoneyTreeManager;
   import mysteriousRoullete.MysteriousManager;
   import newChickenBox.NewChickenBoxManager;
   import newTitle.NewTitleManager;
   import newYearRice.NewYearRiceManager;
   import oldPlayerComeBack.OldPlayerComeBackManager;
   import org.aswing.KeyboardManager;
   import panicBuying.PanicBuyingManager;
   import petIsland.PetIslandManager;
   import petsBag.PetsBagManager;
   import playerDress.PlayerDressManager;
   import powerUp.PowerUpMovieManager;
   import pvePowerBuff.PvePowerBuffManager;
   import quest.TrusteeshipManager;
   import questionAward.QuestionAwardManager;
   import rank.RankManager;
   import redEnvelope.RedEnvelopeManager;
   import rescue.RescueManager;
   import roleRecharge.RoleRechargeMgr;
   import room.RoomManager;
   import roulette.LeftGunRouletteManager;
   import sanXiao.SanXiaoManager;
   import sevenDouble.SevenDoubleManager;
   import signActivity.SignActivityMgr;
   import signBuff.SignBuffManager;
   import stock.StockMgr;
   import team.TeamManager;
   import trainer.controller.LevelRewardManager;
   import trainer.controller.WeakGuildManager;
   import treasureHunting.TreasureManager;
   import treasurePuzzle.controller.TreasurePuzzleManager;
   import uiModeManager.bombUI.HappyLittleGameManager;
   import wasteRecycle.WasteRecycleManager;
   import welfareCenter.WelfareCenterManager;
   import welfareCenter.callBackFund.CallBackFundManager;
   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;
   import wishingTree.WishingTreeManager;
   import witchBlessing.WitchBlessingManager;
   import wonderfulActivity.WonderfulActivityManager;
   import worldboss.WorldBossManager;
   import zodiac.ZodiacManager;
   
   public class DDT
   {
      
      public static var REQUEST_BY_DEVICE:String;
      
      public static var SERVER_ID:int = -1;
      
      public static const THE_HIGHEST_LV:int = 60;
      
      public static var isMaster:Boolean = false;
       
      
      private var _alerLayer:Sprite;
      
      private var _allowMulti:Boolean;
      
      private var _gameLayer:Sprite;
      
      private var _musicList:Array;
      
      private var _pass:String;
      
      private var _user:String;
      
      private var _rid:String;
      
      private var numCh:Number;
      
      private var _loaded:Boolean = false;
      
      public function DDT(){super();}
      
      private function handleDebugSystem() : void{}
      
      private function onClick(param1:MouseEvent) : void{}
      
      private function show(param1:DisplayObjectContainer) : void{}
      
      public function lunch(param1:XML, param2:String, param3:String, param4:int, param5:String = "", param6:String = "", param7:Boolean = false, param8:String = "") : void{}
      
      public function startLoad(param1:XML, param2:String, param3:String, param4:int, param5:String = "") : void{}
      
      private function __onCoreSetupLoadComplete(param1:StartupEvent) : void{}
      
      private function setup() : void{}
      
      private function initWonderfulIcon() : void{}
      
      private function deleWAIcon() : void{}
      
      private function setupComponent() : void{}
      
      private function soundPlay() : void{}
   }
}
