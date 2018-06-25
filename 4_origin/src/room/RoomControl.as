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
      
      protected function __updateBattleTimesRemain(e:CEvent) : void
      {
      }
      
      private function __updateDataHandler(event:Event) : void
      {
         checkData();
      }
      
      private function checkData() : void
      {
         var pkgs:Array = RoomManager.Instance.pkgs;
         if(pkgs.length <= 0)
         {
            return;
         }
         var event:CrazyTankSocketEvent = pkgs.shift();
         var _loc3_:* = event.type;
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
                                                               __forcedExitHandler(event);
                                                            }
                                                         }
                                                         else
                                                         {
                                                            __paymentFailed(event);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         __removePlayerInRoom(event);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      __addPlayerInRoom(event);
                                                   }
                                                }
                                                else
                                                {
                                                   __waitCancel(event);
                                                }
                                             }
                                             else
                                             {
                                                __waitGameRecv(event);
                                             }
                                          }
                                          else
                                          {
                                             __waitGameFailed(event);
                                          }
                                       }
                                       else
                                       {
                                          __buffUpdate(event);
                                       }
                                    }
                                    else
                                    {
                                       __buffObtain(event);
                                    }
                                 }
                                 else
                                 {
                                    __netWork(event);
                                 }
                              }
                              else
                              {
                                 __setPlayerTeam(event);
                              }
                           }
                           else
                           {
                              __updateGameStyle(event);
                           }
                        }
                        else
                        {
                           __playerStateChange(event);
                        }
                     }
                     else
                     {
                        __updateRoomPlaces(event);
                     }
                  }
                  else
                  {
                     __settingRoom(event);
                  }
               }
               else
               {
                  __loginRoomResult(event);
               }
            }
            else
            {
               __createSingleRoom(event);
            }
         }
         else
         {
            __createRoom(event);
         }
         checkData();
      }
      
      private function __createRoom(evt:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var info:RoomInfo = new RoomInfo();
         info.ID = pkg.readInt();
         info.type = pkg.readUnsignedByte();
         info.hardLevel = pkg.readByte();
         info.timeType = pkg.readByte();
         info.totalPlayer = pkg.readByte();
         info.viewerCnt = pkg.readByte();
         info.placeCount = pkg.readByte();
         info.isLocked = pkg.readBoolean();
         info.mapId = pkg.readInt();
         info.started = pkg.readBoolean();
         info.Name = pkg.readUTF();
         var _loc4_:* = pkg.readByte();
         info.gameMode = _loc4_;
         info.dungeonMode = _loc4_;
         info.levelLimits = pkg.readInt();
         info.isCrossZone = pkg.readBoolean();
         info.isWithinLeageTime = pkg.readBoolean();
         info.isOpenBoss = pkg.readBoolean();
         info.pic = evt.pkg.readUTF();
         _isShowGameLoading = evt.pkg.readBoolean();
         if(_isShowGameLoading)
         {
            GameLoadingManager.Instance.show();
            if(info.type == 10)
            {
               NewHandGuideManager.Instance.mapID = info.mapId;
            }
         }
         RoomManager.Instance.setCurrent(info);
         if(_isShowGameLoading)
         {
            GameLoadingManager.Instance.createRoomComplete();
            if(info.gameMode == 8)
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
      
      private function __paymentFailed(e:CrazyTankSocketEvent) : void
      {
         var alert:* = null;
         var alert1:* = null;
         var alert2:* = null;
         var pkg:PackageIn = e.pkg;
         var type:int = pkg.readByte();
         var payment:Boolean = pkg.readBoolean();
         if(type == 0)
         {
            if(!payment)
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               alert.addEventListener("response",_responseI);
            }
         }
         else if(type == 1)
         {
            if(!payment)
            {
               RoomManager.Instance.dispatchEvent(new Event("PaymentCard"));
               alert1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               if(alert1.parent)
               {
                  alert1.parent.removeChild(alert1);
               }
               LayerManager.Instance.addToLayer(alert1,3,true,2);
               alert1.addEventListener("response",_responseI);
               ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("tank.gameover.NotEnoughPayToTakeCard"));
            }
         }
         else if(type == 2)
         {
            if(!payment)
            {
               alert2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               alert2.addEventListener("response",_responseII);
            }
         }
      }
      
      private function _responseI(evt:FrameEvent) : void
      {
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      private function _responseII(evt:FrameEvent) : void
      {
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_responseII);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            __toPaymentTryagainHandler();
         }
         else
         {
            __cancelPaymenttryagainHandler();
         }
         ObjectUtils.disposeObject(evt.currentTarget);
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
      
      protected function __createSingleRoom(event:CrazyTankSocketEvent) : void
      {
         var fpInfo:* = null;
         var pkg:PackageIn = event.pkg;
         var info:RoomInfo = new RoomInfo();
         info.ID = pkg.readInt();
         info.type = pkg.readUnsignedByte();
         info.hardLevel = pkg.readByte();
         info.isPlaying = pkg.readBoolean();
         info.gameMode = pkg.readByte();
         if(info.gameMode == 20)
         {
            info.type = 18;
         }
         info.mapId = pkg.readInt();
         info.isCrossZone = pkg.readBoolean();
         RoomManager.Instance.setCurrent(info);
         PlayerManager.Instance.Self.ZoneID = pkg.readInt();
         _isShowGameLoading = pkg.readBoolean();
         if(_isShowGameLoading)
         {
            GameControl.Instance.addEventListener("StartLoading",__startLoading);
            GameLoadingManager.Instance.show();
         }
         if(GameControl.Instance.Current != null)
         {
            fpInfo = GameControl.Instance.Current.findRoomPlayer(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.ZoneID);
         }
         if(fpInfo == null)
         {
            fpInfo = new RoomPlayer(PlayerManager.Instance.Self);
         }
         info.addPlayer(fpInfo);
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
         RoomManager.Instance.dispatchEvent(event);
      }
      
      protected function __startLoading(e:Event) : void
      {
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      public function showSingleRoomView(type:int = 6) : void
      {
         _singleRoomView = ComponentFactory.Instance.creat("room.view.roomView.singleRoomView",[type]);
         _singleRoomView.show();
         _singleRoomView.addEventListener("response",__onSingleRoomEvent);
      }
      
      protected function __onSingleRoomEvent(event:FrameEvent) : void
      {
         if(event.responseCode == 1 || event.responseCode == 4 || event.responseCode == 0)
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
      
      private function __showSingleRoomViewHandler(event:CEvent) : void
      {
         checkData();
         showSingleRoomView(RoomManager.Instance.battleType);
      }
      
      private function __loginRoomResult(evt:CrazyTankSocketEvent) : void
      {
         RoomManager.Instance.dispatchEvent(new Event("loginRoomResult"));
         if(evt.pkg.readBoolean() == false)
         {
         }
      }
      
      private function __settingRoom(evt:CrazyTankSocketEvent) : void
      {
         if(RoomManager.Instance.current == null)
         {
            return;
         }
         var bool:Boolean = evt.pkg.readBoolean();
         if(bool)
         {
            RoomManager.Instance.current.pic = evt.pkg.readUTF();
            if(!RoomManager.Instance.current.selfRoomPlayer.isHost && StateManager.currentStateType != "dungeonRoom")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("BaseRoomView.getout.bossRoom"));
            }
         }
         RoomManager.Instance.current.isOpenBoss = bool;
         var _loc3_:* = evt.pkg.readInt();
         RoomManager.Instance.current.dungeonMode = _loc3_;
         RoomManager.Instance.current.gameMode = _loc3_;
         RoomManager.Instance.current.mapId = evt.pkg.readInt();
         RoomManager.Instance.current.type = evt.pkg.readByte();
         RoomManager.Instance.current.roomPass = evt.pkg.readUTF();
         RoomManager.Instance.current.roomName = evt.pkg.readUTF();
         RoomManager.Instance.current.timeType = evt.pkg.readByte();
         RoomManager.Instance.current.hardLevel = evt.pkg.readByte();
         RoomManager.Instance.current.levelLimits = evt.pkg.readInt();
         RoomManager.Instance.current.isCrossZone = evt.pkg.readBoolean();
         if(RoomManager.Instance.current.type == 15)
         {
            RoomManager.Instance.dispatchEvent(new RoomEvent("startLabyrinth"));
         }
      }
      
      private function __updateRoomPlaces(evt:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var states:Array = [];
         for(i = 0; i < 10; )
         {
            states[i] = evt.pkg.readInt();
            i++;
         }
         if(RoomManager.Instance.current)
         {
            RoomManager.Instance.current.updatePlaceState(states);
         }
      }
      
      private function __playerStateChange(evt:CrazyTankSocketEvent) : void
      {
         var states:* = null;
         var i:int = 0;
         if(RoomManager.Instance.current)
         {
            states = [];
            for(i = 0; i < 8; )
            {
               states[i] = evt.pkg.readByte();
               i++;
            }
            RoomManager.Instance.current.updatePlayerState(states);
         }
      }
      
      private function __updateGameStyle(evt:CrazyTankSocketEvent) : void
      {
         if(RoomManager.Instance.current == null)
         {
            return;
         }
         RoomManager.Instance.current.gameMode = evt.pkg.readByte();
         if(RoomManager.Instance.current.gameMode == 4 && StateManager.currentStateType != "teamRoom")
         {
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("tank.room.UpdateGameStyle"));
         }
      }
      
      private function __setPlayerTeam(evt:CrazyTankSocketEvent) : void
      {
         if(RoomManager.Instance.current == null)
         {
            return;
         }
         RoomManager.Instance.current.updatePlayerTeam(evt.pkg.clientId,evt.pkg.readByte(),evt.pkg.readByte());
      }
      
      private function __netWork(event:CrazyTankSocketEvent) : void
      {
         var info:PlayerInfo = PlayerManager.Instance.findPlayer(event.pkg.clientId);
         var speed:int = event.pkg.readInt();
         if(info)
         {
            info.webSpeed = speed;
         }
      }
      
      private function __buffObtain(evt:CrazyTankSocketEvent) : void
      {
         var lth:int = 0;
         var i:int = 0;
         var type:int = 0;
         var isExist:Boolean = false;
         var beginData:* = null;
         var validDate:int = 0;
         var value:int = 0;
         var buff:* = null;
         var pkg:PackageIn = evt.pkg;
         if(!RoomManager.Instance.current)
         {
            RoomManager.Instance.current = new RoomInfo();
         }
         if(pkg.clientId == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         if(RoomManager.Instance.current.findPlayerByID(pkg.clientId) != null)
         {
            lth = pkg.readInt();
            for(i = 0; i < lth; )
            {
               type = pkg.readInt();
               isExist = pkg.readBoolean();
               beginData = pkg.readDate();
               validDate = pkg.readInt();
               value = pkg.readInt();
               buff = new BuffInfo(type,isExist,beginData,validDate,value);
               RoomManager.Instance.current.findPlayerByID(pkg.clientId).playerInfo.buffInfo.add(buff.Type,buff);
               i++;
            }
            evt.stopImmediatePropagation();
         }
      }
      
      private function __buffUpdate(evt:CrazyTankSocketEvent) : void
      {
         var len:int = 0;
         var i:int = 0;
         var _type:int = 0;
         var _isExist:Boolean = false;
         var _beginData:* = null;
         var _validDate:int = 0;
         var _value:int = 0;
         var _buff:* = null;
         var pkg:PackageIn = evt.pkg;
         if(pkg.clientId == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         if(RoomManager.Instance.current && RoomManager.Instance.current.findPlayerByID(pkg.clientId) != null)
         {
            len = pkg.readInt();
            for(i = 0; i < len; )
            {
               _type = pkg.readInt();
               _isExist = pkg.readBoolean();
               _beginData = pkg.readDate();
               _validDate = pkg.readInt();
               _value = pkg.readInt();
               _buff = new BuffInfo(_type,_isExist,_beginData,_validDate,_value);
               if(_isExist)
               {
                  RoomManager.Instance.current.findPlayerByID(pkg.clientId).playerInfo.buffInfo.add(_buff.Type,_buff);
               }
               else
               {
                  RoomManager.Instance.current.findPlayerByID(pkg.clientId).playerInfo.buffInfo.remove(_buff.Type);
               }
               i++;
            }
            evt.stopImmediatePropagation();
         }
      }
      
      private function __waitGameFailed(evt:CrazyTankSocketEvent) : void
      {
         if(RoomManager.Instance.current)
         {
            RoomManager.Instance.current.pickupFailed();
         }
      }
      
      private function __waitGameRecv(evt:CrazyTankSocketEvent) : void
      {
         if(RoomManager.Instance.current)
         {
            RoomManager.Instance.current.startPickup();
         }
      }
      
      private function __waitCancel(evt:CrazyTankSocketEvent) : void
      {
         if(RoomManager.Instance.current)
         {
            RoomManager.Instance.current.cancelPickup();
         }
      }
      
      private function __addPlayerInRoom(evt:CrazyTankSocketEvent) : void
      {
         var pkg:* = null;
         var id:int = 0;
         var isInGame:Boolean = false;
         var pos:int = 0;
         var team:int = 0;
         var isFirstIn:Boolean = false;
         var level:int = 0;
         var ddtkingGrade:int = 0;
         var offer:int = 0;
         var hide:int = 0;
         var repute:int = 0;
         var speed:int = 0;
         var zoneID:int = 0;
         var enterNum:int = 0;
         var info:* = null;
         var unknown1:int = 0;
         var unknown2:int = 0;
         var count:int = 0;
         var j:int = 0;
         var place:int = 0;
         var p:* = null;
         var ptd:int = 0;
         var activedSkillCount:int = 0;
         var k:int = 0;
         var splace:int = 0;
         var sid:int = 0;
         var fpInfo:* = null;
         InviteManager.Instance.clearResponseInviteFrame();
         if(RoomManager.Instance.current)
         {
            pkg = evt.pkg;
            id = pkg.clientId;
            isInGame = pkg.readBoolean();
            pos = pkg.readByte();
            team = pkg.readByte();
            isFirstIn = pkg.readBoolean();
            level = pkg.readInt();
            ddtkingGrade = pkg.readInt();
            offer = pkg.readInt();
            hide = pkg.readInt();
            repute = pkg.readInt();
            speed = pkg.readInt();
            zoneID = pkg.readInt();
            enterNum = pkg.readInt();
            if(id != PlayerManager.Instance.Self.ID)
            {
               info = PlayerManager.Instance.findPlayer(id);
               info.beginChanges();
               info.ID = pkg.readInt();
               info.NickName = pkg.readUTF();
               info.typeVIP = pkg.readByte();
               info.VIPLevel = pkg.readInt();
               info.Sex = pkg.readBoolean();
               info.Style = pkg.readUTF();
               info.Colors = pkg.readUTF();
               info.Skin = pkg.readUTF();
               info.WeaponID = pkg.readInt();
               info.DeputyWeaponID = pkg.readInt();
               info.Repute = repute;
               info.Grade = level;
               info.ddtKingGrade = ddtkingGrade;
               info.Offer = offer;
               info.Hide = hide;
               info.ConsortiaID = pkg.readInt();
               info.ConsortiaName = pkg.readUTF();
               info.badgeID = pkg.readInt();
               info.WinCount = pkg.readInt();
               info.TotalCount = pkg.readInt();
               info.EscapeCount = pkg.readInt();
               unknown1 = pkg.readInt();
               unknown2 = pkg.readInt();
               info.IsMarried = pkg.readBoolean();
               if(info.IsMarried)
               {
                  info.SpouseID = pkg.readInt();
                  info.SpouseName = pkg.readUTF();
               }
               else
               {
                  info.SpouseID = 0;
                  info.SpouseName = "";
               }
               info.LoginName = pkg.readUTF();
               info.Nimbus = pkg.readInt();
               info.FightPower = pkg.readInt();
               info.apprenticeshipState = pkg.readInt();
               info.masterID = pkg.readInt();
               info.setMasterOrApprentices(pkg.readUTF());
               info.graduatesCount = pkg.readInt();
               info.honourOfMaster = pkg.readUTF();
               info.DailyLeagueFirst = pkg.readBoolean();
               info.DailyLeagueLastScore = pkg.readInt();
               info.guardCoreID = pkg.readInt();
               info.isOld = pkg.readBoolean();
               count = pkg.readInt();
               for(j = 0; j < count; )
               {
                  place = pkg.readInt();
                  p = info.pets[place];
                  ptd = pkg.readInt();
                  if(p == null)
                  {
                     p = new PetInfo();
                     p.TemplateID = ptd;
                     PetInfoManager.fillPetInfo(p);
                  }
                  p.ID = pkg.readInt();
                  p.Name = pkg.readUTF();
                  p.UserID = pkg.readInt();
                  p.Level = pkg.readInt();
                  p.IsEquip = true;
                  p.clearEquipedSkills();
                  activedSkillCount = pkg.readInt();
                  for(k = 0; k < activedSkillCount; )
                  {
                     splace = pkg.readInt();
                     sid = pkg.readInt();
                     p.equipdSkills.add(splace,sid);
                     k++;
                  }
                  p.Place = place;
                  info.pets.add(p.Place,p);
                  j++;
               }
               info.curcentRoomBordenTemplateId = pkg.readInt();
               info.commitChanges();
            }
            else
            {
               info = PlayerManager.Instance.Self;
            }
            info.ZoneID = zoneID;
            info.activityTanabataNum = enterNum;
            if(GameControl.Instance.Current != null)
            {
               fpInfo = GameControl.Instance.Current.findRoomPlayer(id,zoneID);
            }
            if(fpInfo == null)
            {
               fpInfo = new RoomPlayer(info);
            }
            fpInfo.isFirstIn = isFirstIn;
            fpInfo.place = pos;
            fpInfo.team = team;
            fpInfo.webSpeedInfo.delay = speed;
            RoomManager.Instance.current.addPlayer(fpInfo);
            if(fpInfo.isSelf && RoomManager.Instance.current && !_isShowGameLoading)
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
                  else if(RoomManager.Instance.current.type == 70)
                  {
                     StateManager.setState("dreamLandRoom");
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
      
      private function __removePlayerInRoom(evt:CrazyTankSocketEvent) : void
      {
         var id:int = 0;
         var zoneID:int = 0;
         var info:* = null;
         var bossState:int = 0;
         CampBattleManager.instance.isFighting = false;
         if(RoomManager.Instance.current)
         {
            id = evt.pkg.clientId;
            zoneID = evt.pkg.readInt();
            info = RoomManager.Instance.current.findPlayerByID(id,zoneID);
            if(info && info.isSelf)
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
               else if(StateManager.currentStateType == "dreamLandRoom")
               {
                  StateManager.setState("main");
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
                        bossState = DemonChiYouManager.instance.model.bossState;
                        if(bossState == 2)
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
                  GameControl.Instance.Current.removeRoomPlayer(zoneID,id);
                  GameControl.Instance.Current.removeGamePlayerByPlayerID(zoneID,id);
               }
               RoomManager.Instance.current.removePlayer(zoneID,id);
            }
            RoomManager.Instance.dispatchEvent(new Event("PlayerRoomExit"));
         }
         _isSingleBattleAndForcedExit = false;
         GameLoadingManager.Instance.hide();
      }
      
      protected function __forcedExitHandler(event:Event) : void
      {
         _isSingleBattleAndForcedExit = true;
      }
   }
}
