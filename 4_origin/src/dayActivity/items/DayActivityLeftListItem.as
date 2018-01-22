package dayActivity.items
{
   import bagAndInfo.BagAndInfoManager;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import cryptBoss.CryptBossManager;
   import dayActivity.ActivityData;
   import dayActivity.DayActivityControl;
   import ddt.manager.BattleGroudManager;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.HelperUIModuleLoad;
   import ddtBuried.BuriedManager;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import giftSystem.GiftManager;
   import gypsyShop.ctrl.GypsyShopManager;
   import gypsyShop.model.GypsyNPCModel;
   import horse.HorseManager;
   import labyrinth.LabyrinthControl;
   import league.LeagueManager;
   import littleGame.LittleControl;
   import petsBag.PetsBagManager;
   import ringStation.RingStationManager;
   import trainer.controller.WeakGuildManager;
   import worldboss.WorldBossManager;
   
   public class DayActivityLeftListItem extends Component implements Disposeable
   {
       
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _line:Bitmap;
      
      private var _str:String;
      
      private var _overCount:int;
      
      private var _total:int;
      
      private var _money:int;
      
      private var _data:ActivityData;
      
      private var _lastCreatTime:int = 0;
      
      private var _backGround:Component;
      
      private var _startTime:int;
      
      private var _endTime:int;
      
      private var _activityType:int;
      
      private var alertFrame:BaseAlerFrame;
      
      public function DayActivityLeftListItem(param1:Boolean, param2:ActivityData)
      {
         super();
         _data = param2;
         initView(param1,param2);
      }
      
      private function initView(param1:Boolean, param2:ActivityData) : void
      {
         buttonMode = true;
         useHandCursor = true;
         if(param1)
         {
            _txt1 = ComponentFactory.Instance.creatComponentByStylename("day.activityView.left.Itemtxt1");
            _txt2 = ComponentFactory.Instance.creatComponentByStylename("day.activityView.left.Itemtxt1");
            _money = param2.MoneyPoint;
            buttonMode = true;
            useHandCursor = true;
         }
         else
         {
            _txt1 = ComponentFactory.Instance.creatComponentByStylename("day.activityView.left.Itemtxt2");
            _txt2 = ComponentFactory.Instance.creatComponentByStylename("day.activityView.left.Itemtxt2");
         }
         _activityType = param2.ActivityType;
         _txt1.x = 0;
         _txt1.y = 4;
         _txt1.text = param2.Description;
         addChild(_txt1);
         _txt2.x = 223;
         _txt2.y = 4;
         _txt2.text = param2.OverCount + "/" + param2.Count;
         addChild(_txt2);
         _total = param2.Count;
         _line = ComponentFactory.Instance.creatBitmap("day.line");
         addChild(_line);
         addEventListener("click",jumpHander);
         _backGround = new Component();
         _backGround.graphics.beginFill(0);
         _backGround.graphics.drawRect(0,0,200,20);
         _backGround.graphics.endFill();
         _backGround.alpha = 0;
         _backGround.tipStyle = "ddt.view.tips.OneLineTip";
         _backGround.tipDirctions = "5,1,2";
         if(param2.JumpType > 0)
         {
            _backGround.tipData = LanguageMgr.GetTranslation("ddt.battleGroud.itemTips",param2.ActivePoint,param2.Description);
         }
         else
         {
            _backGround.tipData = LanguageMgr.GetTranslation("ddt.battleGroud.btnTip",param2.ActivePoint);
         }
         addChild(_backGround);
      }
      
      protected function jumpHander(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         if(param1.target is SimpleBitmapButton)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _str = LanguageMgr.GetTranslation("ddt.Dayactivity.addSpeed",_money);
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_str,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2,null,"SimpleAlert",50,true,0);
            _loc3_.enterEnable = false;
            if(_loc3_.parent)
            {
               _loc3_.parent.removeChild(_loc3_);
            }
            LayerManager.Instance.addToLayer(_loc3_,2,true,2);
            _loc3_.addEventListener("response",onFrameResponse);
            return;
         }
         if(_data.JumpType > 0)
         {
            var _loc4_:* = _data.JumpType;
            if(1 !== _loc4_)
            {
               if(2 !== _loc4_)
               {
                  if(3 !== _loc4_)
                  {
                     if(4 !== _loc4_)
                     {
                        if(5 !== _loc4_)
                        {
                           if(6 !== _loc4_)
                           {
                              if(7 !== _loc4_)
                              {
                                 if(8 !== _loc4_)
                                 {
                                    if(9 !== _loc4_)
                                    {
                                       if(10 !== _loc4_)
                                       {
                                          if(11 !== _loc4_)
                                          {
                                             if(12 !== _loc4_)
                                             {
                                                if(13 !== _loc4_)
                                                {
                                                   if(14 !== _loc4_)
                                                   {
                                                      if(15 !== _loc4_)
                                                      {
                                                         if(16 !== _loc4_)
                                                         {
                                                            if(23 !== _loc4_)
                                                            {
                                                               if(50 !== _loc4_)
                                                               {
                                                                  if(51 !== _loc4_)
                                                                  {
                                                                     if(53 !== _loc4_)
                                                                     {
                                                                        if(54 !== _loc4_)
                                                                        {
                                                                           if(55 !== _loc4_)
                                                                           {
                                                                              if(56 !== _loc4_)
                                                                              {
                                                                                 if(57 !== _loc4_)
                                                                                 {
                                                                                    if(58 === _loc4_)
                                                                                    {
                                                                                       if(PlayerManager.Instance.Self.Grade < 19)
                                                                                       {
                                                                                          MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",19));
                                                                                          return;
                                                                                       }
                                                                                       FarmModelController.instance.goFarm(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName);
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    if(PlayerManager.Instance.Self.Grade < 19)
                                                                                    {
                                                                                       MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",19));
                                                                                       return;
                                                                                    }
                                                                                    PetsBagManager.instance().show();
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
                                                                        if(PlayerManager.Instance.Self.Grade < 27)
                                                                        {
                                                                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",27));
                                                                           return;
                                                                        }
                                                                        RingStationManager.instance.show();
                                                                     }
                                                                  }
                                                               }
                                                               if(!WeakGuildManager.Instance.checkOpen(76,25))
                                                               {
                                                                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",25));
                                                                  return;
                                                               }
                                                               FarmModelController.instance.goFarm(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName);
                                                            }
                                                            else if(GypsyNPCModel.getInstance().isStart())
                                                            {
                                                               GypsyShopManager.getInstance().showMainFrame();
                                                            }
                                                            else
                                                            {
                                                               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("gypsy.upOpen"));
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
                                                            if(!PlayerManager.Instance.Self.IsWeakGuildFinish(38))
                                                            {
                                                               SocketManager.Instance.out.syncWeakStep(38);
                                                               SocketManager.Instance.out.syncWeakStep(8);
                                                            }
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
                                                   else
                                                   {
                                                      if(PlayerManager.Instance.Self.Grade < 23)
                                                      {
                                                         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",23));
                                                         return;
                                                      }
                                                      if(LittleControl.Instance.hasActive())
                                                      {
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
                                                   if(PlayerManager.Instance.Self.Grade < 10)
                                                   {
                                                      MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",10));
                                                      return;
                                                   }
                                                   toDungeon();
                                                }
                                             }
                                             else
                                             {
                                                if(PlayerManager.Instance.Self.Grade < 19)
                                                {
                                                   MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",19));
                                                   return;
                                                }
                                                FarmModelController.instance.goFarm(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName);
                                             }
                                          }
                                          else
                                          {
                                             if(PlayerManager.Instance.Self.Grade < 17)
                                             {
                                                MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",17));
                                                return;
                                             }
                                             _loc2_ = ConsortionModelManager.Instance.bossCallCondition;
                                             if(PlayerManager.Instance.Self.consortiaInfo.Level < _loc2_)
                                             {
                                                MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortia.bossFrame.conditionTxt2",_loc2_));
                                                return;
                                             }
                                             StateManager.setState("consortia",ConsortionModelManager.Instance.openBossFrame);
                                          }
                                       }
                                       else
                                       {
                                          if(PlayerManager.Instance.Self.Grade < 23)
                                          {
                                             MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",23));
                                             return;
                                          }
                                          new HelperUIModuleLoad().loadUIModule(["ddtbagandinfo"],GiftManager.Instance.show);
                                          if(!PlayerManager.Instance.Self.IsWeakGuildFinish(38))
                                          {
                                             SocketManager.Instance.out.syncWeakStep(38);
                                             SocketManager.Instance.out.syncWeakStep(8);
                                          }
                                       }
                                    }
                                    else
                                    {
                                       if(PlayerManager.Instance.Self.Grade < 8)
                                       {
                                          MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",8));
                                          return;
                                       }
                                       CheckWeaponManager.instance.setFunction(this,jumpHander,[param1]);
                                       if(CheckWeaponManager.instance.isNoWeapon())
                                       {
                                          CheckWeaponManager.instance.showAlert();
                                          return;
                                       }
                                       if(getTimer() - _lastCreatTime > 1000)
                                       {
                                          _lastCreatTime = getTimer();
                                          GameInSocketOut.sendSingleRoomBegin(1);
                                       }
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
                                    ComponentSetting.SEND_USELOG_ID(1);
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
                                 ComponentSetting.SEND_USELOG_ID(5);
                                 if(PlayerManager.Instance.Self.IsWeakGuildFinish(15) && !PlayerManager.Instance.Self.IsWeakGuildFinish(65))
                                 {
                                    SocketManager.Instance.out.syncWeakStep(65);
                                 }
                              }
                           }
                           else
                           {
                              if(PlayerManager.Instance.Self.Grade < 19)
                              {
                                 MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",19));
                                 return;
                              }
                              FarmModelController.instance.goFarm(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName);
                           }
                        }
                        else
                        {
                           if(PlayerManager.Instance.Self.Grade < 22)
                           {
                              MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",22));
                              return;
                           }
                           BagAndInfoManager.Instance.showBagAndInfo(6 - 1);
                           if(!PlayerManager.Instance.Self.IsWeakGuildFinish(38))
                           {
                              SocketManager.Instance.out.syncWeakStep(38);
                              SocketManager.Instance.out.syncWeakStep(8);
                           }
                        }
                     }
                     else
                     {
                        if(!WorldBossManager.Instance.isOpen)
                        {
                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthBoxIconTips.labelII"));
                           return;
                        }
                        WorldBossManager.Instance.show();
                     }
                  }
                  else
                  {
                     if(PlayerManager.Instance.Self.Grade < 28)
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",28));
                        return;
                     }
                     if(!BattleGroudManager.Instance.isShow)
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthBoxIconTips.labelII"));
                        return;
                     }
                     GameInSocketOut.sendCreateRoom(LanguageMgr.GetTranslation("ddt.battleRoom.roomName"),120,3);
                  }
               }
               else
               {
                  if(PlayerManager.Instance.Self.Grade < 24)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",24));
                     return;
                  }
                  if(!LeagueManager.instance.isOpen)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthBoxIconTips.labelII"));
                     return;
                  }
                  StateManager.setState("roomlist");
                  ComponentSetting.SEND_USELOG_ID(3);
                  if(PlayerManager.Instance.Self.IsWeakGuildFinish(1) && !PlayerManager.Instance.Self.IsWeakGuildFinish(4))
                  {
                     SocketManager.Instance.out.syncWeakStep(4);
                  }
               }
            }
            else
            {
               if(PlayerManager.Instance.Self.Grade < 30)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",30));
                  return;
               }
               LabyrinthControl.Instance.show();
            }
            DayActivityControl.Instance.dispose();
         }
      }
      
      public function setTxt2(param1:int) : void
      {
         if(param1 >= _total)
         {
            param1 = _total;
         }
         _txt2.text = param1 + "/" + _total;
      }
      
      private function onFrameResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(_loc2_.isBand,_money,onCheckComplete);
         }
         _loc2_.removeEventListener("response",onFrameResponse);
         ObjectUtils.disposeObject(_loc2_);
         _loc2_ = null;
      }
      
      protected function onCheckComplete() : void
      {
         DayActivityControl.Instance.send(!!CheckMoneyUtils.instance.isBind?1:2,_activityType);
      }
      
      private function toDungeon() : void
      {
         if(!WeakGuildManager.Instance.checkOpen(16,8))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",8));
            return;
         }
         if(!PlayerManager.Instance.checkEnterDungeon)
         {
            return;
         }
         StateManager.setState("dungeon");
         ComponentSetting.SEND_USELOG_ID(4);
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(16) && !PlayerManager.Instance.Self.IsWeakGuildFinish(67))
         {
            SocketManager.Instance.out.syncWeakStep(67);
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener("click",jumpHander);
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
