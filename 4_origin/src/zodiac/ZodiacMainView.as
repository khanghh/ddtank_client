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
         var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(201585);
         var _loc1_:BagCell = new BagCell(0,_loc2_,false);
         _boxComponent.tipData = _loc1_.tipData;
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
      
      private function __addCounts(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ZodiacControl.instance.inRolling)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("zodiac.mainview.inrolling"));
            return;
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("zodiac.mainview.addCountstip",ServerConfigManager.instance.zodiacAddPrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,1);
         _loc2_.addEventListener("response",__onAlertResponse);
      }
      
      private function __onAlertResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onAlertResponse);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            CheckMoneyUtils.instance.checkMoney(_loc2_.isBand,ServerConfigManager.instance.zodiacAddPrice,onCompleteHandler);
         }
         _loc2_.dispose();
      }
      
      private function onCompleteHandler() : void
      {
         SocketManager.Instance.out.zodiacAddCounts(CheckMoneyUtils.instance.isBind);
      }
      
      private function __gotoFinish(param1:MouseEvent) : void
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
      
      private function __getAward(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ZodiacControl.instance.inRolling)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("zodiac.mainview.inrolling"));
            return;
         }
         SocketManager.Instance.out.zodiacGetAward(ZodiacModel.instance.questArr[_index - 1]);
      }
      
      private function __getAwardAll(param1:MouseEvent) : void
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
      
      private function __showHelpFrame(param1:MouseEvent) : void
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
      
      private function __helpFrameRespose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            _helpframe.parent.removeChild(_helpframe);
         }
      }
      
      private function __closeHelpFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _helpframe.parent.removeChild(_helpframe);
      }
      
      public function setViewIndex(param1:int) : void
      {
         if(param1 == 0)
         {
            param1 = 1;
         }
         _index = param1;
         _title.gotoAndStop(_index);
         _details.text = LanguageMgr.GetTranslation("zodiac.mainview.constellation" + _index);
         setQuestInfo();
         updateView();
      }
      
      public function updateView() : void
      {
         var _loc1_:int = 0;
         _last = ZodiacModel.instance.maxCounts - ZodiacModel.instance.finshedCounts;
         _lastCount.text = _last.toString();
         var _loc2_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= 13)
         {
            if((ZodiacModel.instance.awardRecord >> _loc1_ & 1) == 1)
            {
               _loc2_++;
            }
            _loc1_++;
         }
         _boxMask.y = _boxBtnBitmap.y + _boxBtnBitmap.height - _loc2_ * 4;
         if(_loc2_ == 12)
         {
            var _loc4_:* = false;
            _boxMask.visible = _loc4_;
            _loc4_ = _loc4_;
            _boxBtnBitmapDark.visible = _loc4_;
            _boxBtnBitmap.visible = _loc4_;
            _boxAwardBtn.visible = true;
            _boxComponent.buttonMode = true;
         }
         if(_loc2_ == 13)
         {
            _boxBtnBitmap.visible = true;
            _loc4_ = false;
            _boxMask.visible = _loc4_;
            _boxBtnBitmapDark.visible = _loc4_;
            _boxAwardBtn.visible = false;
            _boxComponent.buttonMode = false;
         }
         var _loc3_:QuestInfo = TaskManager.instance.getQuestByID(ZodiacModel.instance.questArr[_index - 1]);
         refreshQuestBtn(_index,_loc3_);
      }
      
      private function setQuestInfo() : void
      {
         var _loc4_:int = 0;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         if(_awards != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _awards.length)
            {
               removeChild(_awards[0]);
               _awards.shift();
            }
         }
         else
         {
            _awards = [];
         }
         var _loc1_:int = ZodiacModel.instance.questArr[_index - 1];
         if(_loc1_ != 0)
         {
            _loc8_ = TaskManager.instance.getQuestByID(_loc1_);
            if((ZodiacModel.instance.awardRecord >> _index & 1) == 1)
            {
               _quest.text = _loc8_.Detail + "(" + LanguageMgr.GetTranslation("zodiac.mainview.questcomplete") + ")";
            }
            else
            {
               _quest.text = _loc8_.conditionDescription[0];
            }
            _indexType = ZodiacModel.instance.indexTypeArr[_loc1_];
            refreshQuestBtn(_index,_loc8_);
            if(_loc8_.itemRewards)
            {
               _loc7_ = PositionUtils.creatPoint("zodiac.mainview.awardcell.pos");
               _loc6_ = 0;
               while(_loc6_ < _loc8_.itemRewards.length)
               {
                  _loc2_ = _loc8_.itemRewards[_loc6_];
                  _loc5_ = new InventoryItemInfo();
                  _loc5_.TemplateID = _loc2_.itemID;
                  _loc5_.Count = _loc2_.count[0];
                  _loc5_.AttackCompose = _loc2_.AttackCompose;
                  _loc5_.DefendCompose = _loc2_.DefendCompose;
                  _loc5_.LuckCompose = _loc2_.LuckCompose;
                  _loc5_.AgilityCompose = _loc2_.AgilityCompose;
                  _loc5_.StrengthenLevel = _loc2_.StrengthenLevel;
                  _loc5_.MagicAttack = _loc2_.MagicAttack;
                  _loc5_.MagicDefence = _loc2_.MagicDefence;
                  _loc5_.IsBinds = _loc2_.isBind;
                  _loc5_.ValidDate = _loc2_.ValidateTime;
                  ItemManager.fill(_loc5_);
                  _loc3_ = new BagCell(0,_loc5_,false,ComponentFactory.Instance.creatBitmap("zodiac.mainview.awardcell.bg"),false);
                  _loc3_.setContentSize(53,53);
                  _loc3_.setCount(_loc5_.Count);
                  _loc3_.x = _loc7_.x + 78 * (_loc6_ % 3);
                  _loc3_.y = _loc7_.y + 62 * (int(_loc6_ / 3) % 3);
                  addChild(_loc3_);
                  _awards.push(_loc3_);
                  _loc6_++;
               }
            }
         }
         else
         {
            _indexType = 0;
         }
      }
      
      private function refreshQuestBtn(param1:int, param2:QuestInfo) : void
      {
         if(param2 == null)
         {
            return;
         }
         if((ZodiacModel.instance.awardRecord >> param1 & 1) == 1)
         {
            _gotofinishBtn.visible = false;
            _getAwardBtn.visible = true;
            _getAwardBtn.enable = false;
         }
         else if(param2.isAchieved)
         {
            _gotofinishBtn.visible = false;
            _getAwardBtn.visible = true;
            _getAwardBtn.enable = false;
         }
         else if(param2.isCompleted)
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
