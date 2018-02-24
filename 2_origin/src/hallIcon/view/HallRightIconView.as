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
      
      private function __addIcon(param1:Event) : void
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
      
      private function addChildBox(param1:DisplayObject) : void
      {
         _iconBox.addChild(param1);
         _iconBox.arrange();
         _iconBox.x = -_iconBox.width;
      }
      
      private function __updateBatchIconViewHandler(param1:HallIconEvent) : void
      {
         var _loc2_:Dictionary = HallIconManager.instance.model.cacheRightIconDic;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            updateIconView(_loc3_);
         }
      }
      
      private function __updateIconViewHandler(param1:HallIconEvent) : void
      {
         var _loc2_:HallIconInfo = HallIconInfo(param1.data);
         updateIconView(_loc2_);
      }
      
      private function updateIconView(param1:HallIconInfo) : void
      {
         if(param1.halltype == 1 && _wonderFulPlay)
         {
            commonUpdateIconPanelView(_wonderFulPlay,param1,false);
            if(!param1.isopen)
            {
               removeWonderFulPlayChildHandler(param1.icontype);
            }
         }
         else if(param1.halltype == 2 && _activity)
         {
            commonUpdateIconPanelView(_activity,param1,true);
         }
         else
         {
            var _loc2_:* = param1.icontype;
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
      
      private function commonUpdateIconPanelView(param1:HallIconPanel, param2:HallIconInfo, param3:Boolean = false) : void
      {
         var _loc4_:* = null;
         if(param2.isopen)
         {
            _loc4_ = param1.getIconByType(param2.icontype) as HallIcon;
            if(!_loc4_)
            {
               _loc4_ = param1.addIcon(createHallIconPanelIcon(param2),param2.icontype,param2.orderid,param3) as HallIcon;
            }
            _loc4_.updateIcon(param2);
         }
         else
         {
            param1.removeIconByType(param2.icontype);
         }
         param1.arrange();
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
      
      private function __everyDayActivityIconClickHandler(param1:MouseEvent) : void
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
      
      private function __cityBattleIconClickHandler(param1:MouseEvent) : void
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
      
      private function __rankIconClickHandler(param1:MouseEvent) : void
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
      
      private function __wantstrongIconClickHandler(param1:MouseEvent) : void
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
      
      private function __roleRechargeClickHandler(param1:MouseEvent) : void
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
      
      private function __polarIconClickHandler(param1:MouseEvent) : void
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
      
      private function __firstRechargeIconClickHandler(param1:MouseEvent) : void
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
      
      private function __wonderFulPlayClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(_wonderFulPlay && param1.target == _wonderFulPlay.mainIcon)
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
         if(param1.target is HallIcon)
         {
            _loc2_ = param1.target as HallIcon;
            if(_loc2_.iconInfo.halltype == 1)
            {
               var _loc3_:* = _loc2_.iconInfo.icontype;
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
                        CampBattleManager.instance.__onCampBtnHander(param1);
                     }
                  }
               }
               SoundManager.instance.play("003");
               StateManager.setState("worldbossAward");
            }
         }
      }
      
      public function removeWonderFulPlayChildHandler(param1:String) : void
      {
         var _loc2_:* = param1;
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
      
      private function sevenDoubleCanEnterHandler(param1:Event) : void
      {
         SevenDoubleManager.instance.removeEventListener("sevenDoubleCanEnter",sevenDoubleCanEnterHandler);
         StateManager.setState("sevenDoubleScene");
      }
      
      private function canEnterHandler(param1:Event) : void
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
      
      private function __activityClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(_activity && param1.target == _activity.mainIcon)
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
         if(param1.target is HallIcon)
         {
            _loc2_ = param1.target as HallIcon;
            if(_loc2_.iconInfo.halltype == 2)
            {
               var _loc6_:* = _loc2_.iconInfo.icontype;
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
                                                                                                                                                                                                         if("devilTurn" === _loc6_)
                                                                                                                                                                                                         {
                                                                                                                                                                                                            if(ActivityEnterGrapType.Instance.IsEnterGame(ServerConfigManager.instance.devilTurnOpenLevelLimit))
                                                                                                                                                                                                            {
                                                                                                                                                                                                               DevilTurnManager.instance.show();
                                                                                                                                                                                                            }
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
                                                                                                                                                                        _loc3_ = CallBackLotteryDrawManager.instance.luckeyLotteryDrawModel.phase;
                                                                                                                                                                        _loc4_ = CallBackLotteryDrawManager.instance.getLuckeyLeftSec();
                                                                                                                                                                        if(_loc4_ <= 0)
                                                                                                                                                                        {
                                                                                                                                                                           _loc4_ = 0;
                                                                                                                                                                        }
                                                                                                                                                                        if(_loc4_ > 0 && _loc3_ == 0)
                                                                                                                                                                        {
                                                                                                                                                                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.activity.notOpen"));
                                                                                                                                                                           return;
                                                                                                                                                                        }
                                                                                                                                                                        if(_loc4_ <= 0 && _loc3_ == 0 || _loc4_ >= 0 && _loc3_ > 0)
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
                                                                                                                                                         GrowthPackageManager.instance.onClickIcon(param1);
                                                                                                                                                      }
                                                                                                                                                   }
                                                                                                                                                   else if(ActivityEnterGrapType.Instance.IsEnterGame(17))
                                                                                                                                                   {
                                                                                                                                                      GuildMemberWeekManager.instance.onClickguildMemberWeekIcon(param1);
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
                                                                                                                        _loc5_ = PlayerManager.Instance.Self;
                                                                                                                        if(PlayerManager.Instance.Self.Bag.getItemAt(6) == null)
                                                                                                                        {
                                                                                                                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIController.weapon"));
                                                                                                                           return;
                                                                                                                        }
                                                                                                                        if(_loc5_.IsMounts)
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
                                                                                       NewSevenDayAndNewPlayerManager.Instance.onClickSevenDayTargetIcon(param1);
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
                                                                     GodsRoadsManager.instance.openGodsRoads(param1);
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
                                          NewChickenBoxManager.instance.enterNewBoxView(param1);
                                       }
                                    }
                                    else if(ActivityEnterGrapType.Instance.IsEnterGame(1))
                                    {
                                       LanternRiddlesManager.instance.onLanternShow(param1);
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
                              LuckStarManager.Instance.onClickLuckyStarIocn(param1);
                           }
                        }
                        else if(ActivityEnterGrapType.Instance.IsEnterGame(21))
                        {
                           SuperWinnerManager.instance.openSuperWinner(param1);
                        }
                     }
                     else if(ActivityEnterGrapType.Instance.IsEnterGame(13))
                     {
                        PyramidManager.instance.onClickPyramidIcon(param1);
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
      
      public function createHallIconPanelIcon(param1:HallIconInfo) : HallIcon
      {
         var _loc2_:* = null;
         var _loc3_:* = param1.icontype;
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
                                                                                                                                                                                                                                                                                       if("devilTurn" === _loc3_)
                                                                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                                                                          _loc2_ = "assets.hallIcon.devilTurnIcon";
                                                                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                                                                       _loc2_ = "assets.hallIcon.teamBattleIcon";
                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                                                                 else
                                                                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                                                                    _loc2_ = "assets.hallIcon.minesIcon";
                                                                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                                                              }
                                                                                                                                                                                                                                                                              else
                                                                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                                                                 _loc2_ = "assets.hallIcon.stockIcon";
                                                                                                                                                                                                                                                                              }
                                                                                                                                                                                                                                                                           }
                                                                                                                                                                                                                                                                           else
                                                                                                                                                                                                                                                                           {
                                                                                                                                                                                                                                                                              _loc2_ = "assets.hallIcon.bankIcon";
                                                                                                                                                                                                                                                                           }
                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                        {
                                                                                                                                                                                                                                                                           _loc2_ = "assets.hallIcon.conRechargeIcon";
                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                     }
                                                                                                                                                                                                                                                                     else
                                                                                                                                                                                                                                                                     {
                                                                                                                                                                                                                                                                        _loc2_ = "assets.hallIcon.defendDDTIslandIcon";
                                                                                                                                                                                                                                                                     }
                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                                  else
                                                                                                                                                                                                                                                                  {
                                                                                                                                                                                                                                                                     _loc2_ = "assets.hallIcon.condiscountIcon";
                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                               }
                                                                                                                                                                                                                                                               else
                                                                                                                                                                                                                                                               {
                                                                                                                                                                                                                                                                  _loc2_ = "assets.hallIcon.sevendayIcon";
                                                                                                                                                                                                                                                               }
                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                            {
                                                                                                                                                                                                                                                               _loc2_ = "assets.hallIcon.oldPlayerComeBack";
                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                         }
                                                                                                                                                                                                                                                         else
                                                                                                                                                                                                                                                         {
                                                                                                                                                                                                                                                            _loc2_ = "assets.hallIcon.indianaIcon";
                                                                                                                                                                                                                                                         }
                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                      else
                                                                                                                                                                                                                                                      {
                                                                                                                                                                                                                                                         _loc2_ = "assets.hallIcon.ddtKingWayIcon";
                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                   else
                                                                                                                                                                                                                                                   {
                                                                                                                                                                                                                                                      _loc2_ = "assets.hallIcon.cityBattle";
                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                {
                                                                                                                                                                                                                                                   _loc2_ = "assets.hallIcon.goldmineIcon";
                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                             else
                                                                                                                                                                                                                                             {
                                                                                                                                                                                                                                                _loc2_ = "assets.hallIcon.lotteryTicketIcon";
                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                          else
                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                             _loc2_ = "assets.hallIcon.braveDoor.icon";
                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                       else
                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                          _loc2_ = "assets.hallIcon.signActivity";
                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                       _loc2_ = "asset.hall.callBackLotteryDrawIcon";
                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                 else
                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                    _loc2_ = "assets.hallIcon.bombTurnTable.icon";
                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                              }
                                                                                                                                                                                                                              else
                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                 _loc2_ = "assets.hallIcon.angelInvestmentIcon";
                                                                                                                                                                                                                              }
                                                                                                                                                                                                                           }
                                                                                                                                                                                                                           else
                                                                                                                                                                                                                           {
                                                                                                                                                                                                                              _loc2_ = "asset.hallIcon.welfareCenterIcon";
                                                                                                                                                                                                                           }
                                                                                                                                                                                                                        }
                                                                                                                                                                                                                        else
                                                                                                                                                                                                                        {
                                                                                                                                                                                                                           _loc2_ = "assets.hallIcon.ddQiYuanIcon";
                                                                                                                                                                                                                        }
                                                                                                                                                                                                                     }
                                                                                                                                                                                                                     else
                                                                                                                                                                                                                     {
                                                                                                                                                                                                                        _loc2_ = "assets.hallIcon.redEnvelope";
                                                                                                                                                                                                                     }
                                                                                                                                                                                                                  }
                                                                                                                                                                                                                  else
                                                                                                                                                                                                                  {
                                                                                                                                                                                                                     _loc2_ = "assets.hallIcon.godOfWealthIcon";
                                                                                                                                                                                                                  }
                                                                                                                                                                                                               }
                                                                                                                                                                                                               else
                                                                                                                                                                                                               {
                                                                                                                                                                                                                  _loc2_ = "asset.hallIcon.exchangeAct";
                                                                                                                                                                                                               }
                                                                                                                                                                                                            }
                                                                                                                                                                                                            else
                                                                                                                                                                                                            {
                                                                                                                                                                                                               _loc2_ = "assets.hallIcon.godCard";
                                                                                                                                                                                                            }
                                                                                                                                                                                                         }
                                                                                                                                                                                                         else
                                                                                                                                                                                                         {
                                                                                                                                                                                                            _loc2_ = "assets.hallIcon.panicBuyingIcon";
                                                                                                                                                                                                         }
                                                                                                                                                                                                      }
                                                                                                                                                                                                      else
                                                                                                                                                                                                      {
                                                                                                                                                                                                         _loc2_ = "assets.hallIconl.sanxiaoBtn";
                                                                                                                                                                                                      }
                                                                                                                                                                                                   }
                                                                                                                                                                                                   else
                                                                                                                                                                                                   {
                                                                                                                                                                                                      _loc2_ = "assets.hallIcon.MemoryGameIcon";
                                                                                                                                                                                                   }
                                                                                                                                                                                                }
                                                                                                                                                                                                else
                                                                                                                                                                                                {
                                                                                                                                                                                                   _loc2_ = "assets.hallIcon.DDTMatch";
                                                                                                                                                                                                }
                                                                                                                                                                                             }
                                                                                                                                                                                             else
                                                                                                                                                                                             {
                                                                                                                                                                                                _loc2_ = "assets.hallIcon.happyRecharge";
                                                                                                                                                                                             }
                                                                                                                                                                                          }
                                                                                                                                                                                          else
                                                                                                                                                                                          {
                                                                                                                                                                                             _loc2_ = "assets.hallIcon.petIsland";
                                                                                                                                                                                          }
                                                                                                                                                                                       }
                                                                                                                                                                                       else
                                                                                                                                                                                       {
                                                                                                                                                                                          _loc2_ = "assets.hallIcon.prayIndianaIcon";
                                                                                                                                                                                       }
                                                                                                                                                                                    }
                                                                                                                                                                                    else
                                                                                                                                                                                    {
                                                                                                                                                                                       _loc2_ = "assets.hallIcon.horseRace";
                                                                                                                                                                                    }
                                                                                                                                                                                 }
                                                                                                                                                                                 else
                                                                                                                                                                                 {
                                                                                                                                                                                    _loc2_ = "assets.hallIcon.zodiacIcon";
                                                                                                                                                                                 }
                                                                                                                                                                              }
                                                                                                                                                                              else
                                                                                                                                                                              {
                                                                                                                                                                                 _loc2_ = "assets.hallIcon.newYearRiceIcon";
                                                                                                                                                                              }
                                                                                                                                                                           }
                                                                                                                                                                           else
                                                                                                                                                                           {
                                                                                                                                                                              _loc2_ = "assets.hallIcon.treasureLostIcon";
                                                                                                                                                                           }
                                                                                                                                                                        }
                                                                                                                                                                        else
                                                                                                                                                                        {
                                                                                                                                                                           _loc2_ = "assets.hallIcon.cloudbuylotteryIcon";
                                                                                                                                                                        }
                                                                                                                                                                     }
                                                                                                                                                                     else
                                                                                                                                                                     {
                                                                                                                                                                        _loc2_ = "assets.hallIcon.magpiebridge";
                                                                                                                                                                     }
                                                                                                                                                                  }
                                                                                                                                                                  else
                                                                                                                                                                  {
                                                                                                                                                                     _loc2_ = "assets.hallIcon.catchInsect";
                                                                                                                                                                  }
                                                                                                                                                               }
                                                                                                                                                               else
                                                                                                                                                               {
                                                                                                                                                                  _loc2_ = "assets.hallIcon.rescue";
                                                                                                                                                               }
                                                                                                                                                            }
                                                                                                                                                            else
                                                                                                                                                            {
                                                                                                                                                               _loc2_ = "assets.hallIcon.halloweenIcon";
                                                                                                                                                            }
                                                                                                                                                         }
                                                                                                                                                         else
                                                                                                                                                         {
                                                                                                                                                            _loc2_ = "asset.hallIcon.FoodActivity";
                                                                                                                                                         }
                                                                                                                                                      }
                                                                                                                                                      else
                                                                                                                                                      {
                                                                                                                                                         _loc2_ = "assets.hallIcon.worshipTheMoon";
                                                                                                                                                      }
                                                                                                                                                   }
                                                                                                                                                   else
                                                                                                                                                   {
                                                                                                                                                      _loc2_ = "assets.hallIcon.treasurePuzzleIcon";
                                                                                                                                                   }
                                                                                                                                                }
                                                                                                                                                else
                                                                                                                                                {
                                                                                                                                                   _loc2_ = "assets.hallIcon.witchBlessingIcon";
                                                                                                                                                }
                                                                                                                                             }
                                                                                                                                             else
                                                                                                                                             {
                                                                                                                                                _loc2_ = "assets.hallIcon.boguAdventureIcon";
                                                                                                                                             }
                                                                                                                                          }
                                                                                                                                          else
                                                                                                                                          {
                                                                                                                                             _loc2_ = "assets.hallIcon.DDPlayIcon";
                                                                                                                                          }
                                                                                                                                       }
                                                                                                                                       else
                                                                                                                                       {
                                                                                                                                          _loc2_ = "assets.hallIcon.chickActivationIcon";
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       _loc2_ = "assets.hallIcon.kingDivisionIcon";
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 else
                                                                                                                                 {
                                                                                                                                    _loc2_ = "assets.hallIcon.saleShopIcon";
                                                                                                                                 }
                                                                                                                              }
                                                                                                                              else
                                                                                                                              {
                                                                                                                                 _loc2_ = "assets.hallIcon.entertainmentIcon";
                                                                                                                              }
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              _loc2_ = "assets.hallIcon.godsRoadsIcon";
                                                                                                                           }
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           _loc2_ = "assets.hallIcon.sevenDayTargetIcon";
                                                                                                                        }
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        _loc2_ = "assets.hallIcon.lightRoadIcon";
                                                                                                                     }
                                                                                                                  }
                                                                                                                  else
                                                                                                                  {
                                                                                                                     _loc2_ = "assets.hallIcon.limitActivityIcon";
                                                                                                                  }
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  _loc2_ = "assets.hallIcon.oldPlayerRegressIcon";
                                                                                                               }
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               _loc2_ = "assets.hallIcon.treasureHuntingIcon";
                                                                                                            }
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            _loc2_ = "assets.hallIcon.syahIcon";
                                                                                                         }
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         _loc2_ = "assets.hallIcon.mysteriousRouletteIcon";
                                                                                                      }
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      _loc2_ = "assets.hallIcon.luckStoneIcon";
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   _loc2_ = "assets.hallIcon.groupPurchaseIcon";
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                _loc2_ = "assets.hallIcon.rouletteGunIcon";
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             _loc2_ = "assets.hallIcon.newChickenBoxIcon";
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          _loc2_ = "assets.hallIcon.lanternriddlesIcon";
                                                                                       }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       _loc2_ = "assets.hallIcon.guildmemberweekIcon";
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    _loc2_ = "assets.hallIcon.accumulativeLoginIcon";
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 _loc2_ = "assets.hallIcon.diceIcon";
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              _loc2_ = "assets.hallIcon.growthPachageIcon";
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           _loc2_ = "assets.hallIcon.luckyStarIcon";
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc2_ = "assets.hallIcon.superWinnerEntryIcon";
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc2_ = "assets.hallIcon.pyramidIcon";
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  _loc2_ = "asset.hallIcon.catchBeastIcon";
                                                               }
                                                            }
                                                            else
                                                            {
                                                               _loc2_ = "assets.hallIcon.christmasIcon";
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _loc2_ = "asset.ddthall.trialEnterIcon";
                                                         }
                                                      }
                                                      else
                                                      {
                                                         _loc2_ = "assets.hallIcon.survivalIcon";
                                                      }
                                                   }
                                                   else
                                                   {
                                                      _loc2_ = "asset.hall.draftIcon";
                                                   }
                                                }
                                                else
                                                {
                                                   _loc2_ = "assets.hallIcon.moneyTree";
                                                }
                                             }
                                             else
                                             {
                                                _loc2_ = "assets.hallIcon.buriedIcon";
                                             }
                                          }
                                          else
                                          {
                                             _loc2_ = "assets.hallIcon.escortEntryIcon";
                                          }
                                       }
                                       else
                                       {
                                          _loc2_ = "assets.hallIcon.flowerGivingIcon";
                                       }
                                    }
                                    else
                                    {
                                       _loc2_ = "assets.hallIcon.littleGameNoteIcon";
                                    }
                                 }
                                 else
                                 {
                                    _loc2_ = "assets.hallIcon.consortiaBattleEntryIcon";
                                 }
                              }
                              else
                              {
                                 _loc2_ = "assets.hallIcon.fightFootballTimeIcon";
                              }
                           }
                           else
                           {
                              _loc2_ = "assets.hallIcon.transnationalIcon";
                           }
                        }
                        else
                        {
                           _loc2_ = "assets.hallIcon.ringStationIcon";
                        }
                     }
                     else
                     {
                        _loc2_ = "assets.hallIcon.leagueIcon";
                     }
                  }
                  else
                  {
                     _loc2_ = "assets.hallIcon.sevenDoubleEntryIcon";
                  }
               }
               else
               {
                  _loc2_ = "assets.hallIcon.campIcon";
               }
            }
            else
            {
               _loc2_ = "assets.hallIcon.worldBossEntrance_4";
            }
         }
         else
         {
            _loc2_ = "assets.hallIcon.worldBossEntrance_1";
         }
         return new HallIcon(_loc2_,param1);
      }
      
      public function getIconByType(param1:int, param2:String) : DisplayObject
      {
         if(param1 == 1 && _wonderFulPlay)
         {
            return _wonderFulPlay.getIconByType(param2);
         }
         if(param1 == 2 && _activity)
         {
            return _activity.getIconByType(param2);
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
      
      private function checkNoneActivity(param1:int) : void
      {
         if(param1 <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.calendar.NoneActivity"));
         }
      }
      
      public function __checkHallIconExperienceOpenHandler(param1:HallIconEvent) : void
      {
         updateRightIconTaskArrow();
      }
      
      private function updateRightIconTaskArrow() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:Object = HallIconManager.instance.model.cacheRightIconTask;
         if(_loc2_ && !_loc2_.isCompleted && SharedManager.Instance.halliconExperienceStep < 2)
         {
            _loc3_ = SharedManager.Instance.halliconExperienceStep;
            _loc1_ = 1;
            if(_iconBox.numChildren == 3)
            {
               _loc1_ = 2;
            }
            else if(_iconBox.numChildren == 4)
            {
               _loc1_ = 3;
            }
            else if(_iconBox.numChildren == 5)
            {
               _loc1_ = 4;
            }
            if(_loc3_ == 1)
            {
               _loc1_ = _loc1_ + 1;
            }
            NewHandContainer.Instance.showArrow(199,-90,"hallIcon.hallIconExperiencePos" + _loc1_,"assets.hallIcon.experienceClickTxt","hallIcon.hallIconExperienceTxt" + _loc1_,_showArrowSp,0,true);
         }
         else if(NewHandContainer.Instance.hasArrow(199))
         {
            NewHandContainer.Instance.clearArrowByID(199);
         }
      }
      
      private function checkRightIconTaskClickHandler(param1:int) : void
      {
         if(!HallIconManager.instance.model.cacheRightIconTask)
         {
            return;
         }
         if(param1 == 1 && SharedManager.Instance.halliconExperienceStep == 0)
         {
            SharedManager.Instance.halliconExperienceStep = 1;
            updateRightIconTaskArrow();
            SharedManager.Instance.save();
         }
         else if(param1 == 2 && SharedManager.Instance.halliconExperienceStep == 1)
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
      
      private function __removeIcon(param1:Event) : void
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
