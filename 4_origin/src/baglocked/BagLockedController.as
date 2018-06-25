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
      
      public function BagLockedController()
      {
         super();
      }
      
      public static function get Instance() : BagLockedController
      {
         if(_instance == null)
         {
            _instance = new BagLockedController();
         }
         return _instance;
      }
      
      public function BagLoackedController() : void
      {
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(233),__delQuestionHandler);
         BaglockedManager.Instance.addEventListener("bagloackedOpenView",__onOpenView);
         BaglockedManager.Instance.addEventListener("bagloackedOnShow",__onOnShow);
      }
      
      public function set bagLockedInfo(value:BagLockedInfo) : void
      {
         _bagLockedInfo = value;
      }
      
      public function get bagLockedInfo() : BagLockedInfo
      {
         if(!_bagLockedInfo)
         {
            _bagLockedInfo = new BagLockedInfo();
         }
         return _bagLockedInfo;
      }
      
      private function loadUi(fn:Function) : void
      {
         _currentFn = fn;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__uiProgress);
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",__uiComplete);
         UIModuleLoader.Instance.addUIModuleImp("ddtbaglocked");
      }
      
      private function __onClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__uiProgress);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__uiComplete);
      }
      
      private function __uiProgress(event:UIModuleEvent) : void
      {
         if(event.module == "ddtbaglocked")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function __uiComplete(event:UIModuleEvent) : void
      {
         if(event.module == "ddtbaglocked")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__uiProgress);
            event.currentTarget.removeEventListener("uiModuleComplete",__uiComplete);
            UIModuleSmallLoading.Instance.hide();
            if(_currentFn != null)
            {
               _currentFn();
            }
            _currentFn = null;
         }
      }
      
      protected function __onOnShow(event:SetPassEvent) : void
      {
         loadUi(onShow);
      }
      
      private function onShow() : void
      {
         switch(int(BaglockedManager.LOCK_SETTING) - -1)
         {
            case 0:
               if(!_explainFrame)
               {
                  _explainFrame = ComponentFactory.Instance.creat("baglocked.explainFrame");
                  _explainFrame.bagLockedController = this;
               }
               _explainFrame.show();
               break;
            case 1:
               if(!_explainFrame2)
               {
                  _explainFrame2 = ComponentFactory.Instance.creat("baglocked.explainFrame2");
                  _explainFrame2.bagLockedController = this;
               }
               _explainFrame2.show();
               checkBindCase = 0;
               SocketManager.Instance.out.checkPhoneBind();
               addLockPwdEvent();
               break;
            case 2:
            case 3:
               if(!_explainFrame4399)
               {
                  _explainFrame4399 = ComponentFactory.Instance.creat("baglocked.explainFrame4399");
                  _explainFrame4399.bagLockedController = this;
               }
               _explainFrame4399.show();
         }
      }
      
      public function closeExplainFrame() : void
      {
         if(_explainFrame)
         {
            ObjectUtils.disposeObject(_explainFrame);
         }
         _explainFrame = null;
         if(_explainFrame2)
         {
            ObjectUtils.disposeObject(_explainFrame2);
         }
         _explainFrame2 = null;
         if(_explainFrame4399)
         {
            ObjectUtils.disposeObject(_explainFrame4399);
         }
         _explainFrame4399 = null;
      }
      
      public function openSetPassFrame1() : void
      {
         _setPassFrame1 = ComponentFactory.Instance.creat("baglocked.setPassFrame1");
         _setPassFrame1.bagLockedController = this;
         _setPassFrame1.show();
      }
      
      public function closeSetPassFrame1() : void
      {
         ObjectUtils.disposeObject(_setPassFrame1);
         _setPassFrame1 = null;
      }
      
      public function openSetPassFrame2() : void
      {
         _setPassFrame2 = ComponentFactory.Instance.creat("baglocked.setPassFrame2");
         _setPassFrame2.bagLockedController = this;
         _setPassFrame2.show();
      }
      
      public function closeSetPassFrame2() : void
      {
         ObjectUtils.disposeObject(_setPassFrame2);
         _setPassFrame2 = null;
      }
      
      public function openSetPassFrame3() : void
      {
         _setPassFrame3 = ComponentFactory.Instance.creat("baglocked.setPassFrame3");
         _setPassFrame3.bagLockedController = this;
         _setPassFrame3.show();
      }
      
      public function closeSetPassFrame3() : void
      {
         ObjectUtils.disposeObject(_setPassFrame3);
         _setPassFrame3 = null;
      }
      
      public function setPassComplete() : void
      {
         SocketManager.Instance.out.sendBagLocked(_bagLockedInfo.psw,1,"",_bagLockedInfo.questionOne,_bagLockedInfo.answerOne,_bagLockedInfo.questionTwo,_bagLockedInfo.answerTwo);
         _bagLockedInfo = null;
      }
      
      protected function __onOpenView(event:SetPassEvent) : void
      {
         loadUi(onOpenBagLockedGetFrame);
      }
      
      private function onOpenBagLockedGetFrame() : void
      {
         if(_bagLockedGetFrame == null)
         {
            _bagLockedGetFrame = ComponentFactory.Instance.creat("baglocked.bagLockedGetFrame");
            _bagLockedGetFrame.bagLockedController = this;
         }
         _bagLockedGetFrame.show();
      }
      
      public function clearBagLockedGetFrame() : void
      {
         _bagLockedGetFrame = null;
      }
      
      public function BagLockedGetFrameController() : void
      {
         SocketManager.Instance.out.sendBagLocked(_bagLockedInfo.psw,2);
         _bagLockedInfo = null;
      }
      
      public function closeBagLockedGetFrame() : void
      {
         close();
      }
      
      public function openUpdatePassFrame() : void
      {
         _updatePassFrame = ComponentFactory.Instance.creat("baglocked.updatePassFrame");
         _updatePassFrame.bagLockedController = this;
         _updatePassFrame.show();
      }
      
      public function updatePassFrameController() : void
      {
         SocketManager.Instance.out.sendBagLocked(_bagLockedInfo.psw,3,_bagLockedInfo.newPwd);
         _bagLockedInfo = null;
      }
      
      public function closeUpdatePassFrame() : void
      {
         close();
      }
      
      public function openDelPassFrame() : void
      {
         _delPassFrame = ComponentFactory.Instance.creat("baglocked.delPassFrame");
         _delPassFrame.bagLockedController = this;
         _delPassFrame.show();
      }
      
      public function delPassFrameController() : void
      {
         SocketManager.Instance.out.sendBagLocked("",4,"",_bagLockedInfo.questionOne,_bagLockedInfo.answerOne,_bagLockedInfo.questionTwo,_bagLockedInfo.answerTwo);
         _bagLockedInfo = null;
      }
      
      public function closeDelPassFrame() : void
      {
         close();
      }
      
      public function openSetPassFrameNew() : void
      {
         _setPassFrameNew = ComponentFactory.Instance.creat("baglocked.setPassFrameNew");
         _setPassFrameNew.bagLockedController = this;
         _setPassFrameNew.show();
      }
      
      public function setPassFrameNewController() : void
      {
         SocketManager.Instance.out.sendBagLocked(_bagLockedInfo.psw,1);
         _bagLockedInfo = null;
      }
      
      public function closeSetPassFrameNew() : void
      {
         close();
      }
      
      public function openAppealFrame() : void
      {
         _appealFrame = ComponentFactory.Instance.creat("baglocked.appealFrame");
         _appealFrame.bagLockedController = this;
         _appealFrame.show();
      }
      
      public function openPhoneServiceFrame() : void
      {
         _phoneServiceFrame = ComponentFactory.Instance.creat("baglocked.phoneServiceFrame");
         _phoneServiceFrame.init2(0);
         _phoneServiceFrame.bagLockedController = this;
         _phoneServiceFrame.show();
      }
      
      public function openChangePhoneFrame() : void
      {
         _changePhoneFrame = ComponentFactory.Instance.creat("baglocked.phoneServiceFrame");
         _changePhoneFrame.init2(1);
         _changePhoneFrame.bagLockedController = this;
         _changePhoneFrame.show();
      }
      
      public function openChangePhoneFrame1() : void
      {
         _changePhoneFrame1 = ComponentFactory.Instance.creat("baglocked.phoneInputFrame");
         _changePhoneFrame1.init2(0);
         _changePhoneFrame1.bagLockedController = this;
         _changePhoneFrame1.show();
      }
      
      public function openChangePhoneFrame2() : void
      {
         _changePhoneFrame2 = ComponentFactory.Instance.creat("baglocked.msnConfirmFrame");
         _changePhoneFrame2.init2(0);
         _changePhoneFrame2.bagLockedController = this;
         _changePhoneFrame2.show();
      }
      
      public function openChangePhoneFrame3() : void
      {
         _changePhoneFrame3 = ComponentFactory.Instance.creat("baglocked.phoneConfirmFrame");
         _changePhoneFrame3.init2(0);
         _changePhoneFrame3.bagLockedController = this;
         _changePhoneFrame3.show();
      }
      
      public function openChangePhoneFrame4() : void
      {
         _changePhoneFrame4 = ComponentFactory.Instance.creat("baglocked.msnConfirmFrame");
         _changePhoneFrame4.init2(1);
         _changePhoneFrame4.bagLockedController = this;
         _changePhoneFrame4.show();
      }
      
      public function openQuestionConfirmFrame1() : void
      {
         _questionConfirmFrame1 = ComponentFactory.Instance.creat("baglocked.questionConfirmFrame");
         _questionConfirmFrame1.bagLockedController = this;
         _questionConfirmFrame1.show();
      }
      
      public function openQuestionConfirmFrame2() : void
      {
         _questionConfirmFrame2 = ComponentFactory.Instance.creat("baglocked.phoneConfirmFrame");
         _questionConfirmFrame2.init2(1);
         _questionConfirmFrame2.bagLockedController = this;
         _questionConfirmFrame2.show();
      }
      
      public function openQuestionConfirmFrame3() : void
      {
         _questionConfirmFrame3 = ComponentFactory.Instance.creat("baglocked.msnConfirmFrame");
         _questionConfirmFrame3.init2(2);
         _questionConfirmFrame3.bagLockedController = this;
         _questionConfirmFrame3.show();
      }
      
      public function openDeleteQuestionFrame1() : void
      {
         _deleteQuestionFrame1 = ComponentFactory.Instance.creat("baglocked.deleteInputFrame");
         _deleteQuestionFrame1.init2(0);
         _deleteQuestionFrame1.bagLockedController = this;
         _deleteQuestionFrame1.show();
      }
      
      public function openDeleteQuestionFrame2() : void
      {
         _deleteQuestionFrame2 = ComponentFactory.Instance.creat("baglocked.deleteConfirmFrame");
         _deleteQuestionFrame2.init2(0);
         _deleteQuestionFrame2.bagLockedController = this;
         _deleteQuestionFrame2.show();
      }
      
      public function openDeletePwdFrame() : void
      {
         _deletePwdFrame = ComponentFactory.Instance.creat("baglocked.phoneServiceFrame");
         _deletePwdFrame.init2(2);
         _deletePwdFrame.bagLockedController = this;
         _deletePwdFrame.show();
      }
      
      public function openDeletePwdByphoneFrame1() : void
      {
         _deletePwdFrame1 = ComponentFactory.Instance.creat("baglocked.deleteInputFrame");
         _deletePwdFrame1.init2(1);
         _deletePwdFrame1.bagLockedController = this;
         _deletePwdFrame1.show();
      }
      
      public function openDeletePwdByphoneFrame2() : void
      {
         _deletePwdFrame2 = ComponentFactory.Instance.creat("baglocked.deleteConfirmFrame");
         _deletePwdFrame2.init2(1);
         _deletePwdFrame2.bagLockedController = this;
         _deletePwdFrame2.show();
      }
      
      public function openBindPhoneFrame() : void
      {
         _benefitOfBindingFrame = ComponentFactory.Instance.creat("baglocked.benefitOfBindingFrame");
         _benefitOfBindingFrame.bagLockedController = this;
         _benefitOfBindingFrame.show();
      }
      
      public function openGetConfirmFrame() : void
      {
         _getConfirmFrame = ComponentFactory.Instance.creat("baglocked.getConfirmFrame");
         _getConfirmFrame.bagLockedController = this;
         _getConfirmFrame.show();
      }
      
      public function openConfirmNum4399Frame() : void
      {
         _confirmNum4399Frame = ComponentFactory.Instance.creat("baglocked.confirmNum4399Frame");
         _confirmNum4399Frame.bagLockedController = this;
         _confirmNum4399Frame.show();
      }
      
      public function close() : void
      {
         ObjectUtils.disposeObject(_updatePassFrame);
         _updatePassFrame = null;
         ObjectUtils.disposeObject(_bagLockedGetFrame);
         _bagLockedGetFrame = null;
         ObjectUtils.disposeObject(_delPassFrame);
         _delPassFrame = null;
         ObjectUtils.disposeObject(_setPassFrameNew);
         _setPassFrameNew = null;
         ObjectUtils.disposeObject(_setPassFrame3);
         _setPassFrame3 = null;
         ObjectUtils.disposeObject(_setPassFrame2);
         _setPassFrame2 = null;
         ObjectUtils.disposeObject(_setPassFrame1);
         _setPassFrame1 = null;
         ObjectUtils.disposeObject(_explainFrame);
         _explainFrame = null;
         ObjectUtils.disposeObject(_explainFrame2);
         _explainFrame2 = null;
         ObjectUtils.disposeObject(_explainFrame4399);
         _explainFrame4399 = null;
         ObjectUtils.disposeObject(_appealFrame);
         _appealFrame = null;
         ObjectUtils.disposeObject(_phoneServiceFrame);
         _phoneServiceFrame = null;
         ObjectUtils.disposeObject(_changePhoneFrame);
         _changePhoneFrame = null;
         ObjectUtils.disposeObject(_changePhoneFrame1);
         _changePhoneFrame1 = null;
         ObjectUtils.disposeObject(_changePhoneFrame2);
         _changePhoneFrame2 = null;
         ObjectUtils.disposeObject(_changePhoneFrame3);
         _changePhoneFrame3 = null;
         ObjectUtils.disposeObject(_changePhoneFrame4);
         _changePhoneFrame4 = null;
         ObjectUtils.disposeObject(_questionConfirmFrame1);
         _questionConfirmFrame1 = null;
         ObjectUtils.disposeObject(_questionConfirmFrame2);
         _questionConfirmFrame2 = null;
         ObjectUtils.disposeObject(_questionConfirmFrame3);
         _questionConfirmFrame3 = null;
         ObjectUtils.disposeObject(_deleteQuestionFrame1);
         _deleteQuestionFrame1 = null;
         ObjectUtils.disposeObject(_deleteQuestionFrame2);
         _deleteQuestionFrame2 = null;
         ObjectUtils.disposeObject(_deletePwdFrame);
         _deletePwdFrame = null;
         ObjectUtils.disposeObject(_deletePwdFrame1);
         _deletePwdFrame1 = null;
         ObjectUtils.disposeObject(_deletePwdFrame2);
         _deletePwdFrame2 = null;
         ObjectUtils.disposeObject(_benefitOfBindingFrame);
         _benefitOfBindingFrame = null;
         ObjectUtils.disposeObject(_getConfirmFrame);
         _getConfirmFrame = null;
         ObjectUtils.disposeObject(_confirmNum4399Frame);
         _confirmNum4399Frame = null;
         dispatchEvent(new Event("complete"));
      }
      
      public function get questionConfirmFrame1() : QuestionConfirmFrame
      {
         return _questionConfirmFrame1;
      }
      
      public function get explainFrame2() : ExplainFrame2
      {
         return _explainFrame2;
      }
      
      public function requestConfirm(type:int, code:String = "") : void
      {
         var loader:BaseLoader = requestMsnConfirm(type,code);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      public function addLockPwdEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(403),__getBackLockPwdHandler);
      }
      
      protected function __getBackLockPwdHandler(event:PkgEvent) : void
      {
         var flag:Boolean = false;
         var count:int = 0;
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readByte();
         if(cmd == 5)
         {
            isPhoneBind = pkg.readBoolean();
            switch(int(checkBindCase))
            {
               case 0:
                  explainFrame2.phoneServiceBtn.enable = isPhoneBind;
                  break;
               case 1:
                  isPhoneBind = true;
                  if(isPhoneBind)
                  {
                     if(PlayerManager.Instance.Self.questionOne == "")
                     {
                        openSetPassFrame1();
                     }
                     else
                     {
                        openSetPassFrameNew();
                     }
                     closeExplainFrame();
                     removeLockPwdEvent();
                  }
                  else
                  {
                     openBindPhoneFrame();
                     closeExplainFrame();
                  }
            }
            return;
         }
         var step:int = pkg.readInt();
         switch(int(cmd) - 1)
         {
            case 0:
               switch(int(step))
               {
                  case 0:
                     flag = pkg.readBoolean();
                     if(flag)
                     {
                        close();
                        openChangePhoneFrame1();
                     }
                     break;
                  case 1:
                     close();
                     openChangePhoneFrame2();
                     break;
                  case 2:
                     break;
                  case 3:
                     close();
                     openChangePhoneFrame3();
                     break;
                  case 4:
                     close();
                     openChangePhoneFrame4();
                     break;
                  case 5:
                     break;
                  case 6:
                     close();
                     removeLockPwdEvent();
               }
               break;
            case 1:
               switch(int(step))
               {
                  case 0:
                     flag = pkg.readBoolean();
                     if(flag)
                     {
                        count = pkg.readInt();
                        close();
                        openQuestionConfirmFrame1();
                        questionConfirmFrame1.setRestTimes(count);
                     }
                     break;
                  case 1:
                     flag = pkg.readBoolean();
                     if(flag)
                     {
                        close();
                        openQuestionConfirmFrame2();
                     }
                     else
                     {
                        count = pkg.readInt();
                        questionConfirmFrame1.setRestTimes(count);
                     }
                     break;
                  case 2:
                     close();
                     openQuestionConfirmFrame3();
                     break;
                  case 3:
                     break;
                  case 4:
                     close();
                     removeLockPwdEvent();
               }
               break;
            case 2:
               switch(int(step))
               {
                  case 0:
                     flag = pkg.readBoolean();
                     if(flag)
                     {
                        close();
                        openDeleteQuestionFrame1();
                     }
                     break;
                  case 1:
                     close();
                     openDeleteQuestionFrame2();
                     break;
                  case 2:
                     break;
                  case 3:
                     close();
                     PlayerManager.Instance.Self.questionOne = "";
                     PlayerManager.Instance.Self.questionTwo = "";
                     PlayerManager.Instance.Self.bagPwdState = false;
                     PlayerManager.Instance.Self.bagLocked = false;
                     PlayerManager.Instance.Self.onReceiveTypes("afterDel");
                     removeLockPwdEvent();
               }
               break;
            case 3:
               switch(int(step))
               {
                  case 0:
                     flag = pkg.readBoolean();
                     if(flag)
                     {
                        close();
                        openDeletePwdByphoneFrame1();
                     }
                     break;
                  case 1:
                     close();
                     openDeletePwdByphoneFrame2();
                     break;
                  case 2:
                     break;
                  case 3:
                     close();
                     PlayerManager.Instance.Self.bagPwdState = false;
                     PlayerManager.Instance.Self.bagLocked = false;
                     PlayerManager.Instance.Self.onReceiveTypes("afterDel");
                     removeLockPwdEvent();
               }
         }
      }
      
      public function removeLockPwdEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(403),__getBackLockPwdHandler);
      }
      
      public function requestMsnConfirm(type:int, code:String = "") : BaseLoader
      {
         var args:URLVariables = new URLVariables();
         args["uid"] = PlayerManager.Instance.Self.ID;
         args["type"] = type;
         args["code"] = code;
         args["rnd"] = Math.random();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ResetPassword4399.ashx"),6,args);
         loader.analyzer = new MsnConfirmAnalyzer(msnConfirmAnalyeComplete);
         return loader;
      }
      
      public function msnConfirmAnalyeComplete(analyzer:MsnConfirmAnalyzer) : void
      {
         switch(int(analyzer.type) - 1)
         {
            case 0:
               if(analyzer.value)
               {
                  close();
                  openConfirmNum4399Frame();
               }
               else
               {
                  MessageTipManager.getInstance().show(analyzer.alertMessage);
               }
               break;
            case 1:
               if(analyzer.value)
               {
                  close();
               }
               MessageTipManager.getInstance().show(analyzer.alertMessage);
         }
      }
      
      protected function __delQuestionHandler(event:PkgEvent) : void
      {
         PlayerManager.Instance.Self.bagPwdState = false;
         PlayerManager.Instance.Self.bagLocked = false;
         PlayerManager.Instance.Self.questionOne = "";
         PlayerManager.Instance.Self.questionTwo = "";
         PlayerManager.Instance.Self.onReceiveTypes("afterDel");
      }
   }
}
