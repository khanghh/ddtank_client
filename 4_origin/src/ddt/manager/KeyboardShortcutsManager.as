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
      
      public function KeyboardShortcutsManager()
      {
         super();
      }
      
      public static function get Instance() : KeyboardShortcutsManager
      {
         if(_instance == null)
         {
            _instance = new KeyboardShortcutsManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         if(isAddEvent)
         {
            StageReferance.stage.addEventListener("keyUp",__onKeyDown);
            isAddEvent = false;
         }
      }
      
      private function __onKeyDown(param1:KeyboardEvent) : void
      {
         if(isFullForbid)
         {
            return;
         }
         if(isForbiddenSection)
         {
            getKeyboardShortcutsState();
         }
         if(param1.target is TextField && (param1.target as TextField).type == "input")
         {
            return;
         }
         if(LayerManager.Instance.backGroundInParent)
         {
            closeCurrentFrame(param1.keyCode);
            return;
         }
         var _loc2_:* = param1.keyCode;
         if(KeyStroke.VK_M.getCode() !== _loc2_)
         {
            if(KeyStroke.VK_B.getCode() !== _loc2_)
            {
               if(KeyStroke.VK_Q.getCode() !== _loc2_)
               {
                  if(KeyStroke.VK_F.getCode() !== _loc2_)
                  {
                     if(KeyStroke.VK_G.getCode() !== _loc2_)
                     {
                        if(KeyStroke.VK_H.getCode() !== _loc2_)
                        {
                           if(KeyStroke.VK_T.getCode() !== _loc2_)
                           {
                              if(KeyStroke.VK_R.getCode() !== _loc2_)
                              {
                                 if(KeyStroke.VK_S.getCode() !== _loc2_)
                                 {
                                    if(KeyStroke.VK_P.getCode() === _loc2_)
                                    {
                                       if(isProhibit_P && isProhibitNewHand_P)
                                       {
                                          if(PlayerManager.Instance.Self.Grade >= 25)
                                          {
                                             SoundManager.instance.play("003");
                                             PetsBagManager.instance().show();
                                          }
                                       }
                                    }
                                 }
                              }
                              else if(isProhibit_R && isProhibitNewHand_R)
                              {
                                 if(PlayerManager.Instance.Self.Grade >= 11)
                                 {
                                    SoundManager.instance.play("003");
                                    MailManager.Instance.switchVisible();
                                 }
                              }
                           }
                           else if(isProhibit_T && isProhibitNewHand_T)
                           {
                              SoundManager.instance.play("003");
                              GotoPageController.Instance.switchVisible();
                           }
                        }
                        else if(isProhibit_H && isProhibitNewHand_H)
                        {
                           SoundManager.instance.play("003");
                           SettingController.Instance.switchVisible();
                        }
                     }
                     else if(isProhibit_G)
                     {
                        if(StateManager.currentStateType == "main" || StateManager.currentStateType == "dungeon" || StateManager.currentStateType == "roomlist")
                        {
                           if(PlayerManager.Instance.Self.Grade >= 17)
                           {
                              SoundManager.instance.play("003");
                              StateManager.setState("consortia");
                           }
                        }
                     }
                  }
                  else if(isProhibit_F && isProhibitNewHand_F)
                  {
                     if(PlayerManager.Instance.Self.Grade >= 11)
                     {
                        SoundManager.instance.play("003");
                        IMManager.Instance.show();
                     }
                  }
               }
               else if(isProhibit_Q)
               {
                  SoundManager.instance.play("003");
                  TaskManager.instance.switchVisible();
               }
            }
            else if(isProhibit_B && isProhibitNewHand_B)
            {
               SoundManager.instance.play("003");
               StageReferance.stage.dispatchEvent(new MouseEvent("mouseDown"));
               BagAndInfoManager.Instance.showBagAndInfo();
            }
         }
         else if(isProhibit_M && isProhibitNewHand_M)
         {
            SoundManager.instance.play("003");
            HorseManager.instance.show();
         }
      }
      
      private function closeCurrentFrame(param1:uint) : void
      {
         var _loc2_:* = param1;
         if(KeyStroke.VK_M.getCode() !== _loc2_)
         {
            if(KeyStroke.VK_B.getCode() !== _loc2_)
            {
               if(KeyStroke.VK_R.getCode() !== _loc2_)
               {
                  if(KeyStroke.VK_H.getCode() !== _loc2_)
                  {
                     if(KeyStroke.VK_T.getCode() !== _loc2_)
                     {
                        if(KeyStroke.VK_Q.getCode() !== _loc2_)
                        {
                           if(KeyStroke.VK_S.getCode() !== _loc2_)
                           {
                              if(KeyStroke.VK_Q.getCode() !== _loc2_)
                              {
                                 if(KeyStroke.VK_P.getCode() === _loc2_)
                                 {
                                    if(isProhibit_P && isProhibitNewHand_P && PetsBagManager.instance().isShow && !PetsAdvancedManager.Instance.isPetsAdvancedViewShow)
                                    {
                                       SoundManager.instance.play("003");
                                       PetsBagManager.instance().hide();
                                    }
                                 }
                              }
                              else if(isProhibit_Q && TaskManager.instance.isShow)
                              {
                                 SoundManager.instance.play("003");
                                 TaskManager.instance.switchVisible();
                              }
                           }
                        }
                        else if(isProhibit_Q && TaskManager.instance.isShow)
                        {
                           SoundManager.instance.play("003");
                           TaskManager.instance.switchVisible();
                        }
                     }
                     else if(isProhibit_T && isProhibitNewHand_T && GotoPageController.Instance.isShow)
                     {
                        SoundManager.instance.play("003");
                        GotoPageController.Instance.hide();
                     }
                  }
                  else if(isProhibit_H && SettingController.Instance.isShow)
                  {
                     SoundManager.instance.play("003");
                     SettingController.Instance.hide();
                  }
               }
               else if(isProhibit_R && isProhibitNewHand_R && MailManager.Instance.isShow)
               {
                  SoundManager.instance.play("003");
                  MailManager.Instance.hide();
               }
            }
            else if(isProhibit_B && isProhibitNewHand_B && BagAndInfoManager.Instance.isShown)
            {
               SoundManager.instance.play("003");
               BagAndInfoManager.Instance.hideBagAndInfo();
            }
         }
         else if(isProhibit_M && isProhibitNewHand_M)
         {
            SoundManager.instance.play("003");
            HorseManager.instance.closeFrame();
         }
      }
      
      private function getKeyboardShortcutsState() : void
      {
         var _loc1_:String = StateManager.currentStateType;
         var _loc2_:* = _loc1_;
         if("fightLabGameView" !== _loc2_)
         {
            if("fighting" !== _loc2_)
            {
               if("loadingTrainer" !== _loc2_)
               {
                  if("login" !== _loc2_)
                  {
                     if("churchRoom" !== _loc2_)
                     {
                        if("hotSpringRoom" !== _loc2_)
                        {
                           if("collectionTaskScene" !== _loc2_)
                           {
                              if("demon_chi_you" !== _loc2_)
                              {
                                 if("consortia_domain" !== _loc2_)
                                 {
                                    if("consortiaGuard" !== _loc2_)
                                    {
                                       if("auction" !== _loc2_)
                                       {
                                          if("shop" !== _loc2_)
                                          {
                                             if("trainer1" !== _loc2_)
                                             {
                                                if("trainer2" !== _loc2_)
                                                {
                                                   isProhibit_M = true;
                                                   isProhibit_B = true;
                                                   isProhibit_Q = true;
                                                   isProhibit_F = true;
                                                   isProhibit_H = true;
                                                   isProhibit_T = true;
                                                   isProhibit_R = true;
                                                   isProhibit_S = true;
                                                   isProhibit_G = true;
                                                   isProhibit_P = true;
                                                }
                                             }
                                             isProhibit_M = false;
                                             isProhibit_B = false;
                                             isProhibit_Q = false;
                                             isProhibit_F = false;
                                             isProhibit_H = true;
                                             isProhibit_T = false;
                                             isProhibit_R = false;
                                             isProhibit_S = false;
                                             isProhibit_G = false;
                                             isProhibit_P = false;
                                          }
                                       }
                                       isProhibit_M = true;
                                       isProhibit_B = false;
                                       isProhibit_Q = true;
                                       isProhibit_F = true;
                                       isProhibit_H = true;
                                       isProhibit_T = true;
                                       isProhibit_R = true;
                                       isProhibit_S = true;
                                       isProhibit_G = true;
                                       isProhibit_P = true;
                                    }
                                    addr231:
                                    if(PlayerManager.Instance.Self.Grade < 5)
                                    {
                                       isProhibit_G = false;
                                    }
                                    return;
                                 }
                                 addr18:
                                 isProhibit_M = false;
                                 isProhibit_B = false;
                                 isProhibit_Q = false;
                                 isProhibit_F = false;
                                 isProhibit_H = false;
                                 isProhibit_T = false;
                                 isProhibit_R = false;
                                 isProhibit_S = false;
                                 isProhibit_G = true;
                                 isProhibit_P = false;
                                 §§goto(addr231);
                              }
                              addr17:
                              §§goto(addr18);
                           }
                           addr16:
                           §§goto(addr17);
                        }
                        addr15:
                        §§goto(addr16);
                     }
                     addr14:
                     §§goto(addr15);
                  }
                  addr13:
                  §§goto(addr14);
               }
               addr12:
               §§goto(addr13);
            }
            addr11:
            §§goto(addr12);
         }
         §§goto(addr11);
      }
      
      public function forbiddenFull() : void
      {
         isFullForbid = true;
      }
      
      public function cancelForbidden() : void
      {
         isFullForbid = false;
      }
      
      public function forbiddenSection(param1:int, param2:Boolean) : void
      {
         isForbiddenSection = param2;
         switch(int(param1) - 1)
         {
            case 0:
               isProhibit_M = false;
               isProhibit_B = false;
               isProhibit_Q = true;
               isProhibit_F = true;
               isProhibit_H = false;
               isProhibit_T = false;
               isProhibit_R = false;
               isProhibit_S = false;
               isProhibit_P = false;
               break;
            case 1:
               isProhibit_M = false;
               isProhibit_B = false;
               isProhibit_Q = false;
               isProhibit_F = false;
               isProhibit_H = true;
               isProhibit_T = false;
               isProhibit_R = false;
               isProhibit_S = false;
               isProhibit_P = false;
               break;
            default:
               isProhibit_M = false;
               isProhibit_B = false;
               isProhibit_Q = false;
               isProhibit_F = false;
               isProhibit_H = true;
               isProhibit_T = false;
               isProhibit_R = false;
               isProhibit_S = false;
               isProhibit_P = false;
               break;
            default:
               isProhibit_M = false;
               isProhibit_B = false;
               isProhibit_Q = false;
               isProhibit_F = false;
               isProhibit_H = true;
               isProhibit_T = false;
               isProhibit_R = false;
               isProhibit_S = false;
               isProhibit_P = false;
               break;
            case 4:
               isProhibit_M = true;
               isProhibit_B = true;
               isProhibit_Q = true;
               isProhibit_F = true;
               isProhibit_H = true;
               isProhibit_T = true;
               isProhibit_R = true;
               isProhibit_S = true;
               isProhibit_P = true;
         }
      }
      
      public function prohibitNewHandBag(param1:Boolean) : void
      {
         isProhibitNewHand_B = param1;
      }
      
      public function prohibitNewHandFriend(param1:Boolean) : void
      {
         isProhibitNewHand_F = param1;
      }
      
      public function prohibitNewHandChannel(param1:Boolean) : void
      {
         isProhibitNewHand_T = param1;
      }
      
      public function prohibitNewHandMail(param1:Boolean) : void
      {
         isProhibitNewHand_R = param1;
      }
      
      public function prohibitNewHandCalendar(param1:Boolean) : void
      {
         isProhibitNewHand_S = param1;
      }
      
      public function prohibitNewHandSeting(param1:Boolean) : void
      {
         isProhibitNewHand_H = param1;
      }
      
      public function prohibitNewHandPetsBag(param1:Boolean) : void
      {
         isProhibitNewHand_P = param1;
      }
   }
}
