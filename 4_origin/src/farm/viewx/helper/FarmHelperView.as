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
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(FarmModelController.instance.model.isHelperMay || PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.VIPLevel >= FarmModelController.instance.model.vipLimitLevel)
         {
            if(PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.VIPLevel >= FarmModelController.instance.model.vipLimitLevel)
            {
               _loc1_ = PlayerManager.Instance.Self.VIPExpireDay as Date;
               _helperShowTime.text = _loc1_.fullYear + "-" + (_loc1_.month + 1) + "-";
               _helperShowTime.text = _helperShowTime.text + (_loc1_.date + " " + fixZero(_loc1_.hours) + ":" + fixZero(_loc1_.minutes));
               _helperShowText2.text = LanguageMgr.GetTranslation("ddt.farm.helperShow.text2");
            }
            else
            {
               _loc2_ = FarmModelController.instance.model.stopTime as Date;
               _helperShowTime.text = _loc2_.fullYear + "-" + (_loc2_.month + 1) + "-";
               _helperShowTime.text = _helperShowTime.text + (_loc2_.date + " " + fixZero(_loc2_.hours) + ":" + fixZero(_loc2_.minutes));
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
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         _farmChoose.beginChanges();
         _farmChoose.selctedPropName = "text";
         var _loc2_:VectorListModel = _farmChoose.listPanel.vectorListModel;
         _loc2_.clear();
         _loc5_ = 0;
         for(; _loc5_ < _infoList.length; _loc5_++)
         {
            if(_infoList[_loc5_] && _infoList[_loc5_].TemplateInfo.CategoryID == 32 && _infoList[_loc5_].TemplateInfo.Property7 == "1")
            {
               if(PlayerManager.Instance.Self.VIPLevel < ServerConfigManager.instance.getPrivilegeMinLevel("8") || !PlayerManager.Instance.Self.IsVIP)
               {
               }
               continue;
            }
            if(PlayerManager.Instance.Self.Grade >= _infoList[_loc5_].LimitGrade)
            {
               _loc3_ = _infoList[_loc5_].TemplateInfo.Name;
               _loc4_ = _infoList[_loc5_].TemplateID;
               _listArray.push(_loc3_);
               _listArrayID.push(_loc4_);
               _listSeedNum.push(int(_infoList[_loc5_].TemplateInfo.Property2));
               _loc2_.append(_loc3_);
               if(PlayerManager.Instance.Self.isFarmHelper && _infoList[_loc5_].TemplateID == FarmModelController.instance.model.helperArray[1])
               {
                  _farmChoose.textField.text = _infoList[_loc5_].TemplateInfo.Name;
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
         var _loc1_:VectorListModel = _timeChoose.listPanel.vectorListModel;
         _loc1_.clear();
         _loc1_.append(_listTimeTextArray[0]);
         _loc1_.append(_listTimeTextArray[1]);
         _timeChoose.listPanel.list.updateListView();
         _timeChoose.listPanel.list.addEventListener("listItemClick",__itemClick2);
         _timeChoose.commitChanges();
      }
      
      private function setBtnEna(param1:Boolean = true) : void
      {
         if(_onekeyStartBtn)
         {
            if(param1 == true)
            {
               if(_listArrayID.length > 0)
               {
                  _onekeyStartBtn.enable = param1;
               }
            }
            else
            {
               _onekeyStartBtn.visible = param1;
            }
         }
         if(_seeSeedBtn)
         {
            _seeSeedBtn.enable = !param1;
         }
         if(_onekeyCloseBtn)
         {
            _onekeyCloseBtn.visible = !param1;
         }
         if(_farmChoose)
         {
            _farmChoose.enable = param1;
            _farmChoose.filters = param1 == true?ComponentFactory.Instance.creatFilters("lightFilter"):ComponentFactory.Instance.creatFilters("grayFilter");
         }
         if(_timeChoose)
         {
            _timeChoose.enable = param1;
            _timeChoose.filters = param1 == true?ComponentFactory.Instance.creatFilters("lightFilter"):ComponentFactory.Instance.creatFilters("grayFilter");
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
      
      private function __onSeeSeed(param1:MouseEvent) : void
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
      
      private function __showHelperTime(param1:FarmEvent) : void
      {
         setHelperTime();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function __closeFarmHelper(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __beginHelper(param1:FarmEvent) : void
      {
         if(PlayerManager.Instance.Self.isFarmHelper)
         {
            setBtnEna(false);
            setTimes();
            setGetSeedCount();
         }
      }
      
      private function __stopHelper(param1:FarmEvent) : void
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
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         _currentID = _listArrayID[param1.index];
         var _loc5_:int = 0;
         var _loc4_:* = _infoList;
         for each(var _loc3_ in _infoList)
         {
            if(_loc3_.TemplateID == _currentID)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         _getSeedNumOne = _listSeedNum[param1.index];
         _onekeyStartBtn.enable = true;
         switch(int(_loc2_.APrice1) - -9)
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
      
      private function __itemClick2(param1:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         _currentTime = _listTimeArray[param1.index];
         _needSeed.text = getseedCountByID().toString();
         _getSeed.text = _getSeedNum.toString() + "/" + _getSeedNum.toString();
      }
      
      private function getseedCountByID() : int
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = findSeedTimebyID(_currentID);
         var _loc5_:int = 0;
         var _loc1_:Vector.<FieldVO> = FarmModelController.instance.model.fieldsInfo;
         _loc6_ = 0;
         while(_loc6_ < FarmModelController.instance.model.fieldsInfo.length)
         {
            _loc4_ = (new Date().getTime() - _loc1_[_loc6_].payTime.getTime()) / 3600000;
            if(_loc1_[_loc6_].fieldValidDate > _loc4_ || _loc1_[_loc6_].fieldValidDate == -1)
            {
               _loc5_++;
            }
            _loc6_++;
         }
         var _loc3_:int = _loc5_ * _currentTime / _loc2_;
         _getSeedNum = _loc5_ * _currentTime / _loc2_ * _getSeedNumOne;
         return _loc3_;
      }
      
      private function findSeedTimebyID(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _seedItemInfo.length)
         {
            if(_currentID == _seedItemInfo[_loc2_].TemplateID)
            {
               return int(_seedItemInfo[_loc2_].TemplateInfo.Property3);
            }
            _loc2_++;
         }
         return 0;
      }
      
      private function __comBoxBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __onekeyStartClick(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(_farmChoose.textField.text == null)
         {
            return;
         }
         SoundManager.instance.play("008");
         var _loc5_:SelfInfo = PlayerManager.Instance.Self;
         if(FarmModelController.instance.model.isHelperMay || PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.VIPLevel >= FarmModelController.instance.model.vipLimitLevel)
         {
            _loc4_ = FarmModelController.instance.model.getSeedCountByID(_currentID);
            _loc3_ = getseedCountByID();
            _loc2_ = 0;
            _beginFrame = ComponentFactory.Instance.creatComponentByStylename("farm.farmHelperView.beginFrame");
            _beginFrame.seedID = _currentID;
            _beginFrame.seedTime = _currentTime;
            _beginFrame.getCount = _getSeedNum;
            _beginFrame.modelType = _modelType;
            _beginFrame.needCount = _loc3_ > _loc4_?_loc3_ - _loc4_:0;
            _beginFrame.haveCount = _loc4_ > _loc3_?_loc3_:int(_loc4_);
            _beginFrame.show();
         }
         else
         {
            _configmPnl = ComponentFactory.Instance.creatComponentByStylename("farm.confirmHelperMoneyAlertFrame");
            LayerManager.Instance.addToLayer(_configmPnl,3,true,1);
         }
      }
      
      private function __onekeyCloseClick(param1:MouseEvent) : void
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
      
      private function __confirmStopHelper(param1:FarmEvent) : void
      {
         var _loc2_:Array = [];
         _loc2_.push(false);
         SocketManager.Instance.out.sendBeginHelper(_loc2_);
         dispose();
      }
      
      private function setTimes() : void
      {
         var _loc3_:Date = FarmModelController.instance.model.helperArray[2];
         var _loc4_:int = _loc3_.getTime() / 1000;
         var _loc1_:Date = TimeManager.Instance.Now();
         var _loc2_:int = _loc1_.getTime() / 1000;
         _autoTime = FarmModelController.instance.model.helperArray[3] * 60;
         if(_loc2_ - _loc4_ < 0)
         {
            _timeDiff = _autoTime;
         }
         else
         {
            _timeDiff = _autoTime - (_loc2_ - _loc4_);
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
      
      private function __timerSeedHandler(param1:TimerEvent) : void
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
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         var _loc2_:* = null;
         _timeText.text = getTimeDiff(_timeDiff);
         _timeDiff = Number(_timeDiff) - 1;
         if(_timeDiff == 0)
         {
            _loc2_ = [];
            _loc2_.push(false);
            SocketManager.Instance.out.sendBeginHelper(_loc2_);
            dispose();
         }
      }
      
      private function getTimeDiff(param1:int) : String
      {
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(param1 >= 0)
         {
            _loc4_ = uint(Math.floor(param1 / 60 / 60));
            param1 = param1 % 3600;
            _loc3_ = uint(Math.floor(param1 / 60));
            param1 = param1 % 60;
            _loc2_ = uint(param1);
         }
         return fixZero(_loc4_) + ":" + fixZero(_loc3_) + ":" + fixZero(_loc2_);
      }
      
      private function fixZero(param1:uint) : String
      {
         return param1 < 10?"0" + String(param1):String(param1);
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
