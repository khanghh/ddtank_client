package room
{
   import BraveDoor.BraveDoorManager;
   import bombKing.BombKingManager;
   import bombKing.event.BombKingEvent;
   import braveDoor.BraveDoorControl;
   import campbattle.CampBattleManager;
   import catchInsect.CatchInsectManager;
   import christmas.ChristmasCoreManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.BuffInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.RoomEvent;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PetInfoManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddtKingFloat.DDTKingFloatIconManager;
   import demonChiYou.DemonChiYouManager;
   import drgnBoat.DrgnBoatManager;
   import escort.EscortManager;
   import fightLib.FightLibManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import floatParade.FloatParadeIconManager;
   import gameCommon.GameControl;
   import hall.GameLoadingManager;
   import invite.InviteManager;
   import labyrinth.LabyrinthManager;
   import pet.data.PetInfo;
   import road7th.comm.PackageIn;
   import room.model.RoomInfo;
   import room.model.RoomPlayer;
   import room.view.roomView.SingleRoomView;
   import roomList.pvpRoomList.RoomListManager;
   import sevenDouble.SevenDoubleManager;
   import survival.SurvivalModeControl;
   import trainer.controller.NewHandGuideManager;
   import worldboss.WorldBossManager;
   
   public class RoomControl extends EventDispatcher
   {
      
      private static var _ins:RoomControl;
       
      
      private var _isShowGameLoading:Boolean;
      
      private var _isSingleBattleAndForcedExit:Boolean = false;
      
      public var fightTypeLastSelected:int;
      
      private var _singleRoomView:SingleRoomView;
      
      public function RoomControl()
      {
         super();
      }
      
      public static function get instance() : RoomControl
      {
         if(_ins == null)
         {
            _ins = new RoomControl();
         }
         return _ins;
      }
      
      public function setup() : void
      {
         RoomManager.Instance.addEventListener("updateData",__updateDataHandler);
         RoomManager.Instance.addEventListener("showSingleRoomView",__showSingleRoomViewHandler);
         RoomManager.Instance.addEventListener("update_battle_remain",__updateBattleTimesRemain);
      }
      
      protected function __updateBattleTimesRemain(param1:CEvent) : void
      {
      }
      
      private function __updateDataHandler(param1:Event) : void
      {
         checkData();
      }
      
      private function checkData() : void
      {
         var _loc2_:Array = RoomManager.Instance.pkgs;
         if(_loc2_.length <= 0)
         {
            return;
         }
         var _loc1_:CrazyTankSocketEvent = _loc2_.shift();
         var _loc3_:* = _loc1_.type;
         if("gameRoomCreate" !== _loc3_)
         {
            if("SINGLE_ROOM_BEGIN" !== _loc3_)
            {
               if("gameLogin" !== _loc3_)
               {
                  if("gameRoomSetUp" !== _loc3_)
                  {
                     if("gameRoomOpen" !== _loc3_)
                     {
                        if("playerState" !== _loc3_)
                        {
                           if("GameStyleRecv" !== _loc3_)
                           {
                              if("gameTeam" !== _loc3_)
                              {
                                 if("netWork" !== _loc3_)
                                 {
                                    if("buffObtain" !== _loc3_)
                                    {
                                       if("buffUpdate" !== _loc3_)
                                       {
                                          if("GameWaitFailed" !== _loc3_)
                                          {
                                             if("recvGameWait" !== _loc3_)
                                             {
                                                if("GameWaitCancel" !== _loc3_)
                                                {
                                                   if("gamePlayerEnter" !== _loc3_)
                                                   {
                                                      if("GamePlayerExit" !== _loc3_)
                                                      {
                                                         if("insufficientMoney" !== _loc3_)
                                                         {
                                                            if("singleBattle_forecdExit" === _loc3_)
                                                            {
                                                               __forcedExitHandler(_loc1_);
                                                            }
                                                         }
                                                         else
                                                         {
                                                            __paymentFailed(_loc1_);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         __removePlayerInRoom(_loc1_);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      __addPlayerInRoom(_loc1_);
                                                   }
                                                }
                                                else
                                                {
                                                   __waitCancel(_loc1_);
                                                }
                                             }
                                             else
                                             {
                                                __waitGameRecv(_loc1_);
                                             }
                                          }
                                          else
                                          {
                                             __waitGameFailed(_loc1_);
                                          }
                                       }
                                       else
                                       {
                                          __buffUpdate(_loc1_);
                                       }
                                    }
                                    else
                                    {
                                       __buffObtain(_loc1_);
                                    }
                                 }
                                 else
                                 {
                                    __netWork(_loc1_);
                                 }
                              }
                              else
                              {
                                 __setPlayerTeam(_loc1_);
                              }
                           }
                           else
                           {
                              __updateGameStyle(_loc1_);
                           }
                        }
                        else
                        {
                           __playerStateChange(_loc1_);
                        }
                     }
                     else
                     {
                        __updateRoomPlaces(_loc1_);
                     }
                  }
                  else
                  {
                     __settingRoom(_loc1_);
                  }
               }
               else
               {
                  __loginRoomResult(_loc1_);
               }
            }
            else
            {
               __createSingleRoom(_loc1_);
            }
         }
         else
         {
            __createRoom(_loc1_);
         }
         checkData();
      }
      
      private function __createRoom(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:RoomInfo = new RoomInfo();
         _loc3_.ID = _loc2_.readInt();
         _loc3_.type = _loc2_.readUnsignedByte();
         _loc3_.hardLevel = _loc2_.readByte();
         _loc3_.timeType = _loc2_.readByte();
         _loc3_.totalPlayer = _loc2_.readByte();
         _loc3_.viewerCnt = _loc2_.readByte();
         _loc3_.placeCount = _loc2_.readByte();
         _loc3_.isLocked = _loc2_.readBoolean();
         _loc3_.mapId = _loc2_.readInt();
         _loc3_.started = _loc2_.readBoolean();
         _loc3_.Name = _loc2_.readUTF();
         var _loc4_:* = _loc2_.readByte();
         _loc3_.gameMode = _loc4_;
         _loc3_.dungeonMode = _loc4_;
         _loc3_.levelLimits = _loc2_.readInt();
         _loc3_.isCrossZone = _loc2_.readBoolean();
         _loc3_.isWithinLeageTime = _loc2_.readBoolean();
         _loc3_.isOpenBoss = _loc2_.readBoolean();
         _loc3_.pic = param1.pkg.readUTF();
         _isShowGameLoading = param1.pkg.readBoolean();
         if(_isShowGameLoading)
         {
            GameLoadingManager.Instance.show();
            if(_loc3_.type == 10)
            {
               NewHandGuideManager.Instance.mapID = _loc3_.mapId;
            }
         }
         RoomManager.Instance.setCurrent(_loc3_);
         if(_isShowGameLoading)
         {
            GameLoadingManager.Instance.createRoomComplete();
            if(_loc3_.gameMode == 8)
            {
               enterFightLib();
            }
         }
         RoomManager.Instance.dispatchEvent(new CrazyTankSocketEvent("gameRoomCreate"));
      }
      
      private function enterFightLib() : void
      {
         FightLibManager.Instance.currentInfoID = RoomManager.Instance.current.mapId;
         FightLibManager.Instance.currentInfo.difficulty = RoomManager.Instance.current.hardLevel;
         StateManager.setState("fightLib");
      }
      
      private function __paymentFailed(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         var _loc7_:int = _loc5_.readByte();
         var _loc2_:Boolean = _loc5_.readBoolean();
         if(_loc7_ == 0)
         {
            if(!_loc2_)
            {
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               _loc3_.addEventListener("response",_responseI);
            }
         }
         else if(_loc7_ == 1)
         {
            if(!_loc2_)
            {
               RoomManager.Instance.dispatchEvent(new Event("PaymentCard"));
               _loc4_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               if(_loc4_.parent)
               {
                  _loc4_.parent.removeChild(_loc4_);
               }
               LayerManager.Instance.addToLayer(_loc4_,3,true,2);
               _loc4_.addEventListener("response",_responseI);
               ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("tank.gameover.NotEnoughPayToTakeCard"));
            }
         }
         else if(_loc7_ == 2)
         {
            if(!_loc2_)
            {
               _loc6_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               _loc6_.addEventListener("response",_responseII);
            }
         }
      }
      
      private function _responseI(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function _responseII(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseII);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            __toPaymentTryagainHandler();
         }
         else
         {
            __cancelPaymenttryagainHandler();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function __toPaymentTryagainHandler() : void
      {
         LeavePageManager.leaveToFillPath();
         GameControl.Instance.dispatchPaymentConfirm();
      }
      
      private function __cancelPaymenttryagainHandler() : void
      {
         GameControl.Instance.dispatchLeaveMission();
      }
      
      protected function __createSingleRoom(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:RoomInfo = new RoomInfo();
         _loc4_.ID = _loc3_.readInt();
         _loc4_.type = _loc3_.readUnsignedByte();
         _loc4_.hardLevel = _loc3_.readByte();
         _loc4_.isPlaying = _loc3_.readBoolean();
         _loc4_.gameMode = _loc3_.readByte();
         if(_loc4_.gameMode == 20)
         {
            _loc4_.type = 18;
         }
         _loc4_.mapId = _loc3_.readInt();
         _loc4_.isCrossZone = _loc3_.readBoolean();
         RoomManager.Instance.setCurrent(_loc4_);
         PlayerManager.Instance.Self.ZoneID = _loc3_.readInt();
         _isShowGameLoading = _loc3_.readBoolean();
         if(_isShowGameLoading)
         {
            GameControl.Instance.addEventListener("StartLoading",__startLoading);
            GameLoadingManager.Instance.show();
         }
         if(GameControl.Instance.Current != null)
         {
            _loc2_ = GameControl.Instance.Current.findRoomPlayer(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.ZoneID);
         }
         if(_loc2_ == null)
         {
            _loc2_ = new RoomPlayer(PlayerManager.Instance.Self);
         }
         _loc4_.addPlayer(_loc2_);
         if(RoomManager.Instance.current)
         {
            if(RoomManager.Instance.current.type == 16)
            {
               RoomManager.Instance.battleType = 1;
               RoomManager.Instance.addBattleSingleRoom();
            }
            else if(RoomManager.Instance.current.type == 18)
            {
               RoomManager.Instance.battleType = 2;
               RoomManager.Instance.addBattleSingleRoom(2);
            }
            else if(RoomManager.Instance.current.type == 25)
            {
               RoomManager.Instance.battleType = 6;
               if(_singleRoomView)
               {
                  _singleRoomView.startTime();
               }
            }
            else if(RoomManager.Instance.current.type == 121)
            {
               RoomManager.Instance.battleType = 21;
               SurvivalModeControl.Instance.start();
            }
         }
         PlayerManager.Instance.Self.LastServerId = -1;
         if(BombKingManager.instance.Recording)
         {
            RoomManager.Instance.dispatchEvent(new BombKingEvent("startloadbattlexml"));
         }
         RoomManager.Instance.dispatchEvent(param1);
      }
      
      protected function __startLoading(param1:Event) : void
      {
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      public function showSingleRoomView(param1:int = 6) : void
      {
         _singleRoomView = ComponentFactory.Instance.creat("room.view.roomView.singleRoomView",[param1]);
         _singleRoomView.show();
         _singleRoomView.addEventListener("response",__onSingleRoomEvent);
      }
      
      protected function __onSingleRoomEvent(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 4 || param1.responseCode == 0)
         {
            SoundManager.instance.playButtonSound();
            _singleRoomView.isCloseOrEscClick = true;
            RoomListManager.instance.openMatch = false;
            hideSingleRoomView();
         }
      }
      
      private function hideSingleRoomView() : void
      {
         _singleRoomView.removeEventListener("response",__onSingleRoomEvent);
         ObjectUtils.disposeObject(_singleRoomView);
         _singleRoomView = null;
      }
      
      private function __showSingleRoomViewHandler(param1:CEvent) : void
      {
         checkData();
         showSingleRoomView(RoomManager.Instance.battleType);
      }
      
      private function __loginRoomResult(param1:CrazyTankSocketEvent) : void
      {
         RoomManager.Instance.dispatchEvent(new Event("loginRoomResult"));
         if(param1.pkg.readBoolean() == false)
         {
         }
      }
      
      private function __settingRoom(param1:CrazyTankSocketEvent) : void
      {
         if(RoomManager.Instance.current == null)
         {
            return;
         }
         var _loc2_:Boolean = param1.pkg.readBoolean();
         if(_loc2_)
         {
            RoomManager.Instance.current.pic = param1.pkg.readUTF();
            if(!RoomManager.Instance.current.selfRoomPlayer.isHost && StateManager.currentStateType != "dungeonRoom")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("BaseRoomView.getout.bossRoom"));
            }
         }
         RoomManager.Instance.current.isOpenBoss = _loc2_;
         var _loc3_:* = param1.pkg.readInt();
         RoomManager.Instance.current.dungeonMode = _loc3_;
         RoomManager.Instance.current.gameMode = _loc3_;
         RoomManager.Instance.current.mapId = param1.pkg.readInt();
         RoomManager.Instance.current.type = param1.pkg.readByte();
         RoomManager.Instance.current.roomPass = param1.pkg.readUTF();
         RoomManager.Instance.current.roomName = param1.pkg.readUTF();
         RoomManager.Instance.current.timeType = param1.pkg.readByte();
         RoomManager.Instance.current.hardLevel = param1.pkg.readByte();
         RoomManager.Instance.current.levelLimits = param1.pkg.readInt();
         RoomManager.Instance.current.isCrossZone = param1.pkg.readBoolean();
         if(RoomManager.Instance.current.type == 15)
         {
            RoomManager.Instance.dispatchEvent(new RoomEvent("startLabyrinth"));
         }
      }
      
      private function __updateRoomPlaces(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc2_[_loc3_] = param1.pkg.readInt();
            _loc3_++;
         }
         if(RoomManager.Instance.current)
         {
            RoomManager.Instance.current.updatePlaceState(_loc2_);
         }
      }
      
      private function __playerStateChange(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(RoomManager.Instance.current)
         {
            _loc2_ = [];
            _loc3_ = 0;
            while(_loc3_ < 8)
            {
               _loc2_[_loc3_] = param1.pkg.readByte();
               _loc3_++;
            }
            RoomManager.Instance.current.updatePlayerState(_loc2_);
         }
      }
      
      private function __updateGameStyle(param1:CrazyTankSocketEvent) : void
      {
         if(RoomManager.Instance.current == null)
         {
            return;
         }
         RoomManager.Instance.current.gameMode = param1.pkg.readByte();
         if(RoomManager.Instance.current.gameMode == 4 && StateManager.currentStateType != "teamRoom")
         {
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("tank.room.UpdateGameStyle"));
         }
      }
      
      private function __setPlayerTeam(param1:CrazyTankSocketEvent) : void
      {
         if(RoomManager.Instance.current == null)
         {
            return;
         }
         RoomManager.Instance.current.updatePlayerTeam(param1.pkg.clientId,param1.pkg.readByte(),param1.pkg.readByte());
      }
      
      private function __netWork(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PlayerInfo = PlayerManager.Instance.findPlayer(param1.pkg.clientId);
         var _loc2_:int = param1.pkg.readInt();
         if(_loc3_)
         {
            _loc3_.webSpeed = _loc2_;
         }
      }
      
      private function __buffObtain(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = 0;
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:Boolean = false;
         var _loc6_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:* = null;
         var _loc7_:PackageIn = param1.pkg;
         if(!RoomManager.Instance.current)
         {
            RoomManager.Instance.current = new RoomInfo();
         }
         if(_loc7_.clientId == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         if(RoomManager.Instance.current.findPlayerByID(_loc7_.clientId) != null)
         {
            _loc2_ = _loc7_.readInt();
            _loc10_ = 0;
            while(_loc10_ < _loc2_)
            {
               _loc9_ = _loc7_.readInt();
               _loc3_ = _loc7_.readBoolean();
               _loc6_ = _loc7_.readDate();
               _loc4_ = _loc7_.readInt();
               _loc5_ = _loc7_.readInt();
               _loc8_ = new BuffInfo(_loc9_,_loc3_,_loc6_,_loc4_,_loc5_);
               RoomManager.Instance.current.findPlayerByID(_loc7_.clientId).playerInfo.buffInfo.add(_loc8_.Type,_loc8_);
               _loc10_++;
            }
            param1.stopImmediatePropagation();
         }
      }
      
      private function __buffUpdate(param1:CrazyTankSocketEvent) : void
      {
         var _loc8_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:int = 0;
         var _loc9_:Boolean = false;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:* = null;
         var _loc7_:PackageIn = param1.pkg;
         if(_loc7_.clientId == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         if(RoomManager.Instance.current && RoomManager.Instance.current.findPlayerByID(_loc7_.clientId) != null)
         {
            _loc8_ = _loc7_.readInt();
            _loc10_ = 0;
            while(_loc10_ < _loc8_)
            {
               _loc2_ = _loc7_.readInt();
               _loc9_ = _loc7_.readBoolean();
               _loc4_ = _loc7_.readDate();
               _loc5_ = _loc7_.readInt();
               _loc3_ = _loc7_.readInt();
               _loc6_ = new BuffInfo(_loc2_,_loc9_,_loc4_,_loc5_,_loc3_);
               if(_loc9_)
               {
                  RoomManager.Instance.current.findPlayerByID(_loc7_.clientId).playerInfo.buffInfo.add(_loc6_.Type,_loc6_);
               }
               else
               {
                  RoomManager.Instance.current.findPlayerByID(_loc7_.clientId).playerInfo.buffInfo.remove(_loc6_.Type);
               }
               _loc10_++;
            }
            param1.stopImmediatePropagation();
         }
      }
      
      private function __waitGameFailed(param1:CrazyTankSocketEvent) : void
      {
         if(RoomManager.Instance.current)
         {
            RoomManager.Instance.current.pickupFailed();
         }
      }
      
      private function __waitGameRecv(param1:CrazyTankSocketEvent) : void
      {
         if(RoomManager.Instance.current)
         {
            RoomManager.Instance.current.startPickup();
         }
      }
      
      private function __waitCancel(param1:CrazyTankSocketEvent) : void
      {
         if(RoomManager.Instance.current)
         {
            RoomManager.Instance.current.cancelPickup();
         }
      }
      
      private function __addPlayerInRoom(param1:CrazyTankSocketEvent) : void
      {
         var _loc20_:* = null;
         var _loc10_:int = 0;
         var _loc4_:Boolean = false;
         var _loc7_:int = 0;
         var _loc22_:int = 0;
         var _loc6_:Boolean = false;
         var _loc12_:int = 0;
         var _loc18_:int = 0;
         var _loc21_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc19_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc8_:* = null;
         var _loc16_:int = 0;
         var _loc11_:int = 0;
         var _loc3_:int = 0;
         var _loc23_:int = 0;
         var _loc15_:int = 0;
         var _loc28_:* = null;
         var _loc26_:int = 0;
         var _loc9_:int = 0;
         var _loc24_:int = 0;
         var _loc27_:int = 0;
         var _loc17_:int = 0;
         var _loc25_:* = null;
         InviteManager.Instance.clearResponseInviteFrame();
         if(RoomManager.Instance.current)
         {
            _loc20_ = param1.pkg;
            _loc10_ = _loc20_.clientId;
            _loc4_ = _loc20_.readBoolean();
            _loc7_ = _loc20_.readByte();
            _loc22_ = _loc20_.readByte();
            _loc6_ = _loc20_.readBoolean();
            _loc12_ = _loc20_.readInt();
            _loc18_ = _loc20_.readInt();
            _loc21_ = _loc20_.readInt();
            _loc13_ = _loc20_.readInt();
            _loc14_ = _loc20_.readInt();
            _loc19_ = _loc20_.readInt();
            _loc5_ = _loc20_.readInt();
            _loc2_ = _loc20_.readInt();
            if(_loc10_ != PlayerManager.Instance.Self.ID)
            {
               _loc8_ = PlayerManager.Instance.findPlayer(_loc10_);
               _loc8_.beginChanges();
               _loc8_.ID = _loc20_.readInt();
               _loc8_.NickName = _loc20_.readUTF();
               _loc8_.typeVIP = _loc20_.readByte();
               _loc8_.VIPLevel = _loc20_.readInt();
               _loc8_.Sex = _loc20_.readBoolean();
               _loc8_.Style = _loc20_.readUTF();
               _loc8_.Colors = _loc20_.readUTF();
               _loc8_.Skin = _loc20_.readUTF();
               _loc8_.WeaponID = _loc20_.readInt();
               _loc8_.DeputyWeaponID = _loc20_.readInt();
               _loc8_.Repute = _loc14_;
               _loc8_.Grade = _loc12_;
               _loc8_.ddtKingGrade = _loc18_;
               _loc8_.Offer = _loc21_;
               _loc8_.Hide = _loc13_;
               _loc8_.ConsortiaID = _loc20_.readInt();
               _loc8_.ConsortiaName = _loc20_.readUTF();
               _loc8_.badgeID = _loc20_.readInt();
               _loc8_.WinCount = _loc20_.readInt();
               _loc8_.TotalCount = _loc20_.readInt();
               _loc8_.EscapeCount = _loc20_.readInt();
               _loc16_ = _loc20_.readInt();
               _loc11_ = _loc20_.readInt();
               _loc8_.IsMarried = _loc20_.readBoolean();
               if(_loc8_.IsMarried)
               {
                  _loc8_.SpouseID = _loc20_.readInt();
                  _loc8_.SpouseName = _loc20_.readUTF();
               }
               else
               {
                  _loc8_.SpouseID = 0;
                  _loc8_.SpouseName = "";
               }
               _loc8_.LoginName = _loc20_.readUTF();
               _loc8_.Nimbus = _loc20_.readInt();
               _loc8_.FightPower = _loc20_.readInt();
               _loc8_.apprenticeshipState = _loc20_.readInt();
               _loc8_.masterID = _loc20_.readInt();
               _loc8_.setMasterOrApprentices(_loc20_.readUTF());
               _loc8_.graduatesCount = _loc20_.readInt();
               _loc8_.honourOfMaster = _loc20_.readUTF();
               _loc8_.DailyLeagueFirst = _loc20_.readBoolean();
               _loc8_.DailyLeagueLastScore = _loc20_.readInt();
               _loc8_.guardCoreID = _loc20_.readInt();
               _loc8_.isOld = _loc20_.readBoolean();
               _loc3_ = _loc20_.readInt();
               _loc23_ = 0;
               while(_loc23_ < _loc3_)
               {
                  _loc15_ = _loc20_.readInt();
                  _loc28_ = _loc8_.pets[_loc15_];
                  _loc26_ = _loc20_.readInt();
                  if(_loc28_ == null)
                  {
                     _loc28_ = new PetInfo();
                     _loc28_.TemplateID = _loc26_;
                     PetInfoManager.fillPetInfo(_loc28_);
                  }
                  _loc28_.ID = _loc20_.readInt();
                  _loc28_.Name = _loc20_.readUTF();
                  _loc28_.UserID = _loc20_.readInt();
                  _loc28_.Level = _loc20_.readInt();
                  _loc28_.IsEquip = true;
                  _loc28_.clearEquipedSkills();
                  _loc9_ = _loc20_.readInt();
                  _loc24_ = 0;
                  while(_loc24_ < _loc9_)
                  {
                     _loc27_ = _loc20_.readInt();
                     _loc17_ = _loc20_.readInt();
                     _loc28_.equipdSkills.add(_loc27_,_loc17_);
                     _loc24_++;
                  }
                  _loc28_.Place = _loc15_;
                  _loc8_.pets.add(_loc28_.Place,_loc28_);
                  _loc23_++;
               }
               _loc8_.curcentRoomBordenTemplateId = _loc20_.readInt();
               _loc8_.commitChanges();
            }
            else
            {
               _loc8_ = PlayerManager.Instance.Self;
            }
            _loc8_.ZoneID = _loc5_;
            _loc8_.activityTanabataNum = _loc2_;
            if(GameControl.Instance.Current != null)
            {
               _loc25_ = GameControl.Instance.Current.findRoomPlayer(_loc10_,_loc5_);
            }
            if(_loc25_ == null)
            {
               _loc25_ = new RoomPlayer(_loc8_);
            }
            _loc25_.isFirstIn = _loc6_;
            _loc25_.place = _loc7_;
            _loc25_.team = _loc22_;
            _loc25_.webSpeedInfo.delay = _loc19_;
            RoomManager.Instance.current.addPlayer(_loc25_);
            if(_loc25_.isSelf && RoomManager.Instance.current && !_isShowGameLoading)
            {
               if(RoomManager.Instance.current.type != 5)
               {
                  if(RoomManager.Instance.current.type == 120)
                  {
                     StateManager.setState("battleRoom");
                  }
                  else if(RoomManager.Instance.current.type == 0 || RoomManager.Instance.current.type == 12 || RoomManager.Instance.current.type == 68 || RoomManager.Instance.current.type == 42 || RoomManager.Instance.current.type == 41 || RoomManager.Instance.current.type == 13)
                  {
                     StateManager.setState("matchRoom");
                  }
                  else if(RoomManager.Instance.current.type == 1)
                  {
                     StateManager.setState("challengeRoom");
                  }
                  else if(RoomManager.Instance.current.type == 4 || RoomManager.Instance.current.type == 11 || RoomManager.Instance.current.type == 21 || RoomManager.Instance.current.type == 23 || RoomManager.Instance.current.type == 28 || RoomManager.Instance.current.type == 47 || RoomManager.Instance.current.type == 48 || RoomManager.Instance.current.type == 123)
                  {
                     StateManager.setState("dungeonRoom");
                  }
                  else if(RoomManager.Instance.current.type == 49)
                  {
                     if(BraveDoorManager.instance.moduleIsShow)
                     {
                        BraveDoorControl.instance.switchView(2);
                     }
                     else
                     {
                        BraveDoorControl.instance.lockSwitchView(2);
                        BraveDoorManager.instance.show();
                     }
                  }
                  else if(RoomManager.Instance.current.type == 10)
                  {
                     if(StartupResourceLoader.firstEnterHall)
                     {
                        StateManager.setState("freshmanRoom2");
                     }
                     else
                     {
                        StateManager.setState("freshmanRoom1");
                     }
                  }
                  else if(RoomManager.Instance.current.type == 14)
                  {
                     WorldBossManager.Instance.enterGame();
                  }
                  else if(RoomManager.Instance.current.type == 15)
                  {
                     LabyrinthManager.Instance.enterGame();
                  }
                  else if(RoomManager.Instance.current.type == 40)
                  {
                     ChristmasCoreManager.instance.setupFightEvent();
                  }
                  else if(RoomManager.Instance.current.type == 58)
                  {
                     StateManager.setState("teamRoom");
                  }
               }
            }
            if(_isShowGameLoading)
            {
               GameControl.Instance.addEventListener("StartLoading",__startLoading);
            }
            PlayerManager.Instance.Self.LastServerId = -1;
         }
      }
      
      private function __removePlayerInRoom(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         CampBattleManager.instance.isFighting = false;
         if(RoomManager.Instance.current)
         {
            _loc2_ = param1.pkg.clientId;
            _loc3_ = param1.pkg.readInt();
            _loc5_ = RoomManager.Instance.current.findPlayerByID(_loc2_,_loc3_);
            if(_loc5_ && _loc5_.isSelf)
            {
               GameControl.Instance.currentNum = 0;
               if(StateManager.currentStateType == "matchRoom" || StateManager.currentStateType == "challengeRoom" || StateManager.currentStateType == "singleBattleMatching")
               {
                  StateManager.setState("roomlist");
               }
               else if(RoomManager.Instance.current.type == 120)
               {
                  StateManager.setState("main");
               }
               else if(StateManager.currentStateType == "teamRoom")
               {
                  StateManager.setState("main");
               }
               else if(RoomManager.Instance.current.type == 18)
               {
                  StateManager.setState("main");
               }
               else if(StateManager.currentStateType == "dungeonRoom")
               {
                  StateManager.setState("dungeon");
               }
               else if(RoomManager.Instance.current.type == 49)
               {
                  if(StateManager.currentStateType == "fighting")
                  {
                     StateManager.setState("main");
                  }
                  else
                  {
                     BraveDoorControl.instance.switchView(1);
                     SocketManager.Instance.out.sendUpdateRoomList(7,3);
                  }
               }
               else if(StateManager.currentStateType == "dungeonRoom" || StateManager.currentStateType == "missionResult")
               {
                  StateManager.setState("dungeon");
               }
               else if(StateManager.currentStateType == "fightLabGameView")
               {
                  StateManager.setState("main");
               }
               else if(StateManager.currentStateType == "fighting" || StateManager.currentStateType == "roomLoading" || StateManager.currentStateType == "gameLoading" || StateManager.currentStateType == "fighting3d")
               {
                  if(RoomManager.Instance.current.type == 4 || RoomManager.Instance.current.type == 11 || RoomManager.Instance.current.type == 21 || RoomManager.Instance.current.type == 23 || RoomManager.Instance.current.type == 123)
                  {
                     StateManager.setState("dungeon");
                  }
                  else if(RoomManager.Instance.current.type == 47 || RoomManager.Instance.current.type == 48)
                  {
                     StateManager.setState("dungeon");
                  }
                  else if(RoomManager.Instance.current.type != 14)
                  {
                     if(RoomManager.Instance.current.type == 25)
                     {
                        if(_isSingleBattleAndForcedExit)
                        {
                           StateManager.setState("roomlist");
                        }
                     }
                     else if(RoomManager.Instance.current.type == 15)
                     {
                        StateManager.setState("main",LabyrinthManager.Instance.show);
                     }
                     else if(RoomManager.Instance.current.type == 17)
                     {
                        StateManager.setState("consortia",ConsortionModelManager.Instance.openBossFrame);
                     }
                     else if(RoomManager.Instance.current.type == 19)
                     {
                        StateManager.setState("consortiaBattleScene");
                     }
                     else if(RoomManager.Instance.current.type == 20)
                     {
                        SocketManager.Instance.out.returnToPve();
                     }
                     else if(RoomManager.Instance.current.type == 31)
                     {
                        if(SevenDoubleManager.instance.isStart)
                        {
                           StateManager.setState("sevenDoubleScene");
                        }
                        else if(EscortManager.instance.isStart)
                        {
                           StateManager.setState("escort");
                        }
                        else if(DrgnBoatManager.instance.isStart)
                        {
                           StateManager.setState("drgnBoat");
                        }
                        else if(FloatParadeIconManager.instance.isStart)
                        {
                           StateManager.setState("floatparade");
                        }
                        else if(DDTKingFloatIconManager.instance.isStart)
                        {
                           StateManager.setState("ddtKingFloat");
                        }
                        else
                        {
                           StateManager.setState("main");
                        }
                     }
                     else if(RoomManager.Instance.current.type == 26 || RoomManager.Instance.current.type == 28)
                     {
                        StateManager.setState("main");
                     }
                     else if(RoomManager.Instance.current.type == 40)
                     {
                        if(RoomManager.Instance.isChristmasFight())
                        {
                           if(ChristmasCoreManager.isTimeOver)
                           {
                              ChristmasCoreManager.isTimeOver = false;
                              StateManager.setState("main");
                              return;
                           }
                        }
                        ChristmasCoreManager.isToRoom = true;
                        if(!ChristmasCoreManager.instance.loadUiModuleComplete)
                        {
                           ChristmasCoreManager.instance.reConnect();
                        }
                        else
                        {
                           ChristmasCoreManager.instance.isReConnect = false;
                           StateManager.setState("christmasroom");
                        }
                     }
                     else if(RoomManager.Instance.current.type == 51)
                     {
                        StateManager.setState("main");
                     }
                     else if(RoomManager.Instance.current.type == 29)
                     {
                        StateManager.setState("main");
                     }
                     else if(RoomManager.Instance.current.type == 67 || RoomManager.Instance.current.type == 121)
                     {
                        StateManager.setState("main");
                     }
                     else if(RoomManager.Instance.current.type == 52)
                     {
                        CatchInsectManager.isToRoom = true;
                        if(!CatchInsectManager.instance.loadUiModuleComplete)
                        {
                           CatchInsectManager.instance.reConnect();
                        }
                        else
                        {
                           CatchInsectManager.instance.isReConnect = false;
                           StateManager.setState("catchInsect");
                        }
                     }
                     else if(RoomManager.Instance.current.type == 48)
                     {
                        _loc4_ = DemonChiYouManager.instance.model.bossState;
                        if(_loc4_ == 2)
                        {
                           StateManager.setState("demon_chi_you");
                        }
                        else
                        {
                           StateManager.setState("main");
                        }
                     }
                     else if(RoomManager.Instance.current.type == 150)
                     {
                        StateManager.setState("consortia_domain");
                     }
                     else if(RoomManager.Instance.current.type == 151)
                     {
                        StateManager.setState("consortiaGuard");
                     }
                     else
                     {
                        StateManager.setState("roomlist");
                     }
                  }
               }
               PlayerManager.Instance.Self.unlockAllBag();
            }
            else
            {
               if(GameControl.Instance.Current)
               {
                  GameControl.Instance.Current.removeRoomPlayer(_loc3_,_loc2_);
                  GameControl.Instance.Current.removeGamePlayerByPlayerID(_loc3_,_loc2_);
               }
               RoomManager.Instance.current.removePlayer(_loc3_,_loc2_);
            }
            RoomManager.Instance.dispatchEvent(new Event("PlayerRoomExit"));
         }
         _isSingleBattleAndForcedExit = false;
         GameLoadingManager.Instance.hide();
      }
      
      protected function __forcedExitHandler(param1:Event) : void
      {
         _isSingleBattleAndForcedExit = true;
      }
   }
}
