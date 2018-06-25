package godsRoads.view
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.selfConsortia.ConsortionBankBagView;
   import ddt.bagStore.BagStore;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.BattleGroudManager;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import godsRoads.GodRoadsController;
   import godsRoads.data.GodsRoadsMissionInfo;
   import godsRoads.data.GodsRoadsMissionVo;
   import godsRoads.data.GodsRoadsStepVo;
   import godsRoads.data.GodsRoadsVo;
   import godsRoads.manager.GodsRoadsManager;
   import godsRoads.model.GodsRoadsModel;
   import hallIcon.model.ActivityEnterGrapType;
   import labyrinth.LabyrinthManager;
   import quest.TaskManager;
   import ringStation.RingStationManager;
   import wantstrong.WantStrongControl;
   
   public class GodsRoadsView extends Frame
   {
       
      
      private var _view:Sprite;
      
      private var _model:GodsRoadsModel;
      
      private var _listPanel:ListPanel;
      
      private var _data:GodsRoadsVo;
      
      private var _currentLv:int;
      
      private var _currentMissionID:int;
      
      private var _currentStep:GodsRoadsStepVo;
      
      private var _missionContentTxt:FilterFrameText;
      
      private var _missionProgressTxt:FilterFrameText;
      
      private var _missionStatusTxt:FilterFrameText;
      
      private var _contentTxt:FilterFrameText;
      
      private var _progressTxt:FilterFrameText;
      
      private var _statusTxt:FilterFrameText;
      
      private var _stepProgressTxt:FilterFrameText;
      
      private var _stepProgressNum:FilterFrameText;
      
      private var _smallBtn:BaseButton;
      
      private var _bigBtn:BaseButton;
      
      private var _stepIsOpen:Boolean = false;
      
      private var _btnArr:Vector.<GodsRoadsFlag>;
      
      private var _missionAwardsView:Sprite;
      
      private var _stepAwardsView:Sprite;
      
      public function GodsRoadsView()
      {
         _view = new Sprite();
         _btnArr = new Vector.<GodsRoadsFlag>(7);
         _missionAwardsView = new Sprite();
         _stepAwardsView = new Sprite();
         _model = GodsRoadsManager.instance._model;
         _currentLv = _model.godsRoadsData.currentLevel;
         _currentStep = _model.godsRoadsData.steps[_currentLv - 1];
         super();
         escEnable = true;
      }
      
      public function initView() : void
      {
         addToContent(_view);
         var bg:Bitmap = ComponentFactory.Instance.creatBitmap("asset.GodsRoads.bg");
         _view.addChild(bg);
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("godsRoads.missionList");
         _view.addChild(_listPanel);
         _listPanel.list.setListData(_model.godsRoadsData.currentSteps.missionVos);
         _listPanel.list.updateListView();
         _missionContentTxt = ComponentFactory.Instance.creat("godsRoads.missionContentTxt");
         _missionProgressTxt = ComponentFactory.Instance.creat("godsRoads.missionContentTxt");
         _missionStatusTxt = ComponentFactory.Instance.creat("godsRoads.missionContentTxt");
         _missionContentTxt.text = LanguageMgr.GetTranslation("ddt.godsRoads.contenttxt");
         _missionProgressTxt.text = LanguageMgr.GetTranslation("ddt.godsRoads.progresstxt");
         _missionStatusTxt.text = LanguageMgr.GetTranslation("ddt.godsRoads.statustxt");
         PositionUtils.setPos(_missionContentTxt,"godsRoads.missionContentPos1");
         PositionUtils.setPos(_missionProgressTxt,"godsRoads.missionContentPos2");
         PositionUtils.setPos(_missionStatusTxt,"godsRoads.missionContentPos3");
         _view.addChild(_missionContentTxt);
         _view.addChild(_missionProgressTxt);
         _view.addChild(_missionStatusTxt);
         _contentTxt = ComponentFactory.Instance.creat("godsRoads.contentTxt");
         _progressTxt = ComponentFactory.Instance.creat("godsRoads.contentTxt");
         _statusTxt = ComponentFactory.Instance.creat("godsRoads.contentTxt");
         PositionUtils.setPos(_contentTxt,"godsRoads.contentPos1");
         PositionUtils.setPos(_progressTxt,"godsRoads.contentPos2");
         PositionUtils.setPos(_statusTxt,"godsRoads.contentPos3");
         _view.addChild(_contentTxt);
         _view.addChild(_progressTxt);
         _view.addChild(_statusTxt);
         _stepProgressTxt = ComponentFactory.Instance.creat("godsRoads.stepProgress");
         PositionUtils.setPos(_stepProgressTxt,"godsRoads.stepProgressPos");
         _view.addChild(_stepProgressTxt);
         _stepProgressNum = ComponentFactory.Instance.creat("godsRoads.stepProgressNum");
         PositionUtils.setPos(_stepProgressNum,"godsRoads.stepProgressPos1");
         _view.addChild(_stepProgressNum);
         _smallBtn = ComponentFactory.Instance.creat("godsRoads.smallAwardsBtn");
         _smallBtn.enable = false;
         _bigBtn = ComponentFactory.Instance.creat("godsRoads.bigAwardsBtn");
         _bigBtn.enable = false;
         _view.addChild(_smallBtn);
         _view.addChild(_bigBtn);
         initBtn();
         PositionUtils.setPos(_missionAwardsView,"godsRoads.missionAwardsViewPos");
         _view.addChild(_missionAwardsView);
         PositionUtils.setPos(_stepAwardsView,"godsRoads.stepAwardsViewPos");
         _view.addChild(_stepAwardsView);
         initEvent();
      }
      
      private function initBtn() : void
      {
         var i:int = 0;
         for(i = 0; i < 7; )
         {
            _btnArr[i] = ComponentFactory.Instance.creat("godsRoads.GodsRoadsFlag" + (i + 1),[i + 1]);
            _btnArr[i].enable = false;
            _view.addChild(_btnArr[i]);
            i++;
         }
      }
      
      public function changeSteps(lv:int, mission:int = 0) : void
      {
         _listPanel.vectorListModel.clear();
         _stepIsOpen = _btnArr[lv - 1].isOpened;
         _currentLv = lv;
         _currentStep = _model.godsRoadsData.steps[_currentLv - 1];
         if(_currentStep.getFinishPerNum() == 100)
         {
            if(_currentStep.isGetAwards)
            {
               _bigBtn.enable = false;
            }
            else
            {
               _bigBtn.enable = true;
            }
         }
         else
         {
            _bigBtn.enable = false;
         }
         _listPanel.list.setListData(_currentStep.missionVos);
         _listPanel.list.updateListView();
         _listPanel.list.currentSelectedIndex = mission;
         _stepProgressTxt.text = LanguageMgr.GetTranslation("ddt.godsRoads.stepProgress");
         _stepProgressNum.text = _currentStep.getFinishPerString();
         GodRoadsController.instance.lastStep = _currentStep.currentStep;
         flushStepAwards();
      }
      
      public function updateView(_model:GodsRoadsModel, stepIndex:int = 0, missionIndex:int = 0) : void
      {
         var i:int = 0;
         _data = _model.godsRoadsData;
         for(i = 0; i < 7; )
         {
            if(i + 1 <= _data.currentLevel)
            {
               _btnArr[i].enable = true;
               if(i + 1 <= _data.currentLevel)
               {
                  _btnArr[i].progressNum = _data.steps[i].getFinishPerNum();
               }
               else
               {
                  _btnArr[i].showProgress = false;
               }
            }
            else
            {
               _btnArr[i].enable = false;
            }
            i++;
         }
         if(stepIndex)
         {
            changeSteps(stepIndex,missionIndex);
         }
         else
         {
            changeSteps(_data.currentLevel);
         }
      }
      
      private function flushStepAwards() : void
      {
         var i:int = 0;
         var awardsBox:* = null;
         var itemInfo:* = null;
         var cell:* = null;
         ObjectUtils.disposeAllChildren(_stepAwardsView);
         var awardsArr:Array = _currentStep.awards;
         for(i = 0; i < awardsArr.length; )
         {
            awardsBox = ComponentFactory.Instance.creatBitmap("asset.godsRoads.stepAwardsBox");
            itemInfo = awardsArr[i] as InventoryItemInfo;
            cell = new BagCell(i,itemInfo,false,awardsBox,false);
            cell.setContentSize(48,48);
            cell.setCount(awardsArr[i].Count);
            cell.x = i % 5 * 50;
            cell.y = int(i / 5) * 50;
            _stepAwardsView.addChild(cell);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         this.addEventListener("response",__response);
         if(_listPanel)
         {
            _listPanel.list.addEventListener("listItemClick",__itemClick);
            _listPanel.list.currentSelectedIndex = 0;
         }
         _smallBtn.addEventListener("click",getMissionAwards);
         _bigBtn.addEventListener("click",getStepAwards);
      }
      
      private function __response(e:FrameEvent) : void
      {
         if(e.responseCode == 0 || e.responseCode == 1 || e.responseCode == 4)
         {
            removeEventListener("response",__response);
            dispose();
         }
      }
      
      private function getMissionAwards(e:MouseEvent) : void
      {
         SocketManager.Instance.out.getGodsRoadsAwards(1,_currentMissionID);
      }
      
      private function getStepAwards(e:MouseEvent) : void
      {
         SocketManager.Instance.out.getGodsRoadsAwards(2,_currentLv);
      }
      
      private function __itemClick(e:ListItemEvent) : void
      {
         var i:int = 0;
         var awardsBox:* = null;
         var itemInfo:* = null;
         var cell:* = null;
         ObjectUtils.disposeAllChildren(_missionAwardsView);
         var missionCell:GodsRoadsMisstionCell = e.cell as GodsRoadsMisstionCell;
         var mVo:GodsRoadsMissionVo = missionCell.getCellValue();
         _currentMissionID = mVo.ID;
         GodRoadsController.instance.lastMssion = e.index;
         var awardsArr:Array = mVo.awards;
         for(i = 0; i < awardsArr.length; )
         {
            awardsBox = ComponentFactory.Instance.creatBitmap("asset.godsRoads.missionAwardsBox");
            itemInfo = awardsArr[i] as InventoryItemInfo;
            cell = new BagCell(i,itemInfo,false,awardsBox,false);
            cell.setContentSize(42,42);
            cell.setCount(awardsArr[i].Count);
            cell.x = i % 5 * 44;
            cell.y = int(i / 5) * 44;
            _missionAwardsView.addChild(cell);
            i++;
         }
         var info:GodsRoadsMissionInfo = _model.getMissionInfoById(mVo.ID);
         if(info.Detail.length > 26)
         {
            _contentTxt.text = info.Detail.substring(0,26) + "...";
         }
         else
         {
            _contentTxt.text = info.Detail;
         }
         var tempInt:int = mVo.condition1;
         if(tempInt > info.Para2)
         {
            tempInt = info.Para2;
         }
         _progressTxt.text = tempInt + "/" + info.Para2;
         if(mVo.isFinished)
         {
            _progressTxt.text = info.Para2 + "/" + info.Para2;
            _statusTxt.textFormatStyle = "godsRoads.TextFormat5";
            _statusTxt.filterString = "godsRoads.GF5";
            _statusTxt.mouseEnabled = false;
            _statusTxt.htmlText = LanguageMgr.GetTranslation("ddt.godsRoads.finishedTxt");
            _statusTxt.removeEventListener("link",__linkFunc);
            if(mVo.isGetAwards)
            {
               _smallBtn.enable = false;
            }
            else
            {
               _smallBtn.enable = true;
            }
         }
         else
         {
            _smallBtn.enable = false;
            if(_stepIsOpen)
            {
               _statusTxt.textFormatStyle = "godsRoads.TextFormat6";
               _statusTxt.filterString = "godsRoads.GF6";
               _statusTxt.mouseEnabled = true;
               _statusTxt.htmlText = "<u><a href=\'event:" + info.IndexType + "\'>" + LanguageMgr.GetTranslation("ddt.godsRoads.gotoView") + "</a></u>";
               _statusTxt.addEventListener("link",__linkFunc);
            }
            else
            {
               _statusTxt.textFormatStyle = "godsRoads.TextFormat";
               _statusTxt.filterString = "godsRoads.GF5";
               _statusTxt.mouseEnabled = false;
               _statusTxt.htmlText = LanguageMgr.GetTranslation("ddt.godsRoads.noOpenTxt");
               if(_statusTxt.hasEventListener("link"))
               {
                  _statusTxt.removeEventListener("link",__linkFunc);
               }
            }
         }
      }
      
      private function __linkFunc(e:TextEvent) : void
      {
         var indexType:int = e.text;
         switch(int(indexType) - 31)
         {
            case 0:
               if(PlayerManager.Instance.Self.Grade < 8)
               {
                  TaskManager.instance.switchVisible();
               }
               else
               {
                  WantStrongControl.Instance.setup();
               }
               break;
            case 1:
               if(PlayerManager.Instance.Self.Grade < 12)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("newSevenDayTarget.newSevenDayTargetFrameLevelDown",12));
                  return;
               }
               StateManager.setState("academyRegistration");
               break;
            case 2:
               if(PlayerManager.Instance.Self.Grade < 17)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("newSevenDayTarget.newSevenDayTargetFrameLevelDown",17));
                  return;
               }
               StateManager.setState("consortia");
               break;
            case 3:
               if(PlayerManager.Instance.Self.Grade < 3)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("newSevenDayTarget.newSevenDayTargetFrameLevelDown",3));
                  return;
               }
               StateManager.setState("roomlist");
               break;
            case 4:
               if(PlayerManager.Instance.Self.Grade < 5)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("newSevenDayTarget.newSevenDayTargetFrameLevelDown",5));
                  return;
               }
               BagStore.instance.openStore("bag_store");
               break;
            case 5:
               if(PlayerManager.Instance.Self.Grade < 5)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("newSevenDayTarget.newSevenDayTargetFrameLevelDown",5));
                  return;
               }
               BagStore.instance.openStore("bag_store",2);
               break;
            case 6:
               if(PlayerManager.Instance.Self.Grade < 10)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("newSevenDayTarget.newSevenDayTargetFrameLevelDown",10));
                  return;
               }
               StateManager.setState("dungeon");
               break;
            case 7:
               break;
            case 8:
               if(PlayerManager.Instance.Self.Grade < 16)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("newSevenDayTarget.newSevenDayTargetFrameLevelDown",16));
                  return;
               }
               BagAndInfoManager.Instance.showBagAndInfo(21);
               break;
            case 9:
               if(PlayerManager.Instance.Self.Grade < 19)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("newSevenDayTarget.newSevenDayTargetFrameLevelDown",19));
                  return;
               }
               RingStationManager.instance.show();
               break;
            case 10:
               BagAndInfoManager.Instance.showBagAndInfo(3);
               break;
            case 11:
               BagAndInfoManager.Instance.showBagAndInfo(2);
               break;
            case 12:
               LabyrinthManager.Instance.show();
               break;
            case 13:
               if(ActivityEnterGrapType.Instance.IsEnterGame(28))
               {
                  if(CheckWeaponManager.instance.isNoWeapon())
                  {
                     CheckWeaponManager.instance.showAlert();
                     return;
                  }
                  BattleGroudManager.Instance.__onBattleBtnHander();
               }
               break;
            case 14:
               if(PlayerManager.Instance.Self.Grade < 5)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("newSevenDayTarget.newSevenDayTargetFrameLevelDown",5));
                  return;
               }
               if(this is ConsortionBankBagView)
               {
                  BagStore.instance.isFromConsortionBankFrame = true;
               }
               else
               {
                  BagStore.instance.isFromBagFrame = true;
               }
               BagStore.instance.openStore("bag_store",1);
               break;
         }
         dispose();
      }
      
      override public function dispose() : void
      {
         if(_statusTxt.hasEventListener("link"))
         {
            _statusTxt.removeEventListener("link",__linkFunc);
         }
         if(_listPanel)
         {
            _listPanel.list.removeEventListener("listItemClick",__itemClick);
         }
         if(_view)
         {
            ObjectUtils.removeChildAllChildren(_view);
         }
         _view = null;
         super.dispose();
      }
   }
}
