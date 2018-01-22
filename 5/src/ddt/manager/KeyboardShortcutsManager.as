package ddt.manager {
import bagAndInfo.BagAndInfoManager;

import com.pickgliss.toplevel.StageReferance;
import com.pickgliss.ui.LayerManager;
import org.aswing.KeyboardManager;

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

public class KeyboardShortcutsManager {
    public static const BAG:int = 3;
    public static const FRIEND:int = 4;
    public static const GAME:int = 2;
    public static const GAME_PREPARE:int = 1;
    public static const GAME_WAIT:int = 5;
    private static var _instance:ddt.manager.KeyboardShortcutsManager;

    public static function get Instance():ddt.manager.KeyboardShortcutsManager {
        if (!(_instance != null)) {
            _instance = new KeyboardShortcutsManager();
        }
        return _instance;
    }

    public function KeyboardShortcutsManager() {

    }

    private var isAddEvent:Boolean;
    private var isForbiddenSection:Boolean;
    private var isFullForbid:Boolean;
    private var isProhibit_B:Boolean;
    private var isProhibit_F:Boolean;
    private var isProhibit_G:Boolean;
    private var isProhibit_H:Boolean;
    private var isProhibit_M:Boolean;
    private var isProhibit_P:Boolean;
    private var isProhibit_Q:Boolean;
    private var isProhibit_R:Boolean;
    private var isProhibit_S:Boolean;
    private var isProhibit_T:Boolean;
    private var isProhibitNewHand_B:Boolean;
    private var isProhibitNewHand_F:Boolean;
    private var isProhibitNewHand_H:Boolean;
    private var isProhibitNewHand_M:Boolean;
    private var isProhibitNewHand_P:Boolean;
    private var isProhibitNewHand_R:Boolean;
    private var isProhibitNewHand_S:Boolean;
    private var isProhibitNewHand_T:Boolean;
    private var isToggleConsole:Boolean;

    public function cancelForbidden():void {
        isFullForbid = false;
    }

    public function forbiddenFull():void {
        isFullForbid = true;
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

    public function prohibitNewHandBag(state:Boolean):void {
        isProhibitNewHand_B = state;
    }

    public function prohibitNewHandCalendar(state:Boolean):void {
        isProhibitNewHand_S = state;
    }

    public function prohibitNewHandChannel(state:Boolean):void {
        isProhibitNewHand_T = state;
    }

    public function prohibitNewHandFriend(state:Boolean):void {
        isProhibitNewHand_F = state;
    }

    public function prohibitNewHandMail(state:Boolean):void {
        isProhibitNewHand_R = state;
    }

    public function prohibitNewHandPetsBag(state:Boolean):void {
        isProhibitNewHand_P = state;
    }

    public function prohibitNewHandSeting(state:Boolean):void {
        isProhibitNewHand_H = state;
    }

    public function setup():void {
        if (isAddEvent) {
            com.pickgliss.toplevel.StageReferance.stage.addEventListener('keyUp', __onKeyDown);
            isAddEvent = false;
        }
    }

    private function __onKeyDown(event:flash.events.KeyboardEvent):void {
        var _loc2_:* = event.keyCode;
        if (192 === _loc2_)
        {
            DDTManager.Instance.ddtConsole.toggle();
            KeyboardManager.getInstance().isStopDispatching = DDTManager.Instance.ddtConsole.isOpen();
        }__onKeyDown
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

        if(KeyStroke.VK_M.getCode() === _loc2_)
        {
            if(isProhibit_M && isProhibitNewHand_M)
            {
                SoundManager.instance.play("003");
                HorseManager.instance.show();
            }
        }
        else if(KeyStroke.VK_B.getCode() === _loc2_)
        {
            if(isProhibit_B && isProhibitNewHand_B)
            {
                SoundManager.instance.play("003");
                StageReferance.stage.dispatchEvent(new MouseEvent("mouseDown"));
                BagAndInfoManager.Instance.showBagAndInfo();
            }
        }
        else if(KeyStroke.VK_Q.getCode() === _loc2_)
        {
            if(isProhibit_Q)
            {
                SoundManager.instance.play("003");
                TaskManager.instance.switchVisible();
            }
        }
        else if(KeyStroke.VK_F.getCode() === _loc2_)
        {
            if(isProhibit_F && isProhibitNewHand_F)
            {
                if(PlayerManager.Instance.Self.Grade >= 11)
                {
                    SoundManager.instance.play("003");
                    IMManager.Instance.show();
                }
            }
        }
        else if(KeyStroke.VK_G.getCode() === _loc2_)
        {
            if(isProhibit_G)
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
        else if(KeyStroke.VK_H.getCode() === _loc2_)
        {
            if(isProhibit_H && isProhibitNewHand_H)
            {
                SoundManager.instance.play("003");
                SettingController.Instance.switchVisible();
            }
        }
        else if(KeyStroke.VK_T.getCode() === _loc2_)
        {
            if(isProhibit_T && isProhibitNewHand_T)
            {
                SoundManager.instance.play("003");
                GotoPageController.Instance.switchVisible();
            }
        }
        else
        if(KeyStroke.VK_R.getCode() === _loc2_)
        {
            if(isProhibit_R && isProhibitNewHand_R)
            {
                if(PlayerManager.Instance.Self.Grade >= 11)
                {
                    SoundManager.instance.play("003");
                    MailManager.Instance.switchVisible();
                }
            }
        }
        else if(KeyStroke.VK_S.getCode() === _loc2_)
        {
        }
        else if(KeyStroke.VK_P.getCode() === _loc2_)
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

    private function closeCurrentFrame(keyCode:uint):void {
        var local0:* = keyCode;
        if (org.aswing.KeyStroke.VK_M.getCode() === local0) {
            if (isProhibit_M) {
                if (Boolean(isProhibitNewHand_M)) {
                    ddt.manager.SoundManager.instance.play('003');
                    horse.HorseManager.instance.closeFrame();
                }
            }
            else {
                ddt.manager.SoundManager.instance.play('003');
                horse.HorseManager.instance.closeFrame();
            }
        }
        else {
            if (org.aswing.KeyStroke.VK_B.getCode() === local0) {
                if (isProhibit_B) {
                    if (Boolean(isProhibitNewHand_B)) {
                        if (Boolean(bagAndInfo.BagAndInfoManager.Instance.isShown)) {
                            ddt.manager.SoundManager.instance.play('003');
                            bagAndInfo.BagAndInfoManager.Instance.hideBagAndInfo();
                        }
                    }
                    else {
                        ddt.manager.SoundManager.instance.play('003');
                        bagAndInfo.BagAndInfoManager.Instance.hideBagAndInfo();
                    }
                }
                else {
                    if (Boolean(bagAndInfo.BagAndInfoManager.Instance.isShown)) {
                        ddt.manager.SoundManager.instance.play('003');
                        bagAndInfo.BagAndInfoManager.Instance.hideBagAndInfo();
                    }
                }
            }
            else {
                if (org.aswing.KeyStroke.VK_R.getCode() === local0) {
                    if (isProhibit_R) {
                        if (Boolean(isProhibitNewHand_R)) {
                            if (Boolean(email.MailManager.Instance.isShow)) {
                                ddt.manager.SoundManager.instance.play('003');
                                email.MailManager.Instance.hide();
                            }
                        }
                        else {
                            ddt.manager.SoundManager.instance.play('003');
                            email.MailManager.Instance.hide();
                        }
                    }
                    else {
                        if (Boolean(email.MailManager.Instance.isShow)) {
                            ddt.manager.SoundManager.instance.play('003');
                            email.MailManager.Instance.hide();
                        }
                    }
                }
                else {
                    if (org.aswing.KeyStroke.VK_H.getCode() === local0) {
                        if (isProhibit_H) {
                            if (Boolean(setting.controll.SettingController.Instance.isShow)) {
                                ddt.manager.SoundManager.instance.play('003');
                                setting.controll.SettingController.Instance.hide();
                            }
                        }
                        else {
                            ddt.manager.SoundManager.instance.play('003');
                            setting.controll.SettingController.Instance.hide();
                        }
                    }
                    else {
                        if (org.aswing.KeyStroke.VK_T.getCode() === local0) {
                            if (isProhibit_T) {
                                if (Boolean(isProhibitNewHand_T)) {
                                    if (Boolean(gotopage.view.GotoPageController.Instance.isShow)) {
                                        ddt.manager.SoundManager.instance.play('003');
                                        gotopage.view.GotoPageController.Instance.hide();
                                    }
                                }
                                else {
                                    ddt.manager.SoundManager.instance.play('003');
                                    gotopage.view.GotoPageController.Instance.hide();
                                }
                            }
                            else {
                                if (Boolean(gotopage.view.GotoPageController.Instance.isShow)) {
                                    ddt.manager.SoundManager.instance.play('003');
                                    gotopage.view.GotoPageController.Instance.hide();
                                }
                            }
                        }
                        else {
                            if (org.aswing.KeyStroke.VK_Q.getCode() === local0) {
                                if (isProhibit_Q) {
                                    if (Boolean(quest.TaskManager.instance.isShow)) {
                                        ddt.manager.SoundManager.instance.play('003');
                                        quest.TaskManager.instance.switchVisible();
                                    }
                                }
                                else {
                                    ddt.manager.SoundManager.instance.play('003');
                                    quest.TaskManager.instance.switchVisible();
                                }
                            }
                            else {
                                if (!(org.aswing.KeyStroke.VK_S.getCode() === local0)) {
                                    if (org.aswing.KeyStroke.VK_P.getCode() === local0) {
                                        if (isProhibit_P) {
                                            if (Boolean(isProhibitNewHand_P)) {
                                                if (Boolean(petsBag.PetsBagManager.instance().isShow)) {
                                                    if (!petsBag.petsAdvanced.PetsAdvancedManager.Instance.isPetsAdvancedViewShow) {
                                                        ddt.manager.SoundManager.instance.play('003');
                                                        petsBag.PetsBagManager.instance().hide();
                                                    }
                                                }
                                                else {
                                                    ddt.manager.SoundManager.instance.play('003');
                                                    petsBag.PetsBagManager.instance().hide();
                                                }
                                            }
                                            else if (!petsBag.petsAdvanced.PetsAdvancedManager.Instance.isPetsAdvancedViewShow) {
                                                ddt.manager.SoundManager.instance.play('003');
                                                petsBag.PetsBagManager.instance().hide();
                                            }
                                        }
                                        else {
                                            if (Boolean(petsBag.PetsBagManager.instance().isShow)) {
                                                if (!petsBag.petsAdvanced.PetsAdvancedManager.Instance.isPetsAdvancedViewShow) {
                                                    ddt.manager.SoundManager.instance.play('003');
                                                    petsBag.PetsBagManager.instance().hide();
                                                }
                                            }
                                            else {
                                                ddt.manager.SoundManager.instance.play('003');
                                                petsBag.PetsBagManager.instance().hide();
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private function getKeyboardShortcutsState():void {
        var string1:String = ddt.manager.StateManager.currentStateType;
        var local1:* = string1;
        if ('fightLabGameView' === local1) {
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
        }
        else if ('fighting' === local1) {
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
        }
        else if ('loadingTrainer' === local1) {
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
        }
        else if ('login' === local1) {
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
        }
        else if ('churchRoom' === local1) {
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
        }
        else if ('hotSpringRoom' === local1) {
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
        }
        else if ('collectionTaskScene' === local1) {
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
        }
        else if ('demon_chi_you' === local1) {
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
        }
        else if ('consortia_domain' === local1) {
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
        }
        else if ('consortiaGuard' === local1) {
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
        }
        else if ('auction' === local1) {
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
        else if ('shop' === local1) {
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
        else if ('trainer1' === local1) {
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
        else if ('trainer2' === local1) {
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
        else {
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
        if (ddt.manager.PlayerManager.Instance.Self.Grade < 5) {
            isProhibit_G = false;
        }
    }
}
}