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
      
      public function set data(param1:int) : void
      {
         var _loc5_:* = undefined;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         _tagertLv = param1;
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
               _loc5_ = ConsortionModelManager.Instance.model.activeTargetDic[_tagertLv];
               _loc4_ = [null,lablComplete1,lablComplete2,lablComplete3,lablComplete4];
               _loc2_ = [null,lablUncomplete1,lablUncomplete2,lablUncomplete3,lablUncomplete4];
               _loc3_ = null;
               _loc6_ = 1;
               while(_loc6_ <= _loc5_.length)
               {
                  _loc3_ = _loc5_[_loc6_ - 1];
                  if(_loc3_ && _loc3_.processValue >= _loc3_.conditionValue)
                  {
                     _loc4_[_loc6_].visible = true;
                     _loc4_[_loc6_].text = LanguageMgr.GetTranslation("consortionActiveTarget.target" + _loc6_,_loc3_.conditionValue,_loc3_.processValue,_loc3_.conditionValue);
                     _loc2_[_loc6_].visible = false;
                  }
                  else
                  {
                     _loc4_[_loc6_].visible = false;
                     _loc2_[_loc6_].visible = true;
                     _loc2_[_loc6_].text = LanguageMgr.GetTranslation("consortionActiveTarget.target" + _loc6_,_loc3_.conditionValue,_loc3_.processValue,_loc3_.conditionValue);
                  }
                  if(_loc3_.conditionValue == 0)
                  {
                     _loc7_ = false;
                     _loc2_[_loc6_].visible = _loc7_;
                     _loc4_[_loc6_].visible = _loc7_;
                  }
                  _loc6_++;
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
         var _loc1_:Number = lablLevel.height;
         if(boxContent.visible)
         {
            _loc1_ = boxContent.y + boxContent.height;
         }
         return _loc1_;
      }
   }
}
