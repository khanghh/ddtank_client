package quest
{
   import baglocked.BaglockedManager;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.RequestVairableCreater;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import road7th.utils.StringHelper;
   
   public class InfoCollectView extends Sprite implements Disposeable
   {
       
      
      public var Type:int = 2;
      
      protected var _dataLabel:FilterFrameText;
      
      protected var _validateLabel:FilterFrameText;
      
      protected var _inputData:FilterFrameText;
      
      protected var _inputValidate:FilterFrameText;
      
      protected var _dataAlert:FilterFrameText;
      
      protected var _valiAlert:FilterFrameText;
      
      private var _submitBtn:TextButton;
      
      private var _sendBtn:TextButton;
      
      private var _resetBtn:TextButton;
      
      private var _id:int;
      
      public function InfoCollectView(id:int)
      {
         _id = id;
         super();
         init();
      }
      
      private function init() : void
      {
         addLabel();
         _inputData = ComponentFactory.Instance.creat("core.quest.infoCollect.InputData");
         _sendBtn = ComponentFactory.Instance.creatComponentByStylename("core.quest.infoCollect.SubmitBtn");
         _sendBtn.text = LanguageMgr.GetTranslation("im.InviteDialogFrame.send");
         _dataLabel.y = _inputData.y;
         _sendBtn.y = _dataLabel.y - 7;
         _dataAlert = ComponentFactory.Instance.creat("core.quest.infoCollect.Alert");
         _inputValidate = ComponentFactory.Instance.creat("core.quest.infoCollect.InputValidate");
         _validateLabel = ComponentFactory.Instance.creat("core.quest.infoCollect.Label");
         _validateLabel.text = LanguageMgr.GetTranslation("ddt.quest.collectInfo.validate");
         _submitBtn = ComponentFactory.Instance.creatComponentByStylename("core.quest.infoCollect.CheckBtn");
         _submitBtn.text = StringHelper.trimAll(LanguageMgr.GetTranslation("core.quest.valid"));
         _validateLabel.y = _inputValidate.y;
         _submitBtn.y = _validateLabel.y - 7;
         _valiAlert = ComponentFactory.Instance.creat("core.quest.infoCollect.Result");
         addChild(_inputData);
         addChild(_dataLabel);
         addChild(_inputValidate);
         addChild(_dataAlert);
         addChild(_validateLabel);
         addChild(_sendBtn);
         addChild(_submitBtn);
         addChild(_valiAlert);
         _inputData.addEventListener("focusOut",__onDataFocusOut);
         _sendBtn.addEventListener("click",__onSendBtn);
         _submitBtn.addEventListener("click",_onSubmitBtn);
         modifyView();
         addResetBtn();
      }
      
      protected function addResetBtn() : void
      {
         _resetBtn = ComponentFactory.Instance.creatComponentByStylename("core.quest.infoCollect.ResetBtn");
         _resetBtn.text = LanguageMgr.GetTranslation("ddt.pve.roomlist.itemlist.reset");
         _resetBtn.visible = false;
         addChild(_resetBtn);
         _resetBtn.addEventListener("click",__onRestBtn);
      }
      
      protected function modifyView() : void
      {
         _inputData.restrict = "0-9";
      }
      
      protected function addLabel() : void
      {
         _dataLabel = ComponentFactory.Instance.creat("core.quest.infoCollect.Label");
         _dataLabel.text = LanguageMgr.GetTranslation("ddt.quest.collectInfo.phone");
      }
      
      protected function validate() : void
      {
         alert("ddt.quest.collectInfo.validateSend");
      }
      
      protected function __onSendBtn(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_inputData.text.length < 1)
         {
            alert("ddt.quest.collectInfo.noPhone");
            return;
         }
         if(_inputData.text.length > 11)
         {
            alert("ddt.quest.collectInfo.phoneNumberError");
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         sendData();
      }
      
      protected function _onSubmitBtn(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         sendValidate();
      }
      
      protected function __onRestBtn(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _inputData.type = "input";
         _inputData.text = "";
         _inputData.setFocus();
      }
      
      protected function sendData() : void
      {
         var selfid:Number = PlayerManager.Instance.Self.ID;
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["selfid"] = selfid;
         args["input"] = _inputData.text;
         args["questid"] = _id;
         args["rnd"] = Math.random();
         fillArgs(args);
         var request:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SendActiveKeySystem.ashx"),6,args);
         request.addEventListener("loadError",__onLoadError);
         request.addEventListener("complete",__onDataLoad);
         LoadResourceManager.Instance.startLoad(request);
      }
      
      public function getPhoneData() : void
      {
         var selfid:Number = PlayerManager.Instance.Self.ID;
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["selfid"] = selfid;
         args["rnd"] = Math.random();
         fillArgs(args);
         var request:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GetVefityPhoneNumber.ashx"),6,args);
         request.addEventListener("loadError",__onLoadError);
         request.addEventListener("complete",__onPhoneDataLoad);
         LoadResourceManager.Instance.startLoad(request);
      }
      
      protected function fillArgs(args:URLVariables) : URLVariables
      {
         args["phone"] = args["input"];
         return args;
      }
      
      private function __onDataLoad(e:LoaderEvent) : void
      {
         e.currentTarget.removeEventListener("complete",arguments.callee);
         var x:XML = XML(e.loader.content);
         var result:String = x.@value;
         if(result != "true")
         {
         }
         dalert(x.@message);
      }
      
      private function __onPhoneDataLoad(e:LoaderEvent) : void
      {
         e.currentTarget.removeEventListener("complete",arguments.callee);
         var phoneNum:String = String(e.loader.content);
         if(phoneNum != "")
         {
            _inputData.text = phoneNum;
            _inputData.type = "dynamic";
            if(_resetBtn)
            {
               _resetBtn.visible = true;
            }
         }
      }
      
      private function __onLoadError(e:LoaderEvent) : void
      {
         e.currentTarget.removeEventListener("loadError",arguments.callee);
         e.currentTarget.addEventListener("complete",__onDataLoad);
         e.currentTarget.addEventListener("complete",__onPhoneDataLoad);
      }
      
      private function __onDataFocusOut(e:Event) : void
      {
         alert(updateHelper(_inputData.text));
      }
      
      protected function updateHelper(value:String) : String
      {
         if(value.length > 11)
         {
            return "ddt.quest.collectInfo.phoneNumberError";
         }
         return "";
      }
      
      protected function dalert(alertString:String) : void
      {
         _dataAlert.text = alertString;
      }
      
      protected function alert(alertString:String) : void
      {
         _dataAlert.text = LanguageMgr.GetTranslation(alertString);
      }
      
      protected function dalertVali(alertString:String) : void
      {
         _valiAlert.text = alertString;
      }
      
      protected function alertVali(alertString:String) : void
      {
         _valiAlert.text = LanguageMgr.GetTranslation(alertString);
      }
      
      private function sendValidate() : void
      {
         if(_inputValidate.text.length < 1)
         {
            alertVali("ddt.quest.collectInfo.noValidate");
            return;
         }
         if(_inputValidate.text.length < 6)
         {
            alertVali("ddt.quest.collectInfo.validateError");
            return;
         }
         if(_inputValidate.text.length > 6)
         {
            alertVali("ddt.quest.collectInfo.validateError");
            return;
         }
         SocketManager.Instance.out.sendCollectInfoValidate(Type,_inputValidate.text,_id);
      }
      
      public function dispose() : void
      {
         _inputData.removeEventListener("focusOut",__onDataFocusOut);
         _sendBtn.removeEventListener("click",__onSendBtn);
         _submitBtn.removeEventListener("click",_onSubmitBtn);
         if(_resetBtn)
         {
            _resetBtn.removeEventListener("click",__onRestBtn);
            ObjectUtils.disposeObject(_resetBtn);
            _resetBtn = null;
         }
         ObjectUtils.disposeObject(_dataLabel);
         _dataLabel = null;
         ObjectUtils.disposeObject(_validateLabel);
         _validateLabel = null;
         ObjectUtils.disposeObject(_inputData);
         _inputData = null;
         ObjectUtils.disposeObject(_inputValidate);
         _inputValidate = null;
         ObjectUtils.disposeObject(_valiAlert);
         _valiAlert = null;
         ObjectUtils.disposeObject(_submitBtn);
         _submitBtn = null;
         ObjectUtils.disposeObject(_sendBtn);
         _sendBtn = null;
      }
   }
}
