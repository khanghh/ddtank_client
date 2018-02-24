package baglocked
{
   import baglocked.data.BagLockedInfo;
   import baglocked.phone4399.ConfirmNum4399Frame;
   import baglocked.phone4399.GetConfirmFrame;
   import baglocked.phone4399.MsnConfirmAnalyzer;
   import baglocked.phoneServiceFrames.BenefitOfBindingFrame;
   import baglocked.phoneServiceFrames.DeleteConfirmFrame;
   import baglocked.phoneServiceFrames.DeleteInputFrame;
   import baglocked.phoneServiceFrames.MsnConfirmFrame;
   import baglocked.phoneServiceFrames.PhoneConfirmFrame;
   import baglocked.phoneServiceFrames.PhoneInputFrame;
   import baglocked.phoneServiceFrames.PhoneServiceFrame;
   import baglocked.phoneServiceFrames.QuestionConfirmFrame;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLVariables;
   import road7th.comm.PackageIn;
   
   public class BagLockedController extends EventDispatcher
   {
      
      private static var _instance:BagLockedController;
       
      
      private var _explainFrame:ExplainFrame;
      
      private var _explainFrame2:ExplainFrame2;
      
      private var _explainFrame4399:ExplainFrame4399;
      
      private var _setPassFrame1:SetPassFrame1;
      
      private var _setPassFrame2:SetPassFrame2;
      
      private var _setPassFrame3:SetPassFrame3;
      
      private var _setPassFrameNew:SetPassFrameNew;
      
      private var _appealFrame:AppealFrame;
      
      private var _phoneServiceFrame:PhoneServiceFrame;
      
      private var _changePhoneFrame:PhoneServiceFrame;
      
      private var _changePhoneFrame1:PhoneInputFrame;
      
      private var _changePhoneFrame2:MsnConfirmFrame;
      
      private var _changePhoneFrame3:PhoneConfirmFrame;
      
      private var _changePhoneFrame4:MsnConfirmFrame;
      
      private var _questionConfirmFrame1:QuestionConfirmFrame;
      
      private var _questionConfirmFrame2:PhoneConfirmFrame;
      
      private var _questionConfirmFrame3:MsnConfirmFrame;
      
      private var _deleteQuestionFrame1:DeleteInputFrame;
      
      private var _deleteQuestionFrame2:DeleteConfirmFrame;
      
      private var _deletePwdFrame:PhoneServiceFrame;
      
      private var _deletePwdFrame1:DeleteInputFrame;
      
      private var _deletePwdFrame2:DeleteConfirmFrame;
      
      private var _benefitOfBindingFrame:BenefitOfBindingFrame;
      
      private var _getConfirmFrame:GetConfirmFrame;
      
      private var _confirmNum4399Frame:ConfirmNum4399Frame;
      
      private var _delPassFrame:DelPassFrame;
      
      private var _bagLockedGetFrame:BagLockedGetFrame;
      
      private var _updatePassFrame:UpdatePassFrame;
      
      private var _visible:Boolean = false;
      
      private var _bagLockedInfo:BagLockedInfo;
      
      public var phoneNum:String = "10000000000";
      
      private var _currentFn:Function;
      
      public var checkBindCase:int = 0;
      
      public var isPhoneBind:Boolean = false;
      
      public function BagLockedController(){super();}
      
      public static function get Instance() : BagLockedController{return null;}
      
      public function BagLoackedController() : void{}
      
      public function setup() : void{}
      
      public function set bagLockedInfo(param1:BagLockedInfo) : void{}
      
      public function get bagLockedInfo() : BagLockedInfo{return null;}
      
      private function loadUi(param1:Function) : void{}
      
      private function __onClose(param1:Event) : void{}
      
      private function __uiProgress(param1:UIModuleEvent) : void{}
      
      private function __uiComplete(param1:UIModuleEvent) : void{}
      
      protected function __onOnShow(param1:SetPassEvent) : void{}
      
      private function onShow() : void{}
      
      public function closeExplainFrame() : void{}
      
      public function openSetPassFrame1() : void{}
      
      public function closeSetPassFrame1() : void{}
      
      public function openSetPassFrame2() : void{}
      
      public function closeSetPassFrame2() : void{}
      
      public function openSetPassFrame3() : void{}
      
      public function closeSetPassFrame3() : void{}
      
      public function setPassComplete() : void{}
      
      protected function __onOpenView(param1:SetPassEvent) : void{}
      
      private function onOpenBagLockedGetFrame() : void{}
      
      public function clearBagLockedGetFrame() : void{}
      
      public function BagLockedGetFrameController() : void{}
      
      public function closeBagLockedGetFrame() : void{}
      
      public function openUpdatePassFrame() : void{}
      
      public function updatePassFrameController() : void{}
      
      public function closeUpdatePassFrame() : void{}
      
      public function openDelPassFrame() : void{}
      
      public function delPassFrameController() : void{}
      
      public function closeDelPassFrame() : void{}
      
      public function openSetPassFrameNew() : void{}
      
      public function setPassFrameNewController() : void{}
      
      public function closeSetPassFrameNew() : void{}
      
      public function openAppealFrame() : void{}
      
      public function openPhoneServiceFrame() : void{}
      
      public function openChangePhoneFrame() : void{}
      
      public function openChangePhoneFrame1() : void{}
      
      public function openChangePhoneFrame2() : void{}
      
      public function openChangePhoneFrame3() : void{}
      
      public function openChangePhoneFrame4() : void{}
      
      public function openQuestionConfirmFrame1() : void{}
      
      public function openQuestionConfirmFrame2() : void{}
      
      public function openQuestionConfirmFrame3() : void{}
      
      public function openDeleteQuestionFrame1() : void{}
      
      public function openDeleteQuestionFrame2() : void{}
      
      public function openDeletePwdFrame() : void{}
      
      public function openDeletePwdByphoneFrame1() : void{}
      
      public function openDeletePwdByphoneFrame2() : void{}
      
      public function openBindPhoneFrame() : void{}
      
      public function openGetConfirmFrame() : void{}
      
      public function openConfirmNum4399Frame() : void{}
      
      public function close() : void{}
      
      public function get questionConfirmFrame1() : QuestionConfirmFrame{return null;}
      
      public function get explainFrame2() : ExplainFrame2{return null;}
      
      public function requestConfirm(param1:int, param2:String = "") : void{}
      
      public function addLockPwdEvent() : void{}
      
      protected function __getBackLockPwdHandler(param1:PkgEvent) : void{}
      
      public function removeLockPwdEvent() : void{}
      
      public function requestMsnConfirm(param1:int, param2:String = "") : BaseLoader{return null;}
      
      public function msnConfirmAnalyeComplete(param1:MsnConfirmAnalyzer) : void{}
      
      protected function __delQuestionHandler(param1:PkgEvent) : void{}
   }
}
