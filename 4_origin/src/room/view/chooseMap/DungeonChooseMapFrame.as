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
         var alertInfo:AlertInfo = new AlertInfo();
         alertInfo.title = LanguageMgr.GetTranslation("tank.room.RoomIIMapSetPanel.room");
         alertInfo.submitLabel = LanguageMgr.GetTranslation("ok");
         alertInfo.showCancel = false;
         alertInfo.moveEnable = false;
         _frame.info = alertInfo;
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
      
      private function __timeHandler(evt:Event) : void
      {
         var nowTime:Number = TimeManager.Instance.Now().time;
         var bool:Boolean = MapManager.Instance.checkActiveAndSigleDic(MapManager.Instance.activeDoubleDic,nowTime);
         if(!bool)
         {
            bool = MapManager.Instance.checkActiveAndSigleDic(MapManager.Instance.singleDoubleDic,nowTime);
         }
         if(bool && _view)
         {
            _view.updateActityAndSingleView();
         }
      }
      
      private function onUpdateActivePveInfo(event:CEvent) : void
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
      
      private function __responeHandler(evt:FrameEvent) : void
      {
         var dungeon:* = null;
         var type:int = 0;
         var currentPlayerCount:int = 0;
         NewHandContainer.Instance.clearArrowByID(-1);
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
         else if(evt.responseCode == 3)
         {
            SoundManager.instance.play("008");
            if(_view.checkState())
            {
               dungeon = MapManager.getDungeonInfo(_view.selectedMapID);
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
                  if(dungeon.Type == 6)
                  {
                     GameInSocketOut.sendGameRoomSetUp(_view.selectedMapID,11,false,_view.roomPass,_view.roomName,1,_view.selectedLevel,0,false,0);
                  }
                  else if(MapManager.PVE_ADVANCED_MAP.indexOf(dungeon.ID) != -1)
                  {
                     GameInSocketOut.sendGameRoomSetUp(_view.selectedMapID,4,false,_view.roomPass,_view.roomName,1,_view.selectedLevel,0,false,0);
                  }
                  else if(dungeon.Type == 21 && dungeon.ID == 70001)
                  {
                     GameInSocketOut.sendGameRoomSetUp(_view.selectedMapID,21,false,_view.roomPass,_view.roomName,1,_view.selectedLevel,0,false,0);
                  }
                  else if(dungeon.Type == 23 || dungeon.Type == 47 || dungeon.Type == 48)
                  {
                     if(dungeon.Type == 47)
                     {
                        type = 47;
                     }
                     else if(dungeon.Type == 48)
                     {
                        type = 48;
                     }
                     else
                     {
                        type = dungeon.Type;
                     }
                     GameInSocketOut.sendGameRoomSetUp(_view.selectedMapID,type,false,_view.roomPass,_view.roomName,1,_view.selectedLevel,0,false,0);
                  }
                  else if(dungeon.Type == 24)
                  {
                     GameInSocketOut.sendGameRoomSetUp(_view.selectedMapID,123,false,_view.roomPass,_view.roomName,1,_view.selectedLevel,0,false,0);
                  }
                  else
                  {
                     if(MapManager.Instance.singleDoubleIds.indexOf(_view.selectedMapID) != -1)
                     {
                        currentPlayerCount = RoomManager.Instance.current.currentPlayerCount;
                        if(currentPlayerCount > 1)
                        {
                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.singleDungeonMaxPlayerLimitMsg",currentPlayerCount));
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
         var msg:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var freeCount:int = ServerConfigManager.instance.getDesertFreeEnterCount();
         var feeCount:int = ServerConfigManager.instance.getDesertFeeEnterCount();
         var currentCount:int = PlayerManager.Instance.Self.desertEnterCount;
         if(currentCount < freeCount)
         {
            GameInSocketOut.sendGameRoomSetUp(_view.selectedMapID,4,false,_view.roomPass,_view.roomName,1,_view.selectedLevel,0,false,0);
            dispose();
         }
         else if(currentCount >= freeCount && currentCount < freeCount + feeCount)
         {
            msg = LanguageMgr.GetTranslation("ddt.dungeonRoom.enterDesertMsg");
            _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SimpleAlert",30,true,0);
            _confirmFrame.moveEnable = false;
            _confirmFrame.addEventListener("response",__confirmBuySpirit);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.dungeonRoom.enterDesertMsgII"));
         }
      }
      
      private function __confirmBuySpirit(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",__confirmBuySpirit);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(evt.currentTarget.isBand,2000,onCheckComplete);
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
         var arr:Array = [];
         var price:String = "";
         var str:String = MapManager.getDungeonInfo(_view.selectedMapID).BossFightNeedMoney;
         if(str)
         {
            arr = str.split("|");
         }
         if(arr && arr.length > 0)
         {
            switch(int(_view.selectedLevel))
            {
               case 0:
                  price = arr[0];
                  break;
               case 1:
                  price = arr[1];
                  break;
               case 2:
                  price = arr[2];
                  break;
               case 3:
                  price = arr[3];
                  break;
               case 4:
                  price = arr[4];
                  break;
               case 5:
                  price = arr[5];
            }
         }
         return price;
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
         var name:String = "";
         if(_view.selectedMapID == 27 || _view.selectedMapID == 30)
         {
            name = ItemManager.Instance.getTemplateById(12578).Name;
         }
         else
         {
            name = ItemManager.Instance.getTemplateById(201531).Name;
         }
         return name;
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
      
      private function __alertResponse(evt:FrameEvent) : void
      {
         var bagInfo:* = null;
         var id:int = 0;
         var count:int = 0;
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
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
               bagInfo = _selfInfo.getBag(1);
               if(_view.selectedMapID == 27 || _view.selectedMapID == 30)
               {
                  id = 12578;
               }
               else
               {
                  id = 201531;
               }
               count = bagInfo.getItemCountByTemplateId(id);
               if(count < Number(getPrice()))
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
      
      private function __onNoMoneyResponse(e:FrameEvent) : void
      {
         var _quick:* = null;
         SoundManager.instance.play("008");
         disposeVoucherAlert();
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            _quick = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            if(_view.selectedMapID == 27 || _view.selectedMapID == 30)
            {
               _quick.itemID = 12578;
            }
            else
            {
               _quick.itemID = 201531;
            }
            LayerManager.Instance.addToLayer(_quick,2,true,1);
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
