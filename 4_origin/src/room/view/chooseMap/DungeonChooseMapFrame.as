package room.view.chooseMap
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.BagInfo;
   import ddt.data.map.DungeonInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import kingBless.KingBlessManager;
   import room.RoomManager;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   import trainer.view.NewHandContainer;
   
   public class DungeonChooseMapFrame extends Sprite implements Disposeable
   {
       
      
      private var _frame:BaseAlerFrame;
      
      private var _view:DungeonChooseMapView;
      
      private var _timeTimer:TimerJuggler;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _alert:BaseAlerFrame;
      
      private var _selfInfo:SelfInfo;
      
      private var _voucherAlert:BaseAlerFrame;
      
      public function DungeonChooseMapFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("asset.ddtdungeonRoom.ChooseMap.Frame");
         addChild(_frame);
         var _loc1_:AlertInfo = new AlertInfo();
         _loc1_.title = LanguageMgr.GetTranslation("tank.room.RoomIIMapSetPanel.room");
         _loc1_.submitLabel = LanguageMgr.GetTranslation("ok");
         _loc1_.showCancel = false;
         _loc1_.moveEnable = false;
         _frame.info = _loc1_;
         _view = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.dungeonChooseMapView");
         _frame.addToContent(_view);
      }
      
      private function initEvent() : void
      {
         _frame.addEventListener("response",__responeHandler);
         MapManager.Instance.addEventListener("updateActivePveInfo",onUpdateActivePveInfo);
         GameInSocketOut.sendGetActivePveInfo();
         _timeTimer = TimerManager.getInstance().addTimerJuggler(10000);
         _timeTimer.addEventListener("timer",__timeHandler);
         _timeTimer.start();
      }
      
      private function __timeHandler(param1:Event) : void
      {
         var _loc3_:Number = TimeManager.Instance.Now().time;
         var _loc2_:Boolean = MapManager.Instance.checkActiveAndSigleDic(MapManager.Instance.activeDoubleDic,_loc3_);
         if(!_loc2_)
         {
            _loc2_ = MapManager.Instance.checkActiveAndSigleDic(MapManager.Instance.singleDoubleDic,_loc3_);
         }
         if(_loc2_ && _view)
         {
            _view.updateActityAndSingleView();
         }
      }
      
      private function onUpdateActivePveInfo(param1:CEvent) : void
      {
         if(_view)
         {
            _view.updateActityAndSingleView();
            _view.checkSelectItemAndLevel();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         if(!PlayerManager.Instance.Self.isDungeonGuideFinish(122))
         {
            NewHandContainer.Instance.showArrow(130,0,"guide.dungeon.step3ArrowPos","asset.trainer.dungeonGuide3Txt","guide.dungeon.step3TipPos",LayerManager.Instance.getLayerByType(2));
         }
      }
      
      private function __responeHandler(param1:FrameEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         NewHandContainer.Instance.clearArrowByID(-1);
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
         else if(param1.responseCode == 3)
         {
            SoundManager.instance.play("008");
            if(_view.checkState())
            {
               _loc3_ = MapManager.getDungeonInfo(_view.selectedMapID);
               if(_view.selectedMapID == 70020)
               {
                  openDesert();
                  return;
               }
               if(_view.select)
               {
                  if(KingBlessManager.instance.getOneBuffData(5) > 0 && _view.selectedMapID != 27 && _view.selectedMapID != 30)
                  {
                     if(PlayerManager.Instance.Self.bagLocked)
                     {
                        BaglockedManager.Instance.show();
                        return;
                     }
                     doOpenBossRoom();
                  }
                  else
                  {
                     showAlert();
                  }
               }
               else
               {
                  if(_loc3_.Type == 6)
                  {
                     GameInSocketOut.sendGameRoomSetUp(_view.selectedMapID,11,false,_view.roomPass,_view.roomName,1,_view.selectedLevel,0,false,0);
                  }
                  else if(MapManager.PVE_ADVANCED_MAP.indexOf(_loc3_.ID) != -1)
                  {
                     GameInSocketOut.sendGameRoomSetUp(_view.selectedMapID,4,false,_view.roomPass,_view.roomName,1,_view.selectedLevel,0,false,0);
                  }
                  else if(_loc3_.Type == 21 && _loc3_.ID == 70001)
                  {
                     GameInSocketOut.sendGameRoomSetUp(_view.selectedMapID,21,false,_view.roomPass,_view.roomName,1,_view.selectedLevel,0,false,0);
                  }
                  else if(_loc3_.Type == 23 || _loc3_.Type == 47 || _loc3_.Type == 48)
                  {
                     if(_loc3_.Type == 47)
                     {
                        _loc4_ = 47;
                     }
                     else if(_loc3_.Type == 48)
                     {
                        _loc4_ = 48;
                     }
                     else
                     {
                        _loc4_ = _loc3_.Type;
                     }
                     GameInSocketOut.sendGameRoomSetUp(_view.selectedMapID,_loc4_,false,_view.roomPass,_view.roomName,1,_view.selectedLevel,0,false,0);
                  }
                  else if(_loc3_.Type == 24)
                  {
                     GameInSocketOut.sendGameRoomSetUp(_view.selectedMapID,123,false,_view.roomPass,_view.roomName,1,_view.selectedLevel,0,false,0);
                  }
                  else
                  {
                     if(MapManager.Instance.singleDoubleIds.indexOf(_view.selectedMapID) != -1)
                     {
                        _loc2_ = RoomManager.Instance.current.currentPlayerCount;
                        if(_loc2_ > 1)
                        {
                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.singleDungeonMaxPlayerLimitMsg",_loc2_));
                           return;
                        }
                     }
                     GameInSocketOut.sendGameRoomSetUp(_view.selectedMapID,4,false,_view.roomPass,_view.roomName,1,_view.selectedLevel,0,false,0,false,7);
                  }
                  RoomManager.Instance.current.roomName = _view.roomName;
                  RoomManager.Instance.current.roomPass = _view.roomPass;
                  RoomManager.Instance.current.dungeonType = _view.selectedDungeonType;
                  dispose();
                  if(!PlayerManager.Instance.Self.isDungeonGuideFinish(122))
                  {
                     NoviceDataManager.instance.saveNoviceData(1050,PathManager.userName(),PathManager.solveRequestPath());
                     SocketManager.Instance.out.syncWeakStep(122);
                     NewHandContainer.Instance.clearArrowByID(130);
                  }
                  if(!PlayerManager.Instance.Self.isDungeonGuideFinish(123))
                  {
                     NewHandContainer.Instance.showArrow(130,-45,"trainer.startGameArrowPos","asset.trainer.startGameTipAsset","trainer.startGameTipPos",LayerManager.Instance.getLayerByType(2));
                  }
               }
            }
         }
      }
      
      private function openDesert() : void
      {
         var _loc4_:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:int = ServerConfigManager.instance.getDesertFreeEnterCount();
         var _loc3_:int = ServerConfigManager.instance.getDesertFeeEnterCount();
         var _loc1_:int = PlayerManager.Instance.Self.desertEnterCount;
         if(_loc1_ < _loc2_)
         {
            GameInSocketOut.sendGameRoomSetUp(_view.selectedMapID,4,false,_view.roomPass,_view.roomName,1,_view.selectedLevel,0,false,0);
            dispose();
         }
         else if(_loc1_ >= _loc2_ && _loc1_ < _loc2_ + _loc3_)
         {
            _loc4_ = LanguageMgr.GetTranslation("ddt.dungeonRoom.enterDesertMsg");
            _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc4_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SimpleAlert",30,true,0);
            _confirmFrame.moveEnable = false;
            _confirmFrame.addEventListener("response",__confirmBuySpirit);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.dungeonRoom.enterDesertMsgII"));
         }
      }
      
      private function __confirmBuySpirit(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",__confirmBuySpirit);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(param1.currentTarget.isBand,2000,onCheckComplete);
            _confirmFrame.dispose();
            _confirmFrame = null;
         }
      }
      
      protected function onCheckComplete() : void
      {
         GameInSocketOut.sendGameRoomSetUp(_view.selectedMapID,4,false,_view.roomPass,_view.roomName,1,_view.selectedLevel,0,false,0,CheckMoneyUtils.instance.isBind);
         dispose();
      }
      
      private function getPrice() : String
      {
         var _loc3_:Array = [];
         var _loc1_:String = "";
         var _loc2_:String = MapManager.getDungeonInfo(_view.selectedMapID).BossFightNeedMoney;
         if(_loc2_)
         {
            _loc3_ = _loc2_.split("|");
         }
         if(_loc3_ && _loc3_.length > 0)
         {
            switch(int(_view.selectedLevel))
            {
               case 0:
                  _loc1_ = _loc3_[0];
                  break;
               case 1:
                  _loc1_ = _loc3_[1];
                  break;
               case 2:
                  _loc1_ = _loc3_[2];
                  break;
               case 3:
                  _loc1_ = _loc3_[3];
                  break;
               case 4:
                  _loc1_ = _loc3_[4];
                  break;
               case 5:
                  _loc1_ = _loc3_[5];
            }
         }
         return _loc1_;
      }
      
      private function showAlert() : void
      {
         if(_alert == null)
         {
            _alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.room.openBossTip.text",getPrice(),getName()),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            _alert.moveEnable = false;
            _alert.addEventListener("response",__alertResponse);
         }
      }
      
      private function getName() : String
      {
         var _loc1_:String = "";
         if(_view.selectedMapID == 27 || _view.selectedMapID == 30)
         {
            _loc1_ = ItemManager.Instance.getTemplateById(12578).Name;
         }
         else
         {
            _loc1_ = ItemManager.Instance.getTemplateById(201531).Name;
         }
         return _loc1_;
      }
      
      private function disposeAlert() : void
      {
         if(_alert)
         {
            _alert.removeEventListener("response",__alertResponse);
            ObjectUtils.disposeObject(_alert);
            _alert.dispose();
         }
         _alert = null;
      }
      
      private function __alertResponse(param1:FrameEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               disposeAlert();
               break;
            case 2:
            case 3:
            case 4:
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  return;
               }
               _selfInfo = PlayerManager.Instance.Self;
               _loc3_ = _selfInfo.getBag(1);
               if(_view.selectedMapID == 27 || _view.selectedMapID == 30)
               {
                  _loc2_ = 12578;
               }
               else
               {
                  _loc2_ = 201531;
               }
               _loc4_ = _loc3_.getItemCountByTemplateId(_loc2_);
               if(_loc4_ < Number(getPrice()))
               {
                  showVoucherAlert();
               }
               else
               {
                  doOpenBossRoom();
               }
               break;
         }
      }
      
      private function doOpenBossRoom() : void
      {
         if(_view.selectedMapID == 27 || _view.selectedMapID == 30)
         {
            GameInSocketOut.sendGameRoomSetUp(_view.selectedMapID,123,true,_view.roomPass,_view.roomName,1,_view.selectedLevel,0,false,_view.selectedMapID);
         }
         else
         {
            GameInSocketOut.sendGameRoomSetUp(_view.selectedMapID,4,true,_view.roomPass,_view.roomName,1,_view.selectedLevel,0,false,_view.selectedMapID);
         }
         RoomManager.Instance.current.roomName = _view.roomName;
         RoomManager.Instance.current.roomPass = _view.roomPass;
         RoomManager.Instance.current.dungeonType = _view.selectedDungeonType;
         dispose();
      }
      
      private function showVoucherAlert() : void
      {
         if(_voucherAlert == null)
         {
            _voucherAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("dungeonChooseMapGoods"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
            _voucherAlert.addEventListener("response",__onNoMoneyResponse);
         }
      }
      
      private function disposeVoucherAlert() : void
      {
         disposeAlert();
         if(_voucherAlert)
         {
            _voucherAlert.removeEventListener("response",__onNoMoneyResponse);
            _voucherAlert.disposeChildren = true;
            _voucherAlert.dispose();
            _voucherAlert = null;
         }
      }
      
      private function __onNoMoneyResponse(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         disposeVoucherAlert();
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _loc2_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            if(_view.selectedMapID == 27 || _view.selectedMapID == 30)
            {
               _loc2_.itemID = 12578;
            }
            else
            {
               _loc2_.itemID = 201531;
            }
            LayerManager.Instance.addToLayer(_loc2_,2,true,1);
         }
      }
      
      private function removeEvent() : void
      {
         _frame.removeEventListener("response",__responeHandler);
         MapManager.Instance.removeEventListener("updateActivePveInfo",onUpdateActivePveInfo);
         if(_timeTimer)
         {
            _timeTimer.stop();
            _timeTimer.removeEventListener("timer",__timeHandler);
            TimerManager.getInstance().removeJugglerByTimer(_timeTimer);
            _timeTimer = null;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         disposeAlert();
         disposeVoucherAlert();
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
         if(_view)
         {
            _view.dispose();
            _view = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
