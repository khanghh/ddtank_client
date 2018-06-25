package ddt.utils
{
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.ITipedDisplay;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class HelpBtnEnable
   {
      
      private static var instance:HelpBtnEnable;
       
      
      private var _hasForbiddenDic:Dictionary;
      
      public function HelpBtnEnable(single:inner)
      {
         _hasForbiddenDic = new Dictionary();
         super();
      }
      
      public static function getInstance() : HelpBtnEnable
      {
         if(!instance)
         {
            instance = new HelpBtnEnable(new inner());
         }
         return instance;
      }
      
      public function greyByGrade($target:DisplayObject, minLevel:int) : void
      {
         if(PlayerManager.Instance.Self.Grade < minLevel)
         {
            Helpers.grey($target);
         }
         else
         {
            Helpers.colorful($target);
         }
      }
      
      public function showTipsByGrade(minLevel:int, msg:String, useLanguageMgr:Boolean = true) : Boolean
      {
         if(PlayerManager.Instance.Self.Grade < minLevel)
         {
            if(useLanguageMgr)
            {
               msg = LanguageMgr.GetTranslation(msg,minLevel);
            }
            MessageTipManager.getInstance().show(msg);
            return false;
         }
         return true;
      }
      
      public function addMouseOverTips(target:ITipedDisplay, minLevel:int, msg:String = "tips.open", useLanguageMgr:Boolean = true, tagGrey:Boolean = true, otherCondition:Boolean = true) : void
      {
         if(PlayerManager.Instance.Self.Grade < minLevel && otherCondition)
         {
            tagGrey && Helpers.grey(target as DisplayObject);
            _hasForbiddenDic[target.name] = true;
            if(useLanguageMgr)
            {
               msg = LanguageMgr.GetTranslation(msg,minLevel);
            }
            target.tipData = msg;
            target.tipDirctions = "7,0";
            target.tipStyle = "ddt.view.tips.OneLineTip";
            ShowTipManager.Instance.addTip(target);
            (target as InteractiveObject).addEventListener("click",onClick,false,1);
            if(target is BaseButton)
            {
               (target as BaseButton).enable = false;
            }
            (target as InteractiveObject).mouseEnabled = true;
         }
         else
         {
            removeMouseOverTips(target);
         }
      }
      
      public function removeMouseOverTips(target:ITipedDisplay) : void
      {
         if(target == null)
         {
            return;
         }
         Helpers.colorful(target as DisplayObject);
         delete _hasForbiddenDic[target.name];
         ShowTipManager.Instance.removeTip(target);
         (target as InteractiveObject).removeEventListener("click",onClick);
         if(target is BaseButton)
         {
            (target as BaseButton).enable = true;
         }
      }
      
      private function onClick(e:MouseEvent) : void
      {
         e.stopImmediatePropagation();
      }
      
      public function isForbidden(target:ITipedDisplay) : Boolean
      {
         if(_hasForbiddenDic[target.name])
         {
            return true;
         }
         return false;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
