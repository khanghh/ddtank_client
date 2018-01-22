package carnivalActivity.view
{
   import baglocked.BaglockedManager;
   import beadSystem.model.BeadInfo;
   import carnivalActivity.CarnivalActivityControl;
   import carnivalActivity.view.activityItem.ActivationPotentialItem;
   import carnivalActivity.view.activityItem.BuildUpgradeItem;
   import carnivalActivity.view.activityItem.PetUpgradeItem;
   import carnivalActivity.view.activityItem.PlayerRegisterRwardItem;
   import carnivalActivity.view.activityItem.TurnRoundEggItem;
   import carnivalActivity.view.activityItem.UsePropsItem;
   import carnivalActivity.view.activityItem.UseUpEnergyItem;
   import carnivalActivity.view.activityItem.WashPointCardItem;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.QualityType;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PetInfoManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import pet.data.PetTemplateInfo;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftCurInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.data.SendGiftInfo;
   import wonderfulActivity.views.IRightView;
   
   public class CarnivalActivityView extends Sprite implements IRightView
   {
       
      
      protected var _bg:Bitmap;
      
      private var _titleBg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _closeTimeTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timer:TimerJuggler;
      
      private var _sumTime:Number = 0;
      
      private var _sumTimeStr:String;
      
      private var _actTxt:FilterFrameText;
      
      private var _actTimeTxt:FilterFrameText;
      
      private var _getTxt:FilterFrameText;
      
      private var _getTimeTxt:FilterFrameText;
      
      private var _descSp:Sprite;
      
      private var _descTxt:FilterFrameText;
      
      private var _allDescBg:ScaleBitmapImage;
      
      private var _allDescTxt:FilterFrameText;
      
      private var _buyBg:Bitmap;
      
      private var _priceTxt:FilterFrameText;
      
      private var _buyCountTxt:FilterFrameText;
      
      private var _dailyBuyBg:Bitmap;
      
      private var _buyBtn:TextButton;
      
      private var _gift:CarnivalActivityGift;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _type:int;
      
      private var _childType:int;
      
      private var _id:String;
      
      private var _item:GmActivityInfo;
      
      private var _buyGiftItem:GmActivityInfo;
      
      private var _buyGiftCurInfo:GiftCurInfo;
      
      private var _buyCount:int;
      
      private var _hasBuyGift:Boolean = false;
      
      private var _buyGiftLimitType:int;
      
      private var _buyGiftLimitCount:int;
      
      private var _buyGiftType:int;
      
      private var _buyGiftPrice:int;
      
      private var _buyGiftActId:String = "";
      
      private var _giftInfoVec:Vector.<GiftBagInfo>;
      
      private var _infoVec:Vector.<GmActivityInfo>;
      
      private var _itemVec:Vector.<CarnivalActivityItem>;
      
      private var _rookieRankView:RookieRankTipView;
      
      private var _rookieRankIcon:Bitmap;
      
      public function CarnivalActivityView(param1:int, param2:int = 0, param3:String = "")
      {
         _type = param1;
         _childType = param2;
         _id = param3;
         _itemVec = new Vector.<CarnivalActivityItem>();
         super();
      }
      
      public function init() : void
      {
         initData();
         if(_item == null)
         {
            return;
         }
         initView();
         initEvent();
         updateTime();
      }
      
      private function initData() : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         _giftInfoVec = new Vector.<GiftBagInfo>();
         _infoVec = new Vector.<GmActivityInfo>();
         var _loc4_:Dictionary = WonderfulActivityManager.Instance.activityData;
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc9_:int = 0;
         var _loc8_:* = WonderfulActivityManager.Instance.activityData;
         for each(var _loc3_ in WonderfulActivityManager.Instance.activityData)
         {
            if(!(_loc2_.time < Date.parse(_loc3_.beginTime) || _loc2_.time > Date.parse(_loc3_.endShowTime)))
            {
               if(_loc3_.activityType == _type && _loc3_.activityType == 18)
               {
                  initItem(_loc3_);
               }
               else if(_childType == 4 && _loc3_.activityType == _type && (_loc3_.activityChildType == 4 || _loc3_.activityChildType == 4 + 8))
               {
                  initItem(_loc3_);
               }
               else if(_loc3_.activityType == 20 && _loc3_.activityChildType == 0 && WonderfulActivityManager.Instance.leftViewInfoDic[_loc3_.activityId] != null)
               {
                  if(_id == _loc3_.activityId)
                  {
                     initItem(_loc3_);
                     break;
                  }
               }
               else if(_loc3_.activityType == _type && _loc3_.activityChildType == _childType)
               {
                  initItem(_loc3_);
                  break;
               }
            }
         }
         CarnivalActivityControl.instance.currentType = _type;
         CarnivalActivityControl.instance.currentChildType = _childType;
         _loc6_ = 0;
         while(_loc6_ < _infoVec.length)
         {
            _loc7_ = 0;
            while(_loc7_ < _infoVec[_loc6_].giftbagArray.length)
            {
               if(_infoVec[_loc6_].giftbagArray[_loc7_].rewardMark == 100)
               {
                  _loc5_ = 0;
                  while(_loc5_ < _infoVec[_loc6_].giftbagArray[_loc7_].giftConditionArr.length)
                  {
                     if(_infoVec[_loc6_].giftbagArray[_loc7_].giftConditionArr[_loc5_].conditionIndex == 101 && _infoVec[_loc6_].giftbagArray[_loc7_].giftConditionArr[_loc5_].conditionValue == 1)
                     {
                        _hasBuyGift = true;
                        _buyGiftActId = _infoVec[_loc6_].giftbagArray[_loc7_].giftConditionArr[_loc5_].remain2;
                        break;
                     }
                     _loc5_++;
                  }
               }
               if(!_hasBuyGift)
               {
                  _loc7_++;
                  continue;
               }
               break;
            }
            _loc6_++;
         }
         var _loc11_:int = 0;
         var _loc10_:* = WonderfulActivityManager.Instance.activityData;
         for each(var _loc1_ in WonderfulActivityManager.Instance.activityData)
         {
            if(_loc1_.activityId == _buyGiftActId)
            {
               _buyGiftItem = _loc1_;
               _buyGiftLimitType = _buyGiftItem.giftbagArray[0].giftConditionArr[0].conditionValue;
               _buyGiftLimitCount = _buyGiftItem.giftbagArray[0].giftConditionArr[1].conditionValue;
               _buyGiftType = _buyGiftItem.giftbagArray[0].giftConditionArr[2].conditionValue;
               _buyGiftPrice = _buyGiftItem.giftbagArray[0].giftConditionArr[3].conditionValue;
               break;
            }
         }
      }
      
      private function initItem(param1:GmActivityInfo) : void
      {
         var _loc2_:int = 0;
         if(!_item)
         {
            _item = param1;
         }
         if(_sumTime == 0)
         {
            _sumTime = Date.parse(param1.endTime) - new Date().time;
         }
         _loc2_ = 0;
         while(_loc2_ < param1.giftbagArray.length)
         {
            _giftInfoVec.push(param1.giftbagArray[_loc2_]);
            _loc2_++;
         }
         _infoVec.push(param1);
      }
      
      private function updateTime() : void
      {
         var _loc2_:int = _sumTime <= 0?0:Number(_sumTime / 3600000);
         var _loc1_:int = _sumTime <= 0?0:Number((_sumTime / 3600000 - _loc2_) * 60);
         var _loc3_:String = "";
         if(_loc2_ < 10)
         {
            _loc3_ = _loc3_ + ("0" + _loc2_);
         }
         else
         {
            _loc3_ = _loc3_ + _loc2_;
         }
         _loc3_ = _loc3_ + LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.hour");
         if(_loc1_ < 10)
         {
            _loc3_ = _loc3_ + ("0" + _loc1_);
         }
         else
         {
            _loc3_ = _loc3_ + _loc1_;
         }
         _loc3_ = _loc3_ + LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.minute");
         _timeTxt.text = _loc3_;
      }
      
      protected function __timerHandler(param1:Event) : void
      {
         _sumTime = _sumTime - 60000;
         updateTime();
      }
      
      protected function initView() : void
      {
         var _loc8_:* = null;
         var _loc6_:int = 0;
         var _loc12_:int = 0;
         var _loc9_:* = null;
         var _loc11_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc14_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc10_:* = null;
         CarnivalActivityControl.instance.getBeginTime = Date.parse(_item.beginShowTime);
         CarnivalActivityControl.instance.getEndTime = Date.parse(_item.endShowTime);
         CarnivalActivityControl.instance.actBeginTime = Date.parse(_item.beginTime);
         CarnivalActivityControl.instance.actEndTime = Date.parse(_item.endTime);
         _bg = ComponentFactory.Instance.creat("carnicalAct.bg");
         addChild(_bg);
         var _loc18_:int = 0;
         var _loc17_:* = _infoVec;
         for each(var _loc13_ in _infoVec)
         {
            var _loc16_:* = 0;
            var _loc15_:* = WonderfulActivityManager.Instance.rankActDic;
            for(var _loc5_ in WonderfulActivityManager.Instance.rankActDic)
            {
               if(_loc13_.activityId == _loc5_ && WonderfulActivityManager.Instance.rankActDic[_loc5_].length > 0)
               {
                  _rookieRankIcon = ComponentFactory.Instance.creat("wonderfulactivity.rookie.rankIcon");
                  addChild(_rookieRankIcon);
                  _rookieRankView = new RookieRankTipView();
                  _rookieRankView.x = 258;
                  _rookieRankView.y = 195;
                  _rookieRankView.tipStyle = "carnivalActivity.view.RookieRankTip";
                  _rookieRankView.tipDirctions = "7,3,2";
                  _rookieRankView.tipData = WonderfulActivityManager.Instance.rankActDic[_loc5_];
                  addChild(_rookieRankView);
                  break;
               }
            }
         }
         if(_type == 14)
         {
            _titleTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.mountDarenTxt");
            addChild(_titleTxt);
            _titleTxt.text = "Vua thú cưỡi";
         }
         else if(_type == 20)
         {
            _titleTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.mountDarenTxt");
            addChild(_titleTxt);
            _titleTxt.text = "Tăng Cấp Miếu Thần";
         }
         else
         {
            if(_type == 15)
            {
               _titleBg = ComponentFactory.Instance.creat("carnicalAct.title" + _childType);
               PositionUtils.setPos(_titleBg,"carnivalAct.titlePos" + _childType);
            }
            else
            {
               _titleBg = ComponentFactory.Instance.creat("carnicalAct.title" + _type);
               PositionUtils.setPos(_titleBg,"carnivalAct.titlePos" + _type);
            }
            addChild(_titleBg);
         }
         _closeTimeTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.closeTimeTxt");
         addChild(_closeTimeTxt);
         _closeTimeTxt.text = LanguageMgr.GetTranslation("carnival.closeTimeTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.timeTxt");
         addChild(_timeTxt);
         _actTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.actTxt");
         addChild(_actTxt);
         _actTxt.text = LanguageMgr.GetTranslation("tank.calendar.GoodsExchangeView.actTimeText");
         _actTimeTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.actTimeTxt");
         addChild(_actTimeTxt);
         _actTimeTxt.text = _item.beginTime.split(" ")[0] + "-" + _item.endTime.split(" ")[0];
         _getTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.getTxt");
         addChild(_getTxt);
         _getTxt.text = LanguageMgr.GetTranslation("carnival.getTimeTxt");
         _getTimeTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.getTimeTxt");
         addChild(_getTimeTxt);
         _getTimeTxt.text = _item.beginShowTime.split(" ")[0] + "-" + _item.endShowTime.split(" ")[0];
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.descTxt");
         _descSp = new Sprite();
         _descSp.addChild(_descTxt);
         var _loc7_:String = _item.desc;
         _descTxt.text = _loc7_;
         addChild(_descSp);
         _allDescBg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _allDescBg.x = _descTxt.x;
         _allDescBg.y = _descTxt.y + 25;
         _allDescTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.allDescTxt");
         _allDescTxt.text = _loc7_;
         _allDescBg.width = _allDescTxt.width + 16;
         _allDescBg.height = _allDescTxt.height + 8;
         _allDescTxt.x = _allDescBg.x + 8;
         _allDescTxt.y = _allDescBg.y + 4;
         _loc16_ = false;
         _allDescTxt.visible = _loc16_;
         _allDescBg.visible = _loc16_;
         if(_hasBuyGift)
         {
            _buyBg = ComponentFactory.Instance.creat("carnicalAct.buyItem");
            addChild(_buyBg);
            _priceTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.priceTxt");
            addChild(_priceTxt);
            _priceTxt.text = _buyGiftPrice + LanguageMgr.GetTranslation("carnival.buyGiftTypeTxt" + (_buyGiftType == -1?2:1));
            if(_buyGiftLimitType != 3)
            {
               if(_buyGiftLimitType == 1)
               {
                  _dailyBuyBg = ComponentFactory.Instance.creat("carnivalAct.dailyBuyBg");
                  addChild(_dailyBuyBg);
               }
               _buyCountTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.buyCountTxt");
            }
            else
            {
               _priceTxt.y = _priceTxt.y + 9;
            }
            _buyBtn = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.buyBtn");
            addChild(_buyBtn);
            _buyBtn.text = LanguageMgr.GetTranslation("store.Strength.BuyButtonText");
            _gift = new CarnivalActivityGift();
            _gift.tipStyle = "ddt.view.tips.OneLineTip";
            _gift.tipDirctions = "2,7,5";
            _loc8_ = LanguageMgr.GetTranslation("ddt.bagandinfo.awardsTitle") + "\n";
            _loc6_ = 0;
            while(_loc6_ < _buyGiftItem.giftbagArray.length)
            {
               _loc12_ = 0;
               while(_loc12_ < _buyGiftItem.giftbagArray[_loc6_].giftRewardArr.length)
               {
                  _loc9_ = _buyGiftItem.giftbagArray[_loc6_].giftRewardArr[_loc12_];
                  _loc11_ = "";
                  _loc3_ = new InventoryItemInfo();
                  _loc3_.TemplateID = _loc9_.templateId;
                  _loc3_ = ItemManager.fill(_loc3_);
                  if(EquipType.isBead(parseInt(_loc3_.Property1)))
                  {
                     _loc1_ = BeadTemplateManager.Instance.GetBeadInfobyID(_loc3_.TemplateID);
                     _loc11_ = _loc3_.Name + "-" + _loc1_.Name + "Lv" + _loc1_.BaseLevel;
                  }
                  else if(EquipType.isMagicStone(_loc3_.CategoryID))
                  {
                     _loc11_ = _loc3_.Name + "(" + QualityType.QUALITY_STRING[_loc3_.Quality] + ")";
                  }
                  else if(EquipType.isPetEgg(_loc3_.CategoryID))
                  {
                     _loc14_ = PetInfoManager.getPetByTemplateID(parseInt(_loc3_.Property5));
                     _loc11_ = LanguageMgr.GetTranslation("returnActivity.petTxt",_loc14_.StarLevel,_loc14_.Name);
                  }
                  else
                  {
                     _loc11_ = _loc3_.Name;
                  }
                  _loc8_ = _loc8_ + (_loc11_ + " x" + _loc9_.count + (_loc12_ == _buyGiftItem.giftbagArray[_loc6_].giftRewardArr.length - 1?"":"、\n"));
                  _loc12_++;
               }
               _loc6_++;
            }
            _gift.tipData = _loc8_;
            _gift.x = _buyBg.x + 12;
            _gift.y = _buyBg.y + 11;
            addChild(_gift);
         }
         else
         {
            _actTxt.x = _actTxt.x + 125;
            _actTimeTxt.x = _actTimeTxt.x + 125;
            _getTxt.x = _getTxt.x + 125;
            _getTimeTxt.x = _getTimeTxt.x + 125;
            _descSp.x = _descSp.x + 125;
            _allDescBg.x = _allDescBg.x + 125;
            _allDescTxt.x = _allDescTxt.x + 125;
         }
         _vBox = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.vbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.scroll");
         _scrollPanel.setView(_vBox);
         addChild(_scrollPanel);
         _loc2_ = 0;
         while(_loc2_ < _infoVec.length)
         {
            _loc4_ = 0;
            for(; _loc4_ < _infoVec[_loc2_].giftbagArray.length; _loc4_++)
            {
               if(_infoVec[_loc2_].giftbagArray[_loc4_].rewardMark != 100)
               {
                  _loc15_ = _type;
                  if(16 !== _loc15_)
                  {
                     if(17 !== _loc15_)
                     {
                        if(18 !== _loc15_)
                        {
                           if(4 !== _loc15_)
                           {
                              if(14 !== _loc15_)
                              {
                                 if(20 !== _loc15_)
                                 {
                                    if(15 !== _loc15_)
                                    {
                                       if(21 !== _loc15_)
                                       {
                                          if(24 !== _loc15_)
                                          {
                                             if(25 !== _loc15_)
                                             {
                                                if(22 !== _loc15_)
                                                {
                                                   if(23 !== _loc15_)
                                                   {
                                                      if(27 !== _loc15_)
                                                      {
                                                         if(28 !== _loc15_)
                                                         {
                                                            if(26 !== _loc15_)
                                                            {
                                                               if(39 === _loc15_)
                                                               {
                                                                  _loc10_ = new PlayerRegisterRwardItem(_type,_infoVec[_loc2_].giftbagArray[_loc4_],_loc4_ % 2);
                                                               }
                                                            }
                                                            else
                                                            {
                                                               _loc10_ = new PetUpgradeItem(_type,_infoVec[_loc2_].giftbagArray[_loc4_],_loc4_ % 2);
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _loc10_ = new UsePropsItem(_type,_infoVec[_loc2_].giftbagArray[_loc4_],_loc4_ % 2);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         _loc10_ = new TurnRoundEggItem(_type,_infoVec[_loc2_].giftbagArray[_loc4_],_loc4_ % 2);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      _loc10_ = new ActivationPotentialItem(_type,_infoVec[_loc2_].giftbagArray[_loc4_],_loc4_ % 2);
                                                   }
                                                }
                                                else
                                                {
                                                   _loc10_ = new WashPointCardItem(_type,_infoVec[_loc2_].giftbagArray[_loc4_],_loc4_ % 2);
                                                }
                                             }
                                             else
                                             {
                                                _loc10_ = new BuildUpgradeItem(_type,_infoVec[_loc2_].giftbagArray[_loc4_],_loc4_ % 2);
                                             }
                                          }
                                       }
                                       _loc10_ = new UseUpEnergyItem(_type,_infoVec[_loc2_].giftbagArray[_loc4_],_loc4_ % 2);
                                    }
                                    else if(_childType == 4)
                                    {
                                       _loc10_ = new RookieItem(_type,_infoVec[_loc2_].giftbagArray[_loc4_],_loc4_ % 2);
                                    }
                                    else
                                    {
                                       _loc10_ = new CarnivalActivityItem(_type,_infoVec[_loc2_].giftbagArray[_loc4_],_loc4_ % 2);
                                    }
                                 }
                                 else
                                 {
                                    _loc10_ = new GodTempleItem(_type,_infoVec[_loc2_].giftbagArray[_loc4_],_loc4_ % 2);
                                 }
                              }
                              else
                              {
                                 _loc10_ = new HorseDarenItem(_type,_infoVec[_loc2_].giftbagArray[_loc4_],_loc4_ % 2);
                              }
                           }
                           else
                           {
                              _loc10_ = new RookieItem(_type,_infoVec[_loc2_].giftbagArray[_loc4_],_loc4_ % 2);
                           }
                        }
                        else
                        {
                           _loc10_ = new DailyGiftItem(_type,_infoVec[_loc2_].giftbagArray[_loc4_],_loc4_ % 2);
                        }
                     }
                     else
                     {
                        _loc10_ = new WholePeoplePetActItem(_type,_infoVec[_loc2_].giftbagArray[_loc4_],_loc4_ % 2);
                     }
                  }
                  else
                  {
                     _loc10_ = new WholePeopleVipActItem(_type,_infoVec[_loc2_].giftbagArray[_loc4_],_loc4_ % 2);
                  }
                  if(_loc10_)
                  {
                     _itemVec.push(_loc10_);
                     _vBox.addChild(_loc10_);
                     continue;
                  }
                  continue;
               }
            }
            _loc2_++;
         }
         _scrollPanel.invalidateViewport();
         _timer = TimerManager.getInstance().addTimerJuggler(60000,int(_sumTime / 1000));
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
         addChild(_allDescBg);
         addChild(_allDescTxt);
         updateView();
      }
      
      public function updateView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _itemVec;
         for each(var _loc1_ in _itemVec)
         {
            _loc1_.updateView();
         }
         if(!_buyGiftItem)
         {
            return;
         }
         if(WonderfulActivityManager.Instance.activityInitData[_buyGiftItem.activityId] && WonderfulActivityManager.Instance.activityInitData[_buyGiftItem.activityId].giftInfoDic[_buyGiftItem.giftbagArray[0].giftbagId])
         {
            _buyGiftCurInfo = WonderfulActivityManager.Instance.activityInitData[_buyGiftItem.activityId].giftInfoDic[_buyGiftItem.giftbagArray[0].giftbagId];
         }
         if(_buyGiftLimitType != 3)
         {
            if(_buyGiftCurInfo)
            {
               _buyCount = _buyGiftLimitCount - _buyGiftCurInfo.times;
            }
            else
            {
               _buyCount = _buyGiftLimitCount;
            }
            _buyBtn.enable = _buyCount > 0;
         }
         else
         {
            _buyBtn.enable = true;
         }
         if(_buyCountTxt)
         {
            _buyCountTxt.text = LanguageMgr.GetTranslation("carnival.awardBuyCountTxt",_buyCount + "/" + _buyGiftLimitCount);
         }
      }
      
      private function initEvent() : void
      {
         if(_buyBtn)
         {
            _buyBtn.addEventListener("click",__buyGiftPackHandler);
         }
         _descSp.addEventListener("mouseOver",__overHandler);
         _descSp.addEventListener("mouseOut",__outHandler);
      }
      
      protected function __showRookieTip(param1:MouseEvent) : void
      {
      }
      
      protected function __hideRookieTip(param1:MouseEvent) : void
      {
      }
      
      protected function __outHandler(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         _allDescTxt.visible = _loc2_;
         _allDescBg.visible = _loc2_;
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = true;
         _allDescTxt.visible = _loc2_;
         _allDescBg.visible = _loc2_;
      }
      
      protected function __buyGiftPackHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.playButtonSound();
         if(!_buyGiftItem)
         {
            return;
         }
         if(_buyGiftType == -8)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc2_ = 0;
         }
         var _loc3_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("carnival.awardGiftBuyTxt",_buyGiftPrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false,_loc2_);
         _loc3_.addEventListener("response",__alertBuyGift);
      }
      
      protected function buyGift(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         var _loc5_:SendGiftInfo = new SendGiftInfo();
         _loc5_.activityId = _buyGiftItem.activityId;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _buyGiftItem.giftbagArray.length)
         {
            _loc2_.push(_buyGiftItem.giftbagArray[_loc4_].giftbagId + "," + (!!param1?-9:-8));
            _loc4_++;
         }
         _loc5_.giftIdArr = _loc2_;
         _loc3_.push(_loc5_);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc3_);
      }
      
      protected function __alertBuyGift(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",__alertBuyGift);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  ObjectUtils.disposeObject(param1.currentTarget);
                  return;
               }
               if(_loc3_.isBand)
               {
                  if(!checkMoney(true))
                  {
                     _loc3_.dispose();
                     _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("buried.alertInfo.noBindMoney"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
                     _loc2_.addEventListener("response",onResponseHander);
                     return;
                  }
               }
               else if(!checkMoney(false))
               {
                  _loc3_.dispose();
                  _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
                  _loc2_.addEventListener("response",_response);
                  return;
               }
               buyGift(_loc3_.isBand);
               break;
         }
         _loc3_.dispose();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function onResponseHander(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",onResponseHander);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(!checkMoney(false))
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               _loc2_.addEventListener("response",_response);
               return;
            }
            buyGift(false);
         }
         param1.currentTarget.dispose();
      }
      
      private function checkMoney(param1:Boolean) : Boolean
      {
         if(param1)
         {
            if(PlayerManager.Instance.Self.BandMoney < _buyGiftPrice)
            {
               return false;
            }
         }
         else if(PlayerManager.Instance.Self.Money < _buyGiftPrice)
         {
            return false;
         }
         return true;
      }
      
      private function removeEvent() : void
      {
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__buyGiftPackHandler);
         }
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            TimerManager.getInstance().removeJugglerByTimer(_timer);
            _timer = null;
         }
         if(_descSp)
         {
            _descSp.removeEventListener("mouseOver",__overHandler);
            _descSp.removeEventListener("mouseOut",__outHandler);
         }
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function setState(param1:int, param2:int) : void
      {
      }
      
      public function updateAwardState() : void
      {
         updateView();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_closeTimeTxt);
         _closeTimeTxt = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_actTxt);
         _actTxt = null;
         ObjectUtils.disposeObject(_actTimeTxt);
         _actTimeTxt = null;
         ObjectUtils.disposeObject(_getTxt);
         _getTxt = null;
         ObjectUtils.disposeObject(_getTimeTxt);
         _getTimeTxt = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_priceTxt);
         _priceTxt = null;
         ObjectUtils.disposeObject(_buyCountTxt);
         _buyCountTxt = null;
         ObjectUtils.disposeObject(_dailyBuyBg);
         _dailyBuyBg = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_gift);
         _gift = null;
         ObjectUtils.disposeObject(_buyBg);
         _buyBg = null;
         ObjectUtils.disposeObject(_allDescBg);
         _allDescBg = null;
         ObjectUtils.disposeObject(_allDescTxt);
         _allDescTxt = null;
         ObjectUtils.disposeObject(_descSp);
         _descSp = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_rookieRankView);
         _rookieRankView = null;
         ObjectUtils.disposeObject(_rookieRankIcon);
         _rookieRankIcon = null;
         _itemVec = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
