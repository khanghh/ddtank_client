package ddt.states
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.QueueLoader;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.utils.StringUtils;
   import ddt.loader.LoaderCreate;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import hall.HallStateView;
   import login.LoginStateView;
   import room.RoomManager;
   import shop.ShopController;
   import superWinner.controller.SuperWinnerController;
   import worldboss.WorldBossManager;
   import worldboss.event.WorldBossRoomEvent;
   
   public class StateCreater
   {
       
      
      private var _state:Dictionary;
      
      private var _currentStateType:String;
      
      private var _loadCall:Function;
      
      public function StateCreater()
      {
         _state = new Dictionary();
         super();
      }
      
      public static function getNeededUIModuleByType(type:String) : String
      {
         var loadUIModuleTypes:* = null;
         var extraType:String = "";
         if(type == "main")
         {
            return "ddthall";
         }
         if(type == "tofflist")
         {
            return "toffilist";
         }
         if(type == "superWinner")
         {
            return "superwinner";
         }
         if(type == "auction")
         {
            return "ddtbagandinfo,ddtauction,ddtbead";
         }
         if(type == "farm")
         {
            return "farm,chatball";
         }
         if(type == "consortia")
         {
            return "ddtbagandinfo,consortionii,ddtconsortion,ddtbead";
         }
         if(type == "shop")
         {
            return "ddtshop";
         }
         if(type == "roomlist" || type == "dungeon" || type == "freshmanRoom1" || type == "worldbossRoom")
         {
            return "ddtroom,ddtroomlist,chatball,game,gameDecorate,defaultLiving,gameii,gameiii,expression,ddtroomloading,gameover";
         }
         if(type == "freshmanRoom2")
         {
            return "ddtroomloading,gameiii";
         }
         if(type == "matchRoom" || type == "dungeonRoom" || type == "missionResult" || type == "battleRoom" || type == "teamRoom" || type == "dreamLandRoom")
         {
            loadUIModuleTypes = "ddtroom,expression,chatball,game,gameDecorate,defaultLiving,gameii,gameiii,ddtroomloading,gameover";
            if(type == "battleRoom")
            {
               loadUIModuleTypes = loadUIModuleTypes + ",gameBattle";
            }
            return loadUIModuleTypes;
         }
         if(type == "challengeRoom")
         {
            return "challengeroom,ddtroom,expression,chatball,game,gameDecorate,defaultLiving,gameii,gameiii,ddtroomloading";
         }
         if(type == "renshen")
         {
            return "renshen,ddtroom,expression,chatball,game,gameDecorate,defaultLiving,gameii,gameiii";
         }
         if(type == "ddtchurchroomlist")
         {
            return "ddtchurchroomlist";
         }
         if(type == "churchRoom")
         {
            return "churchroom,ddtchurchroomlist,chatball,expression";
         }
         if(type == "civil")
         {
            return "ddtcivil";
         }
         if(type == "hotSpringRoomList")
         {
            return "ddthotspringroomlist";
         }
         if(type == "hotSpringRoom")
         {
            return "hotspringroom,expression,chatball";
         }
         if(type == "fighting")
         {
            if(RoomManager.Instance.current.type == 29)
            {
               extraType = extraType + ",rescue";
            }
            else if(RoomManager.Instance.current.type == 52)
            {
               extraType = extraType + ",catchInsect";
            }
            if(RoomManager.Instance.current.type == 120 || RoomManager.Instance.current.type == 1 && RoomManager.Instance.current.gameMode == 120)
            {
               extraType = extraType + ",gameBattle";
            }
            return "game,gameDecorate,defaultLiving,gameii,gameiii,gameover,chatball" + extraType;
         }
         if(type == "fighting3d")
         {
            return "game,gameii,gameiii,gameover,gameBattle,chatball" + extraType;
         }
         if(type == "trainer1")
         {
            return "game,gameDecorate,defaultLiving,gameii,gameiii,gameover,ddtroomloading,chatball";
         }
         if(type == "trainer2")
         {
            return "gameiii,ddtroomloading,chatball";
         }
         if(type == "academyRegistration")
         {
            return "ddtacademy,academycommon";
         }
         if(type == "fightLib")
         {
            return "gameiii,ddtroomloading,game,gameDecorate,defaultLiving,gameii,newfightlib,chatball,ddtroom";
         }
         if(type == "littleHall")
         {
            return "ddtshop,ddtlittlegame,expression";
         }
         if(type == "worldbossAward")
         {
            return "worldBoss,ddtshop,ddtlittlegame";
         }
         if(type == "worldboss" || type == "christmasroom" || type == "catchInsect")
         {
            return "worldBoss,ddtroom,ddtroomlist,chatball,game,gameDecorate,defaultLiving,gameii,gameiii,expression,ddtroomloading,gameover";
         }
         if(type == "roomLoading" || type == "encounterLoading" || type == "campBattleSceneloaing" || type == "singleBattleMatching")
         {
            return "ddtroom,chatball,game,gameDecorate,defaultLiving,gameii,gameiii,expression,ddtroomloading,gameover";
         }
         if(type == "consortiaBattleScene")
         {
            return "consortiabattle";
         }
         if(type == "campBattleScene")
         {
            return "campbattle,game,gameDecorate,chatball,defaultLiving,consortiabattle,ddtconsortion";
         }
         if(type == "sevenDoubleScene")
         {
            return "sevendoublegame";
         }
         if(type == "escort")
         {
            return "escortgame";
         }
         if(type == "collectionTaskScene")
         {
            return "collectionTask,chatball";
         }
         if(type == "drgnBoat")
         {
            return "drgnBoatgame,chatball";
         }
         if(type == "magpiebridge")
         {
            return "magpieBridge";
         }
         if(type == "ddtKingFloat")
         {
            return "floatParadegame,chatball";
         }
         if(type == "floatparade")
         {
            return "floatParadegame,chatball";
         }
         if(type == "pyramid")
         {
            return "pyramid,ddtshop";
         }
         if(type == "boguadventure")
         {
            return "boguadventure,chatball,defaultLiving";
         }
         if(type == "demon_chi_you")
         {
            return "demonchiyou,ddtroom,ddtroomlist,chatball,game,defaultLiving,gameii,gameiii,expression,ddtroomloading,gameover";
         }
         if(type == "consortia_domain")
         {
            return "consortiadomain,ddtroom,ddtroomlist,chatball,game,defaultLiving,gameii,gameiii,expression,ddtroomloading,gameover,ddtbagandinfo,consortionii,ddtconsortion";
         }
         if(type == "consortiaGuard")
         {
            return "consortiaGuard,ddtroom,ddtroomlist,chatball,game,defaultLiving,gameii,gameiii,expression,ddtroomloading,gameover";
         }
         return "";
      }
      
      public function create(type:String, id:int = 0) : BaseStateView
      {
         var StateViewClass:* = null;
         var _loc4_:* = type;
         if("login" !== _loc4_)
         {
            if("main" !== _loc4_)
            {
               if("shop" !== _loc4_)
               {
                  if("superWinner" !== _loc4_)
                  {
                     if("drgnBoat" !== _loc4_)
                     {
                        if("fighting" !== _loc4_)
                        {
                           if("fighting3d" !== _loc4_)
                           {
                              if("trainer1" !== _loc4_)
                              {
                                 if("trainer2" !== _loc4_)
                                 {
                                    if("fightLabGameView" !== _loc4_)
                                    {
                                       if("churchRoom" !== _loc4_)
                                       {
                                          if("ddtchurchroomlist" !== _loc4_)
                                          {
                                             if("auction" !== _loc4_)
                                             {
                                                if("academyRegistration" !== _loc4_)
                                                {
                                                   if("catchInsect" !== _loc4_)
                                                   {
                                                      if("escort" !== _loc4_)
                                                      {
                                                         if("sevenDoubleScene" !== _loc4_)
                                                         {
                                                            if("christmasroom" !== _loc4_)
                                                            {
                                                               if("renshen" !== _loc4_)
                                                               {
                                                                  if("floatparade" !== _loc4_)
                                                                  {
                                                                     if("ddtKingFloat" !== _loc4_)
                                                                     {
                                                                        if("magpiebridge" !== _loc4_)
                                                                        {
                                                                           if("campBattleScene" !== _loc4_)
                                                                           {
                                                                              if("farm" !== _loc4_)
                                                                              {
                                                                                 if("civil" !== _loc4_)
                                                                                 {
                                                                                    if("collectionTaskScene" !== _loc4_)
                                                                                    {
                                                                                       if("worldboss" !== _loc4_)
                                                                                       {
                                                                                          if("worldbossAward" !== _loc4_)
                                                                                          {
                                                                                             if("worldbossRoom" !== _loc4_)
                                                                                             {
                                                                                                if("tofflist" !== _loc4_)
                                                                                                {
                                                                                                   if("consortia" !== _loc4_)
                                                                                                   {
                                                                                                      if("consortiaBattleScene" !== _loc4_)
                                                                                                      {
                                                                                                         if("littleHall" !== _loc4_)
                                                                                                         {
                                                                                                            if("littleGame" !== _loc4_)
                                                                                                            {
                                                                                                               if("matchRoom" !== _loc4_)
                                                                                                               {
                                                                                                                  if("dungeonRoom" !== _loc4_)
                                                                                                                  {
                                                                                                                     if("battleRoom" !== _loc4_)
                                                                                                                     {
                                                                                                                        if("challengeRoom" !== _loc4_)
                                                                                                                        {
                                                                                                                           if("missionResult" !== _loc4_)
                                                                                                                           {
                                                                                                                              if("freshmanRoom1" !== _loc4_)
                                                                                                                              {
                                                                                                                                 if("freshmanRoom2" !== _loc4_)
                                                                                                                                 {
                                                                                                                                    if("roomLoading" !== _loc4_)
                                                                                                                                    {
                                                                                                                                       if("encounterLoading" !== _loc4_)
                                                                                                                                       {
                                                                                                                                          if("singleBattleMatching" !== _loc4_)
                                                                                                                                          {
                                                                                                                                             if("campBattleSceneloaing" !== _loc4_)
                                                                                                                                             {
                                                                                                                                                if("fightLib" !== _loc4_)
                                                                                                                                                {
                                                                                                                                                   if("pyramid" !== _loc4_)
                                                                                                                                                   {
                                                                                                                                                      if("petIsland" !== _loc4_)
                                                                                                                                                      {
                                                                                                                                                         if("diceSystem" !== _loc4_)
                                                                                                                                                         {
                                                                                                                                                            if("boguadventure" !== _loc4_)
                                                                                                                                                            {
                                                                                                                                                               if("treasure" !== _loc4_)
                                                                                                                                                               {
                                                                                                                                                                  if("hotSpringRoomList" !== _loc4_)
                                                                                                                                                                  {
                                                                                                                                                                     if("hotSpringRoom" !== _loc4_)
                                                                                                                                                                     {
                                                                                                                                                                        if("demon_chi_you" !== _loc4_)
                                                                                                                                                                        {
                                                                                                                                                                           if("consortia_domain" !== _loc4_)
                                                                                                                                                                           {
                                                                                                                                                                              if("consortiaGuard" !== _loc4_)
                                                                                                                                                                              {
                                                                                                                                                                                 if("minGameCubes" !== _loc4_)
                                                                                                                                                                                 {
                                                                                                                                                                                    if("teamRoom" !== _loc4_)
                                                                                                                                                                                    {
                                                                                                                                                                                       if("dreamLandRoom" === _loc4_)
                                                                                                                                                                                       {
                                                                                                                                                                                          StateViewClass = getDefinitionByName("room.view.states.DreamLandChallengeRoomState");
                                                                                                                                                                                       }
                                                                                                                                                                                    }
                                                                                                                                                                                    else
                                                                                                                                                                                    {
                                                                                                                                                                                       StateViewClass = getDefinitionByName("room.view.states.TeamRoomState");
                                                                                                                                                                                    }
                                                                                                                                                                                 }
                                                                                                                                                                                 else
                                                                                                                                                                                 {
                                                                                                                                                                                    StateViewClass = getDefinitionByName("happyLittleGame.cubesGame.CubeGameStateView");
                                                                                                                                                                                 }
                                                                                                                                                                              }
                                                                                                                                                                              else
                                                                                                                                                                              {
                                                                                                                                                                                 StateViewClass = getDefinitionByName("consortion.view.guard.ConsortiaGuardState");
                                                                                                                                                                              }
                                                                                                                                                                           }
                                                                                                                                                                           else
                                                                                                                                                                           {
                                                                                                                                                                              StateViewClass = getDefinitionByName("consortiaDomain.view.ConsortiaDomainScene");
                                                                                                                                                                           }
                                                                                                                                                                        }
                                                                                                                                                                        else
                                                                                                                                                                        {
                                                                                                                                                                           StateViewClass = getDefinitionByName("demonChiYou.view.DemonChiYouSence");
                                                                                                                                                                        }
                                                                                                                                                                     }
                                                                                                                                                                     else
                                                                                                                                                                     {
                                                                                                                                                                        StateViewClass = getDefinitionByName("hotSpring.controller.HotSpringRoomManager");
                                                                                                                                                                     }
                                                                                                                                                                  }
                                                                                                                                                                  else
                                                                                                                                                                  {
                                                                                                                                                                     StateViewClass = getDefinitionByName("hotSpring.controller.HotSpringRoomListManager");
                                                                                                                                                                  }
                                                                                                                                                               }
                                                                                                                                                               else
                                                                                                                                                               {
                                                                                                                                                                  StateViewClass = getDefinitionByName("treasure.view.TreasureMain");
                                                                                                                                                               }
                                                                                                                                                            }
                                                                                                                                                            else
                                                                                                                                                            {
                                                                                                                                                               StateViewClass = getDefinitionByName("boguAdventure.view.BoguAdventureStateView");
                                                                                                                                                            }
                                                                                                                                                         }
                                                                                                                                                         else
                                                                                                                                                         {
                                                                                                                                                            StateViewClass = getDefinitionByName("dice.view.DiceSystem");
                                                                                                                                                         }
                                                                                                                                                      }
                                                                                                                                                      else
                                                                                                                                                      {
                                                                                                                                                         StateViewClass = getDefinitionByName("petIsland.view.PetIslandMainView");
                                                                                                                                                      }
                                                                                                                                                   }
                                                                                                                                                   else
                                                                                                                                                   {
                                                                                                                                                      StateViewClass = getDefinitionByName("pyramid.view.PyramidSystem");
                                                                                                                                                   }
                                                                                                                                                }
                                                                                                                                                else
                                                                                                                                                {
                                                                                                                                                   StateViewClass = getDefinitionByName("fightLib.FightLibState");
                                                                                                                                                }
                                                                                                                                             }
                                                                                                                                             else
                                                                                                                                             {
                                                                                                                                                StateViewClass = getDefinitionByName("roomLoading.CampBattleLoadingState");
                                                                                                                                             }
                                                                                                                                          }
                                                                                                                                          else
                                                                                                                                          {
                                                                                                                                             StateViewClass = getDefinitionByName("roomLoading.SingleBattleMatchState");
                                                                                                                                          }
                                                                                                                                       }
                                                                                                                                       else
                                                                                                                                       {
                                                                                                                                          StateViewClass = getDefinitionByName("roomLoading.EncounterLoadingState");
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       StateViewClass = getDefinitionByName("roomLoading.RoomLoadingState");
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                              }
                                                                                                                              StateViewClass = getDefinitionByName("room.view.states.FreshmanRoomState");
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              StateViewClass = getDefinitionByName("room.view.states.MissionRoomState");
                                                                                                                           }
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           StateViewClass = getDefinitionByName("room.view.states.ChallengeRoomState");
                                                                                                                        }
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        StateViewClass = getDefinitionByName("room.view.states.BattleRoomState");
                                                                                                                     }
                                                                                                                  }
                                                                                                                  else
                                                                                                                  {
                                                                                                                     StateViewClass = getDefinitionByName("room.view.states.DungeonRoomState");
                                                                                                                  }
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  StateViewClass = getDefinitionByName("room.view.states.MatchRoomState");
                                                                                                               }
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               StateViewClass = getDefinitionByName("littleGame.LittleGame");
                                                                                                            }
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            StateViewClass = getDefinitionByName("littleGame.LittleHall");
                                                                                                         }
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         StateViewClass = getDefinitionByName("consortionBattle.view.ConsortiaBattleMainView");
                                                                                                      }
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      StateViewClass = getDefinitionByName("consortion.ConsortionControl");
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   StateViewClass = getDefinitionByName("tofflist.TofflistController");
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                StateViewClass = getDefinitionByName("worldboss.view.WorldBossFightRoomState");
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             StateViewClass = getDefinitionByName("worldboss.WorldBossAwardController");
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          return getDefinitionByName("worldboss.WorldBossRoomController").Instance;
                                                                                       }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       StateViewClass = getDefinitionByName("collectionTask.view.CollectionTaskMainView");
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    StateViewClass = getDefinitionByName("civil.CivilController");
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 StateViewClass = getDefinitionByName("farm.viewx.FarmSwitchView");
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              StateViewClass = getDefinitionByName("campbattle.view.CampBattleView");
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           StateViewClass = getDefinitionByName("magpieBridge.view.MagPieBridgeView");
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        StateViewClass = getDefinitionByName("ddtKingFloat.views.DDTKingFloatMainView");
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     StateViewClass = getDefinitionByName("floatParade.views.FloatParadeMainView");
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  StateViewClass = getDefinitionByName("renshen.view.RunningRenshenStateView");
                                                               }
                                                            }
                                                            else
                                                            {
                                                               StateViewClass = getDefinitionByName("christmas.controller.ChristmasRoomController");
                                                            }
                                                         }
                                                         else
                                                         {
                                                            StateViewClass = getDefinitionByName("sevenDouble.view.SevenDoubleMainView");
                                                         }
                                                      }
                                                      else
                                                      {
                                                         StateViewClass = getDefinitionByName("escort.view.EscortMainView");
                                                      }
                                                   }
                                                   else
                                                   {
                                                      StateViewClass = getDefinitionByName("catchInsect.view.CatchInsectRoomController");
                                                   }
                                                }
                                                else
                                                {
                                                   StateViewClass = getDefinitionByName("academy.AcademyController");
                                                }
                                             }
                                             else
                                             {
                                                StateViewClass = getDefinitionByName("auctionHouse.controller.AuctionHouseController");
                                             }
                                          }
                                          else
                                          {
                                             StateViewClass = getDefinitionByName("church.controller.ChurchRoomListController");
                                          }
                                       }
                                       else
                                       {
                                          StateViewClass = getDefinitionByName("church.controller.ChurchRoomController");
                                       }
                                    }
                                    else
                                    {
                                       StateViewClass = getDefinitionByName("fightLib.view.FightLibGameView");
                                    }
                                 }
                              }
                              StateViewClass = getDefinitionByName("game.view.TrainerGameView");
                           }
                           else
                           {
                              StateViewClass = getDefinitionByName("gameStarling.view.GameView3D");
                           }
                        }
                        else
                        {
                           StateViewClass = getDefinitionByName("game.view.GameView");
                        }
                     }
                     else
                     {
                        StateViewClass = getDefinitionByName("drgnBoat.views.DrgnBoatMainView");
                     }
                     if(StateViewClass)
                     {
                        return new StateViewClass();
                     }
                     return null;
                  }
                  return SuperWinnerController.instance;
               }
               return new ShopController();
            }
            return new HallStateView();
         }
         return new LoginStateView();
      }
      
      public function createAsync(type:String, callback:Function) : void
      {
         var loaderQueue:* = null;
         var uiModuleStr:* = null;
         var modules:* = null;
         var i:int = 0;
         _loadCall = callback;
         _currentStateType = type;
         if(!StateManager.RecordFlag || type != "main")
         {
            var _loc7_:* = type;
            if("consortia" !== _loc7_)
            {
               if("farm" !== _loc7_)
               {
                  if("pyramid" === _loc7_)
                  {
                     AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.creatPyramidLoader());
                  }
               }
               else
               {
                  AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.creatFarmPoultryInfo());
               }
            }
            else
            {
               AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.creatBadgeInfoLoader());
               AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.creatConsortiaWeekRewardLoader());
            }
            if(type == "fighting" || type == "fighting3d" || type == "trainer1" || type == "trainer2")
            {
               loaderQueue = new QueueLoader();
               if(!SoundManager.instance.audioBattleComplete)
               {
                  loaderQueue.addLoader(LoaderCreate.Instance.createAudioBattleLoader());
                  loaderQueue.addEventListener("complete",__onAudioLoadComplete);
                  loaderQueue.start();
               }
            }
            uiModuleStr = getNeededUIModuleByType(type);
            if(uiModuleStr != "")
            {
               modules = uiModuleStr.split(",");
               for(i = 0; i < modules.length; )
               {
                  AssetModuleLoader.addModelLoader(modules[i],6);
                  i++;
               }
               if(type == "auction")
               {
                  AssetModuleLoader.addModelLoader("mark",7);
               }
               else if(type == "dreamLandRoom")
               {
                  AssetModuleLoader.addModelLoader("dreamLandBlessing",5);
               }
            }
         }
         if(isLoaderDDTCORE(type))
         {
            AssetModuleLoader.startCodeLoader(loadComplete);
         }
         else
         {
            AssetModuleLoader.startLoader(loadComplete);
         }
      }
      
      private function __onAudioLoadComplete(e:Event) : void
      {
         e.currentTarget.removeEventListener("complete",__onAudioLoadComplete);
         SoundManager.instance.setupAudioResource(["audiobattle"]);
      }
      
      private function loadComplete() : void
      {
      }
      
      private function __onCloseLoading(event:Event) : void
      {
         if(PlayerManager.Instance.Self.Grade >= 2)
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleSmallLoading.Instance.removeEventListener("close",__onCloseLoading);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUimoduleLoadComplete);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onUimoduleLoadProgress);
            if(_currentStateType == "worldbossRoom")
            {
               WorldBossManager.Instance.dispatchEvent(new WorldBossRoomEvent("stopFight"));
            }
         }
      }
      
      private function getStateLoadingInfo(type:String, needUIModule:String = null, callBack:Function = null) : StateLoadingInfo
      {
         var stateLoadingInfo:* = null;
         var modules:* = null;
         var i:int = 0;
         stateLoadingInfo = _state[type];
         if(stateLoadingInfo == null)
         {
            stateLoadingInfo = new StateLoadingInfo();
            if(needUIModule != null && needUIModule != "")
            {
               modules = needUIModule.split(",");
               for(i = 0; i < modules.length; )
               {
                  stateLoadingInfo.neededUIModule.push(modules[i]);
                  i++;
               }
            }
            else
            {
               stateLoadingInfo.isComplete = true;
            }
            stateLoadingInfo.state = type;
            stateLoadingInfo.callBack = callBack;
            _state[type] = stateLoadingInfo;
         }
         return stateLoadingInfo;
      }
      
      private function __onUimoduleLoadComplete(event:UIModuleEvent) : void
      {
         var i:int = 0;
         var state:* = null;
         if(StringUtils.isEmpty(event.state))
         {
            return;
         }
         var stateLoadingInfo:StateLoadingInfo = getStateLoadingInfo(event.state);
         if(stateLoadingInfo.completeedUIModule.indexOf(event.module) == -1)
         {
            stateLoadingInfo.completeedUIModule.push(event.module);
         }
         var allComplete:Boolean = true;
         for(i = 0; i < stateLoadingInfo.neededUIModule.length; )
         {
            if(stateLoadingInfo.completeedUIModule.indexOf(stateLoadingInfo.neededUIModule[i]) == -1)
            {
               allComplete = false;
               break;
            }
            i++;
         }
         stateLoadingInfo.isComplete = allComplete;
         if(stateLoadingInfo.isComplete && _currentStateType == stateLoadingInfo.state)
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUimoduleLoadComplete);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onUimoduleLoadProgress);
            UIModuleSmallLoading.Instance.hide();
            state = create(event.state);
            if(stateLoadingInfo.callBack != null)
            {
               stateLoadingInfo.callBack(state);
            }
         }
      }
      
      private function __onUimoduleLoadError(event:UIModuleEvent) : void
      {
      }
      
      private function __onUimoduleLoadProgress(event:UIModuleEvent) : void
      {
         var i:int = 0;
         var moduleProgress:Number = NaN;
         var _loc8_:int = 0;
         var _loc7_:* = _state;
         for each(var loadingInfo in _state)
         {
            if(loadingInfo.neededUIModule.indexOf(event.module) != -1)
            {
               loadingInfo.progress[event.module] = event.loader.progress;
            }
         }
         var stateLoadingInfo:StateLoadingInfo = getStateLoadingInfo(event.state);
         var progress:int = 0;
         for(i = 0; i < stateLoadingInfo.neededUIModule.length; )
         {
            if(stateLoadingInfo.progress[stateLoadingInfo.neededUIModule[i]] != null)
            {
               moduleProgress = stateLoadingInfo.progress[stateLoadingInfo.neededUIModule[i]];
               progress = progress + moduleProgress * 100 / stateLoadingInfo.neededUIModule.length;
            }
            i++;
         }
         if(_currentStateType == stateLoadingInfo.state)
         {
            UIModuleSmallLoading.Instance.progress = progress;
         }
      }
      
      private function isLoaderDDTCORE(type:String) : Boolean
      {
         if(type == "escort" || type == "worldboss" || type == "worldbossRoom" || type == "worldbossAward" || type == "campBattleScene" || type == "farm" || type == "floatparade" || type == "ddtKingFloat" || type == "sevenDoubleScene" || type == "christmasroom" || type == "magpiebridge" || type == "civil" || type == "collectionTaskScene" || type == "consortia" || type == "consortiaBattleScene" || type == "matchRoom" || type == "dungeonRoom" || type == "battleRoom" || type == "challengeRoom" || type == "missionResult" || type == "freshmanRoom1" || type == "freshmanRoom2" || type == "roomLoading" || type == "encounterLoading" || type == "singleBattleMatching" || type == "campBattleSceneloaing" || type == "fightLib" || type == "tofflist" || type == "littleHall" || type == "littleGame" || type == "churchRoom" || type == "ddtchurchroomlist" || type == "auction" || type == "drgnBoat" || type == "fighting" || type == "fighting3d" || type == "trainer1" || type == "trainer2" || type == "fightLabGameView" || type == "academyRegistration" || type == "catchInsect" || type == "pyramid" || type == "hotSpringRoomList" || type == "hotSpringRoom" || type == "demon_chi_you" || type == "consortia_domain" || type == "consortiaGuard" || type == "teamRoom" || type == "dreamLandRoom")
         {
            return true;
         }
         return false;
      }
   }
}
