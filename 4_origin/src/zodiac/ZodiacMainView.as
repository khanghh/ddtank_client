package zodiac
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.selfConsortia.ConsortionBankBagView;
   import cryptBoss.CryptBossManager;
   import dayActivity.DayActivityManager;
   import ddt.bagStore.BagStore;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import horse.HorseManager;
   import quest.TaskManager;
   
   public class ZodiacMainView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _title:MovieClip;
      
      private var _details:FilterFrameText;
      
      private var _quest:FilterFrameText;
      
      private var _lastCount:FilterFrameText;
      
      private var _awards:Array;
      
      private var _boxBtnBitmap:Bitmap;
      
      private var _boxBtnBitmapDark:Bitmap;
      
      private var _boxMask:MovieClip;
      
      private var _boxAwardBtn:MovieClip;
      
      private var _boxComponent:Component;
      
      private var _addBtn:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _gotofinishBtn:SimpleBitmapButton;
      
      private var _getAwardBtn:SimpleBitmapButton;
      
      private var _helpframe:Frame;
      
      private var _bgHelp:Scale9CornerImage;
      
      private var _content:MovieClip;
      
      private var _btnOk:TextButton;
      
      private var _index:int;
      
      private var _last:int;
      
      private var _indexType:int;
      
      public function ZodiacMainView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("zodiac.mainview.bg");
         addChild(_bg);
         _title = ClassUtils.CreatInstance("zodiac.mainview.title.mc");
         PositionUtils.setPos(_title,"zodiac.mainview.titlemc.pos");
         addChild(_title);
         _details = ComponentFactory.Instance.creatComponentByStylename("zodiac.mainview.details.txt");
         addChild(_details);
         _quest = ComponentFactory.Instance.creatComponentByStylename("zodiac.mainview.quest.txt");
         addChild(_quest);
         _boxBtnBitmapDark = ComponentFactory.Instance.creatBitmap("zodiac.mainview.boxbitmap");
         _boxBtnBitmapDark.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _boxBtnBitmap = ComponentFactory.Instance.creatBitmap("zodiac.mainview.boxbitmap");
         _boxMask = ClassUtils.CreatInstance("zodiac.mainview.boxbitmap.mask");
         _boxBtnBitmap.mask = _boxMask;
         _boxAwardBtn = ClassUtils.CreatInstance("zodiac.mainview.boxshine");
         _boxAwardBtn.visible = false;
         _boxComponent = ComponentFactory.Instance.creatComponentByStylename("zodiac.frame.boxconent");
         _boxComponent.addChild(_boxBtnBitmapDark);
         _boxComponent.addChild(_boxBtnBitmap);
         _boxComponent.addChild(_boxMask);
         _boxComponent.addChild(_boxAwardBtn);
         _boxComponent.buttonMode = false;
         var allawardinfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(201585);
         var cell:BagCell = new BagCell(0,allawardinfo,false);
         _boxComponent.tipData = cell.tipData;
         addChild(_boxComponent);
         _lastCount = ComponentFactory.Instance.creatComponentByStylename("zodiac.mainview.lastcount.txt");
         addChild(_lastCount);
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("zodiac.mainview.addcounts.btn");
         addChild(_addBtn);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("zodiac.mainview.help.btn");
         addChild(_helpBtn);
         _gotofinishBtn = ComponentFactory.Instance.creatComponentByStylename("zodiac.mainview.gotofinish.btn");
         addChild(_gotofinishBtn);
         _gotofinishBtn.visible = false;
         _getAwardBtn = ComponentFactory.Instance.creatComponentByStylename("zodiac.mainview.getaward.btn");
         addChild(_getAwardBtn);
         _getAwardBtn.visible = false;
      }
      
      private function initEvent() : void
      {
         _addBtn.addEventListener("click",__addCounts);
         _boxComponent.addEventListener("click",__getAwardAll);
         _gotofinishBtn.addEventListener("click",__gotoFinish);
         _getAwardBtn.addEventListener("click",__getAward);
         _helpBtn.addEventListener("click",__showHelpFrame);
      }
      
      private function removeEvent() : void
      {
         _addBtn.removeEventListener("click",__addCounts);
         _boxComponent.removeEventListener("click",__getAwardAll);
         _gotofinishBtn.removeEventListener("click",__gotoFinish);
         _getAwardBtn.removeEventListener("click",__getAward);
         _helpBtn.removeEventListener("click",__showHelpFrame);
      }
      
      private function __addCounts(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ZodiacControl.instance.inRolling)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("zodiac.mainview.inrolling"));
            return;
         }
         var frame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("zodiac.mainview.addCountstip",ServerConfigManager.instance.zodiacAddPrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,1);
         frame.addEventListener("response",__onAlertResponse);
      }
      
      private function __onAlertResponse(e:FrameEvent) : void
      {
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onAlertResponse);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            CheckMoneyUtils.instance.checkMoney(frame.isBand,ServerConfigManager.instance.zodiacAddPrice,onCompleteHandler);
         }
         frame.dispose();
      }
      
      private function onCompleteHandler() : void
      {
         SocketManager.Instance.out.zodiacAddCounts(CheckMoneyUtils.instance.isBind);
      }
      
      private function __gotoFinish(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ZodiacControl.instance.inRolling)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("zodiac.mainview.inrolling"));
            return;
         }
         var _loc2_:* = _indexType;
         if(34 !== _loc2_)
         {
            if(41 !== _loc2_)
            {
               if(42 !== _loc2_)
               {
                  if(37 !== _loc2_)
                  {
                     if(46 !== _loc2_)
                     {
                        if(35 !== _loc2_)
                        {
                           if(47 !== _loc2_)
                           {
                              if(33 !== _loc2_)
                              {
                                 if(48 !== _loc2_)
                                 {
                                    if(49 !== _loc2_)
                                    {
                                       if(50 !== _loc2_)
                                       {
                                          if(51 !== _loc2_)
                                          {
                                             if(52 !== _loc2_)
                                             {
                                                if(53 !== _loc2_)
                                                {
                                                   if(45 !== _loc2_)
                                                   {
                                                      if(54 !== _loc2_)
                                                      {
                                                         if(55 !== _loc2_)
                                                         {
                                                            if(56 !== _loc2_)
                                                            {
                                                               if(57 !== _loc2_)
                                                               {
                                                                  if(58 !== _loc2_)
                                                                  {
                                                                     if(59 !== _loc2_)
                                                                     {
                                                                        if(60 !== _loc2_)
                                                                        {
                                                                           if(61 !== _loc2_)
                                                                           {
                                                                              if(62 !== _loc2_)
                                                                              {
                                                                                 if(63 !== _loc2_)
                                                                                 {
                                                                                    if(64 !== _loc2_)
                                                                                    {
                                                                                       if(65 !== _loc2_)
                                                                                       {
                                                                                          if(66 !== _loc2_)
                                                                                          {
                                                                                             if(67 === _loc2_)
                                                                                             {
                                                                                                if(PlayerManager.Instance.Self.Grade < 14)
                                                                                                {
                                                                                                   MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",14));
                                                                                                   return;
                                                                                                }
                                                                                                StateManager.setState("ddtchurchroomlist");
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             if(PlayerManager.Instance.Self.Grade < 6)
                                                                                             {
                                                                                                MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",6));
                                                                                                return;
                                                                                             }
                                                                                             StateManager.setState("shop");
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          BagAndInfoManager.Instance.showBagAndInfo(0,"",8);
                                                                                       }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       if(PlayerManager.Instance.Self.Grade < 10)
                                                                                       {
                                                                                          MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",10));
                                                                                          return;
                                                                                       }
                                                                                       BagAndInfoManager.Instance.showBagAndInfo(7);
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    if(PlayerManager.Instance.Self.Grade < 16)
                                                                                    {
                                                                                       MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",16));
                                                                                       return;
                                                                                    }
                                                                                    BagAndInfoManager.Instance.showBagAndInfo(6);
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 if(PlayerManager.Instance.Self.Grade < 22)
                                                                                 {
                                                                                    MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",22));
                                                                                    return;
                                                                                 }
                                                                                 BagAndInfoManager.Instance.showBagAndInfo(5);
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              if(PlayerManager.Instance.Self.Grade < 5)
                                                                              {
                                                                                 MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",5));
                                                                                 return;
                                                                              }
                                                                              BagStore.instance.openStore("bag_store");
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           if(PlayerManager.Instance.Self.Grade < 10)
                                                                           {
                                                                              MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",10));
                                                                              return;
                                                                           }
                                                                           BagStore.instance.openStore("bag_store");
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        if(PlayerManager.Instance.Self.Grade < 5)
                                                                        {
                                                                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",5));
                                                                           return;
                                                                        }
                                                                        BagStore.instance.openStore("bag_store");
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     if(PlayerManager.Instance.Self.Grade < 40)
                                                                     {
                                                                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",40));
                                                                        return;
                                                                     }
                                                                     BagStore.instance.openStore("forge_store",4);
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  if(PlayerManager.Instance.Self.Grade < 30)
                                                                  {
                                                                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",30));
                                                                     return;
                                                                  }
                                                                  BagStore.instance.openStore("forge_store",3);
                                                               }
                                                            }
                                                            else
                                                            {
                                                               if(PlayerManager.Instance.Self.Grade < 10)
                                                               {
                                                                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",10));
                                                                  return;
                                                               }
                                                               BagStore.instance.openStore("forge_store",2);
                                                            }
                                                         }
                                                         else
                                                         {
                                                            if(PlayerManager.Instance.Self.Grade < 25)
                                                            {
                                                               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",25));
                                                               return;
                                                            }
                                                            BagStore.instance.openStore("forge_store",1);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         if(PlayerManager.Instance.Self.Grade < 30)
                                                         {
                                                            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",30));
                                                            return;
                                                         }
                                                         BagStore.instance.openStore("forge_store",0);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      if(PlayerManager.Instance.Self.Grade < 25)
                                                      {
                                                         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",25));
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
                                                   }
                                                }
                                                else
                                                {
                                                   DayActivityManager.Instance.show();
                                                }
                                             }
                                             else
                                             {
                                                if(PlayerManager.Instance.Self.Grade < 45)
                                                {
                                                   MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",45));
                                                   return;
                                                }
                                                CryptBossManager.instance.show();
                                             }
                                          }
                                          else
                                          {
                                             if(PlayerManager.Instance.Self.Grade < 15)
                                             {
                                                MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",15));
                                                return;
                                             }
                                             BagAndInfoManager.Instance.showBagAndInfo(4);
                                          }
                                       }
                                       else
                                       {
                                          FarmModelController.instance.goFarm(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName);
                                       }
                                    }
                                 }
                                 else
                                 {
                                    if(PlayerManager.Instance.Self.Grade < 40)
                                    {
                                       MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",40));
                                       return;
                                    }
                                    BagAndInfoManager.Instance.showBagAndInfo(8);
                                 }
                              }
                              else
                              {
                                 if(PlayerManager.Instance.Self.Grade < 17)
                                 {
                                    MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",17));
                                    return;
                                 }
                                 StateManager.setState("consortia");
                              }
                           }
                           else
                           {
                              if(PlayerManager.Instance.Self.Grade < 20)
                              {
                                 MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",20));
                                 return;
                              }
                              HorseManager.instance.show();
                           }
                        }
                        else
                        {
                           if(PlayerManager.Instance.Self.Grade < 5)
                           {
                              MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",5));
                              return;
                           }
                           BagStore.instance.openStore("bag_store");
                        }
                     }
                     else
                     {
                        if(PlayerManager.Instance.Self.Grade < 18)
                        {
                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",18));
                           return;
                        }
                        StateManager.setState("auction");
                     }
                  }
                  else
                  {
                     if(PlayerManager.Instance.Self.Grade < 10)
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",10));
                        return;
                     }
                     StateManager.setState("dungeon");
                  }
               }
               else
               {
                  if(PlayerManager.Instance.Self.Grade < 13)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",13));
                     return;
                  }
                  BagAndInfoManager.Instance.showBagAndInfo(2);
               }
            }
            else
            {
               if(PlayerManager.Instance.Self.Grade < 25)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",25));
                  return;
               }
               BagAndInfoManager.Instance.showBagAndInfo(3);
            }
         }
         else
         {
            if(PlayerManager.Instance.Self.Grade < 3)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",3));
               return;
            }
            StateManager.setState("roomlist");
         }
         ZodiacManager.instance.hide();
      }
      
      private function __getAward(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ZodiacControl.instance.inRolling)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("zodiac.mainview.inrolling"));
            return;
         }
         SocketManager.Instance.out.zodiacGetAward(ZodiacModel.instance.questArr[_index - 1]);
      }
      
      private function __getAwardAll(e:MouseEvent) : void
      {
         if(_boxAwardBtn.visible == false)
         {
            return;
         }
         SoundManager.instance.play("008");
         if(ZodiacControl.instance.inRolling)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("zodiac.mainview.inrolling"));
            return;
         }
         SocketManager.Instance.out.zodiacGetAwardAll();
      }
      
      private function __showHelpFrame(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ZodiacControl.instance.inRolling)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("zodiac.mainview.inrolling"));
            return;
         }
         if(!_helpframe)
         {
            _helpframe = ComponentFactory.Instance.creatComponentByStylename("zodiac.frame.help.main");
            _helpframe.titleText = LanguageMgr.GetTranslation("zodiac.mainframe.title");
            _helpframe.addEventListener("response",__helpFrameRespose);
            _bgHelp = ComponentFactory.Instance.creatComponentByStylename("zodiac.frame.help.bgHelp");
            _content = ComponentFactory.Instance.creatCustomObject("zodiac.frame.help.content");
            _btnOk = ComponentFactory.Instance.creatComponentByStylename("zodiac.frame.help.btnOk");
            _btnOk.text = LanguageMgr.GetTranslation("ok");
            _btnOk.addEventListener("click",__closeHelpFrame);
            _helpframe.addToContent(_bgHelp);
            _helpframe.addToContent(_content);
            _helpframe.addToContent(_btnOk);
         }
         LayerManager.Instance.addToLayer(_helpframe,3,true,2);
      }
      
      private function __helpFrameRespose(e:FrameEvent) : void
      {
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            SoundManager.instance.play("008");
            _helpframe.parent.removeChild(_helpframe);
         }
      }
      
      private function __closeHelpFrame(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _helpframe.parent.removeChild(_helpframe);
      }
      
      public function setViewIndex($index:int) : void
      {
         if($index == 0)
         {
            $index = 1;
         }
         _index = $index;
         _title.gotoAndStop(_index);
         _details.text = LanguageMgr.GetTranslation("zodiac.mainview.constellation" + _index);
         setQuestInfo();
         updateView();
      }
      
      public function updateView() : void
      {
         var index:int = 0;
         _last = ZodiacModel.instance.maxCounts - ZodiacModel.instance.finshedCounts;
         _lastCount.text = _last.toString();
         var propress:int = 0;
         for(index = 1; index <= 13; )
         {
            if((ZodiacModel.instance.awardRecord >> index & 1) == 1)
            {
               propress++;
            }
            index++;
         }
         _boxMask.y = _boxBtnBitmap.y + _boxBtnBitmap.height - propress * 4;
         if(propress == 12)
         {
            var _loc4_:* = false;
            _boxMask.visible = _loc4_;
            _loc4_ = _loc4_;
            _boxBtnBitmapDark.visible = _loc4_;
            _boxBtnBitmap.visible = _loc4_;
            _boxAwardBtn.visible = true;
            _boxComponent.buttonMode = true;
         }
         if(propress == 13)
         {
            _boxBtnBitmap.visible = true;
            _loc4_ = false;
            _boxMask.visible = _loc4_;
            _boxBtnBitmapDark.visible = _loc4_;
            _boxAwardBtn.visible = false;
            _boxComponent.buttonMode = false;
         }
         var info:QuestInfo = TaskManager.instance.getQuestByID(ZodiacModel.instance.questArr[_index - 1]);
         refreshQuestBtn(_index,info);
      }
      
      private function setQuestInfo() : void
      {
         var a:int = 0;
         var info:* = null;
         var pos:* = null;
         var i:int = 0;
         var reward:* = null;
         var tinfo:* = null;
         var cell:* = null;
         if(_awards != null)
         {
            for(a = 0; a < _awards.length; )
            {
               removeChild(_awards[0]);
               _awards.shift();
            }
         }
         else
         {
            _awards = [];
         }
         var questID:int = ZodiacModel.instance.questArr[_index - 1];
         if(questID != 0)
         {
            info = TaskManager.instance.getQuestByID(questID);
            if((ZodiacModel.instance.awardRecord >> _index & 1) == 1)
            {
               _quest.text = info.Detail + "(" + LanguageMgr.GetTranslation("zodiac.mainview.questcomplete") + ")";
            }
            else
            {
               _quest.text = info.conditionDescription[0];
            }
            _indexType = ZodiacModel.instance.indexTypeArr[questID];
            refreshQuestBtn(_index,info);
            if(info.itemRewards)
            {
               pos = PositionUtils.creatPoint("zodiac.mainview.awardcell.pos");
               for(i = 0; i < info.itemRewards.length; )
               {
                  reward = info.itemRewards[i];
                  tinfo = new InventoryItemInfo();
                  tinfo.TemplateID = reward.itemID;
                  tinfo.Count = reward.count[0];
                  tinfo.AttackCompose = reward.AttackCompose;
                  tinfo.DefendCompose = reward.DefendCompose;
                  tinfo.LuckCompose = reward.LuckCompose;
                  tinfo.AgilityCompose = reward.AgilityCompose;
                  tinfo.StrengthenLevel = reward.StrengthenLevel;
                  tinfo.MagicAttack = reward.MagicAttack;
                  tinfo.MagicDefence = reward.MagicDefence;
                  tinfo.IsBinds = reward.isBind;
                  tinfo.ValidDate = reward.ValidateTime;
                  ItemManager.fill(tinfo);
                  cell = new BagCell(0,tinfo,false,ComponentFactory.Instance.creatBitmap("zodiac.mainview.awardcell.bg"),false);
                  cell.setContentSize(53,53);
                  cell.setCount(tinfo.Count);
                  cell.x = pos.x + 78 * (i % 3);
                  cell.y = pos.y + 62 * (int(i / 3) % 3);
                  addChild(cell);
                  _awards.push(cell);
                  i++;
               }
            }
         }
         else
         {
            _indexType = 0;
         }
      }
      
      private function refreshQuestBtn(index:int, info:QuestInfo) : void
      {
         if(info == null)
         {
            return;
         }
         if((ZodiacModel.instance.awardRecord >> index & 1) == 1)
         {
            _gotofinishBtn.visible = false;
            _getAwardBtn.visible = true;
            _getAwardBtn.enable = false;
         }
         else if(info.isAchieved)
         {
            _gotofinishBtn.visible = false;
            _getAwardBtn.visible = true;
            _getAwardBtn.enable = false;
         }
         else if(info.isCompleted)
         {
            _gotofinishBtn.visible = false;
            _getAwardBtn.visible = true;
            _getAwardBtn.enable = true;
         }
         else
         {
            _gotofinishBtn.visible = _indexType == 0 || _indexType == 49?false:true;
            _getAwardBtn.visible = false;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.removeChildAllChildren(this);
      }
   }
}
