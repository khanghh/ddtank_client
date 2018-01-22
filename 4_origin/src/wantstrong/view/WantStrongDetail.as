package wantstrong.view
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import calendar.CalendarManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.CheckMoneyUtils;
   import ddtBuried.BuriedManager;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import horse.HorseManager;
   import labyrinth.LabyrinthControl;
   import quest.TaskManager;
   import road7th.data.DictionaryData;
   import roomList.pveRoomList.DungeonListController;
   import roomList.pvpRoomList.RoomListController;
   import wantstrong.WantStrongControl;
   import wantstrong.data.WantStrongMenuData;
   
   public class WantStrongDetail extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _item:WantStrongMenuData;
      
      private var _titleFrameText:FilterFrameText;
      
      private var _contentFrameText:FilterFrameText;
      
      private var _freeBackContentFrameText:FilterFrameText;
      
      private var _freeNumFrameText:FilterFrameText;
      
      private var _freeHonorFrameText:FilterFrameText;
      
      private var _allBackContentFrameText:FilterFrameText;
      
      private var _allNumFrameText:FilterFrameText;
      
      private var _allHonorFrameText:FilterFrameText;
      
      private var _goBtn:SimpleBitmapButton;
      
      private var _freeBackBtn:SimpleBitmapButton;
      
      private var _allBackBtn:SimpleBitmapButton;
      
      private var _icon:Bitmap;
      
      private var _bagInfoItems:DictionaryData;
      
      private var _cell:BagCell;
      
      public function WantStrongDetail(param1:WantStrongMenuData)
      {
         super();
         _item = param1;
         initView();
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _bg = ComponentFactory.Instance.creat("wantstrong.right.cellbg");
         addChild(_bg);
         _titleFrameText = ComponentFactory.Instance.creatComponentByStylename("wantstrong.view.mainFrame.rightTitle.Text");
         _titleFrameText.text = _item.title;
         addChild(_titleFrameText);
         _loc4_ = 0;
         while(_loc4_ < _item.starNum)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("wantstrong.right.xing");
            _loc3_.x = 135 + 21 * _loc4_;
            _loc3_.y = 6;
            addChild(_loc3_);
            _loc4_++;
         }
         _loc1_ = _item.starNum;
         while(_loc1_ < 5)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("wantstrong.right.grayxing");
            _loc2_.x = 135 + 21 * _loc1_;
            _loc2_.y = 6;
            addChild(_loc2_);
            _loc1_++;
         }
         if(_item.type != 5)
         {
            _contentFrameText = ComponentFactory.Instance.creatComponentByStylename("wantstrong.view.mainFrame.rightContent.Text");
            _contentFrameText.text = _item.description;
            addChild(_contentFrameText);
            _goBtn = ComponentFactory.Instance.creatComponentByStylename("wantstrong.goon");
            _goBtn.addEventListener("click",goBtnHandler);
            addChild(_goBtn);
         }
         else
         {
            _freeBackContentFrameText = ComponentFactory.Instance.creatComponentByStylename("wantstrong.view.mainFrame.freeBackRightContent.Text");
            _freeBackContentFrameText.text = LanguageMgr.GetTranslation("ddt.wantStrong.view.freeFindBack");
            addChild(_freeBackContentFrameText);
            _freeNumFrameText = ComponentFactory.Instance.creatComponentByStylename("wantstrong.view.mainFrame.freeBackRightContentNum.Text");
            _freeNumFrameText.text = "" + _item.awardNum * 0.1;
            addChild(_freeNumFrameText);
            _freeHonorFrameText = ComponentFactory.Instance.creatComponentByStylename("wantstrong.view.mainFrame.freeBackRightContentHonor.Text");
            if(_freeNumFrameText.length > 3)
            {
               _freeHonorFrameText.x = _freeHonorFrameText.x + 8;
            }
            if(_item.awardType == 1)
            {
               _freeHonorFrameText.text = LanguageMgr.GetTranslation("ddt.wantStrong.view.honor");
            }
            else if(_item.awardType == 2)
            {
               _freeHonorFrameText.text = LanguageMgr.GetTranslation("ddt.wantStrong.view.prestige");
            }
            else
            {
               _freeHonorFrameText.text = LanguageMgr.GetTranslation("ddt.wantStrong.view.token");
            }
            addChild(_freeHonorFrameText);
            _allBackContentFrameText = ComponentFactory.Instance.creatComponentByStylename("wantstrong.view.mainFrame.allBackRightContent.Text");
            _allBackContentFrameText.text = LanguageMgr.GetTranslation("ddt.wantStrong.view.allFindBack");
            addChild(_allBackContentFrameText);
            _allNumFrameText = ComponentFactory.Instance.creatComponentByStylename("wantstrong.view.mainFrame.allBackRightContentNum.Text");
            _allNumFrameText.text = "" + _item.awardNum;
            addChild(_allNumFrameText);
            _allHonorFrameText = ComponentFactory.Instance.creatComponentByStylename("wantstrong.view.mainFrame.allBackRightContentHonor.Text");
            if(_allNumFrameText.length > 4)
            {
               _allHonorFrameText.x = _allHonorFrameText.x + 8;
            }
            if(_item.awardType == 1)
            {
               _allHonorFrameText.text = LanguageMgr.GetTranslation("ddt.wantStrong.view.honor");
            }
            else if(_item.awardType == 2)
            {
               _allHonorFrameText.text = LanguageMgr.GetTranslation("ddt.wantStrong.view.prestige");
            }
            else
            {
               _allHonorFrameText.text = LanguageMgr.GetTranslation("ddt.wantStrong.view.token");
            }
            addChild(_allHonorFrameText);
            _freeBackBtn = ComponentFactory.Instance.creatComponentByStylename("wantstrong.freeback");
            _freeBackBtn.addEventListener("click",freeBackBtnHandler);
            _allBackBtn = ComponentFactory.Instance.creatComponentByStylename("wantstrong.allback");
            _allBackBtn.addEventListener("click",allBackBtnHandler);
            _freeBackBtn.enable = _item.freeBackBtnEnable;
            _allBackBtn.enable = _item.allBackBtnEnable;
            addChild(_freeBackBtn);
            addChild(_allBackBtn);
         }
         _icon = ComponentFactory.Instance.creatBitmap(_item.iconUrl);
         _icon.x = 18;
         _icon.y = 40;
         addChild(_icon);
      }
      
      private function freeBackBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.wantStrong.view.freeFindBackAlert"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
         _loc2_.addEventListener("response",__alertFreeBack);
      }
      
      private function __alertFreeBack(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               SocketManager.Instance.out.sendWantStrongBack(_item.bossType,false);
         }
         param1.currentTarget.removeEventListener("response",__alertFreeBack);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function allBackBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.wantStrong.view.allFindBackAlert",_item.moneyNum),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false,0);
         _loc2_.addEventListener("response",__alertAllBack);
      }
      
      private function __alertAllBack(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",__alertAllBack);
         SoundManager.instance.playButtonSound();
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  param1.currentTarget.removeEventListener("response",__alertAllBack);
                  ObjectUtils.disposeObject(param1.currentTarget);
                  return;
               }
               CheckMoneyUtils.instance.checkMoney(_loc3_.isBand,_item.moneyNum,onCheckComplete);
               break;
         }
         _loc3_.dispose();
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.sendWantStrongBack(_item.bossType,true,CheckMoneyUtils.instance.isBind);
      }
      
      private function goBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:WantStrongDetail = param1.target.parent as WantStrongDetail;
         _bagInfoItems = PlayerManager.Instance.Self.PropBag.items;
         var _loc3_:* = _loc2_._item.id;
         if(101 !== _loc3_)
         {
            if(102 !== _loc3_)
            {
               if(103 !== _loc3_)
               {
                  if(104 !== _loc3_)
                  {
                     if(105 !== _loc3_)
                     {
                        if(106 !== _loc3_)
                        {
                           if(107 !== _loc3_)
                           {
                              if(108 !== _loc3_)
                              {
                                 if(109 !== _loc3_)
                                 {
                                    if(110 !== _loc3_)
                                    {
                                       if(111 !== _loc3_)
                                       {
                                          if(112 !== _loc3_)
                                          {
                                             if(113 !== _loc3_)
                                             {
                                                if(114 !== _loc3_)
                                                {
                                                   if(115 !== _loc3_)
                                                   {
                                                      if(116 !== _loc3_)
                                                      {
                                                         if(201 !== _loc3_)
                                                         {
                                                            if(202 !== _loc3_)
                                                            {
                                                               if(203 !== _loc3_)
                                                               {
                                                                  if(301 !== _loc3_)
                                                                  {
                                                                     if(302 !== _loc3_)
                                                                     {
                                                                        if(401 === _loc3_)
                                                                        {
                                                                           WantStrongControl.Instance.close();
                                                                           StateManager.currentStateType = "dungeon";
                                                                           DungeonListController.instance.enter();
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        WantStrongControl.Instance.close();
                                                                        StateManager.currentStateType = "dungeon";
                                                                        DungeonListController.instance.enter();
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     CalendarManager.getInstance().open(1,true);
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  WantStrongControl.Instance.close();
                                                                  StateManager.currentStateType = "roomlist";
                                                                  RoomListController.instance.enter();
                                                               }
                                                            }
                                                            else
                                                            {
                                                               TaskManager.instance.switchVisible();
                                                            }
                                                         }
                                                         else
                                                         {
                                                            LabyrinthControl.Instance.show();
                                                         }
                                                      }
                                                      else
                                                      {
                                                         BagStore.instance.openStore("forge_store",4);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      BagAndInfoManager.Instance.showBagAndInfo(7);
                                                   }
                                                }
                                                else
                                                {
                                                   BagAndInfoManager.Instance.showBagAndInfo(8);
                                                }
                                             }
                                             else
                                             {
                                                HorseManager.instance.show();
                                             }
                                          }
                                          else
                                          {
                                             BagStore.instance.openStore("forge_store",0);
                                          }
                                       }
                                       else
                                       {
                                          BagStore.instance.openStore("forge_store",1);
                                       }
                                    }
                                    else
                                    {
                                       WantStrongControl.Instance.close();
                                       BuriedManager.Instance.enter();
                                    }
                                 }
                                 else
                                 {
                                    BagAndInfoManager.Instance.showBagAndInfo(21);
                                 }
                              }
                              else
                              {
                                 BagStore.instance.openStore("bag_store",2);
                              }
                           }
                           else
                           {
                              BagStore.instance.openStore("bag_store",4);
                           }
                        }
                        else
                        {
                           BagStore.instance.openStore("bag_store");
                        }
                     }
                     else
                     {
                        WantStrongControl.Instance.close();
                        FarmModelController.instance.goFarm(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName);
                        StateManager.setState("farm");
                     }
                  }
                  else
                  {
                     BagAndInfoManager.Instance.showBagAndInfo(4);
                  }
               }
               else if(PlayerManager.Instance.Self.Grade < 30)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("gemstone.limitLevel.tipTxt",30));
               }
               else
               {
                  BagStore.instance.openStore("forge_store",3);
               }
            }
            else
            {
               BagAndInfoManager.Instance.showBagAndInfo(5);
            }
         }
         else
         {
            BagAndInfoManager.Instance.showBagAndInfo(2);
         }
      }
      
      private function removeEvent() : void
      {
         if(_goBtn)
         {
            _goBtn.removeEventListener("click",goBtnHandler);
         }
         if(_freeBackBtn)
         {
            _freeBackBtn.removeEventListener("click",freeBackBtnHandler);
         }
         if(_allBackBtn)
         {
            _allBackBtn.removeEventListener("click",allBackBtnHandler);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
            _cell = null;
         }
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _titleFrameText = null;
         _contentFrameText = null;
         _freeBackContentFrameText = null;
         _freeNumFrameText = null;
         _freeHonorFrameText = null;
         _allBackContentFrameText = null;
         _allNumFrameText = null;
         _allHonorFrameText = null;
         _freeBackBtn = null;
         _allBackBtn = null;
         _goBtn = null;
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
