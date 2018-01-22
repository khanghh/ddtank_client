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
      
      public function HelpBtnEnable(param1:inner){super();}
      
      public static function getInstance() : HelpBtnEnable{return null;}
      
      public function greyByGrade(param1:DisplayObject, param2:int) : void{}
      
      public function showTipsByGrade(param1:int, param2:String, param3:Boolean = true) : Boolean{return false;}
      
      public function addMouseOverTips(param1:ITipedDisplay, param2:int, param3:String = "tips.open", param4:Boolean = true, param5:Boolean = true, param6:Boolean = true) : void{}
      
      public function removeMouseOverTips(param1:ITipedDisplay) : void{}
      
      private function onClick(param1:MouseEvent) : void{}
      
      public function isForbidden(param1:ITipedDisplay) : Boolean{return false;}
   }
}

class inner
{
    
   
   function inner(){super();}
}
