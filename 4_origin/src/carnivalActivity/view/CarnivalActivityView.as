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
      
      public function CarnivalActivityView(type:int, childType:int = 0, $id:String = "")
      {
         _type = type;
         _childType = childType;
         _id = $id;
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
         var k:int = 0;
         var i:int = 0;
         var j:int = 0;
         _giftInfoVec = new Vector.<GiftBagInfo>();
         _infoVec = new Vector.<GmActivityInfo>();
         var dic:Dictionary = WonderfulActivityManager.Instance.activityData;
         var now:Date = TimeManager.Instance.Now();
         var _loc9_:int = 0;
         var _loc8_:* = WonderfulActivityManager.Instance.activityData;
         for each(var item in WonderfulActivityManager.Instance.activityData)
         {
            if(!(now.time < Date.parse(item.beginTime) || now.time > Date.parse(item.endShowTime)))
            {
               if(item.activityType == _type && item.activityType == 18)
               {
                  initItem(item);
               }
               else if(_childType == 4 && item.activityType == _type && (item.activityChildType == 4 || item.activityChildType == 4 + 8))
               {
                  initItem(item);
               }
               else if(item.activityType == 20 && item.activityChildType == 0 && WonderfulActivityManager.Instance.leftViewInfoDic[item.activityId] != null)
               {
                  if(_id == item.activityId)
                  {
                     initItem(item);
                     break;
                  }
               }
               else if(item.activityType == _type && item.activityChildType == _childType)
               {
                  initItem(item);
                  break;
               }
            }
         }
         CarnivalActivityControl.instance.currentType = _type;
         CarnivalActivityControl.instance.currentChildType = _childType;
         for(k = 0; k < _infoVec.length; )
         {
            for(i = 0; i < _infoVec[k].giftbagArray.length; )
            {
               if(_infoVec[k].giftbagArray[i].rewardMark == 100)
               {
                  for(j = 0; j < _infoVec[k].giftbagArray[i].giftConditionArr.length; )
                  {
                     if(_infoVec[k].giftbagArray[i].giftConditionArr[j].conditionIndex == 101 && _infoVec[k].giftbagArray[i].giftConditionArr[j].conditionValue == 1)
                     {
                        _hasBuyGift = true;
                        _buyGiftActId = _infoVec[k].giftbagArray[i].giftConditionArr[j].remain2;
                        break;
                     }
                     j++;
                  }
               }
               if(!_hasBuyGift)
               {
                  i++;
                  continue;
               }
               break;
            }
            k++;
         }
         var _loc11_:int = 0;
         var _loc10_:* = WonderfulActivityManager.Instance.activityData;
         for each(var giftItem in WonderfulActivityManager.Instance.activityData)
         {
            if(giftItem.activityId == _buyGiftActId)
            {
               _buyGiftItem = giftItem;
               _buyGiftLimitType = _buyGiftItem.giftbagArray[0].giftConditionArr[0].conditionValue;
               _buyGiftLimitCount = _buyGiftItem.giftbagArray[0].giftConditionArr[1].conditionValue;
               _buyGiftType = _buyGiftItem.giftbagArray[0].giftConditionArr[2].conditionValue;
               _buyGiftPrice = _buyGiftItem.giftbagArray[0].giftConditionArr[3].conditionValue;
               break;
            }
         }
      }
      
      private function initItem(item:GmActivityInfo) : void
      {
         var k:int = 0;
         if(!_item)
         {
            _item = item;
         }
         if(_sumTime == 0)
         {
            _sumTime = Date.parse(item.endTime) - new Date().time;
         }
         k = 0;
         while(k < item.giftbagArray.length)
         {
            _giftInfoVec.push(item.giftbagArray[k]);
            k++;
         }
         _infoVec.push(item);
      }
      
      private function updateTime() : void
      {
         var hours:int = _sumTime <= 0?0:Number(_sumTime / 3600000);
         var minutes:int = _sumTime <= 0?0:Number((_sumTime / 3600000 - hours) * 60);
         var _sumTimeStr:String = "";
         if(hours < 10)
         {
            _sumTimeStr = _sumTimeStr + ("0" + hours);
         }
         else
         {
            _sumTimeStr = _sumTimeStr + hours;
         }
         _sumTimeStr = _sumTimeStr + LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.hour");
         if(minutes < 10)
         {
            _sumTimeStr = _sumTimeStr + ("0" + minutes);
         }
         else
         {
            _sumTimeStr = _sumTimeStr + minutes;
         }
         _sumTimeStr = _sumTimeStr + LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.minute");
         _timeTxt.text = _sumTimeStr;
      }
      
      protected function __timerHandler(event:Event) : void
      {
         _sumTime = _sumTime - 60000;
         updateTime();
      }
      
      protected function initView() : void
      {
         var awardStr:* = null;
         var ki:int = 0;
         var bi:int = 0;
         var giftInfo:* = null;
         var name:* = null;
         var info:* = null;
         var beadInfo:* = null;
         var petInfo:* = null;
         var k:int = 0;
         var i:int = 0;
         var item:* = null;
         CarnivalActivityControl.instance.getBeginTime = Date.parse(_item.beginShowTime);
         CarnivalActivityControl.instance.getEndTime = Date.parse(_item.endShowTime);
         CarnivalActivityControl.instance.actBeginTime = Date.parse(_item.beginTime);
         CarnivalActivityControl.instance.actEndTime = Date.parse(_item.endTime);
         _bg = ComponentFactory.Instance.creat("carnicalAct.bg");
         addChild(_bg);
         var _loc18_:int = 0;
         var _loc17_:* = _infoVec;
         for each(var gmInfo in _infoVec)
         {
            var _loc16_:* = 0;
            var _loc15_:* = WonderfulActivityManager.Instance.rankActDic;
            for(var id in WonderfulActivityManager.Instance.rankActDic)
            {
               if(gmInfo.activityId == id && WonderfulActivityManager.Instance.rankActDic[id].length > 0)
               {
                  _rookieRankIcon = ComponentFactory.Instance.creat("wonderfulactivity.rookie.rankIcon");
                  addChild(_rookieRankIcon);
                  _rookieRankView = new RookieRankTipView();
                  _rookieRankView.x = 258;
                  _rookieRankView.y = 195;
                  _rookieRankView.tipStyle = "carnivalActivity.view.RookieRankTip";
                  _rookieRankView.tipDirctions = "7,3,2";
                  _rookieRankView.tipData = WonderfulActivityManager.Instance.rankActDic[id];
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
         var str:String = _item.desc;
         _descTxt.text = str;
         addChild(_descSp);
         _allDescBg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _allDescBg.x = _descTxt.x;
         _allDescBg.y = _descTxt.y + 25;
         _allDescTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.allDescTxt");
         _allDescTxt.text = str;
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
            awardStr = LanguageMgr.GetTranslation("ddt.bagandinfo.awardsTitle") + "\n";
            for(ki = 0; ki < _buyGiftItem.giftbagArray.length; )
            {
               for(bi = 0; bi < _buyGiftItem.giftbagArray[ki].giftRewardArr.length; )
               {
                  giftInfo = _buyGiftItem.giftbagArray[ki].giftRewardArr[bi];
                  name = "";
                  info = new InventoryItemInfo();
                  info.TemplateID = giftInfo.templateId;
                  info = ItemManager.fill(info);
                  if(EquipType.isBead(parseInt(info.Property1)))
                  {
                     beadInfo = BeadTemplateManager.Instance.GetBeadInfobyID(info.TemplateID);
                     name = info.Name + "-" + beadInfo.Name + "Lv" + beadInfo.BaseLevel;
                  }
                  else if(EquipType.isMagicStone(info.CategoryID))
                  {
                     name = info.Name + "(" + QualityType.QUALITY_STRING[info.Quality] + ")";
                  }
                  else if(EquipType.isPetEgg(info.CategoryID))
                  {
                     petInfo = PetInfoManager.getPetByTemplateID(parseInt(info.Property5));
                     name = LanguageMgr.GetTranslation("returnActivity.petTxt",petInfo.StarLevel,petInfo.Name);
                  }
                  else
                  {
                     name = info.Name;
                  }
                  awardStr = awardStr + (name + " x" + giftInfo.count + (bi == _buyGiftItem.giftbagArray[ki].giftRewardArr.length - 1?"":"、\n"));
                  bi++;
               }
               ki++;
            }
            _gift.tipData = awardStr;
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
         for(k = 0; k < _infoVec.length; )
         {
            for(i = 0; i < _infoVec[k].giftbagArray.length; i++)
            {
               if(_infoVec[k].giftbagArray[i].rewardMark != 100)
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
                                                                  item = new PlayerRegisterRwardItem(_type,_infoVec[k].giftbagArray[i],i % 2);
                                                               }
                                                            }
                                                            else
                                                            {
                                                               item = new PetUpgradeItem(_type,_infoVec[k].giftbagArray[i],i % 2);
                                                            }
                                                         }
                                                         else
                                                         {
                                                            item = new UsePropsItem(_type,_infoVec[k].giftbagArray[i],i % 2);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         item = new TurnRoundEggItem(_type,_infoVec[k].giftbagArray[i],i % 2);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      item = new ActivationPotentialItem(_type,_infoVec[k].giftbagArray[i],i % 2);
                                                   }
                                                }
                                                else
                                                {
                                                   item = new WashPointCardItem(_type,_infoVec[k].giftbagArray[i],i % 2);
                                                }
                                             }
                                             else
                                             {
                                                item = new BuildUpgradeItem(_type,_infoVec[k].giftbagArray[i],i % 2);
                                             }
                                          }
                                       }
                                       item = new UseUpEnergyItem(_type,_infoVec[k].giftbagArray[i],i % 2);
                                    }
                                    else if(_childType == 4)
                                    {
                                       item = new RookieItem(_type,_infoVec[k].giftbagArray[i],i % 2);
                                    }
                                    else
                                    {
                                       item = new CarnivalActivityItem(_type,_infoVec[k].giftbagArray[i],i % 2);
                                    }
                                 }
                                 else
                                 {
                                    item = new GodTempleItem(_type,_infoVec[k].giftbagArray[i],i % 2);
                                 }
                              }
                              else
                              {
                                 item = new HorseDarenItem(_type,_infoVec[k].giftbagArray[i],i % 2);
                              }
                           }
                           else
                           {
                              item = new RookieItem(_type,_infoVec[k].giftbagArray[i],i % 2);
                           }
                        }
                        else
                        {
                           item = new DailyGiftItem(_type,_infoVec[k].giftbagArray[i],i % 2);
                        }
                     }
                     else
                     {
                        item = new WholePeoplePetActItem(_type,_infoVec[k].giftbagArray[i],i % 2);
                     }
                  }
                  else
                  {
                     item = new WholePeopleVipActItem(_type,_infoVec[k].giftbagArray[i],i % 2);
                  }
                  if(item)
                  {
                     _itemVec.push(item);
                     _vBox.addChild(item);
                     continue;
                  }
                  continue;
               }
            }
            k++;
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
         for each(var cItem in _itemVec)
         {
            cItem.updateView();
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
      
      protected function __showRookieTip(event:MouseEvent) : void
      {
      }
      
      protected function __hideRookieTip(event:MouseEvent) : void
      {
      }
      
      protected function __outHandler(event:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         _allDescTxt.visible = _loc2_;
         _allDescBg.visible = _loc2_;
      }
      
      protected function __overHandler(event:MouseEvent) : void
      {
         var _loc2_:Boolean = true;
         _allDescTxt.visible = _loc2_;
         _allDescBg.visible = _loc2_;
      }
      
      protected function __buyGiftPackHandler(event:MouseEvent) : void
      {
         var type:int = 0;
         SoundManager.instance.playButtonSound();
         if(!_buyGiftItem)
         {
            return;
         }
         if(_buyGiftType == -8)
         {
            type = 0;
         }
         else
         {
            type = 0;
         }
         var alertAsk:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("carnival.awardGiftBuyTxt",_buyGiftPrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false,type);
         alertAsk.addEventListener("response",__alertBuyGift);
      }
      
      protected function buyGift(isBand:Boolean) : void
      {
         var i:int = 0;
         var sendInfoVec:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         var info:SendGiftInfo = new SendGiftInfo();
         info.activityId = _buyGiftItem.activityId;
         var temp:Array = [];
         for(i = 0; i < _buyGiftItem.giftbagArray.length; )
         {
            temp.push(_buyGiftItem.giftbagArray[i].giftbagId + "," + (!!isBand?-9:-8));
            i++;
         }
         info.giftIdArr = temp;
         sendInfoVec.push(info);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(sendInfoVec);
      }
      
      protected function __alertBuyGift(event:FrameEvent) : void
      {
         var alertFrame:* = null;
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__alertBuyGift);
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  ObjectUtils.disposeObject(event.currentTarget);
                  return;
               }
               if(frame.isBand)
               {
                  if(!checkMoney(true))
                  {
                     frame.dispose();
                     alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("buried.alertInfo.noBindMoney"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
                     alertFrame.addEventListener("response",onResponseHander);
                     return;
                  }
               }
               else if(!checkMoney(false))
               {
                  frame.dispose();
                  alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
                  alertFrame.addEventListener("response",_response);
                  return;
               }
               buyGift(frame.isBand);
               break;
         }
         frame.dispose();
      }
      
      private function _response(evt:FrameEvent) : void
      {
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      private function onResponseHander(e:FrameEvent) : void
      {
         var alertFrame:* = null;
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",onResponseHander);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            if(!checkMoney(false))
            {
               alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               alertFrame.addEventListener("response",_response);
               return;
            }
            buyGift(false);
         }
         e.currentTarget.dispose();
      }
      
      private function checkMoney(isBand:Boolean) : Boolean
      {
         if(isBand)
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
      
      public function setState(type:int, id:int) : void
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
