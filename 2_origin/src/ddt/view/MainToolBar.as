package ddt.view
{
   import bagAndInfo.BagAndInfoManager;
   import calendar.CalendarManager;
   import com.greensock.TweenLite;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.layout.StageResizeUtils;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.events.TaskEvent;
   import ddt.manager.ExitPromptManager;
   import ddt.manager.IMManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddtBuried.BuriedManager;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import gotopage.view.GotoPageController;
   import hall.HallStateView;
   import hall.tasktrack.HallTaskGuideManager;
   import horse.HorseManager;
   import magicStone.MagicStoneManager;
   import petsBag.PetsBagManager;
   import quest.QuestBubbleManager;
   import quest.TaskManager;
   import road7th.utils.MovieClipWrapper;
   import trainer.controller.WeakGuildManager;
   import trainer.view.NewHandContainer;
   
   public class MainToolBar extends Sprite
   {
      
      public static const ENTER_HALL:int = 0;
      
      public static const LEAVE_HALL:int = 1;
      
      private static var _instance:MainToolBar;
       
      
      private var _toolBarBg:Bitmap;
      
      private var _bgGradient:Bitmap;
      
      private var _goSupplyBtn:BaseButton;
      
      private var _goShopBtn:BaseButton;
      
      private var _goBagBtn:BaseButton;
      
      private var _goTaskBtn:BaseButton;
      
      private var _goFriendListBtn:BaseButton;
      
      private var _goSignBtn:BaseButton;
      
      private var _goChannelBtn:BaseButton;
      
      private var _goReturnBtn:BaseButton;
      
      private var _goExitBtn:BaseButton;
      
      private var _goBuriedBtn:BaseButton;
      
      private var _goPetBtn:BaseButton;
      
      private var _horseBtn:BaseButton;
      
      private var _callBackFun:Function;
      
      private var _unReadTask:Boolean;
      
      private var _enabled:Boolean;
      
      private var _unReadMovement:Boolean;
      
      private var _taskEffectEnable:Boolean;
      
      private var _signEffectEnable:Boolean = true;
      
      private var _boxContainer:HBox;
      
      private var allBtns:Array;
      
      private var _isEvent:Boolean;
      
      private var _bagTxt:Bitmap;
      
      private var _shopTxt:Bitmap;
      
      private var _jobTxt:Bitmap;
      
      private var _friendTxt:Bitmap;
      
      private var _signTxt:Bitmap;
      
      private var _otherTxt:Bitmap;
      
      private var _petTxt:Bitmap;
      
      private var _gameSetTxt:Bitmap;
      
      private var _horseTxt:Bitmap;
      
      private var _guideBtnTxtList:Array;
      
      private var _openBtnList:Array;
      
      private var _placePointList:Array;
      
      private var _lastClick:Number = 0;
      
      private var _taskShineEffect:IEffect;
      
      private var _signShineEffect:IEffect;
      
      private var _friendShineEffec:IEffect;
      
      private var _bagShineEffect:IEffect;
      
      private var _talkTimer:Timer;
      
      public function MainToolBar()
      {
         _talkTimer = new Timer(1000);
         super();
         initView();
         initEvent();
         createGuideData();
         PositionUtils.setPos(this,"toolbar.mainToolBarPos");
      }
      
      public static function get Instance() : MainToolBar
      {
         if(_instance == null)
         {
            _instance = new MainToolBar();
         }
         return _instance;
      }
      
      override public function get width() : Number
      {
         return 560;
      }
      
      private function initView() : void
      {
         _goSupplyBtn = ComponentFactory.Instance.creat("toolbar.gochargebtn");
         _toolBarBg = ComponentFactory.Instance.creatBitmap("asset.toolbar.toolBarBg");
         _goShopBtn = ComponentFactory.Instance.creat("toolbar.goshopbtn");
         _goBagBtn = ComponentFactory.Instance.creat("toolbar.gobagbtn");
         _goTaskBtn = ComponentFactory.Instance.creat("toolbar.gotaskbtn");
         _goFriendListBtn = ComponentFactory.Instance.creat("toolbar.goimbtn");
         _goChannelBtn = ComponentFactory.Instance.creat("toolbar.turntobtn");
         _goReturnBtn = ComponentFactory.Instance.creat("toolbar.gobackbtn");
         _goExitBtn = ComponentFactory.Instance.creat("toolbar.goexitbtn");
         _goPetBtn = ComponentFactory.Instance.creat("toolbar.petbtn");
         _goBuriedBtn = ComponentFactory.Instance.creat("toolbar.competitionbtn");
         _horseBtn = ComponentFactory.Instance.creat("toolbar.horsebtn");
         _bagTxt = ComponentFactory.Instance.creatBitmap("asset.toolbar.bagTxt");
         _bagTxt.visible = false;
         _shopTxt = ComponentFactory.Instance.creatBitmap("asset.toolbar.shopTxt");
         _shopTxt.visible = false;
         _jobTxt = ComponentFactory.Instance.creatBitmap("asset.toolbar.jobTxt");
         _friendTxt = ComponentFactory.Instance.creatBitmap("asset.toolbar.friendTxt");
         _friendTxt.visible = false;
         _otherTxt = ComponentFactory.Instance.creatBitmap("asset.toolbar.otherTxt");
         _otherTxt.visible = false;
         _petTxt = ComponentFactory.Instance.creatBitmap("asset.toolbar.petTxt");
         _petTxt.visible = false;
         _gameSetTxt = ComponentFactory.Instance.creatBitmap("asset.toolbar.setTxt");
         _gameSetTxt.visible = false;
         _horseTxt = ComponentFactory.Instance.creatBitmap("asset.toolbar.horseTxt");
         _horseTxt.visible = false;
         _goSupplyBtn.tipData = LanguageMgr.GetTranslation("tank.view.common.BellowStripViewII.supply");
         _goShopBtn.tipData = LanguageMgr.GetTranslation("tank.view.common.BellowStripViewII.shop");
         _goBagBtn.tipData = LanguageMgr.GetTranslation("tank.view.common.BellowStripViewII.bag");
         _goTaskBtn.tipData = LanguageMgr.GetTranslation("tank.game.ToolStripView.task");
         _goFriendListBtn.tipData = LanguageMgr.GetTranslation("tank.game.ToolStripView.friend");
         _goChannelBtn.tipData = LanguageMgr.GetTranslation("tank.view.common.BellowStripViewII.channel");
         _goReturnBtn.tipData = LanguageMgr.GetTranslation("tank.view.common.BellowStripViewII.back");
         _goExitBtn.tipData = LanguageMgr.GetTranslation("tank.view.common.BellowStripViewII.exit");
         _goPetBtn.tipData = LanguageMgr.GetTranslation("tank.game.ToolStripView.pet");
         _goBuriedBtn.tipData = LanguageMgr.GetTranslation("tank.game.ToolStripView.liansai");
         _horseBtn.tipData = LanguageMgr.GetTranslation("tank.game.ToolStripView.horse");
         allBtns = [];
         allBtns.push(_goShopBtn);
         allBtns.push(_goBagBtn);
         allBtns.push(_goPetBtn);
         allBtns.push(_horseBtn);
         allBtns.push(_goFriendListBtn);
         allBtns.push(_goChannelBtn);
         allBtns.push(_goReturnBtn);
         allBtns.push(_goSupplyBtn);
         allBtns.push(_goBuriedBtn);
         addChild(_toolBarBg);
         addChild(_goReturnBtn);
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("toolbar.bagShineIconPos");
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("toolbar.ShineAssetPos");
         _signShineEffect = EffectManager.Instance.creatEffect(1,_goSignBtn,"asset.toolbar.SignBtnGlow",_loc1_);
         _friendShineEffec = EffectManager.Instance.creatEffect(1,_goFriendListBtn,"asset.toolbar.friendBtnGlow",_loc1_);
         _taskShineEffect = EffectManager.Instance.creatEffect(1,_goTaskBtn,"asset.toolbar.TaskBtnGlow",_loc1_);
         _bagShineEffect = EffectManager.Instance.creatEffect(1,_goBagBtn,"asset.toolbar.bagBtnGlow",_loc2_);
      }
      
      public function setMoveChild(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this.numChildren)
         {
            this.getChildAt(_loc3_).x = this.getChildAt(_loc3_).x + param1;
            this.getChildAt(_loc3_).y = this.getChildAt(_loc3_).y + param2;
            _loc3_++;
         }
      }
      
      private function createGuideData() : void
      {
         var _loc6_:Object = {};
         _loc6_["btn"] = _goShopBtn;
         _loc6_["place"] = 7;
         _loc6_["level"] = 6;
         var _loc5_:Object = {};
         _loc5_["btn"] = _goBagBtn;
         _loc5_["place"] = 6;
         _loc5_["level"] = 0;
         var _loc1_:Object = {};
         _loc1_["btn"] = _goPetBtn;
         _loc1_["place"] = 5;
         _loc1_["level"] = 19;
         var _loc2_:Object = {};
         _loc2_["btn"] = _horseBtn;
         _loc2_["place"] = 4;
         _loc2_["level"] = 12;
         var _loc3_:Object = {};
         _loc3_["btn"] = _goBuriedBtn;
         _loc3_["place"] = 3;
         _loc3_["level"] = 25;
         var _loc4_:Object = {};
         _loc4_["btn"] = _goFriendListBtn;
         _loc4_["place"] = 2;
         _loc4_["level"] = 11;
         var _loc8_:Object = {};
         _loc8_["btn"] = _goChannelBtn;
         _loc8_["place"] = 1;
         _loc8_["level"] = 0;
         var _loc7_:Object = {};
         _loc7_["btn"] = _goExitBtn;
         _loc7_["place"] = 0;
         _loc7_["level"] = 0;
         _guideBtnTxtList = [];
         _guideBtnTxtList.push(_loc6_);
         _guideBtnTxtList.push(_loc5_);
         _guideBtnTxtList.push(_loc1_);
         _guideBtnTxtList.push(_loc2_);
         _guideBtnTxtList.push(_loc3_);
         _guideBtnTxtList.push(_loc4_);
         _guideBtnTxtList.push(_loc8_);
         _guideBtnTxtList.push(_loc7_);
         _placePointList = [];
         _placePointList.push({
            "btn":new Point(454,-22),
            "txt":new Point(451,17)
         });
         _placePointList.push({
            "btn":new Point(399,-22),
            "txt":new Point(399,17)
         });
         _placePointList.push({
            "btn":new Point(343,-20),
            "txt":new Point(346,17)
         });
         _placePointList.push({
            "btn":new Point(292,-24),
            "txt":new Point(295,17)
         });
         _placePointList.push({
            "btn":new Point(238,-23),
            "txt":new Point(239,17)
         });
         _placePointList.push({
            "btn":new Point(185,-19),
            "txt":new Point(188,17)
         });
         _placePointList.push({
            "btn":new Point(131,-23),
            "txt":new Point(131,17)
         });
         _placePointList.push({
            "btn":new Point(75,-23),
            "txt":new Point(75,17)
         });
      }
      
      public function set enabled(param1:Boolean) : void
      {
         _enabled = param1;
         update();
      }
      
      public function enableAll() : void
      {
         enabled = true;
         _goExitBtn.enable = true;
         setReturnEnable(true);
      }
      
      public function disableAll() : void
      {
         enabled = false;
         _goExitBtn.enable = false;
      }
      
      private function initEvent() : void
      {
         _isEvent = true;
         _goSupplyBtn.addEventListener("click",__onSupplyClick);
         _goShopBtn.addEventListener("click",__onShopClick);
         _goBagBtn.addEventListener("click",__onBagClick);
         _goTaskBtn.addEventListener("mouseOver",_overTaskBtn);
         _goTaskBtn.addEventListener("mouseOut",_outTaskBtn);
         _goTaskBtn.addEventListener("click",__onTaskClick);
         _goFriendListBtn.addEventListener("click",__onImClick);
         _goFriendListBtn.addEventListener("mouseOver",__friendOverHandler);
         _goFriendListBtn.addEventListener("mouseOut",__friendOutHandler);
         _goChannelBtn.addEventListener("click",__onChannelClick);
         _goReturnBtn.addEventListener("click",__onReturnClick);
         _goExitBtn.addEventListener("click",__onExitClick);
         _goPetBtn.addEventListener("click",__onPetClick);
         _goBuriedBtn.addEventListener("click",__onBuriedClick);
         _horseBtn.addEventListener("click",__onHorseClick);
         IMManager.Instance.addEventListener("hasNewMessage",__hasNewHandler);
         IMManager.Instance.addEventListener("nomessage",__noMessageHandler);
         addEventListener("addedToStage",__addToStageHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(273),questManuGetHandler);
         TaskManager.instance.addEventListener("changed",taskChangeHandler);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
      }
      
      protected function __propertyChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Grade"])
         {
            if(PlayerManager.Instance.Self.Grade == 45)
            {
               MagicStoneManager.instance.upTo40Flag = true;
               if(BagAndInfoManager.Instance.isShown)
               {
                  MagicStoneManager.instance.weakGuide(3);
                  MagicStoneManager.instance.removeWeakGuide(0);
               }
               else if(_goBagBtn.enable)
               {
                  MagicStoneManager.instance.weakGuide(0,this);
               }
            }
         }
      }
      
      private function taskChangeHandler(param1:TaskEvent) : void
      {
         if(!PlayerManager.Instance.Self.isNewOnceFinish(111))
         {
            if(PlayerManager.Instance.Self.Grade >= 12 && param1.info.QuestID == 568 && param1.data.isAchieved && _horseBtn.parent)
            {
               NewHandContainer.Instance.showArrow(128,0,new Point(800,484),"","",this,0,true);
            }
         }
         if(param1.info.QuestID == 7 && param1.data.isAchieved)
         {
            if(!PlayerManager.Instance.Self.isNewOnceFinish(124) && PlayerManager.Instance.Self.Grade == 13)
            {
               NewHandContainer.Instance.showArrow(140,0,localToGlobal(new Point(805,484)),"","");
            }
            else
            {
               NewHandContainer.Instance.clearArrowByID(140);
            }
         }
         if(param1.info.QuestID == 25 && param1.data.isAchieved)
         {
            if(!PlayerManager.Instance.Self.isNewOnceFinish(125) && PlayerManager.Instance.Self.Grade == 15)
            {
               NewHandContainer.Instance.showArrow(141,0,new Point(805,484),"","",this);
            }
            else
            {
               NewHandContainer.Instance.clearArrowByID(141);
            }
         }
         if(param1.info.QuestID == 29 && param1.data.isAchieved)
         {
            if(!PlayerManager.Instance.Self.isNewOnceFinish(126) && PlayerManager.Instance.Self.Grade == 16)
            {
               NewHandContainer.Instance.showArrow(142,0,new Point(805,484),"","",this);
            }
            else
            {
               NewHandContainer.Instance.clearArrowByID(142);
            }
         }
      }
      
      private function checkHorseGuide() : void
      {
         if(!PlayerManager.Instance.Self.isNewOnceFinish(111))
         {
            if(PlayerManager.Instance.Self.Grade >= 12 && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(568)))
            {
               NewHandContainer.Instance.showArrow(128,0,new Point(800,484),"","",this);
            }
         }
         if(!PlayerManager.Instance.Self.isNewOnceFinish(124))
         {
            if(PlayerManager.Instance.Self.Grade == 13 && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(7)))
            {
               NewHandContainer.Instance.showArrow(140,0,localToGlobal(new Point(805,484)),"","");
               showBagShineEffect(true);
            }
         }
         if(!PlayerManager.Instance.Self.isNewOnceFinish(125))
         {
            if(PlayerManager.Instance.Self.Grade == 15 && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(25)))
            {
               NewHandContainer.Instance.showArrow(141,0,new Point(805,484),"","",this);
            }
         }
         if(!PlayerManager.Instance.Self.isNewOnceFinish(126))
         {
            if(PlayerManager.Instance.Self.Grade == 16 && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(29)))
            {
               NewHandContainer.Instance.showArrow(142,0,new Point(805,484),"","",this);
               showBagShineEffect(true);
            }
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(101))
         {
            if(PlayerManager.Instance.Self.Grade >= 22)
            {
               NewHandContainer.Instance.showArrow(145,0,new Point(_goBagBtn.x + 20,_goBagBtn.y - 50),"","",this);
               showBagShineEffect(true);
            }
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(136))
         {
            if(PlayerManager.Instance.Self.Grade >= 25)
            {
               NewHandContainer.Instance.showArrow(147,0,new Point(806,493),"","",this);
               showBagShineEffect(true);
            }
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(139))
         {
            if(PlayerManager.Instance.Self.Grade >= 35)
            {
               NewHandContainer.Instance.showArrow(149,0,new Point(_goBagBtn.x + 20,_goBagBtn.y - 50),"","",this);
               showBagShineEffect(true);
            }
         }
      }
      
      protected function __addToStageHandler(param1:Event) : void
      {
         if(IMManager.Instance.hasUnreadMessage() && !IMManager.Instance.cancelflashState)
         {
            showFriendShineEffec(true);
         }
         else
         {
            showFriendShineEffec(false);
         }
      }
      
      protected function __noMessageHandler(param1:Event) : void
      {
         showFriendShineEffec(false);
      }
      
      protected function __hasNewHandler(param1:Event) : void
      {
         if(!_talkTimer.running)
         {
            SoundManager.instance.play("200");
            _talkTimer.start();
            _talkTimer.addEventListener("timer",__stopTalkTime);
         }
         showFriendShineEffec(true);
      }
      
      private function __stopTalkTime(param1:TimerEvent) : void
      {
         _talkTimer.stop();
         _talkTimer.removeEventListener("timer",__stopTalkTime);
      }
      
      protected function __friendOverHandler(param1:MouseEvent) : void
      {
         IMManager.Instance.showMessageBox(_goFriendListBtn);
      }
      
      protected function __friendOutHandler(param1:MouseEvent) : void
      {
         IMManager.Instance.hideMessageBox();
      }
      
      public function newBtnOpenCartoon() : Point
      {
         var _loc5_:* = null;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc13_:int = PlayerManager.Instance.Self.Grade;
         var _loc3_:int = _guideBtnTxtList.length;
         _loc8_ = 0;
         while(_loc8_ < _loc3_)
         {
            if(_loc13_ == _guideBtnTxtList[_loc8_].level)
            {
               _loc5_ = _guideBtnTxtList[_loc8_];
               break;
            }
            _loc8_++;
         }
         var _loc9_:int = _openBtnList.length;
         var _loc11_:Array = [];
         var _loc4_:int = _loc5_.place;
         _loc7_ = 0;
         while(_loc7_ < _loc9_)
         {
            if(_openBtnList[_loc7_].place > _loc4_)
            {
               _loc11_.push(_openBtnList[_loc7_]);
            }
            _loc7_++;
         }
         _loc11_.sortOn("place",16);
         var _loc10_:int = _loc11_.length;
         var _loc12_:int = _openBtnList.length - _loc10_;
         _loc5_["btn"].x = _placePointList[_loc12_]["btn"].x;
         _loc5_["btn"].y = _placePointList[_loc12_]["btn"].y;
         var _loc1_:int = _loc12_ + 1;
         _loc6_ = 0;
         while(_loc6_ < _loc10_)
         {
            _loc2_ = _placePointList[_loc1_ + _loc6_];
            TweenLite.to(_loc11_[_loc6_]["btn"],0.3,{
               "x":_loc2_["btn"].x,
               "y":_loc2_["btn"].y
            });
            _loc6_++;
         }
         setTimeout(showCurLevelOpenBtn,300,_loc5_);
         return _placePointList[_loc12_]["btn"] as Point;
      }
      
      private function showCurLevelOpenBtn(param1:Object) : void
      {
         param1.btn.scaleX = 0.2;
         param1.btn.scaleY = 0.2;
         var _loc3_:int = param1.btn.x;
         var _loc2_:int = param1.btn.y;
         param1.btn.x = param1.btn.x + 23;
         param1.btn.y = param1.btn.y + 25;
         TweenLite.to(param1.btn,0.4,{
            "x":_loc3_,
            "y":_loc2_,
            "scaleX":1,
            "scaleY":1
         });
         var _loc5_:MovieClip = ComponentFactory.Instance.creat("asset.newOpenGuide.bagOpenLightMc");
         _loc5_.mouseEnabled = false;
         _loc5_.mouseChildren = false;
         _loc5_.x = _loc3_;
         _loc5_.y = _loc2_;
         addChild(_loc5_);
         var _loc4_:MovieClipWrapper = new MovieClipWrapper(_loc5_,true,true);
         addChild(param1.btn);
         if(param1.btn == _goShopBtn)
         {
            addChild(_goSupplyBtn);
         }
         checkHorseGuide();
      }
      
      public function btnOpen() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _openBtnList = [];
         var _loc2_:int = _guideBtnTxtList.length;
         var _loc5_:int = PlayerManager.Instance.Self.Grade;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            if(_loc5_ > _guideBtnTxtList[_loc4_].level || _loc5_ == _guideBtnTxtList[_loc4_].level && PlayerManager.Instance.Self.isNewOnceFinish(200 + _guideBtnTxtList[_loc4_].level))
            {
               _openBtnList.push(_guideBtnTxtList[_loc4_]);
            }
            _loc4_++;
         }
         _openBtnList.sortOn("place",16);
         var _loc1_:int = _openBtnList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            if(!_openBtnList[_loc3_]["btn"].parent)
            {
               addChild(_openBtnList[_loc3_]["btn"]);
            }
            _openBtnList[_loc3_]["btn"].x = _placePointList[_loc3_]["btn"].x;
            _openBtnList[_loc3_]["btn"].y = _placePointList[_loc3_]["btn"].y;
            _loc3_++;
         }
         if(_goShopBtn.parent)
         {
            addChild(_goSupplyBtn);
         }
         checkHorseGuide();
         if(PlayerManager.Instance.Self.Grade < 10 && !HallStateView.IsMaster)
         {
            HallTaskGuideManager.instance.showTask1ClickBagArrow();
         }
      }
      
      private function questManuGetHandler(param1:PkgEvent) : void
      {
         HallTaskGuideManager.instance.showTask1ClickBagArrow();
      }
      
      public function set backFunction(param1:Function) : void
      {
         _callBackFun = param1;
      }
      
      private function removeEvent() : void
      {
         _isEvent = false;
         _goSupplyBtn.removeEventListener("click",__onSupplyClick);
         _goShopBtn.removeEventListener("click",__onShopClick);
         _goBagBtn.removeEventListener("click",__onBagClick);
         _goTaskBtn.removeEventListener("mouseOver",_overTaskBtn);
         _goTaskBtn.removeEventListener("mouseOut",_outTaskBtn);
         _goTaskBtn.removeEventListener("click",__onTaskClick);
         _goFriendListBtn.removeEventListener("click",__onImClick);
         _goFriendListBtn.removeEventListener("mouseOver",__friendOverHandler);
         _goFriendListBtn.removeEventListener("mouseOut",__friendOutHandler);
         _goChannelBtn.removeEventListener("click",__onChannelClick);
         _goReturnBtn.removeEventListener("click",__onReturnClick);
         _goExitBtn.removeEventListener("click",__onExitClick);
         _goPetBtn.removeEventListener("click",__onPetClick);
         _goBuriedBtn.removeEventListener("click",__onBuriedClick);
         _horseBtn.removeEventListener("click",__onHorseClick);
         IMManager.Instance.removeEventListener("hasNewMessage",__hasNewHandler);
         IMManager.Instance.removeEventListener("nomessage",__noMessageHandler);
         removeEventListener("addedToStage",__addToStageHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(273),questManuGetHandler);
         TaskManager.instance.removeEventListener("changed",taskChangeHandler);
      }
      
      public function show() : void
      {
         if(!_isEvent)
         {
            initEvent();
         }
         enableAll();
         if(IMManager.Instance.hasUnreadMessage() && !IMManager.Instance.cancelflashState)
         {
            showFriendShineEffec(true);
         }
         else
         {
            showFriendShineEffec(false);
         }
         StageResizeUtils.Instance.addAutoResizeByStyle(this,"toolbar.mainToolBarLayoutInfo");
         LayerManager.Instance.addToLayer(this,4,false,0,false);
         refresh();
      }
      
      public function hide() : void
      {
         dispose();
      }
      
      public function setRoomWaitState() : void
      {
         KeyboardShortcutsManager.Instance.forbiddenSection(1,true);
      }
      
      public function setRoomStartState() : void
      {
         KeyboardShortcutsManager.Instance.forbiddenSection(1,false);
         var _loc1_:* = false;
         _goBuriedBtn.enable = _loc1_;
         _loc1_ = _loc1_;
         _goPetBtn.enable = _loc1_;
         _loc1_ = _loc1_;
         _goSupplyBtn.enable = _loc1_;
         _loc1_ = _loc1_;
         _goShopBtn.enable = _loc1_;
         _goReturnBtn.enable = _loc1_;
         setChannelEnable(false);
         setBagEnable(false);
      }
      
      public function setRoomStartState2(param1:Boolean) : void
      {
         KeyboardShortcutsManager.Instance.forbiddenSection(1,param1);
         var _loc2_:* = param1;
         _goBuriedBtn.enable = _loc2_;
         _loc2_ = _loc2_;
         _goPetBtn.enable = _loc2_;
         _loc2_ = _loc2_;
         _goSupplyBtn.enable = _loc2_;
         _loc2_ = _loc2_;
         _goShopBtn.enable = _loc2_;
         _goReturnBtn.enable = _loc2_;
         setChannelEnable(param1);
         setBagEnable(param1);
      }
      
      private function setSeverListStartState() : void
      {
         var _loc1_:* = false;
         _goBuriedBtn.enable = _loc1_;
         _loc1_ = _loc1_;
         _goPetBtn.enable = _loc1_;
         _loc1_ = _loc1_;
         _goSupplyBtn.enable = _loc1_;
         _loc1_ = _loc1_;
         _goShopBtn.enable = _loc1_;
         _loc1_ = _loc1_;
         _goTaskBtn.enable = _loc1_;
         _goReturnBtn.enable = _loc1_;
         setChannelEnable(false);
         setFriendBtnEnable(false);
         setBagEnable(false);
         if(_taskShineEffect)
         {
            showTaskShineEffect(false);
         }
      }
      
      public function setReturnEnable(param1:Boolean) : void
      {
         _goReturnBtn.enable = param1;
      }
      
      public function setBtnStateForConsortiaDomain(param1:Boolean) : void
      {
         _goSupplyBtn.visible = param1;
         _goShopBtn.enable = param1;
         _goChannelBtn.enable = param1;
         _horseBtn.enable = param1;
      }
      
      public function updateReturnBtn(param1:int) : void
      {
         this.visible = true;
         switch(int(param1))
         {
            case 0:
               addChild(_goExitBtn);
               _goExitBtn.visible = true;
               _goReturnBtn.visible = false;
               break;
            case 1:
               addChild(_goReturnBtn);
               _goExitBtn.visible = false;
               _goReturnBtn.visible = true;
         }
      }
      
      public function set ExitBtnVisible(param1:Boolean) : void
      {
         _goExitBtn.visible = param1;
      }
      
      private function isBitMapAddGrayFilter(param1:Bitmap, param2:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(!param2)
         {
            param1.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else
         {
            param1.filters = null;
         }
      }
      
      private function dispose() : void
      {
         removeEvent();
         QuestBubbleManager.Instance.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function __onReturnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015");
         if(StateManager.currentStateType == "main")
         {
            KeyboardShortcutsManager.Instance.forbiddenFull();
         }
         else if(StateManager.currentStateType == "farm")
         {
            FarmModelController.instance.exitFarm(PlayerManager.Instance.Self.ID);
         }
         if(_callBackFun != null)
         {
            _callBackFun();
         }
         else
         {
            StateManager.back();
         }
      }
      
      private function __onExitClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         ExitPromptManager.Instance.showView();
      }
      
      private function __onBuriedClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         if(getTimer() - _lastClick > 1000)
         {
            _lastClick = getTimer();
            BuriedManager.Instance.enter();
         }
      }
      
      private function __onPetClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         if(!PetsBagManager.instance().isShow)
         {
            PetsBagManager.instance().isShow = true;
            PetsBagManager.instance().isSelf = true;
            PetsBagManager.instance().show();
         }
      }
      
      private function __onImClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         IMManager.Instance.show();
      }
      
      private function __onChannelClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         GotoPageController.Instance.switchVisible();
      }
      
      private function __onSignClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         _signEffectEnable = false;
         CalendarManager.getInstance().open(2);
      }
      
      private function __onHorseClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         HorseManager.instance.show();
      }
      
      public function set signEffectEnable(param1:Boolean) : void
      {
         _signEffectEnable = param1;
      }
      
      private function _overTaskBtn(param1:MouseEvent) : void
      {
         ShowTipManager.Instance.removeTip(_goTaskBtn);
         QuestBubbleManager.Instance.addEventListener("show_task_tip",_showTaskTip);
         QuestBubbleManager.Instance.show();
      }
      
      private function _outTaskBtn(param1:MouseEvent) : void
      {
         QuestBubbleManager.Instance.dispose();
      }
      
      private function _showTaskTip(param1:Event) : void
      {
         ShowTipManager.Instance.addTip(_goTaskBtn);
         ShowTipManager.Instance.showTip(_goTaskBtn);
         QuestBubbleManager.Instance.dispose();
      }
      
      private function __onTaskClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         if(_taskShineEffect && _taskEffectEnable)
         {
            _taskEffectEnable = false;
            showTaskShineEffect(false);
         }
         QuestBubbleManager.Instance.dispose();
         showTask();
      }
      
      private function showTask() : void
      {
         TaskManager.instance.switchVisible();
      }
      
      private function __onBagClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         BagAndInfoManager.Instance.showBagAndInfo();
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(38))
         {
            SocketManager.Instance.out.syncWeakStep(38);
            SocketManager.Instance.out.syncWeakStep(8);
         }
         showBagShineEffect(false);
         MagicStoneManager.instance.removeWeakGuide(0);
      }
      
      private function __onShopClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(toShopNeedConfirm())
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.room.ToShopConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            _loc2_.addEventListener("response",__confirmToShopResponse);
         }
         else
         {
            StateManager.setState("shop");
         }
         SoundManager.instance.play("003");
      }
      
      private function toShopNeedConfirm() : Boolean
      {
         if(StateManager.currentStateType == "matchRoom" || StateManager.currentStateType == "dungeonRoom" || StateManager.currentStateType == "missionResult")
         {
            return true;
         }
         return false;
      }
      
      private function __confirmToShopResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__confirmToShopResponse);
         ObjectUtils.disposeObject(_loc2_);
         SoundManager.instance.play("008");
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            StateManager.setState("shop");
         }
      }
      
      private function __onSupplyClick(param1:MouseEvent) : void
      {
         LeavePageManager.leaveToFillPath();
      }
      
      public function set unReadTask(param1:Boolean) : void
      {
         if(_unReadTask == param1)
         {
            return;
         }
         _unReadTask = param1;
         if(_enabled)
         {
            updateTask();
         }
      }
      
      public function get unReadTask() : Boolean
      {
         return _unReadTask;
      }
      
      public function set unReadMovement(param1:Boolean) : void
      {
      }
      
      public function get unReadMovement() : Boolean
      {
         return _unReadMovement;
      }
      
      public function showTaskHightLight() : void
      {
         unReadTask = true;
      }
      
      public function hideTaskHightLight() : void
      {
         unReadTask = false;
      }
      
      public function showmovementHightLight() : void
      {
         unReadMovement = true;
      }
      
      public function setRoomState() : void
      {
         setChannelEnable(false);
      }
      
      public function setShopState() : void
      {
         setBagEnable(false);
      }
      
      public function setAuctionHouseState() : void
      {
         setBagEnable(false);
      }
      
      private function update() : void
      {
         var _loc1_:* = 0;
         _loc1_ = uint(0);
         while(_loc1_ < allBtns.length)
         {
            setEnableByIndex(_loc1_,_enabled);
            _loc1_++;
         }
         setRoomWaitState();
      }
      
      private function setEnableByIndex(param1:int, param2:Boolean) : void
      {
         if(param1 == 1)
         {
            setBagEnable(param2);
         }
         else if(param1 == 4)
         {
            setFriendBtnEnable(param2);
         }
         else if(param1 != 5)
         {
            if(param1 == 6)
            {
               setChannelEnable(param2);
            }
            else
            {
               allBtns[param1].enable = param2;
            }
         }
      }
      
      private function updateTask() : void
      {
         if(_unReadTask)
         {
            showTaskShineEffect(true);
         }
         else
         {
            showTaskShineEffect(false);
         }
         _goTaskBtn.enable = true;
         tipTask();
      }
      
      private function showFriendShineEffec(param1:Boolean) : void
      {
         if(param1 && _goFriendListBtn.parent)
         {
            _friendShineEffec.play();
            _goFriendListBtn.alpha = 0;
            _friendTxt.alpha = 0;
         }
         else
         {
            _friendShineEffec.stop();
            _goFriendListBtn.alpha = 1;
            _friendTxt.alpha = 1;
         }
      }
      
      private function showTaskShineEffect(param1:Boolean) : void
      {
      }
      
      public function showSignShineEffect(param1:Boolean) : void
      {
         if(param1)
         {
            _signShineEffect.play();
         }
         else
         {
            _signShineEffect.stop();
         }
      }
      
      public function showBagShineEffect(param1:Boolean) : void
      {
         if(param1 && _goBagBtn.parent)
         {
            _bagShineEffect.play();
            _goBagBtn.alpha = 0;
         }
         else
         {
            _bagShineEffect.stop();
            _goBagBtn.alpha = 1;
         }
      }
      
      public function __player(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      public function refresh() : void
      {
      }
      
      private function setChannelEnable(param1:Boolean) : void
      {
         this.isBitMapAddGrayFilter(_otherTxt,param1);
         _goChannelBtn.enable = param1;
         if(param1 && PlayerManager.Instance.Self.IsWeakGuildFinish(95))
         {
            KeyboardShortcutsManager.Instance.prohibitNewHandChannel(true);
            KeyboardShortcutsManager.Instance.prohibitNewHandSeting(true);
         }
         else
         {
            KeyboardShortcutsManager.Instance.prohibitNewHandChannel(false);
            KeyboardShortcutsManager.Instance.prohibitNewHandSeting(false);
         }
      }
      
      private function setBagEnable(param1:Boolean) : void
      {
         this.isBitMapAddGrayFilter(_bagTxt,param1);
         _goBagBtn.enable = param1;
         if(param1)
         {
            if(MagicStoneManager.instance.upTo40Flag)
            {
               MagicStoneManager.instance.weakGuide(0,this);
            }
         }
         else
         {
            NewHandContainer.Instance.clearArrowByID(124);
            showBagShineEffect(false);
         }
         if(param1 && PlayerManager.Instance.Self.IsWeakGuildFinish(7))
         {
            KeyboardShortcutsManager.Instance.prohibitNewHandBag(true);
         }
         else
         {
            KeyboardShortcutsManager.Instance.prohibitNewHandBag(false);
         }
      }
      
      private function setFriendBtnEnable(param1:Boolean) : void
      {
         this.isBitMapAddGrayFilter(_friendTxt,param1);
         _goFriendListBtn.enable = param1;
         if(param1 && PlayerManager.Instance.Self.IsWeakGuildFinish(27))
         {
            KeyboardShortcutsManager.Instance.prohibitNewHandFriend(true);
         }
         else
         {
            KeyboardShortcutsManager.Instance.prohibitNewHandFriend(false);
         }
      }
      
      private function setSignEnable(param1:Boolean) : void
      {
         this.isBitMapAddGrayFilter(_signTxt,param1);
         _goSignBtn.enable = param1;
         if(param1 && _goSignBtn.parent && _signEffectEnable && !CalendarManager.getInstance().hasTodaySigned())
         {
            showSignShineEffect(true);
         }
         else
         {
            showSignShineEffect(false);
         }
         if(param1 && PlayerManager.Instance.Self.IsWeakGuildFinish(99))
         {
            KeyboardShortcutsManager.Instance.prohibitNewHandCalendar(true);
         }
         else
         {
            KeyboardShortcutsManager.Instance.prohibitNewHandCalendar(false);
         }
      }
      
      public function tipTask() : void
      {
      }
      
      public function get goBagBtn() : BaseButton
      {
         return _goBagBtn;
      }
   }
}
