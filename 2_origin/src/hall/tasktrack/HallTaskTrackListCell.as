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
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _info;
      }
      
      public function setCellValue(value:*) : void
      {
         _info = value as QuestInfo;
         updateViewData();
      }
      
      private function updateViewData() : void
      {
         var tmpCondition:* = null;
         var isHasOpitional:Boolean = false;
         var tmp2:* = null;
         var tmpHtmlText2:* = null;
         var i:int = 0;
         var cond:* = null;
         var tmp:* = null;
         var tmpText:* = null;
         var tmpHtmlText:* = null;
         var tinfo:* = null;
         _conditionTxtVBox.removeAllChild();
         var _loc15_:int = 0;
         var _loc14_:* = _conditionTxtList;
         for each(var txt in _conditionTxtList)
         {
            txt.removeEventListener("link",textClickHandler);
            ObjectUtils.disposeObject(txt);
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
            tmpCondition = _info.conditions;
            isHasOpitional = false;
            var _loc17_:int = 0;
            var _loc16_:* = tmpCondition;
            for each(var qc in tmpCondition)
            {
               if(qc.isOpitional)
               {
                  isHasOpitional = true;
                  break;
               }
            }
            if(!_info.isCompleted)
            {
               if(isHasOpitional)
               {
                  tmp2 = ComponentFactory.Instance.creatComponentByStylename("hall.taskTrack.cellConditionTxt");
                  tmp2.mouseEnabled = true;
                  tmp2.addEventListener("link",textClickHandler);
                  _conditionTxtList.push(tmp2);
                  tmpHtmlText2 = "<u><a href=\"event:-1\">" + LanguageMgr.GetTranslation("hall.taskTrack.tipTxt") + "</a></u>";
                  tmp2.htmlText = tmpHtmlText2;
                  _conditionTxtVBox.addChild(tmp2);
               }
               else
               {
                  i = 0;
                  while(_info.conditions[i])
                  {
                     cond = _info.conditions[i];
                     if(_info.progress[i] > 0)
                     {
                        tmp = ComponentFactory.Instance.creatComponentByStylename("hall.taskTrack.cellConditionTxt");
                        tmp.addEventListener("link",textClickHandler);
                        _conditionTxtList.push(tmp);
                        tmpText = cond.description + _info.conditionStatus[i];
                        if(isCanTrack(_info.MapID,_info.conditions[i].type,_info.conditions[i].param))
                        {
                           tmpHtmlText = "<u><a href=\"event:" + _info.conditions[i].type + "\">" + tmpText + "</a></u>";
                           tmp.htmlText = tmpHtmlText;
                           tmp.mouseEnabled = true;
                        }
                        else
                        {
                           tmp.htmlText = tmpText;
                           tmp.mouseEnabled = false;
                        }
                        _conditionTxtVBox.addChild(tmp);
                     }
                     i++;
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
               for each(var temp in _info.itemRewards)
               {
                  tinfo = new InventoryItemInfo();
                  tinfo.TemplateID = temp.itemID;
                  ItemManager.fill(tinfo);
                  if(!(0 != tinfo.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != tinfo.NeedSex))
                  {
                     if(temp.isOptional == 1)
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
      
      private function onFinishHandler(event:TextEvent) : void
      {
         var alert:* = null;
         SoundManager.instance.play("008");
         if(_info.RewardBindMoney != 0 && _info.RewardBindMoney + PlayerManager.Instance.Self.DDTMoney > ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel))
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),false,false,true,1);
            alert.addEventListener("response",__onResponse);
         }
         else
         {
            finishQuest(_info);
         }
      }
      
      private function finishQuest(pQuestInfo:QuestInfo) : void
      {
         var items:* = null;
         var info:* = null;
         if(pQuestInfo && !pQuestInfo.isCompleted)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.dropTaskIII"));
            setCellValue(pQuestInfo);
            return;
         }
         if(hasOptionalAward)
         {
            items = [];
            var _loc6_:int = 0;
            var _loc5_:* = pQuestInfo.itemRewards;
            for each(var temp in pQuestInfo.itemRewards)
            {
               info = new InventoryItemInfo();
               info.TemplateID = temp.itemID;
               ItemManager.fill(info);
               info.ValidDate = temp.ValidateTime;
               info.TemplateID = temp.itemID;
               info.IsJudge = true;
               info.IsBinds = temp.isBind;
               info.AttackCompose = temp.AttackCompose;
               info.DefendCompose = temp.DefendCompose;
               info.AgilityCompose = temp.AgilityCompose;
               info.LuckCompose = temp.LuckCompose;
               info.StrengthenLevel = temp.StrengthenLevel;
               info.Count = temp.count[pQuestInfo.QuestLevel - 1];
               if(!(0 != info.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != info.NeedSex))
               {
                  if(temp.isOptional == 1)
                  {
                     items.push(info);
                  }
               }
            }
            HallTaskTrackManager.instance.moduleLoad(showSelectedAwardFrame,[items]);
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
      
      private function showSelectedAwardFrame(items:Array) : void
      {
         TryonSystemController.Instance.show(items,chooseReward,null);
      }
      
      private function __onResponse(pEvent:FrameEvent) : void
      {
         pEvent.currentTarget.removeEventListener("response",__onResponse);
         if(pEvent.responseCode == 3)
         {
            finishQuest(_info);
         }
         ObjectUtils.disposeObject(pEvent.currentTarget);
      }
      
      private function getSexByInt(Sex:Boolean) : int
      {
         if(Sex)
         {
            return 1;
         }
         return 2;
      }
      
      private function chooseReward(item:ItemTemplateInfo) : void
      {
         SocketManager.Instance.out.sendQuestFinish(_info.QuestID,item.TemplateID);
      }
      
      private function textClickHandler(event:TextEvent) : void
      {
         if(_info.MapID > 0)
         {
            TaskManager.instance.jumpToQuestByID(_info.QuestID);
            return;
         }
         var idxMap:Dictionary = HallTaskTrackManager.instance.btnIndexMap;
         var tmp:int = event.text;
         switch(int(_info.ConditionTurn) - -1)
         {
            case 0:
               TaskManager.instance.jumpToQuestByID(_info.QuestID);
               break;
            default:
               TaskManager.instance.jumpToQuestByID(_info.QuestID);
               break;
            case 2:
               if(tmp == 9)
               {
                  NoviceDataManager.instance.saveNoviceData(670,PathManager.userName(),PathManager.solveRequestPath());
               }
               else if(tmp == 19)
               {
                  IsStore = true;
                  NoviceDataManager.instance.saveNoviceData(850,PathManager.userName(),PathManager.solveRequestPath());
               }
               (HallTaskTrackManager.instance.btnList[idxMap["store"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               break;
            case 3:
               (HallTaskTrackManager.instance.btnList[idxMap["constrion"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               break;
            case 4:
               break;
            case 5:
               (HallTaskTrackManager.instance.btnList[idxMap["dungeon"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               break;
            case 6:
               (HallTaskTrackManager.instance.btnList[idxMap["roomList"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
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
               (HallTaskTrackManager.instance.btnList[idxMap["home"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               break;
            case 12:
               (HallTaskTrackManager.instance.btnList[idxMap["cryptBoss"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               break;
            case 13:
               NoviceDataManager.instance.saveNoviceData(820,PathManager.userName(),PathManager.solveRequestPath());
               CollectionTaskManager.Instance.setUp();
               break;
            case 14:
               PetsBagManager.instance().show();
               break;
            case 15:
               (HallTaskTrackManager.instance.btnList[idxMap["labyrinth"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               break;
            case 16:
               BuriedManager.Instance.enter();
               break;
            case 17:
               (HallTaskTrackManager.instance.btnList[idxMap["ringStation"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
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
      
      private function isCanTrack(mapId:int, typeId:int, param:int) : Boolean
      {
         if(mapId > 0)
         {
            return true;
         }
         var _loc4_:* = typeId;
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
                                                                                                            addr62:
                                                                                                            return true;
                                                                                                         }
                                                                                                         addr61:
                                                                                                         §§goto(addr62);
                                                                                                      }
                                                                                                      addr60:
                                                                                                      §§goto(addr61);
                                                                                                   }
                                                                                                   addr59:
                                                                                                   §§goto(addr60);
                                                                                                }
                                                                                                addr58:
                                                                                                §§goto(addr59);
                                                                                             }
                                                                                             addr57:
                                                                                             §§goto(addr58);
                                                                                          }
                                                                                          addr56:
                                                                                          §§goto(addr57);
                                                                                       }
                                                                                       addr55:
                                                                                       §§goto(addr56);
                                                                                    }
                                                                                    addr54:
                                                                                    §§goto(addr55);
                                                                                 }
                                                                                 addr53:
                                                                                 §§goto(addr54);
                                                                              }
                                                                              addr52:
                                                                              §§goto(addr53);
                                                                           }
                                                                           addr51:
                                                                           §§goto(addr52);
                                                                        }
                                                                        addr50:
                                                                        §§goto(addr51);
                                                                     }
                                                                     addr49:
                                                                     §§goto(addr50);
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
                  addr23:
                  if(param == 14)
                  {
                     return false;
                  }
                  §§goto(addr33);
               }
               addr22:
               §§goto(addr23);
            }
            addr21:
            §§goto(addr22);
         }
         §§goto(addr21);
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
         for each(var txt in _conditionTxtList)
         {
            txt.removeEventListener("link",textClickHandler);
            ObjectUtils.disposeObject(txt);
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
