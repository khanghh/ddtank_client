package consortion.view.selfConsortia
{
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortionActiveTargetData;
   import ddt.manager.LanguageMgr;
   import morn.core.handlers.Handler;
   
   public class ConsortionActiveTargetItem extends ConsortionActiveTargetItemUI
   {
       
      
      private var _tagertLv:int = 0;
      
      public function ConsortionActiveTargetItem()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         lnkBtnReward.clickHandler = new Handler(getReward);
      }
      
      private function getReward() : void
      {
         ConsortionModelManager.Instance.requestConsortionActiveTagertReward(_tagertLv);
      }
      
      public function set data(value:int) : void
      {
         var targets:* = undefined;
         var completeLablArr:* = null;
         var unCompleteLablArr:* = null;
         var target:* = null;
         var i:int = 0;
         _tagertLv = value;
         lablLevel.text = LanguageMgr.GetTranslation("consortionActiveTarget.level" + _tagertLv);
         labOpenStatus.text = LanguageMgr.GetTranslation("consortionActiveTarget.close");
         var _loc7_:* = false;
         boxContent.visible = _loc7_;
         _loc7_ = _loc7_;
         lnkBtnReward.visible = _loc7_;
         _loc7_ = _loc7_;
         lablFinish.visible = _loc7_;
         _loc7_ = _loc7_;
         labUnactive.visible = _loc7_;
         lablProcess.visible = _loc7_;
         _loc7_ = ConsortionModelManager.Instance.model.activeTargetStautsDic[_tagertLv];
         if(0 !== _loc7_)
         {
            if(1 !== _loc7_)
            {
               if(2 !== _loc7_)
               {
                  if(3 === _loc7_)
                  {
                     lablFinish.visible = true;
                     lablFinish.text = LanguageMgr.GetTranslation("consortionActiveTarget.status2");
                  }
               }
               else
               {
                  _loc7_ = true;
                  lnkBtnReward.visible = _loc7_;
                  lablFinish.visible = _loc7_;
                  lablFinish.text = LanguageMgr.GetTranslation("consortionActiveTarget.status2");
                  lnkBtnReward.label = LanguageMgr.GetTranslation("consortionActiveReward");
               }
            }
            else
            {
               _loc7_ = true;
               lablProcess.visible = _loc7_;
               boxContent.visible = _loc7_;
               lablProcess.text = LanguageMgr.GetTranslation("consortionActiveTarget.status1");
               labOpenStatus.text = LanguageMgr.GetTranslation("consortionActiveTarget.open");
               targets = ConsortionModelManager.Instance.model.activeTargetDic[_tagertLv];
               completeLablArr = [null,lablComplete1,lablComplete2,lablComplete3,lablComplete4];
               unCompleteLablArr = [null,lablUncomplete1,lablUncomplete2,lablUncomplete3,lablUncomplete4];
               target = null;
               for(i = 1; i <= targets.length; )
               {
                  target = targets[i - 1];
                  if(target && target.processValue >= target.conditionValue)
                  {
                     completeLablArr[i].visible = true;
                     completeLablArr[i].text = LanguageMgr.GetTranslation("consortionActiveTarget.target" + i,target.conditionValue,target.processValue,target.conditionValue);
                     unCompleteLablArr[i].visible = false;
                  }
                  else
                  {
                     completeLablArr[i].visible = false;
                     unCompleteLablArr[i].visible = true;
                     unCompleteLablArr[i].text = LanguageMgr.GetTranslation("consortionActiveTarget.target" + i,target.conditionValue,target.processValue,target.conditionValue);
                  }
                  if(target.conditionValue == 0)
                  {
                     _loc7_ = false;
                     unCompleteLablArr[i].visible = _loc7_;
                     completeLablArr[i].visible = _loc7_;
                  }
                  i++;
               }
            }
         }
         else
         {
            labUnactive.text = LanguageMgr.GetTranslation("consortionActiveTarget.status0");
            labUnactive.visible = true;
         }
      }
      
      override public function get height() : Number
      {
         var height:Number = lablLevel.height;
         if(boxContent.visible)
         {
            height = boxContent.y + boxContent.height;
         }
         return height;
      }
   }
}
