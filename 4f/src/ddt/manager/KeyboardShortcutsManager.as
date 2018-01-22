package ddt.manager
{
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import email.MailManager;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gotopage.view.GotoPageController;
   import horse.HorseManager;
   import org.aswing.KeyStroke;
   import petsBag.PetsBagManager;
   import petsBag.petsAdvanced.PetsAdvancedManager;
   import quest.TaskManager;
   import setting.controll.SettingController;
   
   public class KeyboardShortcutsManager
   {
      
      public static const GAME_PREPARE:int = 1;
      
      public static const GAME:int = 2;
      
      public static const BAG:int = 3;
      
      public static const FRIEND:int = 4;
      
      public static const GAME_WAIT:int = 5;
      
      private static var _instance:KeyboardShortcutsManager;
       
      
      private var isProhibit_M:Boolean;
      
      private var isProhibit_B:Boolean;
      
      private var isProhibit_Q:Boolean;
      
      private var isProhibit_F:Boolean;
      
      private var isProhibit_G:Boolean;
      
      private var isProhibit_H:Boolean;
      
      private var isProhibit_T:Boolean;
      
      private var isProhibit_R:Boolean;
      
      private var isProhibit_S:Boolean;
      
      private var isProhibit_P:Boolean;
      
      private var isFullForbid:Boolean;
      
      private var isAddEvent:Boolean = true;
      
      private var isForbiddenSection:Boolean = true;
      
      private var isProhibitNewHand_M:Boolean = true;
      
      private var isProhibitNewHand_B:Boolean = true;
      
      private var isProhibitNewHand_F:Boolean = true;
      
      private var isProhibitNewHand_T:Boolean = true;
      
      private var isProhibitNewHand_R:Boolean = true;
      
      private var isProhibitNewHand_S:Boolean = true;
      
      private var isProhibitNewHand_H:Boolean = true;
      
      private var isProhibitNewHand_P:Boolean = true;
      
      public function KeyboardShortcutsManager(){super();}
      
      public static function get Instance() : KeyboardShortcutsManager{return null;}
      
      public function setup() : void{}
      
      private function __onKeyDown(param1:KeyboardEvent) : void{}
      
      private function closeCurrentFrame(param1:uint) : void{}
      
      private function getKeyboardShortcutsState() : void{}
      
      public function forbiddenFull() : void{}
      
      public function cancelForbidden() : void{}
      
      public function forbiddenSection(param1:int, param2:Boolean) : void{}
      
      public function prohibitNewHandBag(param1:Boolean) : void{}
      
      public function prohibitNewHandFriend(param1:Boolean) : void{}
      
      public function prohibitNewHandChannel(param1:Boolean) : void{}
      
      public function prohibitNewHandMail(param1:Boolean) : void{}
      
      public function prohibitNewHandCalendar(param1:Boolean) : void{}
      
      public function prohibitNewHandSeting(param1:Boolean) : void{}
      
      public function prohibitNewHandPetsBag(param1:Boolean) : void{}
   }
}
