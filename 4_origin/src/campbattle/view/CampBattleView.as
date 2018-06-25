package campbattle.view
{
   import campbattle.CampBattleControl;
   import campbattle.CampBattleManager;
   import campbattle.data.CampModel;
   import campbattle.data.RoleData;
   import campbattle.event.MapEvent;
   import campbattle.view.awardsView.AwardsViewFrame;
   import campbattle.view.rank.ScoreRankView;
   import campbattle.view.roleView.CampBattlePlayer;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.ChatView;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import gameCommon.model.SmallEnemy;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class CampBattleView extends BaseStateView
   {
       
      
      private var _mapID:int;
      
      private var _mapLayer:Sprite;
      
      private var _uiLayer:Sprite;
      
      private var _headView:HeadInfoView;
      
      private var _titleView:CampBattleTitle;
      
      private var _backBtn:CampBattleReturnBtn;
      
      private var _smallMap:Bitmap;
      
      private var _mapView:CampBattleMap;
      
      private var _campLight:Bitmap;
      
      private var _progressBar:CampProgress;
      
      private var _statueBtn:CampStatueBtn;
      
      private var _clickDoor:ClickDoor;
      
      private var _battleTimer:CampBattleInTimer;
      
      private var _chatView:ChatView;
      
      private var _hideBtn:CampStateHideBtn;
      
      private var _helpBtn:BaseButton;
      
      private var _rankView:ScoreRankView;
      
      private var _itemList:Array;
      
      private var _awardsBtn:BaseButton;
      
      public function CampBattleView()
      {
         super();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         super.enter(prev,data);
         _mapID = int(data);
         CampBattleManager.instance.mapID = _mapID;
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         _mapLayer = new Sprite();
         addChild(_mapLayer);
         _uiLayer = new Sprite();
         addChild(_uiLayer);
      }
      
      private function initView() : void
      {
         _headView = new HeadInfoView(PlayerManager.Instance.Self);
         _uiLayer.addChild(_headView);
         _titleView = new CampBattleTitle();
         _uiLayer.addChild(_titleView);
         _titleView.setTitleTxt2(CampBattleControl.instance.model.captureName);
         _titleView.setTitleTxt4(CampBattleControl.instance.model.winCount.toString());
         _battleTimer = new CampBattleInTimer();
         _uiLayer.addChild(_battleTimer);
         _backBtn = new CampBattleReturnBtn();
         PositionUtils.setPos(_backBtn,"ddtCampBattle.views.returnBtnPos");
         _uiLayer.addChild(_backBtn);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("stateMap.texpSystem.btnHelp");
         addChild(_helpBtn);
         _hideBtn = new CampStateHideBtn();
         PositionUtils.setPos(_hideBtn,"ddtCampBattle.views.hideBtnPos");
         _hideBtn.visible = _mapID > 0?false:true;
         _hideBtn.turnMC();
         addChild(_hideBtn);
         _rankView = new ScoreRankView();
         PositionUtils.setPos(_rankView,"ddtCampBattle.views.rankViewPos");
         addChild(_rankView);
         _awardsBtn = ComponentFactory.Instance.creat("ddtCampBattle.awardsBtn");
         addChild(_awardsBtn);
         createBg();
         addChatView();
         if(_mapID == 0 && CampBattleManager.instance.awardsFrameView)
         {
            CampBattleManager.instance.awardsFrameView = false;
            __onClickAwardsBtn();
            _mapView.hideRoles(_hideBtn.isHide);
         }
      }
      
      public function changeMap(id:int) : void
      {
         _mapID = id;
         CampBattleManager.instance.mapID = _mapID;
         createBg();
      }
      
      private function createActItem() : void
      {
         _itemList = [];
         _progressBar = new CampProgress();
         PositionUtils.setPos(_progressBar,"ddtCampBattle.views.progressBarPos");
         _campLight = ComponentFactory.Instance.creat("camp.campBattle.light");
         if(CampBattleControl.instance.model.isCapture)
         {
            _progressBar.setCapture();
            if(CampBattleControl.instance.model.captureZoneID == PlayerManager.Instance.Self.ZoneID && CampBattleControl.instance.model.captureUserID == PlayerManager.Instance.Self.ID)
            {
               _campLight.visible = true;
            }
         }
         _statueBtn = new CampStatueBtn();
         PositionUtils.setPos(_statueBtn,"ddtCampBattle.views.statueBtnPos");
         _itemList.push(_campLight);
         _itemList.push(_statueBtn);
         _itemList.push(_progressBar);
      }
      
      private function initEvent() : void
      {
         _backBtn.returnBtn.addEventListener("click",__onBackBtnClick);
         _helpBtn.addEventListener("click",__onHelpBtnClick);
         _hideBtn.addEventListener("hidePlayer",__onHideBtnClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(146,7),__onMonsterStateChange);
         SocketManager.Instance.addEventListener(PkgEvent.format(146,2),__onRoleMoveHander);
         SocketManager.Instance.addEventListener(PkgEvent.format(146,17),__onCapMapHander);
         SocketManager.Instance.addEventListener(PkgEvent.format(146,4),__onAddMonstersList);
         SocketManager.Instance.addEventListener(PkgEvent.format(146,23),__onDoorstatus);
         CampBattleControl.instance.addEventListener("enter_fight",__onFighterHander);
         CampBattleControl.instance.addEventListener("to_other_map",__onToOhterMapHander);
         CampBattleControl.instance.addEventListener("capture_statue",__onCaptureMapHander);
         CampBattleControl.instance.addEventListener("statue_goto_fight",__onStatueGotoFightHander);
         CampBattleControl.instance.addEventListener("capture_over",__onCaptureOverHander);
         CampBattleControl.instance.addEventListener("goto_fight",__onGotoFightHander);
         CampBattleControl.instance.addEventListener("win_count_pvp",__onUpdateWinCount);
         CampBattleControl.instance.addEventListener("player_state_change",__onPlayerStateChange);
         CampBattleControl.instance.addEventListener("update_score",__onUpdateScoreHander);
         CampBattleControl.instance.addEventListener("add_role",__onAddRole);
         CampBattleControl.instance.addEventListener("remove_role",__onRemoveRole);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         addEventListener("enterFrame",__onEnterFrameHander);
         _awardsBtn.addEventListener("click",__onClickAwardsBtn);
      }
      
      private function __onClickAwardsBtn(evt:MouseEvent = null) : void
      {
         SoundManager.instance.play("008");
         var rewView:AwardsViewFrame = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.RewardView");
         LayerManager.Instance.addToLayer(rewView,3,true,1);
      }
      
      protected function __onAddRole(event:MapEvent) : void
      {
         _mapView.playerModel.add(event.data[0],event.data[1]);
      }
      
      protected function __onRemoveRole(event:MapEvent) : void
      {
         _mapView.playerModel.remove(event.data);
      }
      
      protected function __onUpdateWinCount(event:MapEvent) : void
      {
         if(_titleView)
         {
            _titleView.setTitleTxt4(CampBattleControl.instance.model.winCount.toString());
         }
      }
      
      private function __onDoorstatus(evt:PkgEvent) : void
      {
         CampBattleControl.instance.model.doorIsOpen = true;
         _clickDoor.doorStatus();
      }
      
      private function __onUpdateScoreHander(event:MapEvent) : void
      {
         _headView.updateScore(CampBattleControl.instance.model.myScore);
      }
      
      private function __onEnterFrameHander(event:Event) : void
      {
         var p:* = null;
         var mainRole:* = null;
         var fp:* = null;
         var disX:int = 0;
         var disY:int = 0;
         if(CampBattleControl.instance.model.isCapture)
         {
            p = new Point(1459,864);
            if(_mapView && _mapView.getMainRole())
            {
               mainRole = _mapView.getMainRole();
               fp = new Point(mainRole.x,mainRole.y);
               disX = Math.abs(fp.x - p.x);
               disY = Math.abs(fp.y - p.y);
               if(disX > 300 || disY > 200)
               {
                  if(mainRole.playerInfo.isCapture)
                  {
                     SocketManager.Instance.out.captureMap(false);
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.campBattle.outofCaptrue"));
                  }
               }
            }
         }
      }
      
      private function createBg() : void
      {
         if(CampBattleControl.instance.model.isShowResurrectView)
         {
            createRrsurrectView();
         }
         if(_mapID == 0)
         {
            _titleView.visible = false;
            _clickDoor = new ClickDoor();
            PositionUtils.setPos(_clickDoor,"ddtCampBattle.views.clickDoorPos");
            _smallMap = ComponentFactory.Instance.creat("campbattle.passSmall");
            creatMap("tank.campBattle.Map-1",CampBattleControl.PVE_MAPRESOURCEURL,CampBattleControl.instance.model.playerModel,CampBattleControl.instance.model.monsterList,[_clickDoor],_smallMap);
         }
         else if(_mapID == 1)
         {
            _titleView.visible = true;
            createActItem();
            _smallMap = ComponentFactory.Instance.creat("campbattle.pkSmall");
            creatMap("tank.campBattle.Map-2",CampBattleControl.PVP_MAPRESOURCEURL,CampBattleControl.instance.model.playerModel,CampBattleControl.instance.model.monsterList,_itemList,_smallMap);
         }
      }
      
      private function addChatView() : void
      {
         _chatView = ChatManager.Instance.view;
         addChild(_chatView);
         ChatManager.Instance.state = 0;
         ChatManager.Instance.setFocus();
         ChatManager.Instance.lock = true;
      }
      
      private function __onStatueGotoFightHander(event:MapEvent) : void
      {
         var p:Point = new Point(event.data[0],event.data[1]);
         var zoneID:int = CampBattleControl.instance.model.captureZoneID;
         var userID:int = CampBattleControl.instance.model.captureUserID;
         var mainRole:CampBattlePlayer = _mapView.getMainRole();
         if(_mapView.getCurrRole(zoneID,userID).playerInfo.team == mainRole.playerInfo.team)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.campBattle.statuCaptured"));
            return;
         }
         if(!mainRole.playerInfo.isDead)
         {
            _mapView.checkPonitDistance(p,SocketManager.Instance.out.enterPTPFight,userID,zoneID);
         }
      }
      
      private function creatMap(clsStr:String = null, resStr:String = null, playerModel:DictionaryData = null, monsterModel:DictionaryData = null, itemList:Array = null, smallMap:Bitmap = null) : void
      {
         _mapView = new CampBattleMap(clsStr,resStr,playerModel,monsterModel,itemList,smallMap);
         _mapLayer.addChild(_mapView);
      }
      
      private function __onGotoFightHander(event:MapEvent) : void
      {
         var p:Point = new Point(event.data[0],event.data[1]);
         var zoneID:int = event.data[2];
         var userID:int = event.data[3];
         if(_mapView.getMainRole())
         {
            if(!_mapView.getMainRole().playerInfo.isDead)
            {
               _mapView.checkPonitDistance(p,SocketManager.Instance.out.enterPTPFight,userID,zoneID);
            }
         }
      }
      
      private function __onCaptureMapHander(event:MapEvent) : void
      {
         var p:Point = new Point(event.data[0],event.data[1]);
         _mapView.checkPonitDistance(p,captureMap);
      }
      
      private function captureMap() : void
      {
         CampBattleControl.instance.dispatchEvent(new MapEvent("capture_start"));
      }
      
      private function __onCapMapHander(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var model:CampModel = CampBattleControl.instance.model;
         model.isCapture = pkg.readBoolean();
         model.captureZoneID = pkg.readInt();
         model.captureUserID = pkg.readInt();
         model.captureName = pkg.readUTF();
         if(model.captureName.length > 4)
         {
            model.captureName = model.captureName.replace(4,"......");
         }
         model.captureTeam = pkg.readInt();
         CampBattleControl.instance.dispatchEvent(new MapEvent("capture_over",[model.captureZoneID,model.captureUserID]));
         var role:RoleData = getRoleData(model.captureZoneID,model.captureUserID);
         if(role)
         {
            role.isCapture = model.isCapture;
         }
      }
      
      private function __onAddMonstersList(evt:PkgEvent) : void
      {
         var count:int = 0;
         var i:int = 0;
         var id:int = 0;
         var living:* = null;
         var str:* = null;
         var outPos:* = null;
         var npcID:int = 0;
         var pkg:PackageIn = evt.pkg;
         if(!CampBattleControl.instance.model.isFighting)
         {
            CampBattleControl.instance.model.monsterCount = pkg.readInt();
            count = pkg.readInt();
            for(i = 0; i < count; )
            {
               id = pkg.readInt();
               living = new SmallEnemy(id,2,1000);
               living.typeLiving = 2;
               living.actionMovieName = pkg.readUTF();
               str = pkg.readUTF();
               living.direction = 1;
               outPos = new Point(pkg.readInt(),pkg.readInt());
               living.name = "虫子";
               living.stateType = pkg.readInt();
               npcID = pkg.readInt();
               CampBattleControl.instance.model.monsterList.add(living.LivingID,living);
               if(npcID > 0)
               {
                  if(CampBattleControl.instance.model.monsterCount == 10)
                  {
                     living.pos = new Point(CampBattleControl.instance.model.monsterPosList[i][0],CampBattleControl.instance.model.monsterPosList[i][1]);
                  }
                  else
                  {
                     living.pos = outPos;
                  }
               }
               else
               {
                  living.pos = new Point(CampBattleControl.instance.model.monsterPosList[i][0],CampBattleControl.instance.model.monsterPosList[i][1]);
               }
               i++;
            }
            dispatchEvent(new MapEvent("pve_count"));
         }
      }
      
      private function __onCaptureOverHander(event:MapEvent) : void
      {
         var zoneID:int = event.data[0];
         var userID:int = event.data[1];
         if(CampBattleControl.instance.model.isCapture)
         {
            if(_titleView)
            {
               _titleView.setTitleTxt2(CampBattleControl.instance.model.captureName);
               _titleView.setTitleTxt4("0");
            }
            _statueBtn._arrowMc.stop();
            _statueBtn._arrowMc.visible = false;
         }
         else if(_titleView)
         {
            _titleView.setTitleTxt2(LanguageMgr.GetTranslation("ddt.campBattle.NOcapture"));
            _titleView.setTitleTxt4("0");
         }
         var otherPlayer:CampBattlePlayer = _mapView.getCurrRole(zoneID,userID);
         if(otherPlayer)
         {
            otherPlayer.setCaptureVisible(CampBattleControl.instance.model.isCapture);
         }
         var selfPlayer:CampBattlePlayer = CampBattlePlayer(_mapView.getMainRole());
         if(selfPlayer)
         {
            if(selfPlayer.playerInfo.zoneID == zoneID && selfPlayer.playerInfo.ID == userID)
            {
               _campLight.visible = CampBattleControl.instance.model.isCapture;
            }
         }
      }
      
      private function __onRoleMoveHander(event:PkgEvent) : void
      {
         var x:int = 0;
         var y:int = 0;
         var zoneID:int = 0;
         var userID:int = 0;
         var role:* = null;
         var p:* = null;
         var pkg:PackageIn = event.pkg;
         if(!CampBattleControl.instance.model.isFighting)
         {
            x = pkg.readInt();
            y = pkg.readInt();
            zoneID = pkg.readInt();
            userID = pkg.readInt();
            role = getRoleData(zoneID,userID);
            if(role)
            {
               role.posX = x;
               role.posY = y;
               role.stateType = 1;
               if(PlayerManager.Instance.Self.ZoneID == zoneID && PlayerManager.Instance.Self.ID == userID)
               {
                  return;
               }
               p = new Point(x,y);
               _mapView.roleMoves(zoneID,userID,p);
            }
         }
      }
      
      private function __onToOhterMapHander(event:MapEvent) : void
      {
         var p:Point = new Point(event.data[0],event.data[1]);
         if(!_mapView.getMainRole().playerInfo.isDead)
         {
            _mapView.checkPonitDistance(p,SocketManager.Instance.out.changeMap);
         }
      }
      
      private function __onPlayerStateChange(evt:MapEvent) : void
      {
         _mapView.setRoleState(evt.data[0],evt.data[1],evt.data[2]);
      }
      
      private function __onMonsterStateChange(evt:PkgEvent) : void
      {
         var monsterID:int = 0;
         var type:int = 0;
         var pkg:PackageIn = evt.pkg;
         if(!CampBattleControl.instance.model.isFighting)
         {
            monsterID = pkg.readInt();
            type = pkg.readInt();
            if(type == 4)
            {
               CampBattleControl.instance.model.monsterList.remove(monsterID);
            }
            else
            {
               _mapView.setMonsterState(monsterID,type);
            }
         }
      }
      
      private function getRoleData(zoneID:int, userID:int) : RoleData
      {
         var key:String = zoneID + "_" + userID;
         var data:RoleData = null;
         if(CampBattleControl.instance.model.playerModel)
         {
            data = CampBattleControl.instance.model.playerModel[key];
         }
         return data;
      }
      
      private function createRrsurrectView() : void
      {
         CampBattleControl.instance.model.isShowResurrectView = false;
         var _resurrectView:CampBattleResurrectView = new CampBattleResurrectView(CampBattleControl.instance.model.liveTime);
         _resurrectView.addEventListener("complete",__onResurrectHandler,false,0,true);
         LayerManager.Instance.addToLayer(_resurrectView,3,true);
      }
      
      private function __onResurrectHandler(event:Event) : void
      {
         var _resurrectView:CampBattleResurrectView = event.currentTarget as CampBattleResurrectView;
         if(_resurrectView)
         {
            _resurrectView.removeEventListener("complete",__onResurrectHandler);
            _resurrectView.dispose();
            _resurrectView = null;
         }
         SocketManager.Instance.out.resurrect(false,false);
         _mapView.setRoleState(PlayerManager.Instance.Self.ZoneID,PlayerManager.Instance.Self.ID,1);
      }
      
      private function __startLoading(e:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      protected function __onFighterHander(event:MapEvent) : void
      {
         var p:Point = new Point(event.data[0],event.data[1]);
         var id:int = event.data[2];
         if(!_mapView || !_mapView.getMainRole() || !_mapView.getMainRole().playerInfo || _mapView.getMainRole().playerInfo.isDead)
         {
            return;
         }
         _mapView.checkPonitDistance(p,SocketManager.Instance.out.CampbattleEnterFight,id);
      }
      
      protected function __onHideBtnClick(event:Event) : void
      {
         SoundManager.instance.playButtonSound();
         _mapView.hideRoles(_hideBtn.isHide);
      }
      
      protected function __onHelpBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var helpframe:CampBattleHelpView = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.views.helpView");
         helpframe.addEventListener("response",frameEvent);
         LayerManager.Instance.addToLayer(helpframe,3,true,1);
      }
      
      private function frameEvent(event:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         event.currentTarget.removeEventListener("response",frameEvent);
         event.currentTarget.dispose();
      }
      
      protected function __onBackBtnClick(event:MouseEvent) : void
      {
         var msg:String = LanguageMgr.GetTranslation("ddt.campBattle.outCampBattle");
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SimpleAlert",30,true);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",__onConfirm);
      }
      
      protected function __onConfirm(event:FrameEvent) : void
      {
         var confirmFrame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            SocketManager.Instance.out.outCampBatttle();
            StateManager.setState("main");
         }
         confirmFrame.dispose();
         confirmFrame = null;
      }
      
      override public function getType() : String
      {
         return "campBattleScene";
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         dispose();
         super.dispose();
      }
      
      private function removeEvent() : void
      {
         _backBtn.returnBtn.removeEventListener("click",__onBackBtnClick);
         _helpBtn.removeEventListener("click",__onHelpBtnClick);
         _hideBtn.removeEventListener("hidePlayer",__onHideBtnClick);
         SocketManager.Instance.removeEventListener(PkgEvent.format(146,7),__onMonsterStateChange);
         SocketManager.Instance.removeEventListener(PkgEvent.format(146,2),__onRoleMoveHander);
         SocketManager.Instance.removeEventListener(PkgEvent.format(146,17),__onCapMapHander);
         SocketManager.Instance.removeEventListener(PkgEvent.format(146,4),__onAddMonstersList);
         SocketManager.Instance.removeEventListener(PkgEvent.format(146,23),__onDoorstatus);
         CampBattleControl.instance.removeEventListener("enter_fight",__onFighterHander);
         CampBattleControl.instance.removeEventListener("to_other_map",__onToOhterMapHander);
         CampBattleControl.instance.removeEventListener("capture_statue",__onCaptureMapHander);
         CampBattleControl.instance.removeEventListener("statue_goto_fight",__onStatueGotoFightHander);
         CampBattleControl.instance.removeEventListener("capture_over",__onCaptureOverHander);
         CampBattleControl.instance.removeEventListener("goto_fight",__onGotoFightHander);
         CampBattleControl.instance.removeEventListener("win_count_pvp",__onUpdateWinCount);
         CampBattleControl.instance.removeEventListener("player_state_change",__onPlayerStateChange);
         CampBattleControl.instance.removeEventListener("update_score",__onUpdateScoreHander);
         CampBattleControl.instance.removeEventListener("add_role",__onAddRole);
         CampBattleControl.instance.removeEventListener("remove_role",__onRemoveRole);
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         removeEventListener("enterFrame",__onEnterFrameHander);
         _awardsBtn.removeEventListener("click",__onClickAwardsBtn);
      }
      
      private function removeMap() : void
      {
         if(_smallMap)
         {
            _smallMap.bitmapData.dispose();
         }
         _smallMap = null;
         if(_mapView)
         {
            _mapView.dispose();
         }
         _mapView = null;
         if(_clickDoor)
         {
            _clickDoor.dispose();
         }
         _clickDoor = null;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         removeMap();
         if(_campLight)
         {
            _campLight.bitmapData.dispose();
         }
         _campLight = null;
         if(_headView)
         {
            _headView.dispose();
         }
         _headView = null;
         if(_titleView)
         {
            _titleView.dispose();
         }
         _titleView = null;
         if(_backBtn)
         {
            _backBtn.dispose();
         }
         _backBtn = null;
         if(_progressBar)
         {
            _progressBar.dispose();
         }
         _progressBar = null;
         if(_statueBtn)
         {
            _statueBtn.dispose();
         }
         _statueBtn = null;
         if(_battleTimer)
         {
            _battleTimer.dispose();
         }
         _battleTimer = null;
         if(_helpBtn)
         {
            _helpBtn.dispose();
         }
         _helpBtn = null;
         if(_hideBtn)
         {
            _hideBtn.dispose();
         }
         _hideBtn = null;
         if(_rankView)
         {
            _rankView.dispose();
         }
         _rankView = null;
         if(_mapLayer)
         {
            _mapLayer = null;
         }
         if(_uiLayer)
         {
            _uiLayer = null;
         }
      }
   }
}
