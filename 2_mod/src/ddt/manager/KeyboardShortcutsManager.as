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
import org.aswing.KeyboardManager;

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

        private function __onKeyDown(event:flash.events.KeyboardEvent):void {
            var _loc2_:* = event.keyCode;
            if (192 === _loc2_)
            {
                SoundManager.instance.play("003");
                DDTManager.Instance.ddtConsole.toggle();
                KeyboardManager.getInstance().isStopDispatching = DDTManager.Instance.ddtConsole.isOpen();
            }
            if (DDTManager.Instance.ddtConsole.isOpen())
            {
                return;
            }
            if(isFullForbid)
            {
                return;
            }
            if(isForbiddenSection)
            {
                getKeyboardShortcutsState();
            }
            if(event.target is TextField && (event.target as TextField).type == "input")
            {
                return;
            }
            if(LayerManager.Instance.backGroundInParent)
            {
                closeCurrentFrame(event.keyCode);
                return;
            }
            var _loc2_:* = event.keyCode;
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

    }
}
