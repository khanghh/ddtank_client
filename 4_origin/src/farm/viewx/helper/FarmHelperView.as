package farm.viewx.helper
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.data.player.SelfInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import farm.modelx.FieldVO;
   import farm.viewx.ConfirmHelperMoneyAlertFrame;
   import farm.viewx.ManureOrSeedSelectedView;
   import farm.viewx.confirmStopHelperFrame;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class FarmHelperView extends Frame
   {
       
      
      private var _titleBg:DisplayObject;
      
      private var _helperFramBg1:ScaleBitmapImage;
      
      private var _helperFramBg2:ScaleBitmapImage;
      
      private var _onekeyStartBtn:TextButton;
      
      private var _onekeyCloseBtn:TextButton;
      
      private var _helperShowText2:FilterFrameText;
      
      private var _helperShowTime:FilterFrameText;
      
      private var _helperSelSeed:FilterFrameText;
      
      private var _helperSelTime:FilterFrameText;
      
      private var _needSeed:FilterFrameText;
      
      private var _needSeedText:FilterFrameText;
      
      private var _getSeedText:FilterFrameText;
      
      private var _getSeed:FilterFrameText;
      
      private var _getSeedNumOne:int;
      
      private var _getSeedNum:int;
      
      private var _remainTime:FilterFrameText;
      
      private var _helpBtn:TextButton;
      
      private var _farmChoose:ComboBox;
      
      private var _timeChoose:ComboBox;
      
      private var _farmNumChoose:ComboBox;
      
      private var _listArray:Array;
      
      private var _listArrayID:Array;
      
      private var _listSeedNum:Array;
      
      private var _listTimeTextArray:Array;
      
      private var _listTimeArray:Array;
      
      private var _currentTime:int;
      
      private var _currentID:int;
      
      private var _timer:Timer;
      
      private var _timerSeed:Timer;
      
      private var _timeText:FilterFrameText;
      
      private var _timeDiff:int;
      
      private var _autoTime:int;
      
      private var _seedItemInfo:Vector.<ShopItemInfo>;
      
      private var _beginFrame:HelperBeginFrame;
      
      private var _typeString:String;
      
      private var _infoList:Vector.<ShopItemInfo>;
      
      private var _seeSeedBtn:TextButton;
      
      private var _selectedView:ManureOrSeedSelectedView;
      
      private var _configmPnl:ConfirmHelperMoneyAlertFrame;
      
      private var _stopHelpeCconfigm:confirmStopHelperFrame;
      
      private var _modelType:int;
      
      public function FarmHelperView()
      {
         super();
         initView();
         addEvent();
         escEnable = true;
      }
      
      private function initView() : void
      {
         _listArray = [];
         _listArrayID = [];
         _listSeedNum = [];
         _listTimeTextArray = ["12giờ","24giờ"];
         _listTimeArray = new Array(720,1440);
         _currentTime = 720;
         _titleBg = ComponentFactory.Instance.creat("assets.farm.farmHelper.title");
         addChild(_titleBg);
         _helperFramBg1 = ComponentFactory.Instance.creatComponentByStylename("helperFrame.bg1");
         addToContent(_helperFramBg1);
         _helperFramBg2 = ComponentFactory.Instance.creatComponentByStylename("helperFrame.bg2");
         addToContent(_helperFramBg2);
         _onekeyStartBtn = ComponentFactory.Instance.creatComponentByStylename("asset.farm.onekeyStartBtn");
         _onekeyStartBtn.text = LanguageMgr.GetTranslation("ddt.farm.StartBtn.text");
         _onekeyStartBtn.enable = false;
         addToContent(_onekeyStartBtn);
         _onekeyCloseBtn = ComponentFactory.Instance.creatComponentByStylename("asset.farm.onekeyCloseBtn");
         _onekeyCloseBtn.visible = false;
         _onekeyCloseBtn.text = LanguageMgr.GetTranslation("ddt.farm.CloseBtn.text");
         addToContent(_onekeyCloseBtn);
         _seeSeedBtn = ComponentFactory.Instance.creatComponentByStylename("asset.farm.seeSeedBtn");
         _seeSeedBtn.text = LanguageMgr.GetTranslation("ddt.farm.seeSeedBtn.text");
         _seeSeedBtn.enable = false;
         addToContent(_seeSeedBtn);
         _helperShowText2 = ComponentFactory.Instance.creatComponentByStylename("asset.farm.helperShowTxt2");
         addToContent(_helperShowText2);
         _helperShowTime = ComponentFactory.Instance.creatComponentByStylename("asset.farm.helperShowTime");
         addToContent(_helperShowTime);
         _helperSelSeed = ComponentFactory.Instance.creatComponentByStylename("asset.farm.helperSelSeed");
         _helperSelSeed.text = LanguageMgr.GetTranslation("ddt.farm.helperSelSeed.text");
         addToContent(_helperSelSeed);
         _helperSelTime = ComponentFactory.Instance.creatComponentByStylename("asset.farm.helperSelTime");
         _helperSelTime.text = LanguageMgr.GetTranslation("ddt.farm.helperSeltime.text");
         addToContent(_helperSelTime);
         _needSeedText = ComponentFactory.Instance.creatComponentByStylename("asset.farm.helperNeedSeedText");
         _needSeedText.text = LanguageMgr.GetTranslation("ddt.farm.helperNeedSeed.text");
         addToContent(_needSeedText);
         _needSeed = ComponentFactory.Instance.creatComponentByStylename("asset.farm.helperNeedSeed");
         addToContent(_needSeed);
         _getSeedText = ComponentFactory.Instance.creatComponentByStylename("asset.farm.helperGetSeedText");
         _getSeedText.text = LanguageMgr.GetTranslation("ddt.farm.helperGetSeed.text");
         addToContent(_getSeedText);
         _getSeed = ComponentFactory.Instance.creatComponentByStylename("asset.farm.helperGetSeed");
         addToContent(_getSeed);
         _remainTime = ComponentFactory.Instance.creatComponentByStylename("asset.farm.helperRemainTime");
         _remainTime.text = LanguageMgr.GetTranslation("ddt.farm.helperNeedTime.text");
         addToContent(_remainTime);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"asset.farm.helpBtn",null,LanguageMgr.GetTranslation("ddt.farm.helper.help.readme"),"assets.farm.helperTxt",404,484) as TextButton;
         _helpBtn.text = LanguageMgr.GetTranslation("ddt.farm.helpBtn.text");
         _farmChoose = ComponentFactory.Instance.creatComponentByStylename("asset.farm.farmChoose");
         addToContent(_farmChoose);
         _timeChoose = ComponentFactory.Instance.creatComponentByStylename("asset.farm.timeChoose");
         addToContent(_timeChoose);
         _infoList = ShopManager.Instance.getValidGoodByType(88);
         setComboxContent();
         _timeText = ComponentFactory.Instance.creatComponentByStylename("asset.farm.helperTimerText");
         addToContent(_timeText);
         if(PlayerManager.Instance.Self.isFarmHelper)
         {
            setBtnEna(false);
            setTimes();
            setGetSeedCount();
         }
         setHelperTime();
         _seedItemInfo = ShopManager.Instance.getValidGoodByType(88);
      }
      
      private function setHelperTime() : void
      {
         var date:* = null;
         var date1:* = null;
         if(FarmModelController.instance.model.isHelperMay || PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.VIPLevel >= FarmModelController.instance.model.vipLimitLevel)
         {
            if(PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.VIPLevel >= FarmModelController.instance.model.vipLimitLevel)
            {
               date = PlayerManager.Instance.Self.VIPExpireDay as Date;
               _helperShowTime.text = date.fullYear + "-" + (date.month + 1) + "-";
               _helperShowTime.text = _helperShowTime.text + (date.date + " " + fixZero(date.hours) + ":" + fixZero(date.minutes));
               _helperShowText2.text = LanguageMgr.GetTranslation("ddt.farm.helperShow.text2");
            }
            else
            {
               date1 = FarmModelController.instance.model.stopTime as Date;
               _helperShowTime.text = date1.fullYear + "-" + (date1.month + 1) + "-";
               _helperShowTime.text = _helperShowTime.text + (date1.date + " " + fixZero(date1.hours) + ":" + fixZero(date1.minutes));
               _helperShowText2.text = LanguageMgr.GetTranslation("ddt.farm.helperShow.text2");
            }
         }
         else
         {
            _helperShowTime.text = "";
            _helperShowText2.text = "";
         }
      }
      
      private function setComboxContent() : void
      {
         var i:int = 0;
         var name:* = null;
         var ID:int = 0;
         _farmChoose.beginChanges();
         _farmChoose.selctedPropName = "text";
         var comboxModel:VectorListModel = _farmChoose.listPanel.vectorListModel;
         comboxModel.clear();
         for(i = 0; i < _infoList.length; i++)
         {
            if(_infoList[i] && _infoList[i].TemplateInfo.CategoryID == 32 && _infoList[i].TemplateInfo.Property7 == "1")
            {
               if(PlayerManager.Instance.Self.VIPLevel < ServerConfigManager.instance.getPrivilegeMinLevel("8") || !PlayerManager.Instance.Self.IsVIP)
               {
               }
               continue;
            }
            if(PlayerManager.Instance.Self.Grade >= _infoList[i].LimitGrade)
            {
               name = _infoList[i].TemplateInfo.Name;
               ID = _infoList[i].TemplateID;
               _listArray.push(name);
               _listArrayID.push(ID);
               _listSeedNum.push(int(_infoList[i].TemplateInfo.Property2));
               comboxModel.append(name);
               if(PlayerManager.Instance.Self.isFarmHelper && _infoList[i].TemplateID == FarmModelController.instance.model.helperArray[1])
               {
                  _farmChoose.textField.text = _infoList[i].TemplateInfo.Name;
                  continue;
               }
               continue;
            }
         }
         _farmChoose.listPanel.list.updateListView();
         _farmChoose.listPanel.list.addEventListener("listItemClick",__itemClick);
         _farmChoose.commitChanges();
         _timeChoose.beginChanges();
         _timeChoose.selctedPropName = "text";
         _timeChoose.textField.text = "12" + LanguageMgr.GetTranslation("hour");
         var comboxModel2:VectorListModel = _timeChoose.listPanel.vectorListModel;
         comboxModel2.clear();
         comboxModel2.append(_listTimeTextArray[0]);
         comboxModel2.append(_listTimeTextArray[1]);
         _timeChoose.listPanel.list.updateListView();
         _timeChoose.listPanel.list.addEventListener("listItemClick",__itemClick2);
         _timeChoose.commitChanges();
      }
      
      private function setBtnEna(value:Boolean = true) : void
      {
         if(_onekeyStartBtn)
         {
            if(value == true)
            {
               if(_listArrayID.length > 0)
               {
                  _onekeyStartBtn.enable = value;
               }
            }
            else
            {
               _onekeyStartBtn.visible = value;
            }
         }
         if(_seeSeedBtn)
         {
            _seeSeedBtn.enable = !value;
         }
         if(_onekeyCloseBtn)
         {
            _onekeyCloseBtn.visible = !value;
         }
         if(_farmChoose)
         {
            _farmChoose.enable = value;
            _farmChoose.filters = value == true?ComponentFactory.Instance.creatFilters("lightFilter"):ComponentFactory.Instance.creatFilters("grayFilter");
         }
         if(_timeChoose)
         {
            _timeChoose.enable = value;
            _timeChoose.filters = value == true?ComponentFactory.Instance.creatFilters("lightFilter"):ComponentFactory.Instance.creatFilters("grayFilter");
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__closeFarmHelper);
         _onekeyStartBtn.addEventListener("click",__onekeyStartClick);
         _onekeyCloseBtn.addEventListener("click",__onekeyCloseClick);
         _farmChoose.button.addEventListener("click",__comBoxBtnClick);
         _timeChoose.button.addEventListener("click",__comBoxBtnClick);
         FarmModelController.instance.addEventListener("beginHelper",__beginHelper);
         FarmModelController.instance.addEventListener("stopHelper",__stopHelper);
         FarmModelController.instance.addEventListener("confirmStopHelper",__confirmStopHelper);
         FarmModelController.instance.model.addEventListener("payHepler",__showHelperTime);
         _seeSeedBtn.addEventListener("click",__onSeeSeed);
      }
      
      private function __onSeeSeed(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_selectedView != null)
         {
            _selectedView.dispose();
            _selectedView = null;
         }
         _selectedView = new ManureOrSeedSelectedView(true);
         addChild(_selectedView);
         PositionUtils.setPos(_selectedView,"farm.seedSelectViewPos1");
         _selectedView.viewType = 1;
      }
      
      private function __showHelperTime(pEvent:FarmEvent) : void
      {
         setHelperTime();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function __closeFarmHelper(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __beginHelper(event:FarmEvent) : void
      {
         if(PlayerManager.Instance.Self.isFarmHelper)
         {
            setBtnEna(false);
            setTimes();
            setGetSeedCount();
         }
      }
      
      private function __stopHelper(event:FarmEvent) : void
      {
         if(!PlayerManager.Instance.Self.isFarmHelper)
         {
            if(_timer)
            {
               _timer.removeEventListener("timer",__timerHandler);
            }
            if(_timerSeed)
            {
               _timerSeed.removeEventListener("timer",__timerSeedHandler);
            }
            setBtnEna(true);
         }
      }
      
      private function __itemClick(event:ListItemEvent) : void
      {
         var tempInfo:* = null;
         SoundManager.instance.play("008");
         _currentID = _listArrayID[event.index];
         var _loc5_:int = 0;
         var _loc4_:* = _infoList;
         for each(var info in _infoList)
         {
            if(info.TemplateID == _currentID)
            {
               tempInfo = info;
               break;
            }
         }
         _getSeedNumOne = _listSeedNum[event.index];
         _onekeyStartBtn.enable = true;
         switch(int(tempInfo.APrice1) - -9)
         {
            case 0:
               _modelType = -9;
               break;
            case 1:
               _modelType = -8;
               break;
            default:
            default:
            default:
            default:
            default:
               _modelType = -1;
               break;
            case 7:
               _modelType = -2;
               break;
            case 8:
               _modelType = -1;
         }
         _needSeed.text = getseedCountByID().toString();
         _getSeed.text = _getSeedNum.toString() + "/" + _getSeedNum.toString();
      }
      
      private function __itemClick2(event:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         _currentTime = _listTimeArray[event.index];
         _needSeed.text = getseedCountByID().toString();
         _getSeed.text = _getSeedNum.toString() + "/" + _getSeedNum.toString();
      }
      
      private function getseedCountByID() : int
      {
         var m:int = 0;
         var nowDate:int = 0;
         var needTime:int = findSeedTimebyID(_currentID);
         var filedCounts:int = 0;
         var fieldsInfo:Vector.<FieldVO> = FarmModelController.instance.model.fieldsInfo;
         for(m = 0; m < FarmModelController.instance.model.fieldsInfo.length; )
         {
            nowDate = (new Date().getTime() - fieldsInfo[m].payTime.getTime()) / 3600000;
            if(fieldsInfo[m].fieldValidDate > nowDate || fieldsInfo[m].fieldValidDate == -1)
            {
               filedCounts++;
            }
            m++;
         }
         var seedCount:int = filedCounts * _currentTime / needTime;
         _getSeedNum = filedCounts * _currentTime / needTime * _getSeedNumOne;
         return seedCount;
      }
      
      private function findSeedTimebyID(ID:int) : int
      {
         var i:int = 0;
         for(i = 0; i < _seedItemInfo.length; )
         {
            if(_currentID == _seedItemInfo[i].TemplateID)
            {
               return int(_seedItemInfo[i].TemplateInfo.Property3);
            }
            i++;
         }
         return 0;
      }
      
      private function __comBoxBtnClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __onekeyStartClick(e:MouseEvent) : void
      {
         var seedInfoCount:int = 0;
         var seedCount:int = 0;
         var times:int = 0;
         if(_farmChoose.textField.text == null)
         {
            return;
         }
         SoundManager.instance.play("008");
         var selfInfo:SelfInfo = PlayerManager.Instance.Self;
         if(FarmModelController.instance.model.isHelperMay || PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.VIPLevel >= FarmModelController.instance.model.vipLimitLevel)
         {
            seedInfoCount = FarmModelController.instance.model.getSeedCountByID(_currentID);
            seedCount = getseedCountByID();
            times = 0;
            _beginFrame = ComponentFactory.Instance.creatComponentByStylename("farm.farmHelperView.beginFrame");
            _beginFrame.seedID = _currentID;
            _beginFrame.seedTime = _currentTime;
            _beginFrame.getCount = _getSeedNum;
            _beginFrame.modelType = _modelType;
            _beginFrame.needCount = seedCount > seedInfoCount?seedCount - seedInfoCount:0;
            _beginFrame.haveCount = seedInfoCount > seedCount?seedCount:int(seedInfoCount);
            _beginFrame.show();
         }
         else
         {
            _configmPnl = ComponentFactory.Instance.creatComponentByStylename("farm.confirmHelperMoneyAlertFrame");
            LayerManager.Instance.addToLayer(_configmPnl,3,true,1);
         }
      }
      
      private function __onekeyCloseClick(e:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         SoundManager.instance.play("008");
         _stopHelpeCconfigm = ComponentFactory.Instance.creatComponentByStylename("farm.confirmStopHelperFrame");
         LayerManager.Instance.addToLayer(_stopHelpeCconfigm,3,true,1);
      }
      
      private function __confirmStopHelper(event:FarmEvent) : void
      {
         var array1:Array = [];
         array1.push(false);
         SocketManager.Instance.out.sendBeginHelper(array1);
         dispose();
      }
      
      private function setTimes() : void
      {
         var startTime1:Date = FarmModelController.instance.model.helperArray[2];
         var startTime2:int = startTime1.getTime() / 1000;
         var nowTime1:Date = TimeManager.Instance.Now();
         var nowTime2:int = nowTime1.getTime() / 1000;
         _autoTime = FarmModelController.instance.model.helperArray[3] * 60;
         if(nowTime2 - startTime2 < 0)
         {
            _timeDiff = _autoTime;
         }
         else
         {
            _timeDiff = _autoTime - (nowTime2 - startTime2);
         }
         _timer = new Timer(1000,int(_timeDiff));
         _timer.start();
         _timerSeed = new Timer(60000);
         _timerSeed.start();
         if(_timeText == null)
         {
            _timeText = ComponentFactory.Instance.creatComponentByStylename("asset.farm.helperTimerText");
            addChild(_timeText);
         }
         if(_needSeed == null)
         {
            _needSeed = ComponentFactory.Instance.creatComponentByStylename("asset.farm.helperNeedSeed");
            addChild(_needSeed);
         }
         _needSeed.text = FarmModelController.instance.model.helperArray[4];
         _timeChoose.textField.text = FarmModelController.instance.model.helperArray[3] / 60 + LanguageMgr.GetTranslation("hour");
         _timer.addEventListener("timer",__timerHandler);
         _timerSeed.addEventListener("timer",__timerSeedHandler);
      }
      
      private function __timerSeedHandler(evnet:TimerEvent) : void
      {
         setGetSeedCount();
      }
      
      private function setGetSeedCount() : void
      {
         if(_getSeed == null)
         {
            _getSeed = ComponentFactory.Instance.creatComponentByStylename("asset.farm.helperGetSeed");
            addChild(_getSeed);
         }
         _getSeed.text = String(int((1 - _timeDiff / _autoTime) * FarmModelController.instance.model.helperArray[5])) + "/" + FarmModelController.instance.model.helperArray[5].toString();
      }
      
      private function __timerHandler(evnet:TimerEvent) : void
      {
         var array2:* = null;
         _timeText.text = getTimeDiff(_timeDiff);
         _timeDiff = Number(_timeDiff) - 1;
         if(_timeDiff == 0)
         {
            array2 = [];
            array2.push(false);
            SocketManager.Instance.out.sendBeginHelper(array2);
            dispose();
         }
      }
      
      private function getTimeDiff(diff:int) : String
      {
         var h:* = 0;
         var m:* = 0;
         var s:* = 0;
         if(diff >= 0)
         {
            h = uint(Math.floor(diff / 60 / 60));
            diff = diff % 3600;
            m = uint(Math.floor(diff / 60));
            diff = diff % 60;
            s = uint(diff);
         }
         return fixZero(h) + ":" + fixZero(m) + ":" + fixZero(s);
      }
      
      private function fixZero(num:uint) : String
      {
         return num < 10?"0" + String(num):String(num);
      }
      
      private function removeEvent() : void
      {
         _onekeyStartBtn.removeEventListener("click",__onekeyStartClick);
         _onekeyCloseBtn.removeEventListener("click",__onekeyCloseClick);
         removeEventListener("response",__closeFarmHelper);
         _farmChoose.listPanel.list.removeEventListener("listItemClick",__itemClick);
         _timeChoose.listPanel.list.removeEventListener("listItemClick",__itemClick2);
         FarmModelController.instance.removeEventListener("beginHelper",__beginHelper);
         FarmModelController.instance.removeEventListener("stopHelper",__stopHelper);
         FarmModelController.instance.removeEventListener("confirmStopHelper",__confirmStopHelper);
         FarmModelController.instance.model.removeEventListener("payHepler",__showHelperTime);
         if(_timer)
         {
            _timer.removeEventListener("timer",__timerHandler);
         }
         _seeSeedBtn.removeEventListener("click",__onSeeSeed);
      }
      
      private function removeItem() : void
      {
         if(_seeSeedBtn)
         {
            ObjectUtils.disposeObject(_seeSeedBtn);
         }
         _seeSeedBtn = null;
         if(_onekeyStartBtn)
         {
            ObjectUtils.disposeObject(_onekeyStartBtn);
         }
         _onekeyStartBtn = null;
         if(_onekeyCloseBtn)
         {
            ObjectUtils.disposeObject(_onekeyCloseBtn);
         }
         _onekeyCloseBtn = null;
         if(_helperShowText2)
         {
            ObjectUtils.disposeObject(_helperShowText2);
         }
         _helperShowText2 = null;
         if(_helperShowTime)
         {
            ObjectUtils.disposeObject(_helperShowTime);
         }
         _helperShowTime = null;
         if(_farmChoose)
         {
            ObjectUtils.disposeObject(_farmChoose);
         }
         _farmChoose = null;
         if(_timeChoose)
         {
            ObjectUtils.disposeObject(_timeChoose);
         }
         _timeChoose = null;
         if(_farmNumChoose)
         {
            ObjectUtils.disposeObject(_farmNumChoose);
         }
         _farmNumChoose = null;
         if(_listArray)
         {
            ObjectUtils.disposeObject(_listArray);
         }
         _listArray = null;
         if(_helperSelSeed)
         {
            ObjectUtils.disposeObject(_helperSelSeed);
         }
         _helperSelTime = null;
         if(_helperSelTime)
         {
            ObjectUtils.disposeObject(_helperSelTime);
         }
         _helperSelTime = null;
         if(_needSeed)
         {
            ObjectUtils.disposeObject(_needSeed);
         }
         _needSeed = null;
         if(_needSeedText)
         {
            ObjectUtils.disposeObject(_needSeedText);
         }
         _needSeedText = null;
         if(_getSeedText)
         {
            ObjectUtils.disposeObject(_getSeedText);
         }
         _getSeedText = null;
         if(_getSeed)
         {
            ObjectUtils.disposeObject(_getSeed);
         }
         _getSeed = null;
         if(_remainTime)
         {
            ObjectUtils.disposeObject(_remainTime);
         }
         _remainTime = null;
         if(_helperFramBg1)
         {
            ObjectUtils.disposeObject(_helperFramBg1);
         }
         _helperFramBg1 = null;
         if(_helperFramBg2)
         {
            ObjectUtils.disposeObject(_helperFramBg2);
         }
         _helperFramBg2 = null;
         if(_beginFrame)
         {
            ObjectUtils.disposeObject(_beginFrame);
         }
         _beginFrame = null;
         if(_timer)
         {
            ObjectUtils.disposeObject(_timer);
         }
         _timer = null;
         if(_timeText)
         {
            ObjectUtils.disposeObject(_timeText);
         }
         _timeText = null;
         if(_configmPnl)
         {
            _configmPnl.dispose();
         }
         _configmPnl = null;
         if(_selectedView)
         {
            ObjectUtils.disposeObject(_selectedView);
         }
         _selectedView = null;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         removeItem();
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
