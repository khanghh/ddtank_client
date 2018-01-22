package ddt.states
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.utils.StringUtils;
   import ddt.loader.LoaderCreate;
   import ddt.manager.PlayerManager;
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
      
      public static function getNeededUIModuleByType(param1:String) : String
      {
         var _loc2_:* = null;
         var _loc3_:String = "";
         if(param1 == "main")
         {
            return "ddthall";
         }
         if(param1 == "tofflist")
         {
            return "toffilist";
         }
         if(param1 == "superWinner")
         {
            return "superwinner";
         }
         if(param1 == "auction")
         {
            return "ddtbagandinfo,ddtauction,ddtbead";
         }
         if(param1 == "farm")
         {
            return "farm,chatball";
         }
         if(param1 == "consortia")
         {
            return "ddtbagandinfo,consortionii,ddtconsortion,ddtbead";
         }
         if(param1 == "shop")
         {
            return "ddtshop";
         }
         if(param1 == "roomlist" || param1 == "dungeon" || param1 == "freshmanRoom1" || param1 == "worldbossRoom")
         {
            return "ddtroom,ddtroomlist,chatball,game,gameDecorate,defaultLiving,gameii,gameiii,expression,ddtroomloading,gameover";
         }
         if(param1 == "freshmanRoom2")
         {
            return "ddtroomloading,gameiii";
         }
         if(param1 == "matchRoom" || param1 == "dungeonRoom" || param1 == "missionResult" || param1 == "battleRoom" || param1 == "teamRoom")
         {
            _loc2_ = "ddtroom,expression,chatball,game,gameDecorate,defaultLiving,gameii,gameiii,ddtroomloading,gameover";
            if(param1 == "battleRoom")
            {
               _loc2_ = _loc2_ + ",gameBattle";
            }
            return _loc2_;
         }
         if(param1 == "challengeRoom")
         {
            return "challengeroom,ddtroom,expression,chatball,game,gameDecorate,defaultLiving,gameii,gameiii,ddtroomloading";
         }
         if(param1 == "renshen")
         {
            return "renshen,ddtroom,expression,chatball,game,gameDecorate,defaultLiving,gameii,gameiii";
         }
         if(param1 == "ddtchurchroomlist")
         {
            return "ddtchurchroomlist";
         }
         if(param1 == "churchRoom")
         {
            return "churchroom,ddtchurchroomlist,chatball,expression";
         }
         if(param1 == "civil")
         {
            return "ddtcivil";
         }
         if(param1 == "hotSpringRoomList")
         {
            return "ddthotspringroomlist";
         }
         if(param1 == "hotSpringRoom")
         {
            return "hotspringroom,expression,chatball";
         }
         if(param1 == "fighting")
         {
            if(RoomManager.Instance.current.type == 29)
            {
               _loc3_ = _loc3_ + ",rescue";
            }
            else if(RoomManager.Instance.current.type == 52)
            {
               _loc3_ = _loc3_ + ",catchInsect";
            }
            if(RoomManager.Instance.current.type == 120 || RoomManager.Instance.current.type == 1 && RoomManager.Instance.current.gameMode == 120)
            {
               _loc3_ = _loc3_ + ",gameBattle";
            }
            return "game,gameDecorate,defaultLiving,gameii,gameiii,gameover,chatball" + _loc3_;
         }
         if(param1 == "fighting3d")
         {
            return "game,gameii,gameiii,gameover,gameBattle,chatball" + _loc3_;
         }
         if(param1 == "trainer1")
         {
            return "game,gameDecorate,defaultLiving,gameii,gameiii,gameover,ddtroomloading,chatball";
         }
         if(param1 == "trainer2")
         {
            return "gameiii,ddtroomloading,chatball";
         }
         if(param1 == "academyRegistration")
         {
            return "ddtacademy,academycommon";
         }
         if(param1 == "fightLib")
         {
            return "gameiii,ddtroomloading,game,gameDecorate,defaultLiving,gameii,newfightlib,chatball,ddtroom";
         }
         if(param1 == "littleHall")
         {
            return "ddtshop,ddtlittlegame,expression";
         }
         if(param1 == "worldbossAward")
         {
            return "worldBoss,ddtshop,ddtlittlegame";
         }
         if(param1 == "worldboss" || param1 == "christmasroom" || param1 == "catchInsect")
         {
            return "worldBoss,ddtroom,ddtroomlist,chatball,game,gameDecorate,defaultLiving,gameii,gameiii,expression,ddtroomloading,gameover";
         }
         if(param1 == "roomLoading" || param1 == "encounterLoading" || param1 == "campBattleSceneloaing" || param1 == "singleBattleMatching")
         {
            return "ddtroom,chatball,game,gameDecorate,defaultLiving,gameii,gameiii,expression,ddtroomloading,gameover";
         }
         if(param1 == "consortiaBattleScene")
         {
            return "consortiabattle";
         }
         if(param1 == "campBattleScene")
         {
            return "campbattle,game,gameDecorate,chatball,defaultLiving,consortiabattle,ddtconsortion";
         }
         if(param1 == "sevenDoubleScene")
         {
            return "sevendoublegame";
         }
         if(param1 == "escort")
         {
            return "escortgame";
         }
         if(param1 == "collectionTaskScene")
         {
            return "collectionTask,chatball";
         }
         if(param1 == "drgnBoat")
         {
            return "drgnBoatgame,chatball";
         }
         if(param1 == "magpiebridge")
         {
            return "magpieBridge";
         }
         if(param1 == "ddtKingFloat")
         {
            return "floatParadegame,chatball";
         }
         if(param1 == "floatparade")
         {
            return "floatParadegame,chatball";
         }
         if(param1 == "pyramid")
         {
            return "pyramid,ddtshop";
         }
         if(param1 == "boguadventure")
         {
            return "boguadventure,chatball,defaultLiving";
         }
         if(param1 == "demon_chi_you")
         {
            return "demonchiyou,ddtroom,ddtroomlist,chatball,game,defaultLiving,gameii,gameiii,expression,ddtroomloading,gameover";
         }
         if(param1 == "consortia_domain")
         {
            return "consortiadomain,ddtroom,ddtroomlist,chatball,game,defaultLiving,gameii,gameiii,expression,ddtroomloading,gameover,ddtbagandinfo,consortionii,ddtconsortion";
         }
         if(param1 == "consortiaGuard")
         {
            return "consortiaGuard,ddtroom,ddtroomlist,chatball,game,defaultLiving,gameii,gameiii,expression,ddtroomloading,gameover";
         }
         return "";
      }
      
      public function create(param1:String, param2:int = 0) : BaseStateView
      {
         var _loc3_:* = null;
         var _loc4_:* = param1;
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
                                                                                                                                                                                    if("teamRoom" === _loc4_)
                                                                                                                                                                                    {
                                                                                                                                                                                       _loc3_ = getDefinitionByName("room.view.states.TeamRoomState");
                                                                                                                                                                                    }
                                                                                                                                                                                 }
                                                                                                                                                                                 else
                                                                                                                                                                                 {
                                                                                                                                                                                    _loc3_ = getDefinitionByName("happyLittleGame.cubesGame.CubeGameStateView");
                                                                                                                                                                                 }
                                                                                                                                                                              }
                                                                                                                                                                              else
                                                                                                                                                                              {
                                                                                                                                                                                 _loc3_ = getDefinitionByName("consortion.view.guard.ConsortiaGuardState");
                                                                                                                                                                              }
                                                                                                                                                                           }
                                                                                                                                                                           else
                                                                                                                                                                           {
                                                                                                                                                                              _loc3_ = getDefinitionByName("consortiaDomain.view.ConsortiaDomainScene");
                                                                                                                                                                           }
                                                                                                                                                                        }
                                                                                                                                                                        else
                                                                                                                                                                        {
                                                                                                                                                                           _loc3_ = getDefinitionByName("demonChiYou.view.DemonChiYouSence");
                                                                                                                                                                        }
                                                                                                                                                                     }
                                                                                                                                                                     else
                                                                                                                                                                     {
                                                                                                                                                                        _loc3_ = getDefinitionByName("hotSpring.controller.HotSpringRoomManager");
                                                                                                                                                                     }
                                                                                                                                                                  }
                                                                                                                                                                  else
                                                                                                                                                                  {
                                                                                                                                                                     _loc3_ = getDefinitionByName("hotSpring.controller.HotSpringRoomListManager");
                                                                                                                                                                  }
                                                                                                                                                               }
                                                                                                                                                               else
                                                                                                                                                               {
                                                                                                                                                                  _loc3_ = getDefinitionByName("treasure.view.TreasureMain");
                                                                                                                                                               }
                                                                                                                                                            }
                                                                                                                                                            else
                                                                                                                                                            {
                                                                                                                                                               _loc3_ = getDefinitionByName("boguAdventure.view.BoguAdventureStateView");
                                                                                                                                                            }
                                                                                                                                                         }
                                                                                                                                                         else
                                                                                                                                                         {
                                                                                                                                                            _loc3_ = getDefinitionByName("dice.view.DiceSystem");
                                                                                                                                                         }
                                                                                                                                                      }
                                                                                                                                                      else
                                                                                                                                                      {
                                                                                                                                                         _loc3_ = getDefinitionByName("petIsland.view.PetIslandMainView");
                                                                                                                                                      }
                                                                                                                                                   }
                                                                                                                                                   else
                                                                                                                                                   {
                                                                                                                                                      _loc3_ = getDefinitionByName("pyramid.view.PyramidSystem");
                                                                                                                                                   }
                                                                                                                                                }
                                                                                                                                                else
                                                                                                                                                {
                                                                                                                                                   _loc3_ = getDefinitionByName("fightLib.FightLibState");
                                                                                                                                                }
                                                                                                                                             }
                                                                                                                                             else
                                                                                                                                             {
                                                                                                                                                _loc3_ = getDefinitionByName("roomLoading.CampBattleLoadingState");
                                                                                                                                             }
                                                                                                                                          }
                                                                                                                                          else
                                                                                                                                          {
                                                                                                                                             _loc3_ = getDefinitionByName("roomLoading.SingleBattleMatchState");
                                                                                                                                          }
                                                                                                                                       }
                                                                                                                                       else
                                                                                                                                       {
                                                                                                                                          _loc3_ = getDefinitionByName("roomLoading.EncounterLoadingState");
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       _loc3_ = getDefinitionByName("roomLoading.RoomLoadingState");
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                              }
                                                                                                                              _loc3_ = getDefinitionByName("room.view.states.FreshmanRoomState");
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              _loc3_ = getDefinitionByName("room.view.states.MissionRoomState");
                                                                                                                           }
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           _loc3_ = getDefinitionByName("room.view.states.ChallengeRoomState");
                                                                                                                        }
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        _loc3_ = getDefinitionByName("room.view.states.BattleRoomState");
                                                                                                                     }
                                                                                                                  }
                                                                                                                  else
                                                                                                                  {
                                                                                                                     _loc3_ = getDefinitionByName("room.view.states.DungeonRoomState");
                                                                                                                  }
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  _loc3_ = getDefinitionByName("room.view.states.MatchRoomState");
                                                                                                               }
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               _loc3_ = getDefinitionByName("littleGame.LittleGame");
                                                                                                            }
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            _loc3_ = getDefinitionByName("littleGame.LittleHall");
                                                                                                         }
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         _loc3_ = getDefinitionByName("consortionBattle.view.ConsortiaBattleMainView");
                                                                                                      }
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      _loc3_ = getDefinitionByName("consortion.ConsortionControl");
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   _loc3_ = getDefinitionByName("tofflist.TofflistController");
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                _loc3_ = getDefinitionByName("worldboss.view.WorldBossFightRoomState");
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             _loc3_ = getDefinitionByName("worldboss.WorldBossAwardController");
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          return getDefinitionByName("worldboss.WorldBossRoomController").Instance;
                                                                                       }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       _loc3_ = getDefinitionByName("collectionTask.view.CollectionTaskMainView");
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    _loc3_ = getDefinitionByName("civil.CivilController");
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 _loc3_ = getDefinitionByName("farm.viewx.FarmSwitchView");
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              _loc3_ = getDefinitionByName("campbattle.view.CampBattleView");
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           _loc3_ = getDefinitionByName("magpieBridge.view.MagPieBridgeView");
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc3_ = getDefinitionByName("ddtKingFloat.views.DDTKingFloatMainView");
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc3_ = getDefinitionByName("floatParade.views.FloatParadeMainView");
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  _loc3_ = getDefinitionByName("renshen.view.RunningRenshenStateView");
                                                               }
                                                            }
                                                            else
                                                            {
                                                               _loc3_ = getDefinitionByName("christmas.controller.ChristmasRoomController");
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _loc3_ = getDefinitionByName("sevenDouble.view.SevenDoubleMainView");
                                                         }
                                                      }
                                                      else
                                                      {
                                                         _loc3_ = getDefinitionByName("escort.view.EscortMainView");
                                                      }
                                                   }
                                                   else
                                                   {
                                                      _loc3_ = getDefinitionByName("catchInsect.view.CatchInsectRoomController");
                                                   }
                                                }
                                                else
                                                {
                                                   _loc3_ = getDefinitionByName("academy.AcademyController");
                                                }
                                             }
                                             else
                                             {
                                                _loc3_ = getDefinitionByName("auctionHouse.controller.AuctionHouseController");
                                             }
                                          }
                                          else
                                          {
                                             _loc3_ = getDefinitionByName("church.controller.ChurchRoomListController");
                                          }
                                       }
                                       else
                                       {
                                          _loc3_ = getDefinitionByName("church.controller.ChurchRoomController");
                                       }
                                    }
                                    else
                                    {
                                       _loc3_ = getDefinitionByName("fightLib.view.FightLibGameView");
                                    }
                                 }
                              }
                              _loc3_ = getDefinitionByName("game.view.TrainerGameView");
                           }
                           else
                           {
                              _loc3_ = getDefinitionByName("gameStarling.view.GameView3D");
                           }
                        }
                        else
                        {
                           _loc3_ = getDefinitionByName("game.view.GameView");
                        }
                     }
                     else
                     {
                        _loc3_ = getDefinitionByName("drgnBoat.views.DrgnBoatMainView");
                     }
                     if(_loc3_)
                     {
                        return new _loc3_();
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
      
      public function createAsync(param1:String, param2:Function) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         _loadCall = param2;
         _currentStateType = param1;
         if(!StateManager.RecordFlag || param1 != "main")
         {
            var _loc6_:* = param1;
            if("consortia" !== _loc6_)
            {
               if("farm" !== _loc6_)
               {
                  if("pyramid" === _loc6_)
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
            _loc4_ = getNeededUIModuleByType(param1);
            if(_loc4_ != "")
            {
               _loc3_ = _loc4_.split(",");
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  AssetModuleLoader.addModelLoader(_loc3_[_loc5_],6);
                  _loc5_++;
               }
            }
         }
         if(isLoaderDDTCORE(param1))
         {
            AssetModuleLoader.startCodeLoader(loadComplete);
         }
         else
         {
            AssetModuleLoader.startLoader(loadComplete);
         }
      }
      
      private function loadComplete() : void
      {
      }
      
      private function __onCloseLoading(param1:Event) : void
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
      
      private function getStateLoadingInfo(param1:String, param2:String = null, param3:Function = null) : StateLoadingInfo
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         _loc4_ = _state[param1];
         if(_loc4_ == null)
         {
            _loc4_ = new StateLoadingInfo();
            if(param2 != null && param2 != "")
            {
               _loc5_ = param2.split(",");
               _loc6_ = 0;
               while(_loc6_ < _loc5_.length)
               {
                  _loc4_.neededUIModule.push(_loc5_[_loc6_]);
                  _loc6_++;
               }
            }
            else
            {
               _loc4_.isComplete = true;
            }
            _loc4_.state = param1;
            _loc4_.callBack = param3;
            _state[param1] = _loc4_;
         }
         return _loc4_;
      }
      
      private function __onUimoduleLoadComplete(param1:UIModuleEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         if(StringUtils.isEmpty(param1.state))
         {
            return;
         }
         var _loc4_:StateLoadingInfo = getStateLoadingInfo(param1.state);
         if(_loc4_.completeedUIModule.indexOf(param1.module) == -1)
         {
            _loc4_.completeedUIModule.push(param1.module);
         }
         var _loc2_:Boolean = true;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.neededUIModule.length)
         {
            if(_loc4_.completeedUIModule.indexOf(_loc4_.neededUIModule[_loc5_]) == -1)
            {
               _loc2_ = false;
               break;
            }
            _loc5_++;
         }
         _loc4_.isComplete = _loc2_;
         if(_loc4_.isComplete && _currentStateType == _loc4_.state)
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUimoduleLoadComplete);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onUimoduleLoadProgress);
            UIModuleSmallLoading.Instance.hide();
            _loc3_ = create(param1.state);
            if(_loc4_.callBack != null)
            {
               _loc4_.callBack(_loc3_);
            }
         }
      }
      
      private function __onUimoduleLoadError(param1:UIModuleEvent) : void
      {
      }
      
      private function __onUimoduleLoadProgress(param1:UIModuleEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:Number = NaN;
         var _loc8_:int = 0;
         var _loc7_:* = _state;
         for each(var _loc5_ in _state)
         {
            if(_loc5_.neededUIModule.indexOf(param1.module) != -1)
            {
               _loc5_.progress[param1.module] = param1.loader.progress;
            }
         }
         var _loc4_:StateLoadingInfo = getStateLoadingInfo(param1.state);
         var _loc3_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc4_.neededUIModule.length)
         {
            if(_loc4_.progress[_loc4_.neededUIModule[_loc6_]] != null)
            {
               _loc2_ = _loc4_.progress[_loc4_.neededUIModule[_loc6_]];
               _loc3_ = _loc3_ + _loc2_ * 100 / _loc4_.neededUIModule.length;
            }
            _loc6_++;
         }
         if(_currentStateType == _loc4_.state)
         {
            UIModuleSmallLoading.Instance.progress = _loc3_;
         }
      }
      
      private function isLoaderDDTCORE(param1:String) : Boolean
      {
         if(param1 == "escort" || param1 == "worldboss" || param1 == "worldbossRoom" || param1 == "worldbossAward" || param1 == "campBattleScene" || param1 == "farm" || param1 == "floatparade" || param1 == "ddtKingFloat" || param1 == "sevenDoubleScene" || param1 == "christmasroom" || param1 == "magpiebridge" || param1 == "civil" || param1 == "collectionTaskScene" || param1 == "consortia" || param1 == "consortiaBattleScene" || param1 == "matchRoom" || param1 == "dungeonRoom" || param1 == "battleRoom" || param1 == "challengeRoom" || param1 == "missionResult" || param1 == "freshmanRoom1" || param1 == "freshmanRoom2" || param1 == "roomLoading" || param1 == "encounterLoading" || param1 == "singleBattleMatching" || param1 == "campBattleSceneloaing" || param1 == "fightLib" || param1 == "tofflist" || param1 == "littleHall" || param1 == "littleGame" || param1 == "churchRoom" || param1 == "ddtchurchroomlist" || param1 == "auction" || param1 == "drgnBoat" || param1 == "fighting" || param1 == "fighting3d" || param1 == "trainer1" || param1 == "trainer2" || param1 == "fightLabGameView" || param1 == "academyRegistration" || param1 == "catchInsect" || param1 == "pyramid" || param1 == "hotSpringRoomList" || param1 == "hotSpringRoom" || param1 == "demon_chi_you" || param1 == "consortia_domain" || param1 == "consortiaGuard" || param1 == "teamRoom")
         {
            return true;
         }
         return false;
      }
   }
}
