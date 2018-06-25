package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import consortion.ConsortionModelManager;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ConsortiaDutyManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import quest.TaskManager;
   import trainer.view.NewHandContainer;
   
   public class BuildingManager extends Sprite implements Disposeable
   {
       
      
      private var _BG:MutipleImage;
      
      private var _bg:Bitmap;
      
      private var _tax:BaseButton;
      
      private var _establishment:BaseButton;
      
      private var _redPackage:BaseButton;
      
      private var _store:BaseButton;
      
      private var _boss:BaseButton;
      
      private var _chairmanChanel:TextButton;
      
      private var _manager:TextButton;
      
      private var _takeIn:TextButton;
      
      private var _exit:TextButton;
      
      private var _chairChannel:ChairmanChannelPanel;
      
      private var _chairChannelShow:Boolean = true;
      
      public function BuildingManager()
      {
         super();
         initView();
         initEvent();
         guideHanlder();
      }
      
      private function initView() : void
      {
         _BG = ComponentFactory.Instance.creatComponentByStylename("consortion.BuildingManagerBG");
         _tax = ComponentFactory.Instance.creatComponentByStylename("buildingManager.tax");
         _establishment = ComponentFactory.Instance.creatComponentByStylename("buildingManager.establishment");
         _redPackage = ComponentFactory.Instance.creatComponentByStylename("buildingManager.redPackage");
         _store = ComponentFactory.Instance.creatComponentByStylename("buildingManager.store");
         _boss = ComponentFactory.Instance.creatComponentByStylename("buildingManager.boss");
         var tmpGrade:int = ConsortionModelManager.Instance.bossCallCondition;
         _boss.tipData = LanguageMgr.GetTranslation("ddt.consortia.bossFrame.conditionTxt",tmpGrade);
         _chairmanChanel = ComponentFactory.Instance.creatComponentByStylename("buildingManager.chairmanChanel");
         _chairmanChanel.text = LanguageMgr.GetTranslation("consortia.BuildingManager.BtnText1");
         _manager = ComponentFactory.Instance.creatComponentByStylename("buildingManager.manager");
         _manager.text = LanguageMgr.GetTranslation("consortia.BuildingManager.BtnText2");
         _takeIn = ComponentFactory.Instance.creatComponentByStylename("buildingManager.takeIn");
         _takeIn.text = LanguageMgr.GetTranslation("consortia.BuildingManager.BtnText3");
         _exit = ComponentFactory.Instance.creatComponentByStylename("buildingManager.exit");
         _exit.text = LanguageMgr.GetTranslation("consortia.BuildingManager.BtnText4");
         addChild(_BG);
         addChild(_tax);
         addChild(_establishment);
         addChild(_store);
         addChild(_redPackage);
         addChild(_boss);
         addChild(_chairmanChanel);
         addChild(_manager);
         addChild(_takeIn);
         addChild(_exit);
         initRight();
      }
      
      private function initRight() : void
      {
         var right:int = PlayerManager.Instance.Self.Right;
         _exit.enable = ConsortiaDutyManager.GetRight(right,4096);
         _takeIn.enable = ConsortiaDutyManager.GetRight(right,1);
         _chairmanChanel.enable = ConsortiaDutyManager.GetRight(right,512);
      }
      
      private function initEvent() : void
      {
         _tax.addEventListener("click",__onClickHandler);
         _establishment.addEventListener("click",__onClickHandler);
         _redPackage.addEventListener("click",__onClickHandler);
         _store.addEventListener("click",__onClickHandler);
         _chairmanChanel.addEventListener("click",__onClickHandler);
         _manager.addEventListener("click",__onClickHandler);
         _takeIn.addEventListener("click",__onClickHandler);
         _exit.addEventListener("click",__onClickHandler);
         _boss.addEventListener("click",__onClickHandler);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propChange);
      }
      
      private function guideHanlder() : void
      {
         if(TaskManager.instance.getTaskData(140) != null && !TaskManager.instance.getTaskData(140).isAchieved && !PlayerManager.Instance.Self.isNewOnceFinish(129))
         {
            NewHandContainer.Instance.showArrow(143,0,new Point(128,-50),"","",this,0,true);
         }
      }
      
      private function removeEvent() : void
      {
         if(_tax)
         {
            _tax.removeEventListener("click",__onClickHandler);
         }
         if(_establishment)
         {
            _establishment.removeEventListener("click",__onClickHandler);
         }
         if(_store)
         {
            _store.removeEventListener("click",__onClickHandler);
         }
         if(_redPackage)
         {
            _redPackage.removeEventListener("click",__onClickHandler);
         }
         if(_chairmanChanel)
         {
            _chairmanChanel.removeEventListener("click",__onClickHandler);
         }
         if(_manager)
         {
            _manager.removeEventListener("click",__onClickHandler);
         }
         if(_takeIn)
         {
            _takeIn.removeEventListener("click",__onClickHandler);
         }
         if(_exit)
         {
            _exit.removeEventListener("click",__onClickHandler);
         }
         if(_boss)
         {
            _boss.removeEventListener("click",__onClickHandler);
         }
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propChange);
      }
      
      private function __propChange(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["Right"])
         {
            initRight();
         }
      }
      
      private function __onClickHandler(event:MouseEvent) : void
      {
         var tmpGrade:int = 0;
         SoundManager.instance.play("008");
         var _loc3_:* = event.currentTarget;
         if(_establishment !== _loc3_)
         {
            if(_redPackage !== _loc3_)
            {
               if(_tax !== _loc3_)
               {
                  if(_store !== _loc3_)
                  {
                     if(_boss !== _loc3_)
                     {
                        if(_chairmanChanel !== _loc3_)
                        {
                           if(_manager !== _loc3_)
                           {
                              if(_takeIn !== _loc3_)
                              {
                                 if(_exit === _loc3_)
                                 {
                                    ConsortionModelManager.Instance.alertQuitFrame();
                                 }
                              }
                              else
                              {
                                 ConsortionModelManager.Instance.alertTakeInFrame();
                              }
                           }
                           else
                           {
                              ConsortionModelManager.Instance.alertManagerFrame();
                           }
                        }
                        else
                        {
                           showChairmanChannel(event);
                        }
                     }
                     else
                     {
                        tmpGrade = ConsortionModelManager.Instance.bossCallCondition;
                        if(PlayerManager.Instance.Self.consortiaInfo.Level < tmpGrade)
                        {
                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortia.bossFrame.conditionTxt2",tmpGrade));
                        }
                        else
                        {
                           ConsortionModelManager.Instance.openBossFrame();
                        }
                     }
                  }
                  else
                  {
                     ConsortionModelManager.Instance.rankFrame();
                  }
               }
               else
               {
                  ConsortionModelManager.Instance.alertTaxFrame();
               }
            }
            else
            {
               ConsortionModelManager.Instance.alertRedPackageFrame();
            }
         }
         else
         {
            ConsortiaDomainManager.instance.enterScene(true);
         }
      }
      
      private function showChairmanChannel(evt:MouseEvent) : void
      {
         if(_chairChannelShow)
         {
            evt.stopImmediatePropagation();
            if(!_chairChannel)
            {
               _chairChannel = ComponentFactory.Instance.creatCustomObject("chairmanChannelPanel");
               addChild(_chairChannel);
            }
            _chairChannel.visible = true;
            LayerManager.Instance.addToLayer(_chairChannel,3);
            stage.addEventListener("click",__closeChairChnnel);
         }
         else if(_chairChannel)
         {
            _chairChannel.visible = false;
         }
         _chairChannelShow = !!_chairChannelShow?false:true;
      }
      
      private function __closeChairChnnel(e:MouseEvent) : void
      {
         if(e.target != _chairChannel)
         {
            stage.removeEventListener("click",__closeChairChnnel);
            if(_chairChannel)
            {
               _chairChannel.visible = false;
               _chairChannelShow = true;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_chairChannel)
         {
            ObjectUtils.disposeObject(_chairChannel);
         }
         _chairChannel = null;
         if(_tax)
         {
            ObjectUtils.disposeObject(_tax);
         }
         _tax = null;
         if(_store)
         {
            ObjectUtils.disposeObject(_store);
         }
         _store = null;
         if(_redPackage)
         {
            ObjectUtils.disposeObject(_redPackage);
         }
         _redPackage = null;
         if(_boss)
         {
            ObjectUtils.disposeObject(_boss);
         }
         _boss = null;
         if(_BG)
         {
            ObjectUtils.disposeObject(_BG);
         }
         _BG = null;
         if(_chairmanChanel)
         {
            ObjectUtils.disposeObject(_chairmanChanel);
         }
         _chairmanChanel = null;
         if(_manager)
         {
            ObjectUtils.disposeObject(_manager);
         }
         _manager = null;
         if(_takeIn)
         {
            ObjectUtils.disposeObject(_takeIn);
         }
         _takeIn = null;
         if(_exit)
         {
            ObjectUtils.disposeObject(_exit);
         }
         _exit = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
