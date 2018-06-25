package bagAndInfo.ddtKingGrade
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import road7th.utils.MovieClipWrapper;
   
   public class DDTKingGradeFrame extends Frame
   {
       
      
      private var _viewBg:Bitmap;
      
      private var _viewTitle:Bitmap;
      
      private var _propertyVBox:VBox;
      
      private var _propertyTextList:Vector.<FilterFrameText>;
      
      private var _usableNumText:FilterFrameText;
      
      private var _usableNum:int = 0;
      
      private var _currentExp:Number;
      
      private var _nextExp:Number;
      
      private var _tipsText:FilterFrameText;
      
      private var _resetBtn:SimpleBitmapButton;
      
      private var _allBtn:SimpleBitmapButton;
      
      private var _breakBtn:MovieClip;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _rotateBg:MovieClipWrapper;
      
      private var _progress:MovieClip;
      
      private var _progressText:FilterFrameText;
      
      private var _gradeText:FilterFrameText;
      
      private var _progressTips:Component;
      
      private var _btnHelp:BaseButton;
      
      private var _currentButton:DDTKingGradeSelectedButton;
      
      private var _currentTime:int;
      
      public function DDTKingGradeFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var text:* = null;
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"coreii.helpBtn",{
            "x":539,
            "y":5
         },LanguageMgr.GetTranslation("ddt.consortia.bossFrame.helpTitle"),"asset.ddtKingGrade.helpContent",408,488);
         _viewBg = ComponentFactory.Instance.creatBitmap("asset.ddtKingGrade.viewBg");
         _viewTitle = ComponentFactory.Instance.creatBitmap("asset.ddtKingGrade.viewTitle");
         _propertyVBox = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.vBox");
         _usableNumText = ComponentFactory.Instance.creatComponentByStylename("ddtkinggrade.usableNumText");
         _tipsText = ComponentFactory.Instance.creatComponentByStylename("ddtkinggrade.propertyTipsText");
         _tipsText.text = LanguageMgr.GetTranslation("tank.ddtkingGrade.tips");
         _resetBtn = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.resetBtn");
         _allBtn = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.allBtn");
         _breakBtn = ComponentFactory.Instance.creat("asset.ddtKingGrade.break");
         _breakBtn.buttonMode = true;
         PositionUtils.setPos(_breakBtn,"ddtKingGrade.breakBtnPos");
         _rotateBg = new MovieClipWrapper(ComponentFactory.Instance.creat("asset.ddtKingGrade.rotateBg"));
         PositionUtils.setPos(_rotateBg.movie,"ddtKingGrade.rotateBgPos");
         _propertyTextList = new Vector.<FilterFrameText>();
         for(i = 0; i < 6; )
         {
            text = ComponentFactory.Instance.creatComponentByStylename("ddtkinggrade.propertyText");
            _propertyVBox.addChild(text);
            _propertyTextList.push(text);
            i++;
         }
         addToContent(_viewBg);
         addToContent(_viewTitle);
         addToContent(_propertyVBox);
         addToContent(_usableNumText);
         addToContent(_tipsText);
         addToContent(_rotateBg.movie);
         addToContent(_resetBtn);
         addToContent(_allBtn);
         addToContent(_breakBtn);
         _btnGroup = new SelectedButtonGroup();
         _currentButton = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.attackButton");
         _btnGroup.addSelectItem(_currentButton);
         addToContent(_currentButton);
         _currentButton = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.defenceButton");
         _btnGroup.addSelectItem(_currentButton);
         addToContent(_currentButton);
         _currentButton = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.agilityButton");
         _btnGroup.addSelectItem(_currentButton);
         addToContent(_currentButton);
         _currentButton = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.luckButton");
         _btnGroup.addSelectItem(_currentButton);
         addToContent(_currentButton);
         _currentButton = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.mAttackButton");
         _btnGroup.addSelectItem(_currentButton);
         addToContent(_currentButton);
         _currentButton = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.mDefendButton");
         _btnGroup.addSelectItem(_currentButton);
         addToContent(_currentButton);
         _btnGroup.selectIndex = -1;
         _progress = ComponentFactory.Instance.creat("asset.ddtKingGrade.progress");
         _progress.mouseChildren = false;
         PositionUtils.setPos(_progress,"ddtKingGrade.progressPos");
         addToContent(_progress);
         _progressText = ComponentFactory.Instance.creat("ddtKingGrade.progressText");
         addToContent(_progressText);
         _gradeText = ComponentFactory.Instance.creat("ddtKingGrade.gradeText");
         _gradeText.text = LanguageMgr.GetTranslation("ddtKingGrade.grade",PlayerManager.Instance.Self.ddtKingGrade);
         addToContent(_gradeText);
         _progressTips = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.progressTips");
         _progressTips.graphics.beginFill(0,0);
         _progressTips.graphics.drawRect(0,0,290,20);
         _progressTips.graphics.endFill();
         addToContent(_progressTips);
         _progressTips.tipData = "0/0";
         _currentButton = null;
         updateView();
      }
      
      private function __onBreak(e:PkgEvent) : void
      {
         var complete:Boolean = e.pkg.readBoolean();
         if(complete)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingGrade.break"));
            playAction();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingGrade.breakFail"));
         }
      }
      
      private function __onUpdateInfo(e:PkgEvent) : void
      {
         var p:* = NaN;
         var i:int = 0;
         var item:* = null;
         var cost:int = 0;
         var ratio:Number = NaN;
         _usableNum = e.pkg.readInt();
         _currentExp = e.pkg.readLong();
         _nextExp = e.pkg.readLong();
         _progressTips.tipData = _currentExp + "/" + _nextExp;
         if(_nextExp > 0)
         {
            p = Number(Math.floor(_currentExp / _nextExp * 10000) / 100);
         }
         else
         {
            p = 0;
         }
         _progressText.text = p + "%";
         _gradeText.text = LanguageMgr.GetTranslation("ddtKingGrade.grade",PlayerManager.Instance.Self.ddtKingGrade);
         _progress.gotoAndStop(int(p));
         for(i = 0; i < 6; )
         {
            item = _btnGroup.getItemByIndex(i) as DDTKingGradeSelectedButton;
            cost = e.pkg.readInt();
            item.cost = cost;
            item.tipData = {
               "cost":cost,
               "currentCost":_usableNum,
               "type":i
            };
            ratio = e.pkg.readInt() / 10;
            _propertyTextList[i].text = ratio + "%";
            i++;
         }
         updateView();
      }
      
      private function updateView() : void
      {
         _usableNumText.text = LanguageMgr.GetTranslation("tank.ddtkingGrade.usableNum",_usableNum);
      }
      
      public function playAction() : void
      {
         _rotateBg.movie.visible = true;
         _rotateBg.gotoAndPlay(1);
         if(_currentButton)
         {
            _currentButton.playAction();
         }
      }
      
      private function __onPlayActionComplete(e:Event) : void
      {
         _rotateBg.movie.visible = false;
      }
      
      private function __onClickReset(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_btnGroup.selectIndex == -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingGrade.selectReset"));
            return;
         }
         if(_currentButton && _currentButton.level <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingGrade.propertyNotReset"));
            return;
         }
         var arr:Array = ["attack","defence","agility","luck","magicAttack","magicDefend"];
         var p:String = LanguageMgr.GetTranslation(arr[_btnGroup.selectIndex]);
         var frame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddtKingGrade.reset",ServerConfigManager.instance.maxLevelResetCost,p),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
         frame.addEventListener("response",__onReset);
      }
      
      private function __onReset(e:FrameEvent) : void
      {
         e = e;
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onReset);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(false,ServerConfigManager.instance.maxLevelResetCost,function():void
            {
               SocketManager.Instance.out.sendDDTKingGradeReset(false,_btnGroup.selectIndex + 1);
            });
         }
      }
      
      private function __onClickAllReset(e:MouseEvent) : void
      {
         var i:int = 0;
         var button:* = null;
         var frame:* = null;
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var isReset:Boolean = false;
         for(i = 0; i < _btnGroup.length(); )
         {
            button = _btnGroup.getItemByIndex(i) as DDTKingGradeSelectedButton;
            if(button.level > 0)
            {
               isReset = true;
               break;
            }
            i++;
         }
         if(isReset)
         {
            frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddtKingGrade.allReset",ServerConfigManager.instance.maxLevelAllResetCost),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
            frame.addEventListener("response",__onAllReset);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingGrade.allNotReset"));
         }
      }
      
      private function __onAllReset(e:FrameEvent) : void
      {
         e = e;
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onAllReset);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(false,ServerConfigManager.instance.maxLevelAllResetCost,function():void
            {
               SocketManager.Instance.out.sendDDTKingGradeReset(true,_btnGroup.selectIndex + 1);
            });
         }
      }
      
      private function __onClickBreak(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(getTimer() - _currentTime < 2000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("carnival.clickTip"));
            return;
         }
         _currentTime = getTimer();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_btnGroup.selectIndex == -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingGrade.selectBreak"));
            return;
         }
         var nextInfo:DDTKingGradeInfo = DDTKingGradeManager.Instance.data[_currentButton.level + 1];
         if(nextInfo == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingGrade.maxProperty"));
            return;
         }
         if(_usableNum + _currentButton.cost < nextInfo.Cost)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingGrade.breakTip"));
            return;
         }
         SocketManager.Instance.out.sendDDTKingGradeUp(_btnGroup.selectIndex + 1);
      }
      
      private function __onButtonChange(e:Event) : void
      {
         _currentButton = _btnGroup.getItemByIndex(_btnGroup.selectIndex) as DDTKingGradeSelectedButton;
      }
      
      public function show() : void
      {
         SocketManager.Instance.out.sendDDTKingGradeInfo();
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function addEvent() : void
      {
         _resetBtn.addEventListener("click",__onClickReset);
         _allBtn.addEventListener("click",__onClickAllReset);
         _breakBtn.addEventListener("click",__onClickBreak);
         _rotateBg.addEventListener("complete",__onPlayActionComplete);
         _btnGroup.addEventListener("change",__onButtonChange);
         SocketManager.Instance.addEventListener(PkgEvent.format(370,3),__onUpdateInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(370,1),__onBreak);
      }
      
      private function removeEvent() : void
      {
         _resetBtn.removeEventListener("click",__onClickReset);
         _allBtn.removeEventListener("click",__onClickAllReset);
         _breakBtn.removeEventListener("click",__onClickBreak);
         _rotateBg.removeEventListener("complete",__onPlayActionComplete);
         _btnGroup.removeEventListener("change",__onButtonChange);
         SocketManager.Instance.removeEventListener(PkgEvent.format(370,3),__onUpdateInfo);
         SocketManager.Instance.removeEventListener(PkgEvent.format(370,1),__onBreak);
      }
      
      override protected function onResponse(type:int) : void
      {
         DDTKingGradeManager.Instance.isOpen = false;
         dispose();
      }
      
      override public function dispose() : void
      {
         if(_btnHelp)
         {
            ObjectUtils.disposeObject(_btnHelp);
         }
         _btnHelp = null;
         removeEvent();
         _propertyTextList.splice(0,_propertyTextList.length);
         ObjectUtils.disposeObject(_propertyVBox);
         ObjectUtils.disposeObject(_btnGroup);
         ObjectUtils.disposeObject(_rotateBg);
         ObjectUtils.disposeObject(_progress);
         ObjectUtils.disposeObject(_progressText);
         ObjectUtils.disposeObject(_gradeText);
         super.dispose();
         _gradeText = null;
         _progressText = null;
         _propertyTextList = null;
         _progress = null;
         _btnGroup = null;
         _resetBtn = null;
         _allBtn = null;
         _breakBtn = null;
         _propertyVBox = null;
         _viewBg = null;
         _viewTitle = null;
         _rotateBg = null;
      }
   }
}
