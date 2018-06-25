package ddtBuried.views
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.BuriedBox;
   import ddt.view.DiceRoll;
   import ddt.view.SimpleReturnBar;
   import ddtBuried.BuriedControl;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import ddtBuried.items.StarItem;
   import ddtBuried.map.Scence1;
   import ddtBuried.role.BuriedPlayer;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import quest.TaskManager;
   import trainer.view.NewHandContainer;
   
   public class DiceView extends Sprite implements Disposeable
   {
       
      
      private var _back:Bitmap;
      
      private var _mapContent:Sprite;
      
      private var _downBack:Bitmap;
      
      private var _starBtn:SimpleBitmapButton;
      
      private var _starBtnTip:SimpleBitmapButton;
      
      private var _freeBtn:SimpleBitmapButton;
      
      private var _shopBtn:SimpleBitmapButton;
      
      private var _scence:Scence1;
      
      private var _diceRoll:DiceRoll;
      
      private var _txtNum:FilterFrameText;
      
      private var _starItem:StarItem;
      
      private var _isWalkOver:Boolean = false;
      
      private var _buriedBox:BuriedBox;
      
      private var _returnBtn:SimpleReturnBar;
      
      private var role:BuriedPlayer;
      
      private var rolePosition:int;
      
      private var rolePoint:Point;
      
      private var roleNowPosition:int;
      
      private var index:uint;
      
      private var _walkArray:Array;
      
      private var _fountain1:MovieClip;
      
      private var _fountain2:MovieClip;
      
      private var cell:BagCell;
      
      private var _fileTxt:FilterFrameText;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _isRemoeEvent:Boolean;
      
      private var _isOneStep:Boolean;
      
      private var currPos:int;
      
      private var onstep:int;
      
      private var _isCount:Boolean = false;
      
      private var _taskTrackView:TaskTrackView;
      
      public function DiceView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         if(BuriedManager.Instance.mapID == 1)
         {
            _walkArray = BuriedControl.Instance.mapArrays.roadMapsList1;
         }
         else if(BuriedManager.Instance.mapID == 2)
         {
            _walkArray = BuriedControl.Instance.mapArrays.roadMapsList2;
         }
         else if(BuriedManager.Instance.mapID == 3)
         {
            _walkArray = BuriedControl.Instance.mapArrays.roadMapsList3;
         }
         rolePosition = BuriedManager.Instance.nowPosition;
         rolePoint = new Point(_walkArray[rolePosition].x,_walkArray[rolePosition].y);
         _back = ComponentFactory.Instance.creat("buried.shaizi.back");
         addChild(_back);
         _fountain1 = ComponentFactory.Instance.creat("buried.dice.fountain");
         var _loc1_:* = 2.5;
         _fountain1.scaleY = _loc1_;
         _fountain1.scaleX = _loc1_;
         _fountain1.x = 64;
         _fountain1.y = 460;
         addChild(_fountain1);
         _fountain2 = ComponentFactory.Instance.creat("buried.dice.fountain");
         _loc1_ = 2.5;
         _fountain2.scaleY = _loc1_;
         _fountain2.scaleX = _loc1_;
         _fountain2.x = 955;
         _fountain2.y = 460;
         addChild(_fountain2);
         _fileTxt = ComponentFactory.Instance.creatComponentByStylename("ddtburied.right.aTtionTxt");
         _fileTxt.text = LanguageMgr.GetTranslation("buried.alertInfo.diceAtion");
         addChild(_fileTxt);
         _mapContent = new Sprite();
         addChild(_mapContent);
         _downBack = ComponentFactory.Instance.creat("buried.shaizi.downBack");
         addChild(_downBack);
         _starBtnTip = ComponentFactory.Instance.creatComponentByStylename("ddtburied.updateStar");
         _starBtnTip.tipData = LanguageMgr.GetTranslation("buried.alertInfo.starBtnTipfree");
         addChild(_starBtnTip);
         _starBtnTip.alpha = 0;
         _starBtnTip.visible = false;
         _starBtn = ComponentFactory.Instance.creatComponentByStylename("ddtburied.updateStar");
         _starBtn.tipData = LanguageMgr.GetTranslation("buried.alertInfo.starBtnTipfree");
         if(BuriedManager.Instance.nowPosition > 0)
         {
            _starBtn.enable = false;
            _starBtnTip.visible = true;
         }
         addChild(_starBtn);
         _freeBtn = ComponentFactory.Instance.creatComponentByStylename("ddtburied.freeBtn");
         _freeBtn.tipData = LanguageMgr.GetTranslation("buried.alertInfo.btnTipfree");
         addChild(_freeBtn);
         _txtNum = ComponentFactory.Instance.creatComponentByStylename("ddtburied.right.btnTxt");
         _freeBtn.addChild(_txtNum);
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("ddtburied.shopBtn");
         addChild(_shopBtn);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"ddtburied.helpBtn",null,LanguageMgr.GetTranslation("store.view.HelpButtonText"),"buried.shaizi.descript",400,480,false) as SimpleBitmapButton;
         _starItem = new StarItem();
         _starItem.x = 374;
         _starItem.y = 547;
         addChild(_starItem);
         _diceRoll = new DiceRoll();
         _diceRoll.x = 159;
         _diceRoll.y = 238;
         addChild(_diceRoll);
         _taskTrackView = new TaskTrackView();
         PositionUtils.setPos(_taskTrackView,"ddtburied.taskTrack.pos");
         role = new BuriedPlayer(PlayerManager.Instance.Self,roleCallback);
         _returnBtn = ComponentFactory.Instance.creatCustomObject("asset.simpleReturnBar.Button");
         _returnBtn.returnCall = exitHandler;
         _returnBtn.x = 909;
         _returnBtn.y = 541;
         addChild(_returnBtn);
         _buriedBox = new BuriedBox();
         _buriedBox.visible = false;
         addChild(_buriedBox);
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(136))
         {
            if(PlayerManager.Instance.Self.Grade >= 25)
            {
               NewHandContainer.Instance.showArrow(147,0,new Point(742,481),"","",this);
            }
         }
      }
      
      private function exitHandler() : void
      {
         BuriedManager.Instance.dispose();
         BuriedControl.Instance.dispose();
         SocketManager.Instance.out.outCard();
      }
      
      private function roleCallback(role:BuriedPlayer, isLoadSucceed:Boolean, vFlag:int) : void
      {
         if(vFlag == 0)
         {
            if(!role)
            {
               return;
            }
            role.sceneCharacterStateType = "natural";
            role.update();
            role.x = rolePoint.x;
            role.y = rolePoint.y;
            addChild(role);
            addChild(_taskTrackView);
         }
      }
      
      public function upDataBtn() : void
      {
         if(_isCount)
         {
            if(BuriedManager.Instance.num - BuriedManager.Instance.pay_count > 0)
            {
               _freeBtn.tipData = LanguageMgr.GetTranslation("buried.alertInfo.btnTipfree");
            }
            else if(BuriedControl.Instance.getPayData())
            {
               _freeBtn.tipData = LanguageMgr.GetTranslation("buried.alertInfo.btnTip",BuriedControl.Instance.getPayData().NeedMoney);
            }
            else
            {
               _freeBtn.tipData = LanguageMgr.GetTranslation("buried.alertInfo.DiceOver",BuriedManager.Instance.limit);
            }
            _freeBtn.addChild(_txtNum);
            return;
         }
         var tmpMouseEnable:Boolean = true;
         if(_freeBtn)
         {
            tmpMouseEnable = _freeBtn.mouseEnabled;
            _freeBtn.removeEventListener("click",rollClickHander);
            ObjectUtils.disposeObject(_freeBtn);
            _freeBtn = null;
         }
         _freeBtn = ComponentFactory.Instance.creatComponentByStylename("ddtburied.payBtn");
         _freeBtn.mouseEnabled = tmpMouseEnable;
         _isCount = true;
         if(BuriedManager.Instance.num - BuriedManager.Instance.pay_count > 0)
         {
            _freeBtn.tipData = LanguageMgr.GetTranslation("buried.alertInfo.btnTipfree");
         }
         else if(BuriedControl.Instance.getPayData())
         {
            _freeBtn.tipData = LanguageMgr.GetTranslation("buried.alertInfo.btnTip",BuriedControl.Instance.getPayData().NeedMoney);
         }
         else
         {
            _freeBtn.tipData = LanguageMgr.GetTranslation("buried.alertInfo.DiceOver",BuriedManager.Instance.limit);
         }
         addChild(_freeBtn);
         _freeBtn.addChild(_txtNum);
         _freeBtn.addEventListener("click",rollClickHander);
      }
      
      public function setTxt(str:String, $visible:Boolean) : void
      {
         if($visible)
         {
            _txtNum.visible = true;
         }
         else
         {
            _txtNum.visible = false;
         }
         if(_txtNum)
         {
            ObjectUtils.disposeObject(_txtNum);
            _txtNum = null;
         }
         _txtNum = ComponentFactory.Instance.creatComponentByStylename("ddtburied.right.btnTxt");
         _txtNum.text = "(" + str + ")";
         _txtNum.x = 98;
         if(BuriedManager.Instance.num - BuriedManager.Instance.pay_count > 0)
         {
            _freeBtn.tipData = LanguageMgr.GetTranslation("buried.alertInfo.btnTipfree");
            _txtNum.x = 113;
         }
         else if(BuriedControl.Instance.getPayData())
         {
            _freeBtn.tipData = LanguageMgr.GetTranslation("buried.alertInfo.btnTip",BuriedControl.Instance.getPayData().NeedMoney);
         }
         else
         {
            _freeBtn.tipData = LanguageMgr.GetTranslation("buried.alertInfo.DiceOver",BuriedManager.Instance.limit);
         }
         _freeBtn.addChild(_txtNum);
      }
      
      public function setCrFrame(str:String) : void
      {
         _diceRoll.setCrFrame(str);
      }
      
      public function play() : void
      {
         _diceRoll.play();
      }
      
      private function initEvents() : void
      {
         _freeBtn.addEventListener("click",rollClickHander);
         _shopBtn.addEventListener("click",openshopHander);
         _starBtn.addEventListener("click",uplevelClickHander);
         BuriedManager.Instance.addEventListener("buried_removeEvent",removeEventHandler);
         BuriedManager.Instance.addEventListener("diceover",diceOverHandler);
         BuriedControl.Instance.addEventListener("mapover",mapOverHandler);
         BuriedControl.Instance.addEventListener("walkOver",roleWalkOverHander);
         BuriedControl.Instance.addEventListener("updatabtnstats",starBtnstatsHander);
         BuriedManager.Instance.addEventListener("boxmovie_over",boxMoiveOverHander);
         BuriedManager.Instance.addEventListener("buried_oneStep",oneStepHander);
      }
      
      private function removeEvents() : void
      {
         _freeBtn.removeEventListener("click",rollClickHander);
         _shopBtn.removeEventListener("click",openshopHander);
         _starBtn.removeEventListener("click",uplevelClickHander);
         BuriedManager.Instance.removeEventListener("buried_oneStep",oneStepHander);
         BuriedManager.Instance.removeEventListener("buried_removeEvent",removeEventHandler);
         BuriedManager.Instance.removeEventListener("diceover",diceOverHandler);
         BuriedControl.Instance.removeEventListener("mapover",mapOverHandler);
         BuriedControl.Instance.removeEventListener("updatabtnstats",starBtnstatsHander);
         BuriedControl.Instance.removeEventListener("walkOver",roleWalkOverHander);
         BuriedManager.Instance.removeEventListener("boxmovie_over",boxMoiveOverHander);
      }
      
      private function oneStepHander(e:BuriedEvent) : void
      {
         var obj:Object = e.data;
         onstep = obj.key;
         _isOneStep = true;
      }
      
      private function removeEventHandler(e:BuriedEvent) : void
      {
         var obj:Object = e.data;
         currPos = obj.key;
         _isRemoeEvent = true;
      }
      
      private function frameEvent(e:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         e.currentTarget.dispose();
      }
      
      private function boxMoiveOverHander(e:BuriedEvent) : void
      {
         var frame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("buried.alertInfo.mapover"),LanguageMgr.GetTranslation("ok"),"",true,true,true,2,null,"SimpleAlert",60,false);
         frame.addEventListener("response",onMapOverResponse);
      }
      
      private function starBtnstatsHander(e:BuriedEvent) : void
      {
         _starBtn.enable = true;
         _starBtnTip.visible = false;
      }
      
      private function flyGoods() : void
      {
         var id:int = BuriedManager.Instance.currGoodID;
         var info:ItemTemplateInfo = ItemManager.Instance.getTemplateById(id);
         cell = new BagCell(0,info);
         cell.x = role.x;
         cell.y = role.y;
         addChild(cell);
         TweenMax.to(cell,1,{
            "x":461,
            "y":518,
            "scaleX":0.1,
            "scaleY":0.1,
            "onComplete":comp,
            "bezier":[{
               "x":role.x,
               "y":role.y - 80
            }]
         });
      }
      
      private function comp() : void
      {
         ObjectUtils.disposeObject(cell);
      }
      
      private function walkContinueHander(e:BuriedEvent) : void
      {
         var roadArray:* = null;
         if(BuriedManager.Instance.isGetGoods)
         {
            BuriedManager.Instance.isGetGoods = false;
            _scence.updateRoadPoint();
            flyGoods();
         }
         if(_isWalkOver)
         {
            _isWalkOver = false;
            BuriedManager.Instance.isContinue = false;
            BuriedManager.Instance.nowPosition = BuriedManager.Instance.eventPosition;
            roadArray = configRoadArray();
            role.roleWalk(roadArray);
            roleWalkPosition(BuriedManager.Instance.nowPosition);
         }
      }
      
      private function roleWalkOverHander(e:BuriedEvent) : void
      {
         var roadArray:* = null;
         _isWalkOver = true;
         if(BuriedManager.Instance.isBackToStart)
         {
            BuriedManager.Instance.isBackToStart = false;
            _starBtn.enable = true;
            _starBtnTip.visible = false;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("buried.alertInfo.toStart"));
         }
         else if(BuriedManager.Instance.isGo)
         {
            BuriedManager.Instance.isGo = false;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("buried.alertInfo.toGo"));
         }
         else if(BuriedManager.Instance.isGoEnd)
         {
            BuriedManager.Instance.isOver = true;
            BuriedManager.Instance.isGoEnd = false;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("buried.alertInfo.toEnd"));
         }
         else if(BuriedManager.Instance.isBack)
         {
            BuriedManager.Instance.isBack = false;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("buried.alertInfo.toBack"));
         }
         if(BuriedManager.Instance.isOpenBuried)
         {
            BuriedManager.Instance.isOpenBuried = false;
            BuriedControl.Instance.dispatchEvent(new BuriedEvent("openburiedview"));
         }
         _freeBtn.mouseEnabled = true;
         _returnBtn.mouseEnabled = true;
         _returnBtn.mouseChildren = true;
         if(_isRemoeEvent && _isWalkOver)
         {
            _isRemoeEvent = false;
            _scence.updateRoadPoint(currPos);
         }
         if(_isOneStep && _isWalkOver)
         {
            _isOneStep = false;
            _scence.updateRoadPoint(onstep);
         }
         _taskTrackView.refreshTask();
         if(BuriedManager.Instance.isContinue)
         {
            BuriedManager.Instance.isContinue = false;
            _freeBtn.mouseEnabled = false;
            _returnBtn.mouseEnabled = false;
            _returnBtn.mouseChildren = false;
            _isWalkOver = false;
            BuriedManager.Instance.nowPosition = BuriedManager.Instance.eventPosition;
            roleWalkPosition(BuriedManager.Instance.nowPosition);
            roadArray = configRoadArray();
            role.roleWalk(roadArray);
         }
         if(BuriedManager.Instance.isGetGoods && _isWalkOver)
         {
            BuriedManager.Instance.isGetGoods = false;
            _scence.updateRoadPoint();
            flyGoods();
         }
      }
      
      private function mapOverHandler(e:BuriedEvent) : void
      {
         _buriedBox.visible = true;
         _buriedBox.initView(BuriedManager.Instance.level);
         _buriedBox.play();
         _freeBtn.mouseEnabled = false;
         _returnBtn.mouseEnabled = false;
         _returnBtn.mouseChildren = false;
      }
      
      private function onMapOverResponse(e:FrameEvent) : void
      {
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",onMapOverResponse);
         if(e.responseCode == 1 || e.responseCode == 2 || e.responseCode == 3 || e.responseCode == 0)
         {
            SocketManager.Instance.out.refreshMap();
         }
         frame.dispose();
      }
      
      private function diceOverHandler(e:BuriedEvent) : void
      {
         var roadArray:Array = configRoadArray();
         _isWalkOver = false;
         role.roleWalk(roadArray);
         roleWalkPosition(BuriedManager.Instance.nowPosition);
         rolePosition = roleNowPosition;
         _starBtn.enable = false;
         _starBtnTip.visible = true;
         _freeBtn.mouseEnabled = false;
         _returnBtn.mouseEnabled = false;
         _returnBtn.mouseChildren = false;
      }
      
      private function configRoadArray() : Array
      {
         var i:int = 0;
         var j:int = 0;
         roleNowPosition = BuriedManager.Instance.nowPosition;
         var roadArray:Array = [];
         if(rolePosition < roleNowPosition)
         {
            for(i = rolePosition; i <= roleNowPosition; )
            {
               roadArray.push(_walkArray[i]);
               i++;
            }
         }
         else
         {
            for(j = rolePosition; j >= roleNowPosition; )
            {
               roadArray.push(_walkArray[j]);
               j--;
            }
         }
         rolePosition = roleNowPosition;
         return roadArray;
      }
      
      private function roleWalkPosition(position:int) : void
      {
         var xpos:int = 0;
         var ypos:int = 0;
         if(BuriedManager.Instance.mapID == 1)
         {
            xpos = BuriedControl.Instance.mapArrays.standArray1[position].x;
            ypos = BuriedControl.Instance.mapArrays.standArray1[position].y;
         }
         else if(BuriedManager.Instance.mapID == 2)
         {
            xpos = BuriedControl.Instance.mapArrays.standArray2[position].x;
            ypos = BuriedControl.Instance.mapArrays.standArray2[position].y;
         }
         else
         {
            xpos = BuriedControl.Instance.mapArrays.standArray3[position].x;
            ypos = BuriedControl.Instance.mapArrays.standArray3[position].y;
         }
         _scence.selfFindPath(xpos,ypos);
      }
      
      private function rollClickHander(e:MouseEvent) : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(136))
         {
            if(PlayerManager.Instance.Self.Grade >= 25)
            {
               SocketManager.Instance.out.syncWeakStep(136);
               NewHandContainer.Instance.clearArrowByID(147);
            }
         }
         _diceRoll.resetFrame();
         SoundManager.instance.playButtonSound();
         if(TaskManager.instance.isHaveBuriedQuest())
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("buried.alertInfo.questsContiniue"));
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(BuriedManager.Instance.currPayLevel >= 0)
         {
            if(!BuriedControl.Instance.getPayData())
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("buried.alertInfo.DiceOver"));
               return;
            }
            if(BuriedManager.Instance.getRemindRoll())
            {
               if(BuriedManager.Instance.checkMoney(BuriedManager.Instance.getRemindRollBind(),BuriedControl.Instance.getPayData().NeedMoney,SocketManager.Instance.out.rollDice))
               {
                  BuriedManager.Instance.setRemindRoll(false);
                  BuriedManager.Instance.setRemindRollBind(false);
                  BuriedControl.Instance.showTransactionFrame(LanguageMgr.GetTranslation("buried.alertInfo.rollDiceContiniue",BuriedControl.Instance.getPayData().NeedMoney),payRollHander,clickCallBack);
                  return;
               }
               SocketManager.Instance.out.rollDice(BuriedManager.Instance.getRemindRollBind());
               _isWalkOver = false;
               _starBtn.enable = false;
               _starBtnTip.visible = true;
               _freeBtn.mouseEnabled = false;
               _returnBtn.mouseEnabled = false;
               _returnBtn.mouseChildren = false;
               return;
            }
            BuriedControl.Instance.showTransactionFrame(LanguageMgr.GetTranslation("buried.alertInfo.rollDiceContiniue",BuriedControl.Instance.getPayData().NeedMoney),payRollHander,clickCallBack);
            return;
         }
         SocketManager.Instance.out.rollDice();
         _isWalkOver = false;
         _starBtn.enable = false;
         _starBtnTip.visible = true;
         _freeBtn.mouseEnabled = false;
         _returnBtn.mouseEnabled = false;
         _returnBtn.mouseChildren = false;
      }
      
      private function clickCallBack(bool:Boolean) : void
      {
         BuriedManager.Instance.setRemindRoll(bool);
      }
      
      private function payRollHander(bool:Boolean) : void
      {
         if(BuriedManager.Instance.checkMoney(bool,BuriedControl.Instance.getPayData().NeedMoney,SocketManager.Instance.out.rollDice))
         {
            BuriedManager.Instance.setRemindRoll(false);
            return;
         }
         if(BuriedManager.Instance.getRemindRoll())
         {
            BuriedManager.Instance.setRemindRollBind(bool);
         }
         SocketManager.Instance.out.rollDice(bool);
         _freeBtn.mouseEnabled = false;
         _starBtn.enable = false;
         _returnBtn.mouseEnabled = false;
         _returnBtn.mouseChildren = false;
         _diceRoll.resetFrame();
      }
      
      private function openshopHander(e:MouseEvent) : void
      {
         BuriedControl.Instance.openshopHander();
         SoundManager.instance.playButtonSound();
      }
      
      private function uplevelClickHander(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(BuriedManager.Instance.level >= 5)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("buried.alertInfo.starFull"));
            return;
         }
         var frame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("buried.alertInfo.uplevel",BuriedControl.Instance.getUpdateData(true).NeedMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,1);
         frame.addEventListener("response",onUpLevelResponse);
      }
      
      private function onUpLevelResponse(e:FrameEvent) : void
      {
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",onUpLevelResponse);
         if(e.responseCode == 0 || e.responseCode == 4 || e.responseCode == 1)
         {
            frame.dispose();
            return;
         }
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            CheckMoneyUtils.instance.checkMoney(frame.isBand,BuriedControl.Instance.getUpdateData(true).NeedMoney,onCheckComplete);
         }
         frame.dispose();
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.upgradeStartLevel(CheckMoneyUtils.instance.isBind);
      }
      
      public function clearScene() : void
      {
         if(_scence)
         {
            ObjectUtils.disposeObject(_scence);
            _scence = null;
         }
      }
      
      public function setStarList(num:int) : void
      {
         _starItem.setStarList(num);
      }
      
      public function updataStarLevel(num:int) : void
      {
         _starItem.updataStarLevel(num);
      }
      
      public function addMaps(str:String, row:int, col:int, _x:int, _y:int) : void
      {
         clearScene();
         _scence = new Scence1(str,row,col);
         _scence.x = _x;
         _scence.y = _y;
         _mapContent.addChild(_scence);
      }
      
      public function setLimitNum(limit:int) : void
      {
         if(BuriedManager.Instance.num - BuriedManager.Instance.pay_count > 0)
         {
            _freeBtn.tipData = LanguageMgr.GetTranslation("buried.alertInfo.btnTipfree");
         }
         else if(BuriedControl.Instance.getPayData())
         {
            _freeBtn.tipData = LanguageMgr.GetTranslation("buried.alertInfo.btnTip",BuriedControl.Instance.getPayData().NeedMoney);
         }
         else
         {
            _freeBtn.tipData = LanguageMgr.GetTranslation("buried.alertInfo.DiceOver",limit);
         }
      }
      
      public function dispose() : void
      {
         NewHandContainer.Instance.clearArrowByID(136);
         removeEvents();
         if(_fountain1)
         {
            _fountain1.stop();
            while(_fountain1.numChildren)
            {
               ObjectUtils.disposeObject(_fountain1.getChildAt(0));
            }
         }
         if(_fountain2)
         {
            _fountain2.stop();
            while(_fountain2.numChildren)
            {
               ObjectUtils.disposeObject(_fountain2.getChildAt(0));
            }
         }
         if(_starItem)
         {
            _starItem.dispose();
         }
         if(_scence)
         {
            _scence.dispose();
         }
         ObjectUtils.disposeObject(_scence);
         ObjectUtils.disposeObject(_txtNum);
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         _scence = null;
         _txtNum = null;
         _fountain1 = null;
         _fountain2 = null;
         _helpBtn = null;
      }
   }
}
