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
         var bagShineIconPos:Point = ComponentFactory.Instance.creatCustomObject("toolbar.bagShineIconPos");
         var glowPos:Point = ComponentFactory.Instance.creatCustomObject("toolbar.ShineAssetPos");
         _signShineEffect = EffectManager.Instance.creatEffect(1,_goSignBtn,"asset.toolbar.SignBtnGlow",glowPos);
         _friendShineEffec = EffectManager.Instance.creatEffect(1,_goFriendListBtn,"asset.toolbar.friendBtnGlow",glowPos);
         _taskShineEffect = EffectManager.Instance.creatEffect(1,_goTaskBtn,"asset.toolbar.TaskBtnGlow",glowPos);
         _bagShineEffect = EffectManager.Instance.creatEffect(1,_goBagBtn,"asset.toolbar.bagBtnGlow",bagShineIconPos);
      }
      
      public function setMoveChild(x:int, y:int) : void
      {
         var i:int = 0;
         for(i = 0; i < this.numChildren; )
         {
            this.getChildAt(i).x = this.getChildAt(i).x + x;
            this.getChildAt(i).y = this.getChildAt(i).y + y;
            i++;
         }
      }
      
      private function createGuideData() : void
      {
         var obj:Object = {};
         obj["btn"] = _goShopBtn;
         obj["place"] = 7;
         obj["level"] = 6;
         var obj2:Object = {};
         obj2["btn"] = _goBagBtn;
         obj2["place"] = 6;
         obj2["level"] = 0;
         var obj3:Object = {};
         obj3["btn"] = _goPetBtn;
         obj3["place"] = 5;
         obj3["level"] = 19;
         var obj4:Object = {};
         obj4["btn"] = _horseBtn;
         obj4["place"] = 4;
         obj4["level"] = 12;
         var obj5:Object = {};
         obj5["btn"] = _goBuriedBtn;
         obj5["place"] = 3;
         obj5["level"] = 25;
         var obj6:Object = {};
         obj6["btn"] = _goFriendListBtn;
         obj6["place"] = 2;
         obj6["level"] = 11;
         var obj7:Object = {};
         obj7["btn"] = _goChannelBtn;
         obj7["place"] = 1;
         obj7["level"] = 0;
         var obj8:Object = {};
         obj8["btn"] = _goExitBtn;
         obj8["place"] = 0;
         obj8["level"] = 0;
         _guideBtnTxtList = [];
         _guideBtnTxtList.push(obj);
         _guideBtnTxtList.push(obj2);
         _guideBtnTxtList.push(obj3);
         _guideBtnTxtList.push(obj4);
         _guideBtnTxtList.push(obj5);
         _guideBtnTxtList.push(obj6);
         _guideBtnTxtList.push(obj7);
         _guideBtnTxtList.push(obj8);
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
      
      public function set enabled(value:Boolean) : void
      {
         _enabled = value;
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
      
      protected function __propertyChange(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["Grade"])
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
      
      private function taskChangeHandler(event:TaskEvent) : void
      {
         if(event.info.QuestID == 7 && event.data.isAchieved)
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
         if(event.info.QuestID == 25 && event.data.isAchieved)
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
         if(event.info.QuestID == 29 && event.data.isAchieved)
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
      
      protected function __addToStageHandler(event:Event) : void
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
      
      protected function __noMessageHandler(event:Event) : void
      {
         showFriendShineEffec(false);
      }
      
      protected function __hasNewHandler(event:Event) : void
      {
         if(!_talkTimer.running)
         {
            SoundManager.instance.play("200");
            _talkTimer.start();
            _talkTimer.addEventListener("timer",__stopTalkTime);
         }
         showFriendShineEffec(true);
      }
      
      private function __stopTalkTime(event:TimerEvent) : void
      {
         _talkTimer.stop();
         _talkTimer.removeEventListener("timer",__stopTalkTime);
      }
      
      protected function __friendOverHandler(event:MouseEvent) : void
      {
         IMManager.Instance.showMessageBox(_goFriendListBtn);
      }
      
      protected function __friendOutHandler(event:MouseEvent) : void
      {
         IMManager.Instance.hideMessageBox();
      }
      
      public function newBtnOpenCartoon() : Point
      {
         var openBtn:* = null;
         var i:int = 0;
         var k:int = 0;
         var j:int = 0;
         var destPosObj:* = null;
         var curGrade:int = PlayerManager.Instance.Self.Grade;
         var tmpLen:int = _guideBtnTxtList.length;
         for(i = 0; i < tmpLen; )
         {
            if(curGrade == _guideBtnTxtList[i].level)
            {
               openBtn = _guideBtnTxtList[i];
               break;
            }
            i++;
         }
         var tmpLen2:int = _openBtnList.length;
         var tmpMoveBtnList:Array = [];
         var openPlace:int = openBtn.place;
         for(k = 0; k < tmpLen2; )
         {
            if(_openBtnList[k].place > openPlace)
            {
               tmpMoveBtnList.push(_openBtnList[k]);
            }
            k++;
         }
         tmpMoveBtnList.sortOn("place",16);
         var tmpLen3:int = tmpMoveBtnList.length;
         var tmpIndex:int = _openBtnList.length - tmpLen3;
         openBtn["btn"].x = _placePointList[tmpIndex]["btn"].x;
         openBtn["btn"].y = _placePointList[tmpIndex]["btn"].y;
         var tmpStartPlace:int = tmpIndex + 1;
         for(j = 0; j < tmpLen3; )
         {
            destPosObj = _placePointList[tmpStartPlace + j];
            TweenLite.to(tmpMoveBtnList[j]["btn"],0.3,{
               "x":destPosObj["btn"].x,
               "y":destPosObj["btn"].y
            });
            j++;
         }
         setTimeout(showCurLevelOpenBtn,300,openBtn);
         return _placePointList[tmpIndex]["btn"] as Point;
      }
      
      private function showCurLevelOpenBtn(openBtn:Object) : void
      {
         openBtn.btn.scaleX = 0.2;
         openBtn.btn.scaleY = 0.2;
         var tmpBtnX:int = openBtn.btn.x;
         var tmpBtnY:int = openBtn.btn.y;
         openBtn.btn.x = openBtn.btn.x + 23;
         openBtn.btn.y = openBtn.btn.y + 25;
         TweenLite.to(openBtn.btn,0.4,{
            "x":tmpBtnX,
            "y":tmpBtnY,
            "scaleX":1,
            "scaleY":1
         });
         var tmpLightMc:MovieClip = ComponentFactory.Instance.creat("asset.newOpenGuide.bagOpenLightMc");
         tmpLightMc.mouseEnabled = false;
         tmpLightMc.mouseChildren = false;
         tmpLightMc.x = tmpBtnX;
         tmpLightMc.y = tmpBtnY;
         addChild(tmpLightMc);
         var mcw:MovieClipWrapper = new MovieClipWrapper(tmpLightMc,true,true);
         addChild(openBtn.btn);
         if(openBtn.btn == _goShopBtn)
         {
            addChild(_goSupplyBtn);
         }
         checkHorseGuide();
      }
      
      public function btnOpen() : void
      {
         var i:int = 0;
         var k:int = 0;
         _openBtnList = [];
         var tmpLen:int = _guideBtnTxtList.length;
         var curGrade:int = PlayerManager.Instance.Self.Grade;
         for(i = 0; i < tmpLen; )
         {
            if(curGrade > _guideBtnTxtList[i].level || curGrade == _guideBtnTxtList[i].level && PlayerManager.Instance.Self.isNewOnceFinish(200 + _guideBtnTxtList[i].level))
            {
               _openBtnList.push(_guideBtnTxtList[i]);
            }
            i++;
         }
         _openBtnList.sortOn("place",16);
         var tmpLen2:int = _openBtnList.length;
         for(k = 0; k < tmpLen2; )
         {
            if(!_openBtnList[k]["btn"].parent)
            {
               addChild(_openBtnList[k]["btn"]);
            }
            _openBtnList[k]["btn"].x = _placePointList[k]["btn"].x;
            _openBtnList[k]["btn"].y = _placePointList[k]["btn"].y;
            k++;
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
      
      private function questManuGetHandler(event:PkgEvent) : void
      {
         HallTaskGuideManager.instance.showTask1ClickBagArrow();
      }
      
      public function set backFunction(fn:Function) : void
      {
         _callBackFun = fn;
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
      
      public function setRoomStartState2(value:Boolean) : void
      {
         KeyboardShortcutsManager.Instance.forbiddenSection(1,value);
         var _loc2_:* = value;
         _goBuriedBtn.enable = _loc2_;
         _loc2_ = _loc2_;
         _goPetBtn.enable = _loc2_;
         _loc2_ = _loc2_;
         _goSupplyBtn.enable = _loc2_;
         _loc2_ = _loc2_;
         _goShopBtn.enable = _loc2_;
         _goReturnBtn.enable = _loc2_;
         setChannelEnable(value);
         setBagEnable(value);
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
      
      public function setReturnEnable(value:Boolean) : void
      {
         _goReturnBtn.enable = value;
      }
      
      public function setBtnStateForConsortiaDomain(enable:Boolean) : void
      {
         _goSupplyBtn.visible = enable;
         _goShopBtn.enable = enable;
         _goChannelBtn.enable = enable;
         _horseBtn.enable = enable;
      }
      
      public function updateReturnBtn(type:int) : void
      {
         this.visible = true;
         switch(int(type))
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
      
      public function set ExitBtnVisible(value:Boolean) : void
      {
         _goExitBtn.visible = value;
      }
      
      private function isBitMapAddGrayFilter(bmp:Bitmap, flg:Boolean) : void
      {
         if(bmp == null)
         {
            return;
         }
         if(!flg)
         {
            bmp.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else
         {
            bmp.filters = null;
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
      
      private function __onReturnClick(event:MouseEvent) : void
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
      
      private function __onExitClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         ExitPromptManager.Instance.showView();
      }
      
      private function __onBuriedClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         if(getTimer() - _lastClick > 1000)
         {
            _lastClick = getTimer();
            BuriedManager.Instance.enter();
         }
      }
      
      private function __onPetClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         if(!PetsBagManager.instance().isShow)
         {
            PetsBagManager.instance().isShow = true;
            PetsBagManager.instance().isSelf = true;
            PetsBagManager.instance().show();
         }
      }
      
      private function __onImClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         IMManager.Instance.show();
      }
      
      private function __onChannelClick(evnet:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         GotoPageController.Instance.switchVisible();
      }
      
      private function __onSignClick(evnet:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         _signEffectEnable = false;
         CalendarManager.getInstance().open(2);
      }
      
      private function __onHorseClick(evnet:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         HorseManager.instance.show();
      }
      
      public function set signEffectEnable(value:Boolean) : void
      {
         _signEffectEnable = value;
      }
      
      private function _overTaskBtn(e:MouseEvent) : void
      {
         ShowTipManager.Instance.removeTip(_goTaskBtn);
         QuestBubbleManager.Instance.addEventListener("show_task_tip",_showTaskTip);
         QuestBubbleManager.Instance.show();
      }
      
      private function _outTaskBtn(e:MouseEvent) : void
      {
         QuestBubbleManager.Instance.dispose();
      }
      
      private function _showTaskTip(e:Event) : void
      {
         ShowTipManager.Instance.addTip(_goTaskBtn);
         ShowTipManager.Instance.showTip(_goTaskBtn);
         QuestBubbleManager.Instance.dispose();
      }
      
      private function __onTaskClick(event:MouseEvent) : void
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
      
      private function __onBagClick(evnet:MouseEvent) : void
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
      
      private function __onShopClick(event:MouseEvent) : void
      {
         var alert:* = null;
         if(toShopNeedConfirm())
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.room.ToShopConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert.addEventListener("response",__confirmToShopResponse);
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
      
      private function __confirmToShopResponse(event:FrameEvent) : void
      {
         var alert:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__confirmToShopResponse);
         ObjectUtils.disposeObject(alert);
         SoundManager.instance.play("008");
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            StateManager.setState("shop");
         }
      }
      
      private function __onSupplyClick(evnet:MouseEvent) : void
      {
         LeavePageManager.leaveToFillPath();
      }
      
      public function set unReadTask(value:Boolean) : void
      {
         if(_unReadTask == value)
         {
            return;
         }
         _unReadTask = value;
         if(_enabled)
         {
            updateTask();
         }
      }
      
      public function get unReadTask() : Boolean
      {
         return _unReadTask;
      }
      
      public function set unReadMovement(value:Boolean) : void
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
         var i:* = 0;
         for(i = uint(0); i < allBtns.length; )
         {
            setEnableByIndex(i,_enabled);
            i++;
         }
         setRoomWaitState();
      }
      
      private function setEnableByIndex(index:int, value:Boolean) : void
      {
         if(index == 1)
         {
            setBagEnable(value);
         }
         else if(index == 4)
         {
            setFriendBtnEnable(value);
         }
         else if(index != 5)
         {
            if(index == 6)
            {
               setChannelEnable(value);
            }
            else
            {
               allBtns[index].enable = value;
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
      
      private function showFriendShineEffec(show:Boolean) : void
      {
         if(show && _goFriendListBtn.parent)
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
      
      private function showTaskShineEffect(show:Boolean) : void
      {
      }
      
      public function showSignShineEffect(show:Boolean) : void
      {
         if(show)
         {
            _signShineEffect.play();
         }
         else
         {
            _signShineEffect.stop();
         }
      }
      
      public function showBagShineEffect(show:Boolean) : void
      {
         if(show && _goBagBtn.parent)
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
      
      public function __player(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      public function refresh() : void
      {
      }
      
      private function setChannelEnable(value:Boolean) : void
      {
         this.isBitMapAddGrayFilter(_otherTxt,value);
         _goChannelBtn.enable = value;
         if(value && PlayerManager.Instance.Self.IsWeakGuildFinish(95))
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
      
      private function setBagEnable(value:Boolean) : void
      {
         this.isBitMapAddGrayFilter(_bagTxt,value);
         _goBagBtn.enable = value;
         if(value)
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
         if(value && PlayerManager.Instance.Self.IsWeakGuildFinish(7))
         {
            KeyboardShortcutsManager.Instance.prohibitNewHandBag(true);
         }
         else
         {
            KeyboardShortcutsManager.Instance.prohibitNewHandBag(false);
         }
      }
      
      private function setFriendBtnEnable(value:Boolean) : void
      {
         this.isBitMapAddGrayFilter(_friendTxt,value);
         _goFriendListBtn.enable = value;
         if(value && PlayerManager.Instance.Self.IsWeakGuildFinish(27))
         {
            KeyboardShortcutsManager.Instance.prohibitNewHandFriend(true);
         }
         else
         {
            KeyboardShortcutsManager.Instance.prohibitNewHandFriend(false);
         }
      }
      
      private function setSignEnable(value:Boolean) : void
      {
         this.isBitMapAddGrayFilter(_signTxt,value);
         _goSignBtn.enable = value;
         if(value && _goSignBtn.parent && _signEffectEnable && !CalendarManager.getInstance().hasTodaySigned())
         {
            showSignShineEffect(true);
         }
         else
         {
            showSignShineEffect(false);
         }
         if(value && PlayerManager.Instance.Self.IsWeakGuildFinish(99))
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
