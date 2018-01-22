package hall.tasktrack
{
   import bagAndInfo.BagAndInfoManager;
   import collectionTask.CollectionTaskManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.quest.QuestCondition;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddtBuried.BuriedManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.Dictionary;
   import petsBag.PetsBagManager;
   import quest.TaskManager;
   import tryonSystem.TryonSystemController;
   
   public class HallTaskTrackListCell extends Sprite implements Disposeable, IListCell
   {
      
      public static var IsStore:Boolean = false;
       
      
      private var _titleTxt:FilterFrameText;
      
      private var _conditionTxtList:Vector.<FilterFrameText>;
      
      private var _conditionTxtVBox:VBox;
      
      private var _info:QuestInfo;
      
      private var _typeMc:MovieClip;
      
      private var hasOptionalAward:Boolean;
      
      private var _extendUnMc:MovieClip;
      
      public function HallTaskTrackListCell()
      {
         super();
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("hall.taskTrack.cellTitleTxt");
         _titleTxt.addEventListener("link",onFinishHandler,false,0,true);
         _conditionTxtVBox = ComponentFactory.Instance.creatComponentByStylename("hall.taskTrack.cellVBox");
         _typeMc = ComponentFactory.Instance.creat("asset.hall.taskTrack.typeMc");
         _typeMc.mouseEnabled = false;
         _typeMc.mouseChildren = false;
         _typeMc.x = 0;
         _typeMc.y = 0;
         _extendUnMc = ComponentFactory.Instance.creat("asset.hall.taskTrack.extendUnMC");
         _extendUnMc.mouseEnabled = false;
         _extendUnMc.mouseChildren = false;
         _extendUnMc.x = 3;
         _extendUnMc.y = 2;
         addChild(_titleTxt);
         addChild(_typeMc);
         addChild(_conditionTxtVBox);
         addChild(_extendUnMc);
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _info;
      }
      
      public function setCellValue(param1:*) : void
      {
         _info = param1 as QuestInfo;
         updateViewData();
      }
      
      private function updateViewData() : void
      {
         var _loc2_:* = null;
         var _loc3_:Boolean = false;
         var _loc9_:* = null;
         var _loc13_:* = null;
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc11_:* = null;
         var _loc1_:* = null;
         var _loc10_:* = null;
         var _loc8_:* = null;
         _conditionTxtVBox.removeAllChild();
         var _loc15_:int = 0;
         var _loc14_:* = _conditionTxtList;
         for each(var _loc5_ in _conditionTxtList)
         {
            _loc5_.removeEventListener("link",textClickHandler);
            ObjectUtils.disposeObject(_loc5_);
         }
         _conditionTxtList = new Vector.<FilterFrameText>();
         _titleTxt.visible = false;
         _typeMc.visible = false;
         _extendUnMc.visible = false;
         if(_info.QuestID < 0)
         {
            this.mouseChildren = false;
            this.buttonMode = true;
            _typeMc.visible = true;
            _extendUnMc.visible = true;
            _typeMc.gotoAndStop(Math.abs(_info.QuestID));
            _extendUnMc.gotoAndStop(_info.Type);
         }
         else
         {
            this.mouseChildren = true;
            this.buttonMode = false;
            _titleTxt.visible = true;
            _titleTxt.htmlText = "";
            _titleTxt.mouseEnabled = false;
            _titleTxt.text = ">>" + _info.Title;
            _loc2_ = _info.conditions;
            _loc3_ = false;
            var _loc17_:int = 0;
            var _loc16_:* = _loc2_;
            for each(var _loc6_ in _loc2_)
            {
               if(_loc6_.isOpitional)
               {
                  _loc3_ = true;
                  break;
               }
            }
            if(!_info.isCompleted)
            {
               if(_loc3_)
               {
                  _loc9_ = ComponentFactory.Instance.creatComponentByStylename("hall.taskTrack.cellConditionTxt");
                  _loc9_.mouseEnabled = true;
                  _loc9_.addEventListener("link",textClickHandler);
                  _conditionTxtList.push(_loc9_);
                  _loc13_ = "<u><a href=\"event:-1\">" + LanguageMgr.GetTranslation("hall.taskTrack.tipTxt") + "</a></u>";
                  _loc9_.htmlText = _loc13_;
                  _conditionTxtVBox.addChild(_loc9_);
               }
               else
               {
                  _loc7_ = 0;
                  while(_info.conditions[_loc7_])
                  {
                     _loc4_ = _info.conditions[_loc7_];
                     if(_info.progress[_loc7_] > 0)
                     {
                        _loc11_ = ComponentFactory.Instance.creatComponentByStylename("hall.taskTrack.cellConditionTxt");
                        _loc11_.addEventListener("link",textClickHandler);
                        _conditionTxtList.push(_loc11_);
                        _loc1_ = _loc4_.description + _info.conditionStatus[_loc7_];
                        if(isCanTrack(_info.MapID,_info.conditions[_loc7_].type,_info.conditions[_loc7_].param))
                        {
                           _loc10_ = "<u><a href=\"event:" + _info.conditions[_loc7_].type + "\">" + _loc1_ + "</a></u>";
                           _loc11_.htmlText = _loc10_;
                           _loc11_.mouseEnabled = true;
                        }
                        else
                        {
                           _loc11_.htmlText = _loc1_;
                           _loc11_.mouseEnabled = false;
                        }
                        _conditionTxtVBox.addChild(_loc11_);
                     }
                     _loc7_++;
                  }
               }
            }
            hasOptionalAward = false;
            if(_conditionTxtVBox.numChildren <= 0)
            {
               _titleTxt.text = ">>" + _info.Title + LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.over");
               _titleTxt.htmlText = "<a href=\"event:1\">" + _titleTxt.text + "</a>";
               _titleTxt.mouseEnabled = true;
               _titleTxt.textColor = 3652688;
               var _loc19_:int = 0;
               var _loc18_:* = _info.itemRewards;
               for each(var _loc12_ in _info.itemRewards)
               {
                  _loc8_ = new InventoryItemInfo();
                  _loc8_.TemplateID = _loc12_.itemID;
                  ItemManager.fill(_loc8_);
                  if(!(0 != _loc8_.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != _loc8_.NeedSex))
                  {
                     if(_loc12_.isOptional == 1)
                     {
                        hasOptionalAward = true;
                     }
                  }
               }
            }
         }
         if(_info.QuestID < 0 && _info.Type == 2)
         {
            _info.cellHeight = this.height + 3;
         }
         else
         {
            _info.cellHeight = this.height + 7;
         }
      }
      
      private function onFinishHandler(param1:TextEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(_info.RewardBindMoney != 0 && _info.RewardBindMoney + PlayerManager.Instance.Self.DDTMoney > ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel))
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),false,false,true,1);
            _loc2_.addEventListener("response",__onResponse);
         }
         else
         {
            finishQuest(_info);
         }
      }
      
      private function finishQuest(param1:QuestInfo) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         if(param1 && !param1.isCompleted)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.dropTaskIII"));
            setCellValue(param1);
            return;
         }
         if(hasOptionalAward)
         {
            _loc2_ = [];
            var _loc6_:int = 0;
            var _loc5_:* = param1.itemRewards;
            for each(var _loc3_ in param1.itemRewards)
            {
               _loc4_ = new InventoryItemInfo();
               _loc4_.TemplateID = _loc3_.itemID;
               ItemManager.fill(_loc4_);
               _loc4_.ValidDate = _loc3_.ValidateTime;
               _loc4_.TemplateID = _loc3_.itemID;
               _loc4_.IsJudge = true;
               _loc4_.IsBinds = _loc3_.isBind;
               _loc4_.AttackCompose = _loc3_.AttackCompose;
               _loc4_.DefendCompose = _loc3_.DefendCompose;
               _loc4_.AgilityCompose = _loc3_.AgilityCompose;
               _loc4_.LuckCompose = _loc3_.LuckCompose;
               _loc4_.StrengthenLevel = _loc3_.StrengthenLevel;
               _loc4_.Count = _loc3_.count[param1.QuestLevel - 1];
               if(!(0 != _loc4_.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != _loc4_.NeedSex))
               {
                  if(_loc3_.isOptional == 1)
                  {
                     _loc2_.push(_loc4_);
                  }
               }
            }
            HallTaskTrackManager.instance.moduleLoad(showSelectedAwardFrame,[_loc2_]);
         }
         else
         {
            TaskManager.instance.sendQuestFinish(_info.QuestID);
            if(TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(318)) && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(319)))
            {
               SocketManager.Instance.out.syncWeakStep(49);
            }
         }
      }
      
      private function showSelectedAwardFrame(param1:Array) : void
      {
         TryonSystemController.Instance.show(param1,chooseReward,null);
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__onResponse);
         if(param1.responseCode == 3)
         {
            finishQuest(_info);
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function getSexByInt(param1:Boolean) : int
      {
         if(param1)
         {
            return 1;
         }
         return 2;
      }
      
      private function chooseReward(param1:ItemTemplateInfo) : void
      {
         SocketManager.Instance.out.sendQuestFinish(_info.QuestID,param1.TemplateID);
      }
      
      private function textClickHandler(param1:TextEvent) : void
      {
         if(_info.MapID > 0)
         {
            TaskManager.instance.jumpToQuestByID(_info.QuestID);
            return;
         }
         var _loc3_:Dictionary = HallTaskTrackManager.instance.btnIndexMap;
         var _loc2_:int = param1.text;
         switch(int(_info.ConditionTurn) - -1)
         {
            case 0:
               TaskManager.instance.jumpToQuestByID(_info.QuestID);
               break;
            default:
               TaskManager.instance.jumpToQuestByID(_info.QuestID);
               break;
            case 2:
               if(_loc2_ == 9)
               {
                  NoviceDataManager.instance.saveNoviceData(670,PathManager.userName(),PathManager.solveRequestPath());
               }
               else if(_loc2_ == 19)
               {
                  IsStore = true;
                  NoviceDataManager.instance.saveNoviceData(850,PathManager.userName(),PathManager.solveRequestPath());
               }
               (HallTaskTrackManager.instance.btnList[_loc3_["store"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               break;
            case 3:
               (HallTaskTrackManager.instance.btnList[_loc3_["constrion"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               break;
            case 4:
               break;
            case 5:
               (HallTaskTrackManager.instance.btnList[_loc3_["dungeon"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               break;
            case 6:
               (HallTaskTrackManager.instance.btnList[_loc3_["roomList"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               break;
            case 7:
               BagAndInfoManager.Instance.showBagAndInfo();
               break;
            case 8:
               break;
            case 9:
               StateManager.setState("shop");
               break;
            case 10:
               break;
            case 11:
               (HallTaskTrackManager.instance.btnList[_loc3_["home"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               break;
            case 12:
               (HallTaskTrackManager.instance.btnList[_loc3_["cryptBoss"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               break;
            case 13:
               NoviceDataManager.instance.saveNoviceData(820,PathManager.userName(),PathManager.solveRequestPath());
               CollectionTaskManager.Instance.setUp();
               break;
            case 14:
               PetsBagManager.instance().show();
               break;
            case 15:
               (HallTaskTrackManager.instance.btnList[_loc3_["labyrinth"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               break;
            case 16:
               BuriedManager.Instance.enter();
               break;
            case 17:
               (HallTaskTrackManager.instance.btnList[_loc3_["ringStation"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function refreshType() : void
      {
         switch(int(_info.Type))
         {
            case 0:
               _typeMc.gotoAndStop(1);
               break;
            case 1:
               _typeMc.gotoAndStop(2);
               break;
            case 2:
               _typeMc.gotoAndStop(3);
               break;
            case 3:
               _typeMc.gotoAndStop(4);
               break;
            default:
               _typeMc.gotoAndStop(4);
               break;
            default:
            case 6:
               _typeMc.gotoAndStop(4);
               break;
            default:
               _typeMc.gotoAndStop(4);
               break;
            default:
               _typeMc.gotoAndStop(4);
               break;
            default:
               _typeMc.gotoAndStop(4);
               break;
            case 10:
               _typeMc.gotoAndStop(5);
               break;
            default:
               _typeMc.gotoAndStop(5);
               break;
            default:
               _typeMc.gotoAndStop(5);
               break;
            default:
               _typeMc.gotoAndStop(5);
               break;
            default:
               _typeMc.gotoAndStop(5);
               break;
            default:
               _typeMc.gotoAndStop(5);
               break;
            default:
               _typeMc.gotoAndStop(5);
               break;
            case 17:
               _typeMc.gotoAndStop(8);
         }
      }
      
      private function isCanTrack(param1:int, param2:int, param3:int) : Boolean
      {
         if(param1 > 0)
         {
            return true;
         }
         var _loc4_:* = param2;
         if(4 !== _loc4_)
         {
            if(5 !== _loc4_)
            {
               if(6 !== _loc4_)
               {
                  if(22 !== _loc4_)
                  {
                     if(23 !== _loc4_)
                     {
                        if(24 !== _loc4_)
                        {
                           if(26 !== _loc4_)
                           {
                              if(31 !== _loc4_)
                              {
                                 if(34 !== _loc4_)
                                 {
                                    if(36 !== _loc4_)
                                    {
                                       if(37 !== _loc4_)
                                       {
                                          if(9 !== _loc4_)
                                          {
                                             if(10 !== _loc4_)
                                             {
                                                if(11 !== _loc4_)
                                                {
                                                   if(13 !== _loc4_)
                                                   {
                                                      if(19 !== _loc4_)
                                                      {
                                                         if(21 !== _loc4_)
                                                         {
                                                            if(39 !== _loc4_)
                                                            {
                                                               if(50 !== _loc4_)
                                                               {
                                                                  if(60 !== _loc4_)
                                                                  {
                                                                     if(51 !== _loc4_)
                                                                     {
                                                                        if(56 !== _loc4_)
                                                                        {
                                                                           if(57 !== _loc4_)
                                                                           {
                                                                              if(58 !== _loc4_)
                                                                              {
                                                                                 if(59 !== _loc4_)
                                                                                 {
                                                                                    if(61 !== _loc4_)
                                                                                    {
                                                                                       if(64 !== _loc4_)
                                                                                       {
                                                                                          if(65 !== _loc4_)
                                                                                          {
                                                                                             if(76 !== _loc4_)
                                                                                             {
                                                                                                if(3 !== _loc4_)
                                                                                                {
                                                                                                   if(86 !== _loc4_)
                                                                                                   {
                                                                                                      if(87 !== _loc4_)
                                                                                                      {
                                                                                                         if(82 !== _loc4_)
                                                                                                         {
                                                                                                            if(85 !== _loc4_)
                                                                                                            {
                                                                                                               if(83 !== _loc4_)
                                                                                                               {
                                                                                                                  return false;
                                                                                                               }
                                                                                                            }
                                                                                                            addr49:
                                                                                                            return true;
                                                                                                         }
                                                                                                         addr48:
                                                                                                         §§goto(addr49);
                                                                                                      }
                                                                                                      addr47:
                                                                                                      §§goto(addr48);
                                                                                                   }
                                                                                                   addr46:
                                                                                                   §§goto(addr47);
                                                                                                }
                                                                                                addr45:
                                                                                                §§goto(addr46);
                                                                                             }
                                                                                             addr44:
                                                                                             §§goto(addr45);
                                                                                          }
                                                                                          addr43:
                                                                                          §§goto(addr44);
                                                                                       }
                                                                                       addr42:
                                                                                       §§goto(addr43);
                                                                                    }
                                                                                    addr41:
                                                                                    §§goto(addr42);
                                                                                 }
                                                                                 addr40:
                                                                                 §§goto(addr41);
                                                                              }
                                                                              addr39:
                                                                              §§goto(addr40);
                                                                           }
                                                                           addr38:
                                                                           §§goto(addr39);
                                                                        }
                                                                        addr37:
                                                                        §§goto(addr38);
                                                                     }
                                                                     addr36:
                                                                     §§goto(addr37);
                                                                  }
                                                                  addr35:
                                                                  §§goto(addr36);
                                                               }
                                                               addr34:
                                                               §§goto(addr35);
                                                            }
                                                            addr33:
                                                            §§goto(addr34);
                                                         }
                                                         addr32:
                                                         §§goto(addr33);
                                                      }
                                                      addr31:
                                                      §§goto(addr32);
                                                   }
                                                   addr30:
                                                   §§goto(addr31);
                                                }
                                                addr29:
                                                §§goto(addr30);
                                             }
                                             addr28:
                                             §§goto(addr29);
                                          }
                                          addr27:
                                          §§goto(addr28);
                                       }
                                       addr26:
                                       §§goto(addr27);
                                    }
                                    addr25:
                                    §§goto(addr26);
                                 }
                                 addr24:
                                 §§goto(addr25);
                              }
                              addr23:
                              §§goto(addr24);
                           }
                           addr22:
                           §§goto(addr23);
                        }
                        addr21:
                        §§goto(addr22);
                     }
                     addr20:
                     §§goto(addr21);
                  }
                  addr14:
                  if(param3 == 14)
                  {
                     return false;
                  }
                  §§goto(addr20);
               }
               addr13:
               §§goto(addr14);
            }
            addr12:
            §§goto(addr13);
         }
         §§goto(addr12);
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         _titleTxt.removeEventListener("link",onFinishHandler);
         var _loc3_:int = 0;
         var _loc2_:* = _conditionTxtList;
         for each(var _loc1_ in _conditionTxtList)
         {
            _loc1_.removeEventListener("link",textClickHandler);
            ObjectUtils.disposeObject(_loc1_);
         }
         ObjectUtils.disposeAllChildren(this);
         _titleTxt = null;
         _conditionTxtList = null;
         _conditionTxtVBox = null;
         _info = null;
         _typeMc = null;
         _extendUnMc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get typeMc() : MovieClip
      {
         return _typeMc;
      }
   }
}
