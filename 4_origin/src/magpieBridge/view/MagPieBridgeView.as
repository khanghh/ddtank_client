package magpieBridge.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.utils.PositionUtils;
   import ddt.view.BuriedBox;
   import ddt.view.DiceRoll;
   import ddt.view.SimpleReturnBar;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import magpieBridge.MagpieBridgeManager;
   import magpieBridge.event.MagpieBridgeEvent;
   import road7th.comm.PackageIn;
   
   public class MagPieBridgeView extends BaseStateView implements Disposeable
   {
       
      
      private var _playerPosArray:Array;
      
      private var _diceArray:Array;
      
      private var _bg:Bitmap;
      
      private var _returnBtn:SimpleReturnBar;
      
      private var _magpieView:MagpieView;
      
      private var _helpBtn:BaseButton;
      
      private var _controlBg:Bitmap;
      
      private var _diceRoll:DiceRoll;
      
      private var _duckBtn:BaseButton;
      
      private var _lastNum:FilterFrameText;
      
      private var _buyCountBtn:SimpleBitmapButton;
      
      private var _magpieMap:MagpieBridgeMap;
      
      private var _selfPlayer:MagpiePlayer;
      
      private var _walkArray:Array;
      
      private var _magpiePos:int;
      
      private var _addMagpie0:MovieClip;
      
      private var _addMagpie1:MovieClip;
      
      private var _awardCell:BagCell;
      
      private var _awardBox:BuriedBox;
      
      private var _desPos:int;
      
      private var _closeIconFlag:Boolean;
      
      private var _getAwardFlag:Boolean;
      
      private var _addMagpieFlag:Boolean;
      
      private var _stepFlag:Boolean;
      
      private var _addCountFlag:Boolean;
      
      private var _magpieEndNum:int;
      
      private var _endFlag:Boolean;
      
      public function MagPieBridgeView()
      {
         _playerPosArray = [[new Point(802,83),new Point(718,83),new Point(651,83),new Point(578,83),new Point(507,83),new Point(514,118),new Point(521,159),new Point(599,159),new Point(674,159),new Point(686,197),new Point(698,238),new Point(715,283),new Point(729,331),new Point(645,331),new Point(562,331),new Point(477,331),new Point(394,331),new Point(312,331),new Point(221,331),new Point(140,331),new Point(56,331),new Point(59,284),new Point(63,239),new Point(68,198),new Point(70,160),new Point(75,117),new Point(76,82),new Point(150,82),new Point(219,82),new Point(292,82),new Point(294,117),new Point(296,159),new Point(300,198),new Point(376,198),new Point(453,198),new Point(462,239)],[new Point(819,167),new Point(736,167),new Point(664,167),new Point(649,130),new Point(640,93),new Point(574,93),new Point(505,93),new Point(439,93),new Point(370,93),new Point(302,93),new Point(234,93),new Point(167,93),new Point(99,93),new Point(98,128),new Point(96,166),new Point(91,203),new Point(89,245),new Point(86,287),new Point(83,334),new Point(163,334),new Point(244,334),new Point(320,334),new Point(400,334),new Point(480,334),new Point(560,334),new Point(548,285),new Point(539,243),new Point(530,203),new Point(522,164),new Point(451,164),new Point(379,164),new Point(309,164),new Point(236,164),new Point(238,202),new Point(240,244),new Point(312,244)],[new Point(805,122),new Point(725,122),new Point(653,122),new Point(664,157),new Point(675,195),new Point(754,195),new Point(768,239),new Point(783,282),new Point(800,328),new Point(720,328),new Point(638,328),new Point(558,328),new Point(546,282),new Point(538,237),new Point(529,195),new Point(521,158),new Point(446,158),new Point(371,158),new Point(298,158),new Point(296,120),new Point(295,84),new Point(225,84),new Point(152,84),new Point(84,84),new Point(81,121),new Point(78,159),new Point(76,195),new Point(71,238),new Point(71,282),new Point(66,331),new Point(147,331),new Point(230,331),new Point(310,331),new Point(393,331),new Point(389,284),new Point(380,236)]];
         _diceArray = ["one","two","three","four","five","six"];
         super();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.magpieBridge.bg");
         addChild(_bg);
         _returnBtn = ComponentFactory.Instance.creatCustomObject("asset.simpleReturnBar.Button");
         _returnBtn.returnCall = exitHandler;
         _returnBtn.x = 909;
         _returnBtn.y = 541;
         addChild(_returnBtn);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("magpieBridgeView.helpBtn");
         addChild(_helpBtn);
         _magpieView = new MagpieView();
         PositionUtils.setPos(_magpieView,"magpieBridgeView.Pos");
         addChild(_magpieView);
         _controlBg = ComponentFactory.Instance.creat("asset.magpieBridge.controlBg");
         addChild(_controlBg);
         _diceRoll = new DiceRoll();
         PositionUtils.setPos(_diceRoll,"magpieBridgeView.dicePos");
         addChild(_diceRoll);
         _duckBtn = ComponentFactory.Instance.creatComponentByStylename("magpieBridgeView.duckBtn");
         addChild(_duckBtn);
         _lastNum = ComponentFactory.Instance.creatComponentByStylename("magpieBridgeView.lastNum");
         _lastNum.text = MagpieBridgeManager.instance.magpieModel.LastNum.toString();
         addChild(_lastNum);
         _buyCountBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.energyAddBtn");
         _buyCountBtn.tipData = LanguageMgr.GetTranslation("magpieBridgeView.buyCountTxt");
         PositionUtils.setPos(_buyCountBtn,"magpieBridgeView.buyCountsPos");
         addChild(_buyCountBtn);
         _magpieMap = new MagpieBridgeMap();
         PositionUtils.setPos(_magpieMap,"magpieBridgeView.mapPos" + MagpieBridgeManager.instance.magpieModel.MapId.toString());
         addChild(_magpieMap);
         _selfPlayer = new MagpiePlayer(PlayerManager.Instance.Self,roleCallback);
      }
      
      private function initEvent() : void
      {
         _duckBtn.addEventListener("click",__onDuckClick);
         _buyCountBtn.addEventListener("click",__onBuyCountClick);
         _helpBtn.addEventListener("click",__onHelpBtnClick);
         _magpieView.addEventListener("setBtnEnable",__onSetBtnEnable);
         BuriedManager.Instance.addEventListener("diceover",__onDiceOver);
         BuriedManager.Instance.addEventListener("boxmovie_over",__onBoxMovieOver);
         SocketManager.Instance.addEventListener(PkgEvent.format(276,2),__onRollDice);
         SocketManager.Instance.addEventListener(PkgEvent.format(276,3),__onBuyCount);
         SocketManager.Instance.addEventListener(PkgEvent.format(276,8),__onCloseIcon);
         SocketManager.Instance.addEventListener(PkgEvent.format(276,7),__onUpdatePlayerPos);
         SocketManager.Instance.addEventListener(PkgEvent.format(276,6),__onGetAward);
         SocketManager.Instance.addEventListener(PkgEvent.format(276,10),__onMagpieNum);
         SocketManager.Instance.addEventListener(PkgEvent.format(276,13),__onSetCount);
      }
      
      private function exitHandler() : void
      {
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.exitMagpieView();
         StateManager.setState("main");
      }
      
      protected function __onHelpBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:MagpieHelpView = ComponentFactory.Instance.creatComponentByStylename("magpie.view.helpView");
         _loc2_.addEventListener("response",frameEvent);
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      private function frameEvent(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         param1.currentTarget.dispose();
      }
      
      override public function refresh() : void
      {
         if(_magpieMap)
         {
            _magpieMap.dispose();
            _magpieMap = null;
         }
         _magpieMap = new MagpieBridgeMap();
         PositionUtils.setPos(_magpieMap,"magpieBridgeView.mapPos" + MagpieBridgeManager.instance.magpieModel.MapId.toString());
         addChildAt(_magpieMap,numChildren - 2);
         _selfPlayer.sceneCharacterDirection = SceneCharacterDirection.LB;
         PositionUtils.setPos(_selfPlayer,_playerPosArray[MagpieBridgeManager.instance.magpieModel.MapId][MagpieBridgeManager.instance.magpieModel.NowPosition]);
         super.refresh();
      }
      
      protected function __onMagpieNum(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         MagpieBridgeManager.instance.magpieModel.MagpieNum = _loc2_;
         _addMagpieFlag = true;
      }
      
      private function addMagpie() : void
      {
         _magpiePos = MagpieBridgeManager.instance.magpieModel.NowPosition;
         if(!_addMagpie0)
         {
            _addMagpie0 = ComponentFactory.Instance.creat("asset.magpieBridge.magpie0");
            _addMagpie0.addFrameScript(_addMagpie0.totalFrames - 1,playMagpieAnimation);
         }
         var _loc1_:Point = new Point(_magpieMap.mapVec[_magpiePos].x - 5,_magpieMap.mapVec[_magpiePos].y - 10);
         PositionUtils.setPos(_addMagpie0,_loc1_);
         _addMagpie0.gotoAndPlay(1);
         _magpieMap.addChild(_addMagpie0);
      }
      
      private function playMagpieAnimation() : void
      {
         _addMagpie0.stop();
         _addMagpie1 = ComponentFactory.Instance.creat("asset.magpieBridge.magpie1");
         PositionUtils.setPos(_addMagpie1,_magpieMap.localToGlobal(new Point(_magpieMap.mapVec[_magpiePos].x,_magpieMap.mapVec[_magpiePos].y)));
         var _loc1_:Point = _magpieView.localToGlobal(_magpieView.getCurrentMagpiePos(true));
         addChild(_addMagpie1);
         TweenLite.to(_addMagpie1,0.5,{
            "x":_loc1_.x,
            "y":_loc1_.y,
            "onComplete":setMagpieNum
         });
      }
      
      private function setMagpieNum() : void
      {
         ObjectUtils.disposeObject(_addMagpie1);
         _addMagpie1 = null;
         _magpieView.showMagpie();
      }
      
      protected function __onGetAward(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         MagpieBridgeManager.instance.magpieModel.CurrentTempId = _loc2_.readInt();
         _getAwardFlag = true;
      }
      
      private function flyGoods() : void
      {
         var _loc1_:int = MagpieBridgeManager.instance.magpieModel.CurrentTempId;
         var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_loc1_);
         _awardCell = new BagCell(0,_loc2_);
         PositionUtils.setPos(_awardCell,_selfPlayer);
         addChild(_awardCell);
         TweenMax.to(_awardCell,1,{
            "x":461,
            "y":518,
            "scaleX":0.1,
            "scaleY":0.1,
            "onComplete":complete,
            "bezier":[{
               "x":_selfPlayer.x,
               "y":_selfPlayer.y - 80
            }]
         });
      }
      
      private function complete() : void
      {
         ObjectUtils.disposeObject(_awardCell);
         _awardCell = null;
         _magpieMap.closeIcon();
         setBtnEnable(true);
      }
      
      protected function __onUpdatePlayerPos(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _desPos = _loc2_.readInt();
         _stepFlag = true;
      }
      
      protected function __onWalkOver(param1:MagpieBridgeEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         setBtnEnable(true);
         if(_stepFlag)
         {
            setBtnEnable(false);
            _stepFlag = false;
            _magpieMap.closeIcon();
            _loc3_ = MagpieBridgeManager.instance.magpieModel.NowPosition;
            _loc2_ = _desPos - _loc3_;
            showPromptInfo(_loc2_);
            setPlayerWalk(_desPos);
            if(_loc2_ < -1)
            {
               _selfPlayer.sceneCharacterDirection = SceneCharacterDirection.LB;
               PositionUtils.setPos(_selfPlayer,_walkArray.pop());
               _walkArray.splice(0,_walkArray.length);
               setBtnEnable(true);
               return;
            }
            if(_walkArray.length > 0)
            {
               _selfPlayer.roleWalk(_walkArray);
               return;
            }
         }
         if(MagpieBridgeManager.instance.magpieModel.NowPosition == _magpieMap.mapVec.length - 1)
         {
            _endFlag = true;
            setBtnEnable(false);
            MagpieBridgeManager.instance.magpieModel.MagpieNum++;
            addMagpie();
         }
         if(_getAwardFlag)
         {
            setBtnEnable(false);
            _getAwardFlag = false;
            flyGoods();
         }
         if(_addMagpieFlag)
         {
            setBtnEnable(false);
            _addMagpieFlag = false;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magpieBridgeView.addMagpieTxt"));
            addMagpie();
         }
         if(_addCountFlag)
         {
            _addCountFlag = false;
            _lastNum.text = MagpieBridgeManager.instance.magpieModel.LastNum.toString();
            _magpieMap.closeIcon();
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magpieBridgeView.addCountTxt"));
         }
      }
      
      private function showPromptInfo(param1:int) : void
      {
         if(param1 == 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("buried.alertInfo.toGo"));
         }
         else if(param1 == -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("buried.alertInfo.toBack"));
         }
         else if(param1 > 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("buried.alertInfo.toEnd"));
         }
         else if(param1 < -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("buried.alertInfo.toStart"));
         }
      }
      
      private function __onBoxMovieOver(param1:BuriedEvent) : void
      {
         setBtnEnable(true);
         ObjectUtils.disposeObject(_awardBox);
         _awardBox = null;
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("buried.alertInfo.mapover"),LanguageMgr.GetTranslation("ok"),"",true,true,true,2,null,"SimpleAlert",60,false);
         _loc2_.addEventListener("response",onMapOverResponse);
      }
      
      private function onMapOverResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",onMapOverResponse);
         if(param1.responseCode == 1 || param1.responseCode == 2 || param1.responseCode == 3 || param1.responseCode == 0)
         {
            SocketManager.Instance.out.refreshMagpieView();
         }
         _loc2_.dispose();
      }
      
      protected function __onCloseIcon(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:int = _loc3_.readInt();
         var _loc2_:int = _loc3_.readInt();
         if(_loc2_ == 0)
         {
            _closeIconFlag = true;
         }
      }
      
      protected function __onBuyCountClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:MagpieBuyCountsView = ComponentFactory.Instance.creat("magpieBridge.buyCountsView");
         _loc2_.price = ServerConfigManager.instance.magpieBridgeCountPrice;
         _loc2_.show();
      }
      
      protected function __onBuyCount(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:int = _loc2_.readInt();
         _lastNum.text = _loc3_.toString();
         MagpieBridgeManager.instance.magpieModel.LastNum = _loc3_;
      }
      
      protected function __onSetCount(param1:PkgEvent) : void
      {
         MagpieBridgeManager.instance.magpieModel.LastNum++;
         _addCountFlag = true;
      }
      
      protected function __onSetBtnEnable(param1:MagpieBridgeEvent) : void
      {
         if(_endFlag)
         {
            _magpieEndNum = Number(_magpieEndNum) + 1;
            if(_magpieEndNum < 2)
            {
               MagpieBridgeManager.instance.magpieModel.MagpieNum++;
               addMagpie();
            }
            else
            {
               _endFlag = false;
               _magpieEndNum = 0;
               _awardBox = new BuriedBox();
               _awardBox.initView(MagpieBridgeManager.instance.magpieModel.MapId,"asset.magpieBridge.awardBox");
               addChild(_awardBox);
               _awardBox.play();
            }
         }
         else
         {
            _magpieMap.closeIcon();
            setBtnEnable(true);
         }
      }
      
      private function setBtnEnable(param1:Boolean) : void
      {
         _duckBtn.enable = param1;
         _returnBtn.mouseEnabled = param1;
         _returnBtn.mouseChildren = param1;
      }
      
      protected function __onDuckClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         SocketManager.Instance.out.magpieRollDice();
         if(MagpieBridgeManager.instance.magpieModel.LastNum > 0)
         {
            setBtnEnable(false);
         }
      }
      
      protected function __onRollDice(param1:PkgEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc5_:int = _loc4_.readInt();
         var _loc2_:int = _loc4_.readInt();
         var _loc3_:int = _loc4_.readInt();
         _lastNum.text = _loc5_.toString();
         MagpieBridgeManager.instance.magpieModel.LastNum = _loc5_;
         setPlayerWalk(_loc3_);
         _diceRoll.setCrFrame(_diceArray[_loc2_ - 1]);
         _diceRoll.resetFrame();
         _diceRoll.play();
      }
      
      protected function __onDiceOver(param1:BuriedEvent) : void
      {
         if(_walkArray.length > 0)
         {
            _selfPlayer.roleWalk(_walkArray);
         }
      }
      
      private function setPlayerWalk(param1:int) : void
      {
         var _loc4_:Array = _playerPosArray[MagpieBridgeManager.instance.magpieModel.MapId];
         _walkArray = [];
         var _loc2_:int = MagpieBridgeManager.instance.magpieModel.NowPosition;
         var _loc3_:int = param1 < _loc2_?-1:1;
         while(_loc2_ != param1)
         {
            _loc2_ = _loc2_ + _loc3_;
            _walkArray.push(_loc4_[_loc2_]);
         }
         MagpieBridgeManager.instance.magpieModel.NowPosition = _loc2_;
      }
      
      private function roleCallback(param1:MagpiePlayer, param2:Boolean, param3:int) : void
      {
         if(param3 == 0)
         {
            if(!param1)
            {
               return;
            }
            _selfPlayer = param1;
            _selfPlayer.sceneCharacterStateType = "natural";
            _selfPlayer.update();
            PositionUtils.setPos(_selfPlayer,_playerPosArray[MagpieBridgeManager.instance.magpieModel.MapId][MagpieBridgeManager.instance.magpieModel.NowPosition]);
            addChild(_selfPlayer);
            _selfPlayer.addEventListener("walkOver",__onWalkOver);
         }
      }
      
      override public function getType() : String
      {
         return "magpiebridge";
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      private function removeEvent() : void
      {
         _duckBtn.removeEventListener("click",__onDuckClick);
         _buyCountBtn.removeEventListener("click",__onBuyCountClick);
         _helpBtn.removeEventListener("click",__onHelpBtnClick);
         _selfPlayer.removeEventListener("walkOver",__onWalkOver);
         _magpieView.removeEventListener("setBtnEnable",__onSetBtnEnable);
         BuriedManager.Instance.removeEventListener("diceover",__onDiceOver);
         BuriedManager.Instance.removeEventListener("boxmovie_over",__onBoxMovieOver);
         SocketManager.Instance.removeEventListener(PkgEvent.format(276,2),__onRollDice);
         SocketManager.Instance.removeEventListener(PkgEvent.format(276,3),__onBuyCount);
         SocketManager.Instance.removeEventListener(PkgEvent.format(276,8),__onCloseIcon);
         SocketManager.Instance.removeEventListener(PkgEvent.format(276,7),__onUpdatePlayerPos);
         SocketManager.Instance.removeEventListener(PkgEvent.format(276,6),__onGetAward);
         SocketManager.Instance.removeEventListener(PkgEvent.format(276,10),__onMagpieNum);
         SocketManager.Instance.removeEventListener(PkgEvent.format(276,13),__onSetCount);
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_controlBg);
         _controlBg = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         ObjectUtils.disposeObject(_magpieView);
         _magpieView = null;
         ObjectUtils.disposeObject(_diceRoll);
         _diceRoll = null;
         ObjectUtils.disposeObject(_duckBtn);
         _duckBtn = null;
         ObjectUtils.disposeObject(_lastNum);
         _lastNum = null;
         ObjectUtils.disposeObject(_buyCountBtn);
         _buyCountBtn = null;
         ObjectUtils.disposeObject(_magpieMap);
         _magpieMap = null;
         ObjectUtils.disposeObject(_selfPlayer);
         _selfPlayer = null;
         super.dispose();
      }
   }
}
