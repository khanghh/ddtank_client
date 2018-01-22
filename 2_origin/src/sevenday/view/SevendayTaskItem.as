package sevenday.view
{
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.BattleGroudManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddtBuried.BuriedManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import horse.HorseManager;
   import littleGame.LittleControl;
   import petsBag.PetsBagManager;
   import ringStation.RingStationManager;
   import sevenday.SevendayManager;
   import wantstrong.WantStrongManager;
   
   public class SevendayTaskItem extends Sprite implements Disposeable
   {
       
      
      private var _taskText:FilterFrameText;
      
      private var _gotoBtn:FilterFrameText;
      
      private var _icon:ScaleFrameImage;
      
      private var _taskSprite:Sprite;
      
      private var _num:int;
      
      private var _iteminfo:ItemTemplateInfo;
      
      private var _lastCreatTime:int;
      
      private var _info:QuestInfo;
      
      public function SevendayTaskItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatComponentByStylename("sevendayTaskCell.icon");
         PositionUtils.setPos(_icon,"ddt.sevendayTaskCell.iconPos");
         _icon.setFrame(1);
         addChild(_icon);
         _gotoBtn = ComponentFactory.Instance.creatComponentByStylename("sevendayTaskCell.goto");
         _gotoBtn.text = LanguageMgr.GetTranslation("tank.sevenday.woyaotisheng");
         _taskSprite = new Sprite();
         _taskSprite.addChild(_gotoBtn);
         _taskSprite.mouseEnabled = true;
         _taskSprite.buttonMode = true;
         addChild(_taskSprite);
         _taskSprite.addEventListener("click",gotowhere);
         _taskText = ComponentFactory.Instance.creatComponentByStylename("sevendayTaskCell.task");
         addChild(_taskText);
      }
      
      private function complete(param1:int) : void
      {
         _gotoBtn.setFrame(2);
         _icon.setFrame(2);
      }
      
      private function uncomplete(param1:int) : void
      {
         _gotoBtn.setFrame(1);
         _icon.setFrame(1);
      }
      
      private function gotowhere(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.playButtonSound();
         var _loc3_:* = _info.conditions[_num].turnType;
         if(-1 !== _loc3_)
         {
            if(1 !== _loc3_)
            {
               if(2 !== _loc3_)
               {
                  if(4 !== _loc3_)
                  {
                     if(5 !== _loc3_)
                     {
                        if(7 !== _loc3_)
                        {
                           if(13 !== _loc3_)
                           {
                              if(15 !== _loc3_)
                              {
                                 if(16 !== _loc3_)
                                 {
                                    if(18 !== _loc3_)
                                    {
                                       if(21 !== _loc3_)
                                       {
                                          if(22 !== _loc3_)
                                          {
                                             if(23 !== _loc3_)
                                             {
                                                if(20 !== _loc3_)
                                                {
                                                   if(25 !== _loc3_)
                                                   {
                                                      if(26 !== _loc3_)
                                                      {
                                                         if(27 !== _loc3_)
                                                         {
                                                            if(24 !== _loc3_)
                                                            {
                                                               if(28 === _loc3_)
                                                               {
                                                                  if(PlayerManager.Instance.Self.Grade < 11)
                                                                  {
                                                                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",11));
                                                                     return;
                                                                  }
                                                                  SevendayManager.instance.hideFrame();
                                                                  StateManager.setState("civil",false);
                                                               }
                                                            }
                                                            else
                                                            {
                                                               LeavePageManager.leaveToFillPath();
                                                            }
                                                         }
                                                         else
                                                         {
                                                            if(PlayerManager.Instance.Self.Grade < 7)
                                                            {
                                                               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",7));
                                                               return;
                                                            }
                                                            WantStrongManager.Instance.showFrame(2,false);
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
                                                   if(PlayerManager.Instance.Self.Grade < 12)
                                                   {
                                                      MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",12));
                                                      return;
                                                   }
                                                   HorseManager.instance.show();
                                                }
                                             }
                                             else
                                             {
                                                if(PlayerManager.Instance.Self.Grade < 24)
                                                {
                                                   MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",24));
                                                   return;
                                                }
                                                SevendayManager.instance.hideFrame();
                                                StateManager.setState("roomlist");
                                             }
                                          }
                                          else
                                          {
                                             if(PlayerManager.Instance.Self.Grade < 23)
                                             {
                                                MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",23));
                                                return;
                                             }
                                             if(LittleControl.Instance.hasActive())
                                             {
                                                SevendayManager.instance.hideFrame();
                                                StateManager.setState("littleHall");
                                             }
                                             else
                                             {
                                                MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthBoxIconTips.labelII"));
                                             }
                                          }
                                       }
                                       else
                                       {
                                          if(PlayerManager.Instance.Self.Grade < 7)
                                          {
                                             MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",7));
                                             return;
                                          }
                                          WantStrongManager.Instance.showFrame(1,false);
                                       }
                                    }
                                    else
                                    {
                                       _loc2_ = ServerConfigManager.instance.trialBattleLevelLimit;
                                       if(PlayerManager.Instance.Self.Grade < _loc2_)
                                       {
                                          MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",_loc2_));
                                          return;
                                       }
                                       BattleGroudManager.Instance.onShow();
                                    }
                                 }
                                 else
                                 {
                                    if(PlayerManager.Instance.Self.Grade < 27)
                                    {
                                       MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",27));
                                       return;
                                    }
                                    RingStationManager.instance.show();
                                 }
                              }
                              else
                              {
                                 if(PlayerManager.Instance.Self.Grade < 25)
                                 {
                                    MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",25));
                                    return;
                                 }
                                 BuriedManager.Instance.enter();
                              }
                           }
                           else if(!PetsBagManager.instance().isShow)
                           {
                              PetsBagManager.instance().isShow = true;
                              PetsBagManager.instance().isSelf = true;
                              PetsBagManager.instance().show();
                           }
                        }
                        else
                        {
                           if(PlayerManager.Instance.Self.Grade < 8)
                           {
                              MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",8));
                              return;
                           }
                           SevendayManager.instance.hideFrame();
                           if(PlayerManager.Instance.Self.apprenticeshipState == 0)
                           {
                              StateManager.setState("academyRegistration");
                           }
                           else
                           {
                              StateManager.setState("academyRegistration");
                           }
                        }
                     }
                     else
                     {
                        if(PlayerManager.Instance.Self.Grade < 3)
                        {
                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",3));
                           return;
                        }
                        SevendayManager.instance.hideFrame();
                        StateManager.setState("roomlist");
                     }
                  }
                  else
                  {
                     if(PlayerManager.Instance.Self.Grade < 10)
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",10));
                        return;
                     }
                     if(!PlayerManager.Instance.checkEnterDungeon)
                     {
                        return;
                     }
                     SevendayManager.instance.hideFrame();
                     StateManager.setState("dungeon");
                  }
               }
               else
               {
                  if(PlayerManager.Instance.Self.Grade < 17)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",17));
                     return;
                  }
                  SevendayManager.instance.hideFrame();
                  StateManager.setState("consortia");
               }
            }
            else
            {
               if(PlayerManager.Instance.Self.Grade < 5)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",5));
                  return;
               }
               BagStore.instance.openStore();
               BagStore.instance.isFromBagFrame = true;
            }
         }
         SevendayManager.instance.hideFrame();
      }
      
      public function update(param1:QuestInfo, param2:int) : void
      {
         _info = param1;
         _num = param2;
         _taskText.text = param1.conditions[param2].description;
         if(param1.conditionStatusBoolean[param2] || !_info.data)
         {
            complete(param2);
         }
         else
         {
            uncomplete(param2);
         }
      }
      
      public function dispose() : void
      {
         _taskSprite.removeEventListener("click",gotowhere);
         ObjectUtils.disposeObject(_taskText);
         _taskText = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_gotoBtn);
         _gotoBtn = null;
         ObjectUtils.disposeObject(_taskSprite);
         _taskSprite = null;
      }
   }
}
