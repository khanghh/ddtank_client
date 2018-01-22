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
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         _mapID = int(param2);
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
      
      public function changeMap(param1:int) : void
      {
         _mapID = param1;
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
      
      private function __onClickAwardsBtn(param1:MouseEvent = null) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:AwardsViewFrame = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.RewardView");
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      protected function __onAddRole(param1:MapEvent) : void
      {
         _mapView.playerModel.add(param1.data[0],param1.data[1]);
      }
      
      protected function __onRemoveRole(param1:MapEvent) : void
      {
         _mapView.playerModel.remove(param1.data);
      }
      
      protected function __onUpdateWinCount(param1:MapEvent) : void
      {
         if(_titleView)
         {
            _titleView.setTitleTxt4(CampBattleControl.instance.model.winCount.toString());
         }
      }
      
      private function __onDoorstatus(param1:PkgEvent) : void
      {
         CampBattleControl.instance.model.doorIsOpen = true;
         _clickDoor.doorStatus();
      }
      
      private function __onUpdateScoreHander(param1:MapEvent) : void
      {
         _headView.updateScore(CampBattleControl.instance.model.myScore);
      }
      
      private function __onEnterFrameHander(param1:Event) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(CampBattleControl.instance.model.isCapture)
         {
            _loc4_ = new Point(1459,864);
            if(_mapView && _mapView.getMainRole())
            {
               _loc5_ = _mapView.getMainRole();
               _loc6_ = new Point(_loc5_.x,_loc5_.y);
               _loc3_ = Math.abs(_loc6_.x - _loc4_.x);
               _loc2_ = Math.abs(_loc6_.y - _loc4_.y);
               if(_loc3_ > 300 || _loc2_ > 200)
               {
                  if(_loc5_.playerInfo.isCapture)
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
      
      private function __onStatueGotoFightHander(param1:MapEvent) : void
      {
         var _loc3_:Point = new Point(param1.data[0],param1.data[1]);
         var _loc5_:int = CampBattleControl.instance.model.captureZoneID;
         var _loc2_:int = CampBattleControl.instance.model.captureUserID;
         var _loc4_:CampBattlePlayer = _mapView.getMainRole();
         if(_mapView.getCurrRole(_loc5_,_loc2_).playerInfo.team == _loc4_.playerInfo.team)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.campBattle.statuCaptured"));
            return;
         }
         if(!_loc4_.playerInfo.isDead)
         {
            _mapView.checkPonitDistance(_loc3_,SocketManager.Instance.out.enterPTPFight,_loc2_,_loc5_);
         }
      }
      
      private function creatMap(param1:String = null, param2:String = null, param3:DictionaryData = null, param4:DictionaryData = null, param5:Array = null, param6:Bitmap = null) : void
      {
         _mapView = new CampBattleMap(param1,param2,param3,param4,param5,param6);
         _mapLayer.addChild(_mapView);
      }
      
      private function __onGotoFightHander(param1:MapEvent) : void
      {
         var _loc3_:Point = new Point(param1.data[0],param1.data[1]);
         var _loc4_:int = param1.data[2];
         var _loc2_:int = param1.data[3];
         if(_mapView.getMainRole())
         {
            if(!_mapView.getMainRole().playerInfo.isDead)
            {
               _mapView.checkPonitDistance(_loc3_,SocketManager.Instance.out.enterPTPFight,_loc2_,_loc4_);
            }
         }
      }
      
      private function __onCaptureMapHander(param1:MapEvent) : void
      {
         var _loc2_:Point = new Point(param1.data[0],param1.data[1]);
         _mapView.checkPonitDistance(_loc2_,captureMap);
      }
      
      private function captureMap() : void
      {
         CampBattleControl.instance.dispatchEvent(new MapEvent("capture_start"));
      }
      
      private function __onCapMapHander(param1:PkgEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:CampModel = CampBattleControl.instance.model;
         _loc2_.isCapture = _loc4_.readBoolean();
         _loc2_.captureZoneID = _loc4_.readInt();
         _loc2_.captureUserID = _loc4_.readInt();
         _loc2_.captureName = _loc4_.readUTF();
         if(_loc2_.captureName.length > 4)
         {
            _loc2_.captureName = _loc2_.captureName.replace(4,"......");
         }
         _loc2_.captureTeam = _loc4_.readInt();
         CampBattleControl.instance.dispatchEvent(new MapEvent("capture_over",[_loc2_.captureZoneID,_loc2_.captureUserID]));
         var _loc3_:RoleData = getRoleData(_loc2_.captureZoneID,_loc2_.captureUserID);
         if(_loc3_)
         {
            _loc3_.isCapture = _loc2_.isCapture;
         }
      }
      
      private function __onAddMonstersList(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc8_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc7_:PackageIn = param1.pkg;
         if(!CampBattleControl.instance.model.isFighting)
         {
            CampBattleControl.instance.model.monsterCount = _loc7_.readInt();
            _loc5_ = _loc7_.readInt();
            _loc9_ = 0;
            while(_loc9_ < _loc5_)
            {
               _loc2_ = _loc7_.readInt();
               _loc8_ = new SmallEnemy(_loc2_,2,1000);
               _loc8_.typeLiving = 2;
               _loc8_.actionMovieName = _loc7_.readUTF();
               _loc4_ = _loc7_.readUTF();
               _loc8_.direction = 1;
               _loc3_ = new Point(_loc7_.readInt(),_loc7_.readInt());
               _loc8_.name = "虫子";
               _loc8_.stateType = _loc7_.readInt();
               _loc6_ = _loc7_.readInt();
               CampBattleControl.instance.model.monsterList.add(_loc8_.LivingID,_loc8_);
               if(_loc6_ > 0)
               {
                  if(CampBattleControl.instance.model.monsterCount == 10)
                  {
                     _loc8_.pos = new Point(CampBattleControl.instance.model.monsterPosList[_loc9_][0],CampBattleControl.instance.model.monsterPosList[_loc9_][1]);
                  }
                  else
                  {
                     _loc8_.pos = _loc3_;
                  }
               }
               else
               {
                  _loc8_.pos = new Point(CampBattleControl.instance.model.monsterPosList[_loc9_][0],CampBattleControl.instance.model.monsterPosList[_loc9_][1]);
               }
               _loc9_++;
            }
            dispatchEvent(new MapEvent("pve_count"));
         }
      }
      
      private function __onCaptureOverHander(param1:MapEvent) : void
      {
         var _loc4_:int = param1.data[0];
         var _loc2_:int = param1.data[1];
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
         var _loc5_:CampBattlePlayer = _mapView.getCurrRole(_loc4_,_loc2_);
         if(_loc5_)
         {
            _loc5_.setCaptureVisible(CampBattleControl.instance.model.isCapture);
         }
         var _loc3_:CampBattlePlayer = CampBattlePlayer(_mapView.getMainRole());
         if(_loc3_)
         {
            if(_loc3_.playerInfo.zoneID == _loc4_ && _loc3_.playerInfo.ID == _loc2_)
            {
               _campLight.visible = CampBattleControl.instance.model.isCapture;
            }
         }
      }
      
      private function __onRoleMoveHander(param1:PkgEvent) : void
      {
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         if(!CampBattleControl.instance.model.isFighting)
         {
            _loc8_ = _loc5_.readInt();
            _loc7_ = _loc5_.readInt();
            _loc6_ = _loc5_.readInt();
            _loc2_ = _loc5_.readInt();
            _loc4_ = getRoleData(_loc6_,_loc2_);
            if(_loc4_)
            {
               _loc4_.posX = _loc8_;
               _loc4_.posY = _loc7_;
               _loc4_.stateType = 1;
               if(PlayerManager.Instance.Self.ZoneID == _loc6_ && PlayerManager.Instance.Self.ID == _loc2_)
               {
                  return;
               }
               _loc3_ = new Point(_loc8_,_loc7_);
               _mapView.roleMoves(_loc6_,_loc2_,_loc3_);
            }
         }
      }
      
      private function __onToOhterMapHander(param1:MapEvent) : void
      {
         var _loc2_:Point = new Point(param1.data[0],param1.data[1]);
         if(!_mapView.getMainRole().playerInfo.isDead)
         {
            _mapView.checkPonitDistance(_loc2_,SocketManager.Instance.out.changeMap);
         }
      }
      
      private function __onPlayerStateChange(param1:MapEvent) : void
      {
         _mapView.setRoleState(param1.data[0],param1.data[1],param1.data[2]);
      }
      
      private function __onMonsterStateChange(param1:PkgEvent) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         if(!CampBattleControl.instance.model.isFighting)
         {
            _loc2_ = _loc3_.readInt();
            _loc4_ = _loc3_.readInt();
            if(_loc4_ == 4)
            {
               CampBattleControl.instance.model.monsterList.remove(_loc2_);
            }
            else
            {
               _mapView.setMonsterState(_loc2_,_loc4_);
            }
         }
      }
      
      private function getRoleData(param1:int, param2:int) : RoleData
      {
         var _loc4_:String = param1 + "_" + param2;
         var _loc3_:RoleData = null;
         if(CampBattleControl.instance.model.playerModel)
         {
            _loc3_ = CampBattleControl.instance.model.playerModel[_loc4_];
         }
         return _loc3_;
      }
      
      private function createRrsurrectView() : void
      {
         CampBattleControl.instance.model.isShowResurrectView = false;
         var _loc1_:CampBattleResurrectView = new CampBattleResurrectView(CampBattleControl.instance.model.liveTime);
         _loc1_.addEventListener("complete",__onResurrectHandler,false,0,true);
         LayerManager.Instance.addToLayer(_loc1_,3,true);
      }
      
      private function __onResurrectHandler(param1:Event) : void
      {
         var _loc2_:CampBattleResurrectView = param1.currentTarget as CampBattleResurrectView;
         if(_loc2_)
         {
            _loc2_.removeEventListener("complete",__onResurrectHandler);
            _loc2_.dispose();
            _loc2_ = null;
         }
         SocketManager.Instance.out.resurrect(false,false);
         _mapView.setRoleState(PlayerManager.Instance.Self.ZoneID,PlayerManager.Instance.Self.ID,1);
      }
      
      private function __startLoading(param1:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      protected function __onFighterHander(param1:MapEvent) : void
      {
         var _loc3_:Point = new Point(param1.data[0],param1.data[1]);
         var _loc2_:int = param1.data[2];
         if(!_mapView || !_mapView.getMainRole() || !_mapView.getMainRole().playerInfo || _mapView.getMainRole().playerInfo.isDead)
         {
            return;
         }
         _mapView.checkPonitDistance(_loc3_,SocketManager.Instance.out.CampbattleEnterFight,_loc2_);
      }
      
      protected function __onHideBtnClick(param1:Event) : void
      {
         SoundManager.instance.playButtonSound();
         _mapView.hideRoles(_hideBtn.isHide);
      }
      
      protected function __onHelpBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:CampBattleHelpView = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.views.helpView");
         _loc2_.addEventListener("response",frameEvent);
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      private function frameEvent(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         param1.currentTarget.removeEventListener("response",frameEvent);
         param1.currentTarget.dispose();
      }
      
      protected function __onBackBtnClick(param1:MouseEvent) : void
      {
         var _loc3_:String = LanguageMgr.GetTranslation("ddt.campBattle.outCampBattle");
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc3_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SimpleAlert",30,true);
         _loc2_.moveEnable = false;
         _loc2_.addEventListener("response",__onConfirm);
      }
      
      protected function __onConfirm(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            SocketManager.Instance.out.outCampBatttle();
            StateManager.setState("main");
         }
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      override public function getType() : String
      {
         return "campBattleScene";
      }
      
      override public function leaving(param1:BaseStateView) : void
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
