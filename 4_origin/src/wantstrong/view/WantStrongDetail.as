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
      
      public function WantStrongDetail(item:WantStrongMenuData)
      {
         super();
         _item = item;
         initView();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var lightStar:* = null;
         var j:int = 0;
         var grayStar:* = null;
         _bg = ComponentFactory.Instance.creat("wantstrong.right.cellbg");
         addChild(_bg);
         _titleFrameText = ComponentFactory.Instance.creatComponentByStylename("wantstrong.view.mainFrame.rightTitle.Text");
         _titleFrameText.text = _item.title;
         addChild(_titleFrameText);
         for(i = 0; i < _item.starNum; )
         {
            lightStar = ComponentFactory.Instance.creatBitmap("wantstrong.right.xing");
            lightStar.x = 135 + 21 * i;
            lightStar.y = 6;
            addChild(lightStar);
            i++;
         }
         for(j = _item.starNum; j < 5; )
         {
            grayStar = ComponentFactory.Instance.creatBitmap("wantstrong.right.grayxing");
            grayStar.x = 135 + 21 * j;
            grayStar.y = 6;
            addChild(grayStar);
            j++;
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
            _freeHonorFrameText.text = LanguageMgr.GetTranslation("ddt.wantStrong.view.priceValue" + _item.awardType);
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
            _allHonorFrameText.text = LanguageMgr.GetTranslation("ddt.wantStrong.view.priceValue" + _item.awardType);
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
      
      private function freeBackBtnHandler(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var alertAsk:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.wantStrong.view.freeFindBackAlert"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
         alertAsk.addEventListener("response",__alertFreeBack);
      }
      
      private function __alertFreeBack(event:FrameEvent) : void
      {
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               SocketManager.Instance.out.sendWantStrongBack(_item.bossType,false);
         }
         event.currentTarget.removeEventListener("response",__alertFreeBack);
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      private function allBackBtnHandler(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var alertAsk:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.wantStrong.view.allFindBackAlert",_item.moneyNum),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false,0);
         alertAsk.addEventListener("response",__alertAllBack);
      }
      
      private function __alertAllBack(event:FrameEvent) : void
      {
         var alertFrame:* = null;
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__alertAllBack);
         SoundManager.instance.playButtonSound();
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  event.currentTarget.removeEventListener("response",__alertAllBack);
                  ObjectUtils.disposeObject(event.currentTarget);
                  return;
               }
               CheckMoneyUtils.instance.checkMoney(frame.isBand,_item.moneyNum,onCheckComplete);
               break;
         }
         frame.dispose();
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.sendWantStrongBack(_item.bossType,true,CheckMoneyUtils.instance.isBind);
      }
      
      private function goBtnHandler(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var target:WantStrongDetail = event.target.parent as WantStrongDetail;
         _bagInfoItems = PlayerManager.Instance.Self.PropBag.items;
         var _loc3_:* = target._item.id;
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
