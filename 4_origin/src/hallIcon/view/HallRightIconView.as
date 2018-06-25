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
   import dreamlandChallenge.DreamlandChallengeManager;
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
   import newOldPlayer.NewOldPlayerManager;
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
      
      public function HallRightIconView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _showArrowSp = new Sprite();
         addChild(_showArrowSp);
         _iconBox = new HBox();
         _iconBox.spacing = 5;
         addChild(_iconBox);
         updateActivityIcon();
         updateWonderfulPlayIcon();
         updateEveryDayActivityIcon();
         updateWantstrongIcon();
         updateRankIcon();
         updateFirstRechargeIcon();
         updateRoleRechargeIcon();
         SignActivityMgr.instance.showIcon();
         checkShowBossBox();
      }
      
      private function initEvent() : void
      {
         HallIconManager.instance.model.addEventListener("updateRightIconView",__updateIconViewHandler);
         HallIconManager.instance.model.addEventListener("updateBatchRightIconView",__updateBatchIconViewHandler);
         HallIconManager.instance.addEventListener("checkHallIconExperienceOpen",__checkHallIconExperienceOpenHandler);
         FirstRechargeManger.Instance.addEventListener("removefirstrechargeicon",__removeIcon);
         FirstRechargeManger.Instance.addEventListener("addfirstrechargeicon",__addIcon);
      }
      
      private function __addIcon(e:Event) : void
      {
         if(_firstRechargeIcon == null)
         {
            _firstRechargeIcon = ClassUtils.CreatInstance("assets.hallIcon.firstRechargeIcon");
            _firstRechargeIcon.addEventListener("click",__firstRechargeIconClickHandler);
            _firstRechargeIcon.buttonMode = true;
            _firstRechargeIcon.mouseChildren = false;
            addChildBox(_firstRechargeIcon);
         }
      }
      
      private function addChildBox($child:DisplayObject) : void
      {
         _iconBox.addChild($child);
         _iconBox.arrange();
         _iconBox.x = -_iconBox.width;
      }
      
      private function __updateBatchIconViewHandler(evt:HallIconEvent) : void
      {
         var dic:Dictionary = HallIconManager.instance.model.cacheRightIconDic;
         var _loc5_:int = 0;
         var _loc4_:* = dic;
         for each(var info in dic)
         {
            updateIconView(info);
         }
      }
      
      private function __updateIconViewHandler(evt:HallIconEvent) : void
      {
         var iconInfo:HallIconInfo = HallIconInfo(evt.data);
         updateIconView(iconInfo);
      }
      
      private function updateIconView($iconInfo:HallIconInfo) : void
      {
         if($iconInfo.halltype == 1 && _wonderFulPlay)
         {
            commonUpdateIconPanelView(_wonderFulPlay,$iconInfo,false);
            if(!$iconInfo.isopen)
            {
               removeWonderFulPlayChildHandler($iconInfo.icontype);
            }
         }
         else if($iconInfo.halltype == 2 && _activity)
         {
            commonUpdateIconPanelView(_activity,$iconInfo,true);
         }
         else
         {
            var _loc2_:* = $iconInfo.icontype;
            if("wonderfulplay" !== _loc2_)
            {
               if("everydayactivity" !== _loc2_)
               {
                  if("activity" !== _loc2_)
                  {
                     if("wantstrong" !== _loc2_)
                     {
                        if("firstrecharge" !== _loc2_)
                        {
                           if("FoodActivity" !== _loc2_)
                           {
                              if("PolarFuzion" !== _loc2_)
                              {
                                 if("rank" !== _loc2_)
                                 {
                                    if("roleRecharge" === _loc2_)
                                    {
                                       updateRoleRechargeIcon();
                                    }
                                 }
                                 else
                                 {
                                    updateRankIcon();
                                 }
                              }
                              else
                              {
                                 updatePolarIcon();
                              }
                           }
                           else
                           {
                              checkFoodBox();
                           }
                        }
                        else
                        {
                           updateFirstRechargeIcon();
                        }
                     }
                     else
                     {
                        updateWantstrongIcon();
                     }
                  }
                  else
                  {
                     SignActivityMgr.instance.showIcon();
                     updateActivityIcon();
                  }
               }
               else
               {
                  updateEveryDayActivityIcon();
               }
            }
            else
            {
               updateWonderfulPlayIcon();
            }
         }
      }
      
      private function checkFoodBox() : void
      {
         if(FoodActivityManager.Instance._isStart)
         {
            if(_foodButton == null)
            {
               _foodButton = FoodActivityManager.Instance.foodActivityIcon;
               addChildBox(_foodButton);
            }
         }
         else
         {
            removeFoodBox();
         }
      }
      
      private function commonUpdateIconPanelView($hallIconPanel:HallIconPanel, $iconInfo:HallIconInfo, flag:Boolean = false) : void
      {
         var tempIcon:* = null;
         if($iconInfo.isopen)
         {
            tempIcon = $hallIconPanel.getIconByType($iconInfo.icontype) as HallIcon;
            if(!tempIcon)
            {
               tempIcon = $hallIconPanel.addIcon(createHallIconPanelIcon($iconInfo),$iconInfo.icontype,$iconInfo.orderid,flag) as HallIcon;
            }
            tempIcon.updateIcon($iconInfo);
         }
         else
         {
            $hallIconPanel.removeIconByType($iconInfo.icontype);
         }
         $hallIconPanel.arrange();
      }
      
      private function updateEveryDayActivityIcon() : void
      {
         if(HallIconManager.instance.model.everyDayActivityIsOpen)
         {
            if(_everyDayActivityIcon == null)
            {
               _everyDayActivityIcon = ClassUtils.CreatInstance("assets.hallIcon.everyDayActivityIcon");
               _everyDayActivityIcon.addEventListener("click",__everyDayActivityIconClickHandler);
               _everyDayActivityIcon.buttonMode = true;
               _everyDayActivityIcon.mouseChildren = false;
               addChildBox(_everyDayActivityIcon);
            }
         }
         else
         {
            removeEveryDayActivityIcon();
         }
      }
      
      private function __everyDayActivityIconClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         DayActivityManager.Instance.show();
      }
      
      private function updateCityBattleIcon() : void
      {
         if(PlayerManager.Instance.Self.Grade > 10 && CityBattleManager.instance.isOpen)
         {
            if(_cityBattleIcon == null)
            {
               _cityBattleIcon = ClassUtils.CreatInstance("assets.hallIcon.cityBattle");
               _cityBattleIcon.addEventListener("click",__cityBattleIconClickHandler);
               _cityBattleIcon.buttonMode = true;
               _cityBattleIcon.mouseChildren = false;
               addChildBox(_cityBattleIcon);
            }
         }
         else
         {
            removeCityBattleIcon();
         }
      }
      
      private function removeCityBattleIcon() : void
      {
         if(_cityBattleIcon)
         {
            _cityBattleIcon.stop();
            _cityBattleIcon.removeEventListener("click",__cityBattleIconClickHandler);
            ObjectUtils.disposeObject(_cityBattleIcon);
            _cityBattleIcon = null;
         }
      }
      
      private function __cityBattleIconClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.cityBattleInfo();
      }
      
      private function updateRankIcon() : void
      {
         if(WonderfulActivityManager.Instance.rankFlag)
         {
            if(_rankIcon == null)
            {
               _rankIcon = ClassUtils.CreatInstance("assets.hallIcon.rankIcon");
               _rankIcon.addEventListener("click",__rankIconClickHandler);
               _rankIcon.buttonMode = true;
               _rankIcon.mouseChildren = false;
               addChildBox(_rankIcon);
            }
         }
         else
         {
            removeRankIcon();
         }
      }
      
      private function removeRankIcon() : void
      {
         if(_rankIcon)
         {
            _rankIcon.stop();
            _rankIcon.removeEventListener("click",__rankIconClickHandler);
            ObjectUtils.disposeObject(_rankIcon);
            _rankIcon = null;
         }
      }
      
      private function __rankIconClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         RankManager.instance.show();
      }
      
      private function updateWantstrongIcon() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 7)
         {
            if(_wantstrongIcon == null)
            {
               _wantstrongIcon = ClassUtils.CreatInstance("assets.hallIcon.wantstrongIcon");
               _wantstrongIcon.addEventListener("click",__wantstrongIconClickHandler);
               _wantstrongIcon.buttonMode = true;
               _wantstrongIcon.mouseChildren = false;
               addChildBox(_wantstrongIcon);
            }
         }
         else
         {
            removeWantstrongIcon();
         }
      }
      
      private function __wantstrongIconClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         WantStrongManager.Instance.show();
      }
      
      private function updateRoleRechargeIcon() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 1 && RoleRechargeMgr.instance.isOpen)
         {
            if(_roleRechargeIcon == null)
            {
               _roleRechargeIcon = ClassUtils.CreatInstance("asset.ddthall.roleRechargeIcon");
               _roleRechargeIcon.addEventListener("click",__roleRechargeClickHandler);
               _roleRechargeIcon.buttonMode = true;
               _roleRechargeIcon.mouseChildren = false;
               addChildBox(_roleRechargeIcon);
            }
         }
         else
         {
            removeRoleRechargeIcon();
         }
      }
      
      private function __roleRechargeClickHandler(evt:MouseEvent) : void
      {
         SocketManager.Instance.out.requestWonderfulActInit(2);
         WonderfulActivityManager.Instance.refreshIconStatus();
         SoundManager.instance.playButtonSound();
         RoleRechargeMgr.instance.show();
      }
      
      private function updatePolarIcon() : void
      {
         if(PolarRegionManager.Instance.isOpen)
         {
            if(_polarIcon == null)
            {
               _polarIcon = ClassUtils.CreatInstance("asset.ddthall.polarRegion.icon");
               _polarIcon.addEventListener("click",__polarIconClickHandler);
               _polarIcon.buttonMode = true;
               _polarIcon.mouseChildren = false;
               addChildBox(_polarIcon);
            }
         }
         else
         {
            removePolarIcon();
         }
      }
      
      private function __polarIconClickHandler(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         PolarRegionManager.Instance.show();
      }
      
      private function updateFirstRechargeIcon() : void
      {
         if(HallIconManager.instance.model.firstRechargeIsOpen)
         {
            if(_firstRechargeIcon == null)
            {
               _firstRechargeIcon = ClassUtils.CreatInstance("assets.hallIcon.firstRechargeIcon");
               _firstRechargeIcon.addEventListener("click",__firstRechargeIconClickHandler);
               _firstRechargeIcon.buttonMode = true;
               _firstRechargeIcon.mouseChildren = false;
               addChildBox(_firstRechargeIcon);
            }
         }
         else
         {
            removeFirstRechargeIcon();
         }
      }
      
      private function __firstRechargeIconClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         FirstRechargeManger.Instance.show();
      }
      
      private function updateWonderfulPlayIcon() : void
      {
         if(HallIconManager.instance.model.wonderFulPlayIsOpen)
         {
            if(_wonderFulPlay == null)
            {
               _wonderFulPlay = new HallIconPanel("assets.hallIcon.wonderfulPlayIcon","bottom",6);
               _wonderFulPlay.addEventListener("click",__wonderFulPlayClickHandler);
               addChildBox(_wonderFulPlay);
            }
         }
         else
         {
            removeWonderfulPlayIcon();
         }
      }
      
      private function checkShowBossBox() : void
      {
         if(BossBoxManager.instance.isShowBoxButton())
         {
            if(_boxButton == null)
            {
               _boxButton = new SmallBoxButton(0);
            }
            addChildBox(_boxButton);
         }
         else
         {
            removeBossBox();
         }
      }
      
      private function __wonderFulPlayClickHandler(evt:MouseEvent) : void
      {
         var icon:* = null;
         if(_wonderFulPlay && evt.target == _wonderFulPlay.mainIcon)
         {
            topIndex();
            checkNoneActivity(_wonderFulPlay.count);
            checkRightIconTaskClickHandler(1);
            return;
         }
         if(getTimer() - _lastCreatTime < 1000)
         {
            return;
         }
         _lastCreatTime = getTimer();
         if(evt.target is HallIcon)
         {
            icon = evt.target as HallIcon;
            if(icon.iconInfo.halltype == 1)
            {
               var _loc3_:* = icon.iconInfo.icontype;
               if("worldbossentrance1" !== _loc3_)
               {
                  if("worldbossentrance4" !== _loc3_)
                  {
                     if("camp" !== _loc3_)
                     {
                        if("sevendouble" !== _loc3_)
                        {
                           if("league" !== _loc3_)
                           {
                              if("ringstation" !== _loc3_)
                              {
                                 if("consortiabattle" !== _loc3_)
                                 {
                                    if("littlegamenote" !== _loc3_)
                                    {
                                       if("flowerGiving" !== _loc3_)
                                       {
                                          if("escort" !== _loc3_)
                                          {
                                             if("buried" !== _loc3_)
                                             {
                                                if("moneyTree" !== _loc3_)
                                                {
                                                   if("draft" !== _loc3_)
                                                   {
                                                      if("survival" !== _loc3_)
                                                      {
                                                         if("trial" !== _loc3_)
                                                         {
                                                            if("cityBattle" !== _loc3_)
                                                            {
                                                               if("ddtKingWay" !== _loc3_)
                                                               {
                                                                  if("oldPlayerComeBack" !== _loc3_)
                                                                  {
                                                                     if("mines" !== _loc3_)
                                                                     {
                                                                        if("teamBattle" === _loc3_)
                                                                        {
                                                                           TeamManager.instance.show();
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        SocketManager.Instance.out.sendInitHandler();
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     OldPlayerComeBackManager.instance.show();
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  SoundManager.instance.play("008");
                                                                  DDTKingWayManager.instance.show();
                                                               }
                                                            }
                                                            else
                                                            {
                                                               SoundManager.instance.play("008");
                                                               SocketManager.Instance.out.cityBattleInfo();
                                                            }
                                                         }
                                                         else
                                                         {
                                                            SoundManager.instance.play("008");
                                                            if(ActivityEnterGrapType.Instance.IsEnterGame(28))
                                                            {
                                                               if(CheckWeaponManager.instance.isNoWeapon())
                                                               {
                                                                  CheckWeaponManager.instance.showAlert();
                                                                  return;
                                                               }
                                                               BattleGroudManager.Instance.__onBattleBtnHander();
                                                            }
                                                         }
                                                      }
                                                      else
                                                      {
                                                         SoundManager.instance.play("008");
                                                         if(ActivityEnterGrapType.Instance.IsEnterGame(1))
                                                         {
                                                            SurvivalModeManager.Instance.show();
                                                         }
                                                      }
                                                   }
                                                   else
                                                   {
                                                      SoundManager.instance.play("008");
                                                      if(ActivityEnterGrapType.Instance.IsEnterGame(1))
                                                      {
                                                         DraftManager.instance.show();
                                                      }
                                                   }
                                                }
                                                else
                                                {
                                                   SoundManager.instance.play("003");
                                                   if(ActivityEnterGrapType.Instance.IsEnterGame(25))
                                                   {
                                                      MoneyTreeManager.getInstance().npcClicked();
                                                   }
                                                }
                                             }
                                             else
                                             {
                                                SoundManager.instance.play("003");
                                                if(ActivityEnterGrapType.Instance.IsEnterGame(1))
                                                {
                                                   SocketManager.Instance.out.clickAnotherDimensionEnter();
                                                }
                                             }
                                          }
                                          else if(EscortManager.instance.isInGame)
                                          {
                                             EscortManager.instance.addEventListener("escortCanEnter",canEnterHandler);
                                             SocketManager.Instance.out.sendEscortCanEnter();
                                          }
                                          else
                                          {
                                             EscortManager.instance.show();
                                          }
                                       }
                                       else
                                       {
                                          FlowerGivingManager.instance.show();
                                       }
                                    }
                                    else
                                    {
                                       SoundManager.instance.play("008");
                                       if(LittleControl.Instance.hasActive())
                                       {
                                          StateManager.setState("littleHall");
                                       }
                                       else
                                       {
                                          MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthBoxIconTips.labelII"));
                                       }
                                    }
                                 }
                                 else
                                 {
                                    SoundManager.instance.play("008");
                                    if(ConsortiaBattleManager.instance.isCanEnter)
                                    {
                                       GameInSocketOut.sendSingleRoomBegin(4);
                                    }
                                    else if(PlayerManager.Instance.Self.ConsortiaID != 0)
                                    {
                                       MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.cannotEnterTxt"));
                                    }
                                    else
                                    {
                                       MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.cannotEnterTxt2"));
                                    }
                                 }
                              }
                              else
                              {
                                 SoundManager.instance.play("008");
                                 if(ActivityEnterGrapType.Instance.IsEnterGame(27))
                                 {
                                    SoundManager.instance.playButtonSound();
                                    RingStationManager.instance.show();
                                 }
                              }
                           }
                           else
                           {
                              HallIconManager.ISLEAGUE = true;
                              SoundManager.instance.playButtonSound();
                              if(ActivityEnterGrapType.Instance.IsEnterGame(24))
                              {
                                 StateManager.setState("roomlist");
                                 ComponentSetting.SEND_USELOG_ID(3);
                                 if(PlayerManager.Instance.Self.IsWeakGuildFinish(1) && !PlayerManager.Instance.Self.IsWeakGuildFinish(4))
                                 {
                                    SocketManager.Instance.out.syncWeakStep(4);
                                 }
                              }
                           }
                        }
                        else
                        {
                           SoundManager.instance.play("008");
                           if(SevenDoubleManager.instance.isInGame)
                           {
                              SevenDoubleManager.instance.addEventListener("sevenDoubleCanEnter",sevenDoubleCanEnterHandler);
                              SocketManager.Instance.out.sendSevenDoubleCanEnter();
                           }
                           else
                           {
                              SevenDoubleManager.instance.show();
                           }
                        }
                     }
                     else
                     {
                        CampBattleManager.instance.__onCampBtnHander(evt);
                     }
                  }
               }
               SoundManager.instance.play("003");
               StateManager.setState("worldbossAward");
            }
         }
      }
      
      public function removeWonderFulPlayChildHandler($icontype:String) : void
      {
         var _loc2_:* = $icontype;
         if("sevendouble" !== _loc2_)
         {
            if("escort" === _loc2_)
            {
               EscortManager.instance.removeEventListener("escortCanEnter",canEnterHandler);
            }
         }
         else
         {
            SevenDoubleManager.instance.removeEventListener("sevenDoubleCanEnter",sevenDoubleCanEnterHandler);
         }
      }
      
      private function sevenDoubleCanEnterHandler(event:Event) : void
      {
         SevenDoubleManager.instance.removeEventListener("sevenDoubleCanEnter",sevenDoubleCanEnterHandler);
         StateManager.setState("sevenDoubleScene");
      }
      
      private function canEnterHandler(event:Event) : void
      {
         EscortManager.instance.removeEventListener("escortCanEnter",canEnterHandler);
         StateManager.setState("escort");
      }
      
      private function updateActivityIcon() : void
      {
         if(HallIconManager.instance.model.activityIsOpen)
         {
            if(_activity == null)
            {
               _activity = new HallIconPanel("assets.hallIcon.activityIcon","bottom",6);
               _activity.addEventListener("click",__activityClickHandler);
               addChildBox(_activity);
            }
         }
         else
         {
            removeActivityIcon();
         }
      }
      
      private function __activityClickHandler(evt:MouseEvent) : void
      {
         var icon:* = null;
         var self:* = null;
         var phase1:int = 0;
         var firstEnterCdSec:int = 0;
         if(_activity && evt.target == _activity.mainIcon)
         {
            topIndex();
            checkNoneActivity(_activity.count);
            checkRightIconTaskClickHandler(2);
            return;
         }
         if(getTimer() - _lastCreatTime < 1000)
         {
            return;
         }
         _lastCreatTime = getTimer();
         if(evt.target is HallIcon)
         {
            icon = evt.target as HallIcon;
            if(icon.iconInfo.halltype == 2)
            {
               var _loc6_:* = icon.iconInfo.icontype;
               if("christmas" !== _loc6_)
               {
                  if("catchBeast" !== _loc6_)
                  {
                     if("pyramid" !== _loc6_)
                     {
                        if("superWinner" !== _loc6_)
                        {
                           if("luckStar" !== _loc6_)
                           {
                              if("dice" !== _loc6_)
                              {
                                 if("accumulativeLogin" !== _loc6_)
                                 {
                                    if("lanternRiddles" !== _loc6_)
                                    {
                                       if("newChickenBox" !== _loc6_)
                                       {
                                          if("leftGunRoulette" !== _loc6_)
                                          {
                                             if("groupPurchase" !== _loc6_)
                                             {
                                                if("luckStone" !== _loc6_)
                                                {
                                                   if("mysteriousRoulette" !== _loc6_)
                                                   {
                                                      if("syah" !== _loc6_)
                                                      {
                                                         if("treasureHunting" !== _loc6_)
                                                         {
                                                            if("oldPlayerRegress" !== _loc6_)
                                                            {
                                                               if("limitActivity" !== _loc6_)
                                                               {
                                                                  if("godsRoads" !== _loc6_)
                                                                  {
                                                                     if("entertainment" !== _loc6_)
                                                                     {
                                                                        if("saleshop" !== _loc6_)
                                                                        {
                                                                           if("chickActivation" !== _loc6_)
                                                                           {
                                                                              if("DDPlay" !== _loc6_)
                                                                              {
                                                                                 if("boguadventure" !== _loc6_)
                                                                                 {
                                                                                    if("sevenDayTarget" !== _loc6_)
                                                                                    {
                                                                                       if("witchblessing" !== _loc6_)
                                                                                       {
                                                                                          if("treasurepuzzle" !== _loc6_)
                                                                                          {
                                                                                             if("worshipTheMoon" !== _loc6_)
                                                                                             {
                                                                                                if("rescue" !== _loc6_)
                                                                                                {
                                                                                                   if("catchinsect" !== _loc6_)
                                                                                                   {
                                                                                                      if("magpiebridge" !== _loc6_)
                                                                                                      {
                                                                                                         if("cloudbuylottery" !== _loc6_)
                                                                                                         {
                                                                                                            if("newYearRice" !== _loc6_)
                                                                                                            {
                                                                                                               if("zodiac" !== _loc6_)
                                                                                                               {
                                                                                                                  if("horseRace" !== _loc6_)
                                                                                                                  {
                                                                                                                     if("petIsland" !== _loc6_)
                                                                                                                     {
                                                                                                                        if("happyRecharge" !== _loc6_)
                                                                                                                        {
                                                                                                                           if("ddtMatch" !== _loc6_)
                                                                                                                           {
                                                                                                                              if("memoryGame" !== _loc6_)
                                                                                                                              {
                                                                                                                                 if("sanxiao" !== _loc6_)
                                                                                                                                 {
                                                                                                                                    if("panicBuying" !== _loc6_)
                                                                                                                                    {
                                                                                                                                       if("godCard" !== _loc6_)
                                                                                                                                       {
                                                                                                                                          if("godOfWealth" !== _loc6_)
                                                                                                                                          {
                                                                                                                                             if("redEnvelope" !== _loc6_)
                                                                                                                                             {
                                                                                                                                                if("ExchangeAct" !== _loc6_)
                                                                                                                                                {
                                                                                                                                                   if("guildMemberWeek" !== _loc6_)
                                                                                                                                                   {
                                                                                                                                                      if("growthPackage" !== _loc6_)
                                                                                                                                                      {
                                                                                                                                                         if("ddqiyuan" !== _loc6_)
                                                                                                                                                         {
                                                                                                                                                            if("welfareCenter" !== _loc6_)
                                                                                                                                                            {
                                                                                                                                                               if("angelInvestment" !== _loc6_)
                                                                                                                                                               {
                                                                                                                                                                  if("bombTurnTable" !== _loc6_)
                                                                                                                                                                  {
                                                                                                                                                                     if("luckLotteryDraw" !== _loc6_)
                                                                                                                                                                     {
                                                                                                                                                                        if("signActivity" !== _loc6_)
                                                                                                                                                                        {
                                                                                                                                                                           if("bravedoor" !== _loc6_)
                                                                                                                                                                           {
                                                                                                                                                                              if("lotteryTicket" !== _loc6_)
                                                                                                                                                                              {
                                                                                                                                                                                 if("goldmine" !== _loc6_)
                                                                                                                                                                                 {
                                                                                                                                                                                    if("indiana" !== _loc6_)
                                                                                                                                                                                    {
                                                                                                                                                                                       if("sevenday" !== _loc6_)
                                                                                                                                                                                       {
                                                                                                                                                                                          if("condiscount" !== _loc6_)
                                                                                                                                                                                          {
                                                                                                                                                                                             if("defend_island" !== _loc6_)
                                                                                                                                                                                             {
                                                                                                                                                                                                if("conRecharge" !== _loc6_)
                                                                                                                                                                                                {
                                                                                                                                                                                                   if("bank" !== _loc6_)
                                                                                                                                                                                                   {
                                                                                                                                                                                                      if("stock" !== _loc6_)
                                                                                                                                                                                                      {
                                                                                                                                                                                                         if("devilTurn" !== _loc6_)
                                                                                                                                                                                                         {
                                                                                                                                                                                                            if("dreamLandChallenge" !== _loc6_)
                                                                                                                                                                                                            {
                                                                                                                                                                                                               if("worldcupGuess" !== _loc6_)
                                                                                                                                                                                                               {
                                                                                                                                                                                                                  if("oldPlayer" === _loc6_)
                                                                                                                                                                                                                  {
                                                                                                                                                                                                                     SoundManager.instance.playButtonSound();
                                                                                                                                                                                                                     NewOldPlayerManager.instance.openView();
                                                                                                                                                                                                                  }
                                                                                                                                                                                                               }
                                                                                                                                                                                                               else
                                                                                                                                                                                                               {
                                                                                                                                                                                                                  SoundManager.instance.playButtonSound();
                                                                                                                                                                                                                  SocketManager.Instance.out.getWorldcupInfo();
                                                                                                                                                                                                               }
                                                                                                                                                                                                            }
                                                                                                                                                                                                            else
                                                                                                                                                                                                            {
                                                                                                                                                                                                               DreamlandChallengeManager.instance.preOpenView();
                                                                                                                                                                                                            }
                                                                                                                                                                                                         }
                                                                                                                                                                                                         else if(ActivityEnterGrapType.Instance.IsEnterGame(ServerConfigManager.instance.devilTurnOpenLevelLimit))
                                                                                                                                                                                                         {
                                                                                                                                                                                                            DevilTurnManager.instance.show();
                                                                                                                                                                                                         }
                                                                                                                                                                                                      }
                                                                                                                                                                                                      else
                                                                                                                                                                                                      {
                                                                                                                                                                                                         StockMgr.inst.showMainFrame();
                                                                                                                                                                                                      }
                                                                                                                                                                                                   }
                                                                                                                                                                                                   else
                                                                                                                                                                                                   {
                                                                                                                                                                                                      BankManager.instance.show();
                                                                                                                                                                                                   }
                                                                                                                                                                                                }
                                                                                                                                                                                                else
                                                                                                                                                                                                {
                                                                                                                                                                                                   ConRechargeManager.instance.show();
                                                                                                                                                                                                }
                                                                                                                                                                                             }
                                                                                                                                                                                             else
                                                                                                                                                                                             {
                                                                                                                                                                                                SoundManager.instance.play("008");
                                                                                                                                                                                                if(ActivityEnterGrapType.Instance.IsEnterGame(20))
                                                                                                                                                                                                {
                                                                                                                                                                                                   SocketManager.Instance.out.defendislandInfo(1);
                                                                                                                                                                                                }
                                                                                                                                                                                             }
                                                                                                                                                                                          }
                                                                                                                                                                                          else
                                                                                                                                                                                          {
                                                                                                                                                                                             SoundManager.instance.play("008");
                                                                                                                                                                                             CondiscountManager.instance.show();
                                                                                                                                                                                          }
                                                                                                                                                                                       }
                                                                                                                                                                                       else
                                                                                                                                                                                       {
                                                                                                                                                                                          SoundManager.instance.play("008");
                                                                                                                                                                                          SevendayManager.instance.show();
                                                                                                                                                                                       }
                                                                                                                                                                                    }
                                                                                                                                                                                    else
                                                                                                                                                                                    {
                                                                                                                                                                                       SoundManager.instance.play("008");
                                                                                                                                                                                       IndianaDataManager.instance.show();
                                                                                                                                                                                    }
                                                                                                                                                                                 }
                                                                                                                                                                                 else
                                                                                                                                                                                 {
                                                                                                                                                                                    SoundManager.instance.play("008");
                                                                                                                                                                                    GoldmineManager.Instance.show();
                                                                                                                                                                                 }
                                                                                                                                                                              }
                                                                                                                                                                              else
                                                                                                                                                                              {
                                                                                                                                                                                 SoundManager.instance.play("008");
                                                                                                                                                                                 LotteryManager.instance.isClick = true;
                                                                                                                                                                                 SocketManager.Instance.out.getLotteryPrizeInfo();
                                                                                                                                                                              }
                                                                                                                                                                           }
                                                                                                                                                                           else
                                                                                                                                                                           {
                                                                                                                                                                              BraveDoorManager.instance.openView_Handler();
                                                                                                                                                                           }
                                                                                                                                                                        }
                                                                                                                                                                        else
                                                                                                                                                                        {
                                                                                                                                                                           SocketManager.Instance.out.requestWonderfulActInit(2);
                                                                                                                                                                           WonderfulActivityManager.Instance.refreshIconStatus();
                                                                                                                                                                           SoundManager.instance.playButtonSound();
                                                                                                                                                                           SignActivityMgr.instance.show();
                                                                                                                                                                        }
                                                                                                                                                                     }
                                                                                                                                                                     else
                                                                                                                                                                     {
                                                                                                                                                                        phase1 = CallBackLotteryDrawManager.instance.luckeyLotteryDrawModel.phase;
                                                                                                                                                                        firstEnterCdSec = CallBackLotteryDrawManager.instance.getLuckeyLeftSec();
                                                                                                                                                                        if(firstEnterCdSec <= 0)
                                                                                                                                                                        {
                                                                                                                                                                           firstEnterCdSec = 0;
                                                                                                                                                                        }
                                                                                                                                                                        if(firstEnterCdSec > 0 && phase1 == 0)
                                                                                                                                                                        {
                                                                                                                                                                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.activity.notOpen"));
                                                                                                                                                                           return;
                                                                                                                                                                        }
                                                                                                                                                                        if(firstEnterCdSec <= 0 && phase1 == 0 || firstEnterCdSec >= 0 && phase1 > 0)
                                                                                                                                                                        {
                                                                                                                                                                           SoundManager.instance.playButtonSound();
                                                                                                                                                                           CallBackLotteryDrawManager.instance.type = 1;
                                                                                                                                                                           CallBackLotteryDrawManager.instance.show();
                                                                                                                                                                        }
                                                                                                                                                                     }
                                                                                                                                                                  }
                                                                                                                                                                  else
                                                                                                                                                                  {
                                                                                                                                                                     BombTurnTableManager.instance.openView_Handler();
                                                                                                                                                                  }
                                                                                                                                                               }
                                                                                                                                                               else
                                                                                                                                                               {
                                                                                                                                                                  AngelInvestmentManager.instance.onClickIcon();
                                                                                                                                                               }
                                                                                                                                                            }
                                                                                                                                                            else
                                                                                                                                                            {
                                                                                                                                                               WelfareCenterManager.instance.showView();
                                                                                                                                                            }
                                                                                                                                                         }
                                                                                                                                                         else if(ActivityEnterGrapType.Instance.IsEnterGame(1))
                                                                                                                                                         {
                                                                                                                                                            DDQiYuanManager.instance.show();
                                                                                                                                                         }
                                                                                                                                                      }
                                                                                                                                                      else if(ActivityEnterGrapType.Instance.IsEnterGame(1))
                                                                                                                                                      {
                                                                                                                                                         GrowthPackageManager.instance.onClickIcon(evt);
                                                                                                                                                      }
                                                                                                                                                   }
                                                                                                                                                   else if(ActivityEnterGrapType.Instance.IsEnterGame(17))
                                                                                                                                                   {
                                                                                                                                                      GuildMemberWeekManager.instance.onClickguildMemberWeekIcon(evt);
                                                                                                                                                   }
                                                                                                                                                }
                                                                                                                                                else
                                                                                                                                                {
                                                                                                                                                   SoundManager.instance.play("008");
                                                                                                                                                   ExchangeActManager.Instance.onWonderfulClick();
                                                                                                                                                }
                                                                                                                                             }
                                                                                                                                             else
                                                                                                                                             {
                                                                                                                                                SoundManager.instance.play("008");
                                                                                                                                                if(RedEnvelopeManager.instance.openFlag)
                                                                                                                                                {
                                                                                                                                                   RedEnvelopeManager.instance.openFlag = false;
                                                                                                                                                   SocketManager.Instance.out.redEnvelopeListInfo();
                                                                                                                                                }
                                                                                                                                             }
                                                                                                                                          }
                                                                                                                                          else
                                                                                                                                          {
                                                                                                                                             SoundManager.instance.play("008");
                                                                                                                                             GodOfWealthManager.getInstance().show();
                                                                                                                                          }
                                                                                                                                       }
                                                                                                                                       else
                                                                                                                                       {
                                                                                                                                          SoundManager.instance.play("008");
                                                                                                                                          if(ActivityEnterGrapType.Instance.IsEnterGame(31))
                                                                                                                                          {
                                                                                                                                             GodCardRaiseManager.Instance.show();
                                                                                                                                          }
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       SoundManager.instance.play("008");
                                                                                                                                       if(ActivityEnterGrapType.Instance.IsEnterGame(10))
                                                                                                                                       {
                                                                                                                                          PanicBuyingManager.instance.show();
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 else
                                                                                                                                 {
                                                                                                                                    SoundManager.instance.play("008");
                                                                                                                                    if(ActivityEnterGrapType.Instance.IsEnterGame(10))
                                                                                                                                    {
                                                                                                                                       SanXiaoManager.getInstance().show();
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                              }
                                                                                                                              else
                                                                                                                              {
                                                                                                                                 SoundManager.instance.play("008");
                                                                                                                                 if(ActivityEnterGrapType.Instance.IsEnterGame(25))
                                                                                                                                 {
                                                                                                                                    MemoryGameManager.instance.show();
                                                                                                                                 }
                                                                                                                              }
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              SoundManager.instance.play("008");
                                                                                                                              DDTMatchManager.instance.show();
                                                                                                                           }
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           SoundManager.instance.play("008");
                                                                                                                           HappyRechargeManager.instance.loadResource();
                                                                                                                        }
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        SoundManager.instance.play("008");
                                                                                                                        if(ActivityEnterGrapType.Instance.IsEnterGame(25))
                                                                                                                        {
                                                                                                                           SocketManager.Instance.out.petIslandInit(1);
                                                                                                                        }
                                                                                                                     }
                                                                                                                  }
                                                                                                                  else
                                                                                                                  {
                                                                                                                     SoundManager.instance.play("008");
                                                                                                                     if(ActivityEnterGrapType.Instance.IsEnterGame(12))
                                                                                                                     {
                                                                                                                        self = PlayerManager.Instance.Self;
                                                                                                                        if(PlayerManager.Instance.Self.Bag.getItemAt(6) == null)
                                                                                                                        {
                                                                                                                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIController.weapon"));
                                                                                                                           return;
                                                                                                                        }
                                                                                                                        if(self.IsMounts)
                                                                                                                        {
                                                                                                                           HorseRaceManager.Instance.enterView();
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horseRace.noMount"));
                                                                                                                        }
                                                                                                                     }
                                                                                                                  }
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  SoundManager.instance.play("008");
                                                                                                                  if(ActivityEnterGrapType.Instance.IsEnterGame(25))
                                                                                                                  {
                                                                                                                     ZodiacManager.instance.show();
                                                                                                                  }
                                                                                                               }
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               SoundManager.instance.play("008");
                                                                                                               NewYearRiceManager.instance.show();
                                                                                                            }
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            SoundManager.instance.play("008");
                                                                                                            CloudBuyLotteryManager.Instance.loaderCloudBuyFrame();
                                                                                                         }
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         SoundManager.instance.play("008");
                                                                                                         SocketManager.Instance.out.enterMagpieBridge();
                                                                                                      }
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      SoundManager.instance.play("008");
                                                                                                      CatchInsectManager.instance.onClickCatchInsectIcon();
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   SoundManager.instance.play("008");
                                                                                                   RescueManager.instance.show();
                                                                                                }
                                                                                             }
                                                                                             else if(ActivityEnterGrapType.Instance.IsEnterGame(15))
                                                                                             {
                                                                                                SoundManager.instance.playButtonSound();
                                                                                                WorshipTheMoonManager.getInstance().showFrame();
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             SoundManager.instance.playButtonSound();
                                                                                             TreasurePuzzleManager.Instance.onClickTreasurePuzzleIcon();
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          SoundManager.instance.playButtonSound();
                                                                                          WitchBlessingManager.Instance.onClickIcon();
                                                                                       }
                                                                                    }
                                                                                    else if(ActivityEnterGrapType.Instance.IsEnterGame(5))
                                                                                    {
                                                                                       NewSevenDayAndNewPlayerManager.Instance.onClickSevenDayTargetIcon(evt);
                                                                                    }
                                                                                 }
                                                                                 else if(ActivityEnterGrapType.Instance.IsEnterGame(10))
                                                                                 {
                                                                                    SoundManager.instance.playButtonSound();
                                                                                    StateManager.setState("boguadventure");
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 SoundManager.instance.play("008");
                                                                                 if(ActivityEnterGrapType.Instance.IsEnterGame(10))
                                                                                 {
                                                                                    DDPlayManaer.Instance.show();
                                                                                 }
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              SoundManager.instance.play("008");
                                                                              ChickActivationManager.instance.showFrame();
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           SoundManager.instance.play("008");
                                                                           if(ActivityEnterGrapType.Instance.IsEnterGame(15))
                                                                           {
                                                                              SocketManager.Instance.out.sendGetShopBuyLimitedCount();
                                                                              ShopSaleManager.Instance.show();
                                                                           }
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        SoundManager.instance.play("008");
                                                                        if(ActivityEnterGrapType.Instance.IsEnterGame(20))
                                                                        {
                                                                           EntertainmentModeManager.instance.show();
                                                                        }
                                                                     }
                                                                  }
                                                                  else if(ActivityEnterGrapType.Instance.IsEnterGame(10))
                                                                  {
                                                                     GodsRoadsManager.instance.openGodsRoads(evt);
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  SoundManager.instance.play("008");
                                                                  WonderfulActivityManager.Instance.clickWonderfulActView = true;
                                                                  SocketManager.Instance.out.requestWonderfulActInit(1);
                                                               }
                                                            }
                                                            else
                                                            {
                                                               RegressManager.instance.show();
                                                            }
                                                         }
                                                         else if(ActivityEnterGrapType.Instance.IsEnterGame(10))
                                                         {
                                                            TreasureManager.instance.showFrame();
                                                         }
                                                      }
                                                      else if(ActivityEnterGrapType.Instance.IsEnterGame(20))
                                                      {
                                                         SyahManager.Instance.show();
                                                      }
                                                   }
                                                   else if(ActivityEnterGrapType.Instance.IsEnterGame(1))
                                                   {
                                                      MysteriousManager.instance.show();
                                                   }
                                                }
                                                else
                                                {
                                                   SoundManager.instance.play("008");
                                                   if(ActivityEnterGrapType.Instance.IsEnterGame(1))
                                                   {
                                                      if(PlayerManager.Instance.Self.bagLocked)
                                                      {
                                                         BaglockedManager.Instance.show();
                                                         return;
                                                      }
                                                      RouletteManager.instance.useBless();
                                                   }
                                                }
                                             }
                                             else if(ActivityEnterGrapType.Instance.IsEnterGame(15))
                                             {
                                                GroupPurchaseManager.instance.showFrame();
                                             }
                                          }
                                          else if(ActivityEnterGrapType.Instance.IsEnterGame(10))
                                          {
                                             LeftGunRouletteManager.instance.showTurnplate();
                                          }
                                       }
                                       else if(ActivityEnterGrapType.Instance.IsEnterGame(10))
                                       {
                                          NewChickenBoxManager.instance.enterNewBoxView(evt);
                                       }
                                    }
                                    else if(ActivityEnterGrapType.Instance.IsEnterGame(1))
                                    {
                                       LanternRiddlesManager.instance.onLanternShow(evt);
                                    }
                                 }
                                 else if(ActivityEnterGrapType.Instance.IsEnterGame(1))
                                 {
                                    AccumulativeManager.instance.showFrame();
                                 }
                              }
                              else if(ActivityEnterGrapType.Instance.IsEnterGame(1))
                              {
                                 GameInSocketOut.sendRequestEnterDiceSystem();
                              }
                           }
                           else if(ActivityEnterGrapType.Instance.IsEnterGame(10))
                           {
                              LuckStarManager.Instance.onClickLuckyStarIocn(evt);
                           }
                        }
                        else if(ActivityEnterGrapType.Instance.IsEnterGame(21))
                        {
                           SuperWinnerManager.instance.openSuperWinner(evt);
                        }
                     }
                     else if(ActivityEnterGrapType.Instance.IsEnterGame(13))
                     {
                        PyramidManager.instance.onClickPyramidIcon(evt);
                     }
                  }
                  else if(ActivityEnterGrapType.Instance.IsEnterGame(1))
                  {
                     CatchBeastManager.instance.show();
                  }
               }
               else if(ActivityEnterGrapType.Instance.IsEnterGame(1))
               {
                  ChristmasCoreManager.instance.show();
               }
            }
         }
      }
      
      public function createHallIconPanelIcon($iconInfo:HallIconInfo) : HallIcon
      {
         var iconString:* = null;
         var _loc3_:* = $iconInfo.icontype;
         if("worldbossentrance1" !== _loc3_)
         {
            if("worldbossentrance4" !== _loc3_)
            {
               if("camp" !== _loc3_)
               {
                  if("sevendouble" !== _loc3_)
                  {
                     if("league" !== _loc3_)
                     {
                        if("ringstation" !== _loc3_)
                        {
                           if("transnational" !== _loc3_)
                           {
                              if("fightfootballtime" !== _loc3_)
                              {
                                 if("consortiabattle" !== _loc3_)
                                 {
                                    if("littlegamenote" !== _loc3_)
                                    {
                                       if("flowerGiving" !== _loc3_)
                                       {
                                          if("escort" !== _loc3_)
                                          {
                                             if("buried" !== _loc3_)
                                             {
                                                if("moneyTree" !== _loc3_)
                                                {
                                                   if("draft" !== _loc3_)
                                                   {
                                                      if("survival" !== _loc3_)
                                                      {
                                                         if("trial" !== _loc3_)
                                                         {
                                                            if("christmas" !== _loc3_)
                                                            {
                                                               if("catchBeast" !== _loc3_)
                                                               {
                                                                  if("pyramid" !== _loc3_)
                                                                  {
                                                                     if("superWinner" !== _loc3_)
                                                                     {
                                                                        if("luckStar" !== _loc3_)
                                                                        {
                                                                           if("growthPackage" !== _loc3_)
                                                                           {
                                                                              if("dice" !== _loc3_)
                                                                              {
                                                                                 if("accumulativeLogin" !== _loc3_)
                                                                                 {
                                                                                    if("guildMemberWeek" !== _loc3_)
                                                                                    {
                                                                                       if("lanternRiddles" !== _loc3_)
                                                                                       {
                                                                                          if("newChickenBox" !== _loc3_)
                                                                                          {
                                                                                             if("leftGunRoulette" !== _loc3_)
                                                                                             {
                                                                                                if("groupPurchase" !== _loc3_)
                                                                                                {
                                                                                                   if("luckStone" !== _loc3_)
                                                                                                   {
                                                                                                      if("mysteriousRoulette" !== _loc3_)
                                                                                                      {
                                                                                                         if("syah" !== _loc3_)
                                                                                                         {
                                                                                                            if("treasureHunting" !== _loc3_)
                                                                                                            {
                                                                                                               if("oldPlayerRegress" !== _loc3_)
                                                                                                               {
                                                                                                                  if("limitActivity" !== _loc3_)
                                                                                                                  {
                                                                                                                     if("lightRoad" !== _loc3_)
                                                                                                                     {
                                                                                                                        if("sevenDayTarget" !== _loc3_)
                                                                                                                        {
                                                                                                                           if("godsRoads" !== _loc3_)
                                                                                                                           {
                                                                                                                              if("entertainment" !== _loc3_)
                                                                                                                              {
                                                                                                                                 if("saleshop" !== _loc3_)
                                                                                                                                 {
                                                                                                                                    if("kingDivision" !== _loc3_)
                                                                                                                                    {
                                                                                                                                       if("chickActivation" !== _loc3_)
                                                                                                                                       {
                                                                                                                                          if("DDPlay" !== _loc3_)
                                                                                                                                          {
                                                                                                                                             if("boguadventure" !== _loc3_)
                                                                                                                                             {
                                                                                                                                                if("witchblessing" !== _loc3_)
                                                                                                                                                {
                                                                                                                                                   if("treasurepuzzle" !== _loc3_)
                                                                                                                                                   {
                                                                                                                                                      if("worshipTheMoon" !== _loc3_)
                                                                                                                                                      {
                                                                                                                                                         if("FoodActivity" !== _loc3_)
                                                                                                                                                         {
                                                                                                                                                            if("halloween" !== _loc3_)
                                                                                                                                                            {
                                                                                                                                                               if("rescue" !== _loc3_)
                                                                                                                                                               {
                                                                                                                                                                  if("catchinsect" !== _loc3_)
                                                                                                                                                                  {
                                                                                                                                                                     if("magpiebridge" !== _loc3_)
                                                                                                                                                                     {
                                                                                                                                                                        if("cloudbuylottery" !== _loc3_)
                                                                                                                                                                        {
                                                                                                                                                                           if("treasurelost" !== _loc3_)
                                                                                                                                                                           {
                                                                                                                                                                              if("newYearRice" !== _loc3_)
                                                                                                                                                                              {
                                                                                                                                                                                 if("zodiac" !== _loc3_)
                                                                                                                                                                                 {
                                                                                                                                                                                    if("horseRace" !== _loc3_)
                                                                                                                                                                                    {
                                                                                                                                                                                       if("prayIndiana" !== _loc3_)
                                                                                                                                                                                       {
                                                                                                                                                                                          if("petIsland" !== _loc3_)
                                                                                                                                                                                          {
                                                                                                                                                                                             if("happyRecharge" !== _loc3_)
                                                                                                                                                                                             {
                                                                                                                                                                                                if("ddtMatch" !== _loc3_)
                                                                                                                                                                                                {
                                                                                                                                                                                                   if("memoryGame" !== _loc3_)
                                                                                                                                                                                                   {
                                                                                                                                                                                                      if("sanxiao" !== _loc3_)
                                                                                                                                                                                                      {
                                                                                                                                                                                                         if("panicBuying" !== _loc3_)
                                                                                                                                                                                                         {
                                                                                                                                                                                                            if("godCard" !== _loc3_)
                                                                                                                                                                                                            {
                                                                                                                                                                                                               if("ExchangeAct" !== _loc3_)
                                                                                                                                                                                                               {
                                                                                                                                                                                                                  if("godOfWealth" !== _loc3_)
                                                                                                                                                                                                                  {
                                                                                                                                                                                                                     if("redEnvelope" !== _loc3_)
                                                                                                                                                                                                                     {
                                                                                                                                                                                                                        if("ddqiyuan" !== _loc3_)
                                                                                                                                                                                                                        {
                                                                                                                                                                                                                           if("welfareCenter" !== _loc3_)
                                                                                                                                                                                                                           {
                                                                                                                                                                                                                              if("angelInvestment" !== _loc3_)
                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                 if("bombTurnTable" !== _loc3_)
                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                    if("luckLotteryDraw" !== _loc3_)
                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                       if("signActivity" !== _loc3_)
                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                          if("bravedoor" !== _loc3_)
                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                             if("lotteryTicket" !== _loc3_)
                                                                                                                                                                                                                                             {
                                                                                                                                                                                                                                                if("goldmine" !== _loc3_)
                                                                                                                                                                                                                                                {
                                                                                                                                                                                                                                                   if("cityBattle" !== _loc3_)
                                                                                                                                                                                                                                                   {
                                                                                                                                                                                                                                                      if("ddtKingWay" !== _loc3_)
                                                                                                                                                                                                                                                      {
                                                                                                                                                                                                                                                         if("indiana" !== _loc3_)
                                                                                                                                                                                                                                                         {
                                                                                                                                                                                                                                                            if("oldPlayerComeBack" !== _loc3_)
                                                                                                                                                                                                                                                            {
                                                                                                                                                                                                                                                               if("sevenday" !== _loc3_)
                                                                                                                                                                                                                                                               {
                                                                                                                                                                                                                                                                  if("condiscount" !== _loc3_)
                                                                                                                                                                                                                                                                  {
                                                                                                                                                                                                                                                                     if("defend_island" !== _loc3_)
                                                                                                                                                                                                                                                                     {
                                                                                                                                                                                                                                                                        if("conRecharge" !== _loc3_)
                                                                                                                                                                                                                                                                        {
                                                                                                                                                                                                                                                                           if("bank" !== _loc3_)
                                                                                                                                                                                                                                                                           {
                                                                                                                                                                                                                                                                              if("stock" !== _loc3_)
                                                                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                                                                 if("mines" !== _loc3_)
                                                                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                                                                    if("teamBattle" !== _loc3_)
                                                                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                                                                       if("devilTurn" !== _loc3_)
                                                                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                                                                          if("dreamLandChallenge" !== _loc3_)
                                                                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                                                                             if("worldcupGuess" !== _loc3_)
                                                                                                                                                                                                                                                                                             {
                                                                                                                                                                                                                                                                                                if("oldPlayer" === _loc3_)
                                                                                                                                                                                                                                                                                                {
                                                                                                                                                                                                                                                                                                   iconString = "assets.hallIcon.oldPlayerIcon";
                                                                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                                                                             else
                                                                                                                                                                                                                                                                                             {
                                                                                                                                                                                                                                                                                                iconString = "assets.hallIcon.worldcupIcon";
                                                                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                                                                          else
                                                                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                                                                             iconString = "assets.hallIcon.dreamlandChallengeIcon";
                                                                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                                                                       else
                                                                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                                                                          iconString = "assets.hallIcon.devilTurnIcon";
                                                                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                                                                       iconString = "assets.hallIcon.teamBattleIcon";
                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                                                                 else
                                                                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                                                                    iconString = "assets.hallIcon.minesIcon";
                                                                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                                                              }
                                                                                                                                                                                                                                                                              else
                                                                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                                                                 iconString = "assets.hallIcon.stockIcon";
                                                                                                                                                                                                                                                                              }
                                                                                                                                                                                                                                                                           }
                                                                                                                                                                                                                                                                           else
                                                                                                                                                                                                                                                                           {
                                                                                                                                                                                                                                                                              iconString = "assets.hallIcon.bankIcon";
                                                                                                                                                                                                                                                                           }
                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                        {
                                                                                                                                                                                                                                                                           iconString = "assets.hallIcon.conRechargeIcon";
                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                     }
                                                                                                                                                                                                                                                                     else
                                                                                                                                                                                                                                                                     {
                                                                                                                                                                                                                                                                        iconString = "assets.hallIcon.defendDDTIslandIcon";
                                                                                                                                                                                                                                                                     }
                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                                  else
                                                                                                                                                                                                                                                                  {
                                                                                                                                                                                                                                                                     iconString = "assets.hallIcon.condiscountIcon";
                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                               }
                                                                                                                                                                                                                                                               else
                                                                                                                                                                                                                                                               {
                                                                                                                                                                                                                                                                  iconString = "assets.hallIcon.sevendayIcon";
                                                                                                                                                                                                                                                               }
                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                            {
                                                                                                                                                                                                                                                               iconString = "assets.hallIcon.oldPlayerComeBack";
                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                         }
                                                                                                                                                                                                                                                         else
                                                                                                                                                                                                                                                         {
                                                                                                                                                                                                                                                            iconString = "assets.hallIcon.indianaIcon";
                                                                                                                                                                                                                                                         }
                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                      else
                                                                                                                                                                                                                                                      {
                                                                                                                                                                                                                                                         iconString = "assets.hallIcon.ddtKingWayIcon";
                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                   else
                                                                                                                                                                                                                                                   {
                                                                                                                                                                                                                                                      iconString = "assets.hallIcon.cityBattle";
                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                {
                                                                                                                                                                                                                                                   iconString = "assets.hallIcon.goldmineIcon";
                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                             else
                                                                                                                                                                                                                                             {
                                                                                                                                                                                                                                                iconString = "assets.hallIcon.lotteryTicketIcon";
                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                          else
                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                             iconString = "assets.hallIcon.braveDoor.icon";
                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                       else
                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                          iconString = "assets.hallIcon.signActivity";
                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                       iconString = "asset.hall.callBackLotteryDrawIcon";
                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                 else
                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                    iconString = "assets.hallIcon.bombTurnTable.icon";
                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                              }
                                                                                                                                                                                                                              else
                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                 iconString = "assets.hallIcon.angelInvestmentIcon";
                                                                                                                                                                                                                              }
                                                                                                                                                                                                                           }
                                                                                                                                                                                                                           else
                                                                                                                                                                                                                           {
                                                                                                                                                                                                                              iconString = "asset.hallIcon.welfareCenterIcon";
                                                                                                                                                                                                                           }
                                                                                                                                                                                                                        }
                                                                                                                                                                                                                        else
                                                                                                                                                                                                                        {
                                                                                                                                                                                                                           iconString = "assets.hallIcon.ddQiYuanIcon";
                                                                                                                                                                                                                        }
                                                                                                                                                                                                                     }
                                                                                                                                                                                                                     else
                                                                                                                                                                                                                     {
                                                                                                                                                                                                                        iconString = "assets.hallIcon.redEnvelope";
                                                                                                                                                                                                                     }
                                                                                                                                                                                                                  }
                                                                                                                                                                                                                  else
                                                                                                                                                                                                                  {
                                                                                                                                                                                                                     iconString = "assets.hallIcon.godOfWealthIcon";
                                                                                                                                                                                                                  }
                                                                                                                                                                                                               }
                                                                                                                                                                                                               else
                                                                                                                                                                                                               {
                                                                                                                                                                                                                  iconString = "asset.hallIcon.exchangeAct";
                                                                                                                                                                                                               }
                                                                                                                                                                                                            }
                                                                                                                                                                                                            else
                                                                                                                                                                                                            {
                                                                                                                                                                                                               iconString = "assets.hallIcon.godCard";
                                                                                                                                                                                                            }
                                                                                                                                                                                                         }
                                                                                                                                                                                                         else
                                                                                                                                                                                                         {
                                                                                                                                                                                                            iconString = "assets.hallIcon.panicBuyingIcon";
                                                                                                                                                                                                         }
                                                                                                                                                                                                      }
                                                                                                                                                                                                      else
                                                                                                                                                                                                      {
                                                                                                                                                                                                         iconString = "assets.hallIconl.sanxiaoBtn";
                                                                                                                                                                                                      }
                                                                                                                                                                                                   }
                                                                                                                                                                                                   else
                                                                                                                                                                                                   {
                                                                                                                                                                                                      iconString = "assets.hallIcon.MemoryGameIcon";
                                                                                                                                                                                                   }
                                                                                                                                                                                                }
                                                                                                                                                                                                else
                                                                                                                                                                                                {
                                                                                                                                                                                                   iconString = "assets.hallIcon.DDTMatch";
                                                                                                                                                                                                }
                                                                                                                                                                                             }
                                                                                                                                                                                             else
                                                                                                                                                                                             {
                                                                                                                                                                                                iconString = "assets.hallIcon.happyRecharge";
                                                                                                                                                                                             }
                                                                                                                                                                                          }
                                                                                                                                                                                          else
                                                                                                                                                                                          {
                                                                                                                                                                                             iconString = "assets.hallIcon.petIsland";
                                                                                                                                                                                          }
                                                                                                                                                                                       }
                                                                                                                                                                                       else
                                                                                                                                                                                       {
                                                                                                                                                                                          iconString = "assets.hallIcon.prayIndianaIcon";
                                                                                                                                                                                       }
                                                                                                                                                                                    }
                                                                                                                                                                                    else
                                                                                                                                                                                    {
                                                                                                                                                                                       iconString = "assets.hallIcon.horseRace";
                                                                                                                                                                                    }
                                                                                                                                                                                 }
                                                                                                                                                                                 else
                                                                                                                                                                                 {
                                                                                                                                                                                    iconString = "assets.hallIcon.zodiacIcon";
                                                                                                                                                                                 }
                                                                                                                                                                              }
                                                                                                                                                                              else
                                                                                                                                                                              {
                                                                                                                                                                                 iconString = "assets.hallIcon.newYearRiceIcon";
                                                                                                                                                                              }
                                                                                                                                                                           }
                                                                                                                                                                           else
                                                                                                                                                                           {
                                                                                                                                                                              iconString = "assets.hallIcon.treasureLostIcon";
                                                                                                                                                                           }
                                                                                                                                                                        }
                                                                                                                                                                        else
                                                                                                                                                                        {
                                                                                                                                                                           iconString = "assets.hallIcon.cloudbuylotteryIcon";
                                                                                                                                                                        }
                                                                                                                                                                     }
                                                                                                                                                                     else
                                                                                                                                                                     {
                                                                                                                                                                        iconString = "assets.hallIcon.magpiebridge";
                                                                                                                                                                     }
                                                                                                                                                                  }
                                                                                                                                                                  else
                                                                                                                                                                  {
                                                                                                                                                                     iconString = "assets.hallIcon.catchInsect";
                                                                                                                                                                  }
                                                                                                                                                               }
                                                                                                                                                               else
                                                                                                                                                               {
                                                                                                                                                                  iconString = "assets.hallIcon.rescue";
                                                                                                                                                               }
                                                                                                                                                            }
                                                                                                                                                            else
                                                                                                                                                            {
                                                                                                                                                               iconString = "assets.hallIcon.halloweenIcon";
                                                                                                                                                            }
                                                                                                                                                         }
                                                                                                                                                         else
                                                                                                                                                         {
                                                                                                                                                            iconString = "asset.hallIcon.FoodActivity";
                                                                                                                                                         }
                                                                                                                                                      }
                                                                                                                                                      else
                                                                                                                                                      {
                                                                                                                                                         iconString = "assets.hallIcon.worshipTheMoon";
                                                                                                                                                      }
                                                                                                                                                   }
                                                                                                                                                   else
                                                                                                                                                   {
                                                                                                                                                      iconString = "assets.hallIcon.treasurePuzzleIcon";
                                                                                                                                                   }
                                                                                                                                                }
                                                                                                                                                else
                                                                                                                                                {
                                                                                                                                                   iconString = "assets.hallIcon.witchBlessingIcon";
                                                                                                                                                }
                                                                                                                                             }
                                                                                                                                             else
                                                                                                                                             {
                                                                                                                                                iconString = "assets.hallIcon.boguAdventureIcon";
                                                                                                                                             }
                                                                                                                                          }
                                                                                                                                          else
                                                                                                                                          {
                                                                                                                                             iconString = "assets.hallIcon.DDPlayIcon";
                                                                                                                                          }
                                                                                                                                       }
                                                                                                                                       else
                                                                                                                                       {
                                                                                                                                          iconString = "assets.hallIcon.chickActivationIcon";
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       iconString = "assets.hallIcon.kingDivisionIcon";
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 else
                                                                                                                                 {
                                                                                                                                    iconString = "assets.hallIcon.saleShopIcon";
                                                                                                                                 }
                                                                                                                              }
                                                                                                                              else
                                                                                                                              {
                                                                                                                                 iconString = "assets.hallIcon.entertainmentIcon";
                                                                                                                              }
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              iconString = "assets.hallIcon.godsRoadsIcon";
                                                                                                                           }
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           iconString = "assets.hallIcon.sevenDayTargetIcon";
                                                                                                                        }
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        iconString = "assets.hallIcon.lightRoadIcon";
                                                                                                                     }
                                                                                                                  }
                                                                                                                  else
                                                                                                                  {
                                                                                                                     iconString = "assets.hallIcon.limitActivityIcon";
                                                                                                                  }
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  iconString = "assets.hallIcon.oldPlayerRegressIcon";
                                                                                                               }
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               iconString = "assets.hallIcon.treasureHuntingIcon";
                                                                                                            }
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            iconString = "assets.hallIcon.syahIcon";
                                                                                                         }
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         iconString = "assets.hallIcon.mysteriousRouletteIcon";
                                                                                                      }
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      iconString = "assets.hallIcon.luckStoneIcon";
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   iconString = "assets.hallIcon.groupPurchaseIcon";
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                iconString = "assets.hallIcon.rouletteGunIcon";
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             iconString = "assets.hallIcon.newChickenBoxIcon";
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          iconString = "assets.hallIcon.lanternriddlesIcon";
                                                                                       }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       iconString = "assets.hallIcon.guildmemberweekIcon";
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    iconString = "assets.hallIcon.accumulativeLoginIcon";
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 iconString = "assets.hallIcon.diceIcon";
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              iconString = "assets.hallIcon.growthPachageIcon";
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           iconString = "assets.hallIcon.luckyStarIcon";
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        iconString = "assets.hallIcon.superWinnerEntryIcon";
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     iconString = "assets.hallIcon.pyramidIcon";
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  iconString = "asset.hallIcon.catchBeastIcon";
                                                               }
                                                            }
                                                            else
                                                            {
                                                               iconString = "assets.hallIcon.christmasIcon";
                                                            }
                                                         }
                                                         else
                                                         {
                                                            iconString = "asset.ddthall.trialEnterIcon";
                                                         }
                                                      }
                                                      else
                                                      {
                                                         iconString = "assets.hallIcon.survivalIcon";
                                                      }
                                                   }
                                                   else
                                                   {
                                                      iconString = "asset.hall.draftIcon";
                                                   }
                                                }
                                                else
                                                {
                                                   iconString = "assets.hallIcon.moneyTree";
                                                }
                                             }
                                             else
                                             {
                                                iconString = "assets.hallIcon.buriedIcon";
                                             }
                                          }
                                          else
                                          {
                                             iconString = "assets.hallIcon.escortEntryIcon";
                                          }
                                       }
                                       else
                                       {
                                          iconString = "assets.hallIcon.flowerGivingIcon";
                                       }
                                    }
                                    else
                                    {
                                       iconString = "assets.hallIcon.littleGameNoteIcon";
                                    }
                                 }
                                 else
                                 {
                                    iconString = "assets.hallIcon.consortiaBattleEntryIcon";
                                 }
                              }
                              else
                              {
                                 iconString = "assets.hallIcon.fightFootballTimeIcon";
                              }
                           }
                           else
                           {
                              iconString = "assets.hallIcon.transnationalIcon";
                           }
                        }
                        else
                        {
                           iconString = "assets.hallIcon.ringStationIcon";
                        }
                     }
                     else
                     {
                        iconString = "assets.hallIcon.leagueIcon";
                     }
                  }
                  else
                  {
                     iconString = "assets.hallIcon.sevenDoubleEntryIcon";
                  }
               }
               else
               {
                  iconString = "assets.hallIcon.campIcon";
               }
            }
            else
            {
               iconString = "assets.hallIcon.worldBossEntrance_4";
            }
         }
         else
         {
            iconString = "assets.hallIcon.worldBossEntrance_1";
         }
         return new HallIcon(iconString,$iconInfo);
      }
      
      public function getIconByType($hallType:int, $iconType:String) : DisplayObject
      {
         if($hallType == 1 && _wonderFulPlay)
         {
            return _wonderFulPlay.getIconByType($iconType);
         }
         if($hallType == 2 && _activity)
         {
            return _activity.getIconByType($iconType);
         }
         return null;
      }
      
      private function topIndex() : void
      {
         if(this.parent && this.parent.numChildren > 1)
         {
            this.parent.setChildIndex(this,this.parent.numChildren - 1);
         }
      }
      
      private function checkNoneActivity($count:int) : void
      {
         if($count <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.calendar.NoneActivity"));
         }
      }
      
      public function __checkHallIconExperienceOpenHandler(evt:HallIconEvent) : void
      {
         updateRightIconTaskArrow();
      }
      
      private function updateRightIconTaskArrow() : void
      {
         var step:int = 0;
         var posId:int = 0;
         var cacheRightIconTask:Object = HallIconManager.instance.model.cacheRightIconTask;
         if(cacheRightIconTask && !cacheRightIconTask.isCompleted && SharedManager.Instance.halliconExperienceStep < 2)
         {
            step = SharedManager.Instance.halliconExperienceStep;
            posId = 1;
            if(_iconBox.numChildren == 3)
            {
               posId = 2;
            }
            else if(_iconBox.numChildren == 4)
            {
               posId = 3;
            }
            else if(_iconBox.numChildren == 5)
            {
               posId = 4;
            }
            if(step == 1)
            {
               posId = posId + 1;
            }
            NewHandContainer.Instance.showArrow(199,-90,"hallIcon.hallIconExperiencePos" + posId,"assets.hallIcon.experienceClickTxt","hallIcon.hallIconExperienceTxt" + posId,_showArrowSp,0,true);
         }
         else if(NewHandContainer.Instance.hasArrow(199))
         {
            NewHandContainer.Instance.clearArrowByID(199);
         }
      }
      
      private function checkRightIconTaskClickHandler($halltype:int) : void
      {
         if(!HallIconManager.instance.model.cacheRightIconTask)
         {
            return;
         }
         if($halltype == 1 && SharedManager.Instance.halliconExperienceStep == 0)
         {
            SharedManager.Instance.halliconExperienceStep = 1;
            updateRightIconTaskArrow();
            SharedManager.Instance.save();
         }
         else if($halltype == 2 && SharedManager.Instance.halliconExperienceStep == 1)
         {
            SharedManager.Instance.halliconExperienceStep = 2;
            updateRightIconTaskArrow();
            TaskManager.instance.checkQuest(2042,1,0);
            SharedManager.Instance.halliconExperienceStep = 0;
            SharedManager.Instance.save();
         }
      }
      
      private function removeEvent() : void
      {
         HallIconManager.instance.model.removeEventListener("updateRightIconView",__updateIconViewHandler);
         HallIconManager.instance.model.removeEventListener("updateBatchRightIconView",__updateBatchIconViewHandler);
         HallIconManager.instance.removeEventListener("checkHallIconExperienceOpen",__checkHallIconExperienceOpenHandler);
         FirstRechargeManger.Instance.removeEventListener("removefirstrechargeicon",__removeIcon);
         FirstRechargeManger.Instance.removeEventListener("addfirstrechargeicon",__addIcon);
      }
      
      private function removeWonderfulPlayIcon() : void
      {
         if(_wonderFulPlay)
         {
            _wonderFulPlay.removeEventListener("click",__wonderFulPlayClickHandler);
            ObjectUtils.disposeObject(_wonderFulPlay);
            _wonderFulPlay = null;
         }
      }
      
      private function removeEveryDayActivityIcon() : void
      {
         if(_everyDayActivityIcon)
         {
            _everyDayActivityIcon.stop();
            _everyDayActivityIcon.removeEventListener("click",__everyDayActivityIconClickHandler);
            ObjectUtils.disposeObject(_everyDayActivityIcon);
            _everyDayActivityIcon = null;
         }
      }
      
      private function removeWantstrongIcon() : void
      {
         if(_wantstrongIcon)
         {
            _wantstrongIcon.stop();
            _wantstrongIcon.removeEventListener("click",__wantstrongIconClickHandler);
            ObjectUtils.disposeObject(_wantstrongIcon);
            _wantstrongIcon = null;
         }
      }
      
      private function removeRoleRechargeIcon() : void
      {
         if(_roleRechargeIcon)
         {
            _roleRechargeIcon.stop();
            _roleRechargeIcon.removeEventListener("click",__roleRechargeClickHandler);
            ObjectUtils.disposeObject(_roleRechargeIcon);
            _roleRechargeIcon = null;
         }
      }
      
      private function removeFirstRechargeIcon() : void
      {
         if(_firstRechargeIcon)
         {
            _firstRechargeIcon.stop();
            _firstRechargeIcon.removeEventListener("click",__firstRechargeIconClickHandler);
            ObjectUtils.disposeObject(_firstRechargeIcon);
            _firstRechargeIcon = null;
         }
      }
      
      private function removeActivityIcon() : void
      {
         if(_activity)
         {
            _activity.removeEventListener("click",__activityClickHandler);
            ObjectUtils.disposeObject(_activity);
            _activity = null;
         }
      }
      
      private function removeBossBox() : void
      {
         if(_boxButton)
         {
            ObjectUtils.disposeAllChildren(_boxButton);
            ObjectUtils.disposeObject(_boxButton);
            _boxButton = null;
         }
      }
      
      private function removeFoodBox() : void
      {
         if(_foodButton)
         {
            FoodActivityManager.Instance.stopTime();
            ObjectUtils.disposeAllChildren(_foodButton);
            ObjectUtils.disposeObject(_foodButton);
            _foodButton = null;
            FoodActivityManager.Instance.deleteBtn();
         }
      }
      
      private function __removeIcon(e:Event) : void
      {
         removeFirstRechargeIcon();
      }
      
      private function removePolarIcon() : void
      {
         if(_polarIcon)
         {
            ObjectUtils.disposeObject(_polarIcon);
            _polarIcon = null;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeWonderfulPlayIcon();
         removeEveryDayActivityIcon();
         removeActivityIcon();
         removeWantstrongIcon();
         removeRankIcon();
         removeCityBattleIcon();
         removeFirstRechargeIcon();
         removeBossBox();
         removeFoodBox();
         removePolarIcon();
         if(NewHandContainer.Instance.hasArrow(199))
         {
            NewHandContainer.Instance.clearArrowByID(199);
         }
         if(_showArrowSp)
         {
            ObjectUtils.disposeAllChildren(_showArrowSp);
            ObjectUtils.disposeObject(_showArrowSp);
            _showArrowSp = null;
         }
         if(_iconBox)
         {
            ObjectUtils.disposeAllChildren(_iconBox);
            ObjectUtils.disposeObject(_iconBox);
            _iconBox = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
